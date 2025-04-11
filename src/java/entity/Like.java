package entity;

public class Like {

    private int likeID;
    private int userID;
    private int blogID;

    public Like() {
    }

    public Like(int likeID, int userID, int blogID) {
        this.likeID = likeID;
        this.userID = userID;
        this.blogID = blogID;
    }

    public int getLikeID() {
        return likeID;
    }

    public void setLikeID(int likeID) {
        this.likeID = likeID;
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

    @Override
    public String toString() {
        return "Like{" + "likeID=" + likeID + ", userID=" + userID + ", blogID=" + blogID + '}';
    }
}
