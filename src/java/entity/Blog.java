package entity;

import java.util.List;

public class Blog {

    private int blogID;
    private String author;
    private String title;
    private String content;
    private String imageURL;
    private boolean liked;  // Thêm thuộc tính liked
    private int likeCount;  // Thêm thuộc tính likeCount
    private List<Comment> comments;  // Thêm thuộc tính comments

    public Blog() {
    }

    public Blog(int blogID, String author, String title, String content, String imageURL) {
        this.blogID = blogID;
        this.author = author;
        this.title = title;
        this.content = content;
        this.imageURL = imageURL;
    }

    public int getBlogID() {
        return blogID;
    }

    public void setBlogID(int blogID) {
        this.blogID = blogID;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public boolean isLiked() {  // Getter cho thuộc tính liked
        return liked;
    }

    public void setLiked(boolean liked) {  // Setter cho thuộc tính liked
        this.liked = liked;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    @Override
    public String toString() {
        return "Blog{" + "blogID=" + blogID + ", author=" + author + ", title=" + title + ", content=" + content + ", imageURL=" + imageURL + ", likeCount=" + likeCount + ", comments=" + comments + '}';
    }
}
