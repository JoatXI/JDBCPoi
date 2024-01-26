package com.mycompany.webpoi;

import java.util.ArrayList;

/**
 *
 * @author Joat
 */
public class Poi {
    private String name, type, location;
    private ArrayList<String> comments;
    private long likes;
    private boolean liked; // Add a boolean flag to track whether a POI has been liked
    
    /**
     * Constructs a new Places object.
     * 
     * @param nameIn The name of POI.
     * @param typeIn The type of POI.
     * @param locationIn The location of the POI
     * @param likesIn The Number of likes for a POI
     */
    public Poi(String nameIn, String typeIn, String locationIn, long likesIn) {
        this.name = nameIn;
        this.type = typeIn;
        this.location = locationIn;
        this.comments = new ArrayList<>();
        this.likes = 0;
        this.liked = false; // Initialize the liked flag to false
    }
    
    /**
     * Returns a string representation of the POI.
     * 
     * @return A string in the format: "Type: [type], Name: [name], Location: [location]"
     */
    public String toString() {
        return "Type: " + this.type + ", Name: " + this.name + ", Location: " + this.location;
    }
    
    /**
     * Gets the type of the POI.
     * 
     * @return The type of the POI.
     */
    public String getType() {
        return this.type;
    }
    
    /**
     * Gets the name of the POI.
     * 
     * @return The name of the POI.
     */
    public String getName() {
        return this.name;
    }
    
    /**
     * Gets the location of the POI.
     * 
     * @return The location of the POI.
     */

    public String getLocation() {
        return this.location;
    }
    
    /**
     * Gets the likes of the POI.
     * 
     * @return The likes for the POI.
     */
    public long getLikes() {
        return this.likes;
    }
    
    /**
     * Adds a like to this point of interest (POI).
     */
    public void addLikes() {
        this.likes++;
    }
    
    /**
     * Check if the POI has been liked.
     * 
     * @return True if the POI has been liked, false otherwise.
     */
    public boolean isLiked() {
        return liked;
    }
    
    /**
     * Set the liked status of the POI.
     * 
     * @param liked The new liked status.
     */
    public void setLiked(boolean liked) {
        this.liked = liked;
    }
    
    public boolean setLikes(long like) {
        if(like >= 0) {
            return true;
        } else {
            return false;
        }
    }
    
    /**
     * Gets the comment associated with the POI.
     * 
     * @return The comment for the POI.
     
    public ArrayList<String> getComments() {
        return comments;
    }
    
     /**
     * Sets the comment for this point of interest (POI).
     * 
     * @param comment The new comment to set.
     
    public void addComment(String comment) {
        comments.add(comment);
    }
    
    /**
     * Updates the comment for a point of interest (POI).
     * 
     * @param newComment is the new comment to be updated.
     * @param commentIndex is the position of the comment to be updated.
     
    public void updateComment(int commentIndex, String newComment) {
    if (commentIndex >= 0 && commentIndex < comments.size()) {
        comments.set(commentIndex, newComment);
        }
    }*/
}