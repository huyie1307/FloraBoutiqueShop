package controller;

import dao.CartDAO;
import dao.OrderDAO;
import entity.Cart;
import entity.Order;
import entity.OrderDetail;
import entity.PaymentMethod;
import entity.Status;
import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cartIdsParam = request.getParameter("cartIds");
        HttpSession session = request.getSession();

        List<Integer> idList = new ArrayList<>();

        if (cartIdsParam != null && !cartIdsParam.trim().isEmpty()) {
            String[] cartIds = cartIdsParam.split(",");
            for (String idStr : cartIds) {
                try {
                    int id = Integer.parseInt(idStr.trim());
                    idList.add(id);
                } catch (NumberFormatException e) {
                    System.out.println(e);
                }
            }
        }

        CartDAO cartDAO = new CartDAO();
        List<Cart> carts = cartDAO.getCartItemsByIds(idList);
        session.setAttribute("carts", carts);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Lấy thông tin đơn hàng từ request
        String currentName = request.getParameter("name");
        String currentPhone = request.getParameter("phone");
        String currentAddress = request.getParameter("address");
        String orderNote = request.getParameter("orderNote");
        String paymentMethodCheck = request.getParameter("paymentMethod");
        String receiveDateStr = request.getParameter("receiveDate");

        // Lấy danh sách cart từ session
        List<Cart> carts = (List<Cart>) session.getAttribute("carts");
        if (carts == null || carts.isEmpty()) {
            request.getRequestDispatcher("OrderFail.jsp").forward(request, response);
        }
        // Tính tổng tiền đơn hàng
        BigDecimal totalPrice = BigDecimal.ZERO;
        for (Cart cart : carts) {
            BigDecimal itemTotal = BigDecimal.valueOf(cart.getProduct().getPrice())
                    .multiply(BigDecimal.valueOf(cart.getAmount()));
            totalPrice = totalPrice.add(itemTotal);
        }

        // Status Pending có id = 1
        int statusID = 1;
        int paymentMethodID = "online".equals(paymentMethodCheck) ? 1 : 2;

        // Tạo đối tượng Status và PaymentMethod
        Status status = new Status();
        status.setId(statusID);

        PaymentMethod paymentMethod = new PaymentMethod();
        paymentMethod.setId(paymentMethodID);

        // Tạo đối tượng Order và set các thông tin cần thiết
        Order order = new Order();
        order.setUser(user);
        order.setStatus(status);
        order.setCurrentName(currentName);
        order.setCurrentPhone(currentPhone);
        order.setCurrentAddress(currentAddress);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

        try {
            LocalDateTime receiveDate = LocalDateTime.parse(receiveDateStr, formatter);
            order.setCompleteDate(receiveDate);
        } catch (Exception e) {
            System.out.println("Bug in here");
            System.out.println(e);
            return;
        }

        order.setNote(orderNote);
        order.setTotal(totalPrice.doubleValue());
        order.setMethod(paymentMethod);

        // Sử dụng OrderDAO để thêm sản phẩm vào đơn hàng
        OrderDAO orderDAO = new OrderDAO();
        boolean orderSuccess = true;
        for (Cart cart : carts) {
            OrderDetail detail = new OrderDetail();
            detail.setProduct(cart.getProduct());
            detail.setQuantity(cart.getAmount());
            detail.setPrice(cart.getProduct().getPrice());

            // Gọi hàm addProduct đã được cập nhật để thêm hoặc cập nhật sản phẩm trong đơn hàng
            boolean result = orderDAO.addProduct(order, detail);
            if (!result) {
                orderSuccess = false;
                break;
            }
        }

        if (orderSuccess) {
            // Sau khi đặt hàng thành công, xóa các mục trong giỏ hàng
            CartDAO cartDAO = new CartDAO();
            for (Cart cart : carts) {
                cartDAO.deleteCartById(cart.getId());
            }

            // Nếu là thanh toán online thì chuyển sang trang thanh toán online
            if (paymentMethodID == 1) {
                session.setAttribute("carts", carts);
                session.setAttribute("totalPrice", totalPrice);
                session.setAttribute("receiveDate", receiveDateStr);
                response.sendRedirect("onlinepayment");
                return;
            }

            session.removeAttribute("carts");
            request.setAttribute("message", "Đặt hàng thành công!");
            request.getRequestDispatcher("OrderSuccess.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Đặt hàng thất bại, vui lòng thử lại.");
            request.getRequestDispatcher("OrderFail.jsp").forward(request, response);
        }
    }
}
