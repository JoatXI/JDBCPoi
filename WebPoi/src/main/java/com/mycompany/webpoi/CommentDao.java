package com.mycompany.webpoi;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Connection;

/**
 *
 * @author Joat
 */
public class CommentDao {
    
    private Connection conn;
    private String table;
    
    public CommentDao(Connection conn, String table) {
        this.conn = conn;
        this.table = table;
    }
    
    public long addComment(Comment c) throws SQLException {
        PreparedStatement pStmt = conn.prepareStatement("INSERT INTO comments(poiName, username, commentText) VALUES (?, ?, ?)");
        pStmt.setString(1, c.getPoi());
        pStmt.setString(2, c.getUser());
        pStmt.setString(3, c.getCommentText());

        int rowsAdded = pStmt.executeUpdate();
        long allocatedId = 0L;

        // Was a row added successfully?
        if(rowsAdded == 1) {
            // If so, get the keys added
            ResultSet rs = pStmt.getGeneratedKeys();
            
            // next() should return true, but check just in case
            if (rs.next()) {
                // get the allocated primary key
                allocatedId = rs.getLong(1);
            }
        }
        
        // Add the allocated ID to the object and return the ID
        c.setId(allocatedId);
        return allocatedId;
    }
    
    public boolean deleteComment(long id) throws SQLException {
        Comment currComment = findPoiCommentById(id);
        if(currComment != null) {
            PreparedStatement pStmt = conn.prepareStatement("DELETE FROM comments WHERE id = ?");
            
            pStmt.setLong(1, id);
            
            int rowsDeleted = pStmt.executeUpdate();
            
            if(rowsDeleted > 0) {
                return true;
            }
        }
        return false;
    }
    
    public Comment findPoiCommentById(long id) throws SQLException {
        try (PreparedStatement pStmt = conn.prepareStatement("SELECT * FROM comments WHERE id=?")) {
            pStmt.setLong(1, id);

            ResultSet rs = pStmt.executeQuery();
            if (rs.next()) {
                return new Comment(
                        rs.getLong("id"),
                        rs.getString("poiName"),
                        rs.getString("username"),
                        rs.getString("commentText")
                );
            }
        }
        return null; // return null if there were no matching rows
    }
    
    // find all comments with a given poiName
    // returns the comments as an ArrayList
    public ArrayList<Comment> displayComments(String poiName) throws SQLException {
        ArrayList<Comment> commentList = new ArrayList<>();
        
        try (PreparedStatement pStmt = conn.prepareStatement("SELECT * FROM comments WHERE poiName=?")) {
            pStmt.setString(1, poiName);
            ResultSet rs = pStmt.executeQuery();

            while (rs.next()) {
                
                Comment c = new Comment(
                        rs.getLong("id"),
                        rs.getString("poiName"),
                        rs.getString("username"),
                        rs.getString("commentText")
                );
                commentList.add(c);
            }
        }
        return commentList;
    }
    
    public ArrayList<String> authoriseComment(String poiName, String commentText) throws SQLException {
        return null;
    }
}
