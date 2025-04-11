package entity;

public class Comment {

    private int commentID;
    private int userID;
    private int blogID;
    private String content;
    private String userName;

    public Comment() {
    }

    public Comment(int commentID, int userID, int blogID, String content, String userName) {
        this.commentID = commentID;
        this.userID = userID;
        this.blogID = blogID;
        this.content = content;
        this.userName = userName;  // Khởi tạo userName
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getBlogID() {
        return blogID;
    }

    public void setBlogID(int blogID) {
        this.blogID = blogID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public String toString() {
        return "Comment{" + "commentID=" + commentID + ", userID=" + userID + ", blogID=" + blogID + ", content=" + content + '}';
    }
}
