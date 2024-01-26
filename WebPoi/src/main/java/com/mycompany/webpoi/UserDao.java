package com.mycompany.webpoi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Joat
 */
public class UserDao {
    
    private Connection conn;
    private String table;
    
    public UserDao(Connection conn, String table) {
        this.conn = conn;
        this.table = table;
    }
    
    public boolean addUser(User u) throws SQLException {
        PreparedStatement pStmt = conn.prepareStatement("INSERT INTO users(name, username, password, adminStatus) VALUES (?, ?, ?, ?)");
        pStmt.setString(1, u.getName());
        pStmt.setString(2, u.getUsername());
        pStmt.setString(3, u.getPassword());
        pStmt.setBoolean(4, u.isAdmin());

        int rowsAdded = pStmt.executeUpdate();

        // Was a row added successfully?
        if(rowsAdded > 0) {
            // If so, get the keys added
            return true;
        }
        return false;
    }
    
    public boolean updateUser(String oldUsername, String newName, String newUsername, String newPassword) throws SQLException {
        User currUser = findUserByUsername(oldUsername);
        if(currUser != null) {
            PreparedStatement pStmt = conn.prepareStatement("UPDATE users SET name = ?, username = ?, password = ? WHERE username = ?");
        
            pStmt.setString(1, newName);
            pStmt.setString(2, newUsername);
            pStmt.setString(3, newPassword);
            pStmt.setString(4, oldUsername); // Sets the old username in the WHERE clause
            
            int rowsUpdated = pStmt.executeUpdate();
            
            if(rowsUpdated > 0) {
                return true;
            }
        }
        return false;
    }
    
    public boolean deleteUser(String username) throws SQLException {
        User currUser = findUserByUsername(username);
        if(currUser != null) {
            PreparedStatement pStmt = conn.prepareStatement("DELETE FROM users WHERE username = ?");
            
            pStmt.setString(1, username);
            
            int rowsDeleted = pStmt.executeUpdate();
            
            if(rowsDeleted > 0) {
                return true;
            }
        }
        return false;
    }
    
    public User findUserByUsername(String username) throws SQLException {
    // Implementation to fetch user details from the database using the provided username
    // if there's a query to retrieve user details based on the username
        try (PreparedStatement pStmnt = conn.prepareStatement("SELECT * FROM users WHERE username=?")) {
            pStmnt.setString(1, username);

            ResultSet rs = pStmnt.executeQuery();
            if (rs.next()) {
                // Assuming User is a class with a constructor that takes user details as parameters
                String name = rs.getString("name");
                String password = rs.getString("password");
                boolean isAdmin = rs.getBoolean("adminStatus");

                // Creating and returning a User object
                return new User(name, username, password, isAdmin);
            }
        }
        return null; // User not found
    }
    
    // Method to authenticate a user
    public User authenticateLogin(String username, String password) throws SQLException {
        try (PreparedStatement pStmnt = conn.prepareStatement("SELECT * FROM users WHERE username=? AND password=?")) {
            pStmnt.setString(1, username);
            pStmnt.setString(2, password);

            ResultSet rs = pStmnt.executeQuery(); 
            if (rs.next()) {
                // User found, create and return a User object
                String name = rs.getString("name");
                boolean isAdmin = rs.getBoolean("adminStatus");
                
                User user = new User(name, username, password, isAdmin);
                
                return user;
            }
        
        }
        return null; // Authentication failed
    }
    
    public boolean checkUsername(String username) throws SQLException {
        try (PreparedStatement pStmt = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE username=?")) {
            pStmt.setString(1, username);
            ResultSet rs = pStmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        }
        return false;
    }
    
    public ArrayList<User> displayUsers() throws SQLException {
        ArrayList<User> userList = new ArrayList<>();
        
        try (PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM " + table)) {
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                String name = rs.getString("name");
                String username = rs.getString("username");
                String password = rs.getString("password");
                boolean isAdmin = rs.getBoolean("adminStatus");
                
                User user = new User(name, username, password, isAdmin);
                userList.add(user);
            }
        }
        return userList;
    }
}
