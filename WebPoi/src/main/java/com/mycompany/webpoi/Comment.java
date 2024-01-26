package com.mycompany.webpoi;

/**
 *
 * @author Joat
 */
public class Comment {
    
    private String commentText;
    private boolean authorised = false;
    private String username;
    private long id;
    private String poiName;
    
    public Comment(long idIn, String poiNameIn, String usernameIn, String commentTextIn) {
        this.id = idIn;
        this.poiName = poiNameIn;
        this.username = usernameIn;
        this.commentText = commentTextIn;
    }
    
    public String toString() {
        return "ID #" + this.id + " POI: " + this.poiName + " User: " + this.username +  " Comment Text: " + this.commentText;
    }
    
    public long getId() {
        return this.id;
    }
    
    public void setId(long idIn) {
        this.id = idIn;
    }
    
    public String getCommentText() {
        return this.commentText;
    }
    
    public String getUser() {
        return this.username;
    }
    
    public String getPoi() {
        return poiName;
    }
    
    public void authoriseComment() {
        authorised = true;
    }
    
    public void setComment(String newComment) {
        commentText = newComment;
    }
}
