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
        List<Cart> carts = (List<Cart>) session.getAttribute("carts");
        String paymentMethodCheck = request.getParameter("paymentMethod");

        BigDecimal totalPrice = BigDecimal.ZERO;
        for (Cart cart : carts) {
            BigDecimal itemTotal = BigDecimal.valueOf(cart.getProduct().getPrice())
                    .multiply(BigDecimal.valueOf(cart.getAmount()));
            totalPrice = totalPrice.add(itemTotal);
        }

        int statusID = 1;
        int paymentMethodID;

        if ("direct".equals(paymentMethodCheck)) {
            paymentMethodID = 2;
        } else if ("online".equals(paymentMethodCheck)) {
            paymentMethodID = 1;
        } else {
            paymentMethodID = 2;
        }

        Status status = new Status();
        status.setId(statusID);

        PaymentMethod paymentMethod = new PaymentMethod();
        paymentMethod.setId(paymentMethodID);

        Order order = new Order();
        order.setUser(user);
        order.setStatus(status);
        order.setTotal(totalPrice.doubleValue());
        order.setMethod(paymentMethod);

        OrderDAO orderDAO = new OrderDAO();
        boolean orderSuccess = true;
        for (Cart cart : carts) {
            OrderDetail detail = new OrderDetail();
            detail.setProduct(cart.getProduct());
            detail.setQuantity(cart.getAmount());
            detail.setPrice(cart.getProduct().getPrice());

            boolean result = orderDAO.addProduct(order, detail);
            if (!result) {
                orderSuccess = false;
                break;
            }
        }

        if (orderSuccess) {

            CartDAO cartDAO = new CartDAO();
            for (Cart cart : carts) {
                cartDAO.deleteCartById(cart.getId());
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
