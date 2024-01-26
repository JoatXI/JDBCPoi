package com.mycompany.webpoi;

/**
 *
 * @author Joat
 */
public class User {
    private String name, username, password;
    private boolean adminStatus;
    
    public User(String nameIn, String usernameIn, String passwordIn, boolean admin) {
        name = nameIn;
        username = usernameIn;
        password = passwordIn;
        adminStatus = admin;
    }
    
    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }
    
    public void setPassword(String newPassword) {
        password = newPassword;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String newName) {
        name = newName;
    }
    
    public void setAdminStatus(boolean admin) {
        adminStatus = admin;
    }

    public boolean isAdmin() {
        return adminStatus;
    }
    
    public String toString() {
        return "Name: " + name + " Username: " + username + " Admin status: " + adminStatus;
    } 
}
