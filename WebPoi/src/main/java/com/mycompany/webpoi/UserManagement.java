package com.mycompany.webpoi;

/**
 *
 * @author Group member 2
 */
import java.util.ArrayList;
import java.util.List;

// UserManagement class to manage users
class UserManagement {
    private List<User> users = new ArrayList<>();

    // Function to sign up a new user
    public void signUp(String username, String password, String name, boolean isAdmin) {
        User newUser = new User(username, password, name, isAdmin);
        users.add(newUser);
    }

    // Function to log in and verify user credentials
    public User logIn(String username, String password) {
        for (User user : users) {
            if (user.getUsername().equals(username) && user.getPassword().equals(password)) {
                return user;
            }
        }
        return null; // Invalid credentials
    }

    // Function to get a list of all users (admin-only)
    public List<User> getAllUsers(User adminUser) {
        if (adminUser.isAdmin()) {
            return users;
        }
        return null; // Only admins can access this
    }

    // Function to change user details (admin-only)
    public boolean updateUserDetails(User adminUser, User user, String name, String newPassword) {
        if (adminUser.isAdmin()) {
            user.setName(name);
            user.setPassword(newPassword);
            return true;
        }
        return false; // Only admins can update user details
    }

    // Function to delete a user (admin-only)
    public boolean deleteUser(User adminUser, User user) {
        if (adminUser.isAdmin()) {
            users.remove(user);
            return true;
        }
        return false; // Only admins can delete users
    }

    // Method to find a user by their username
    public User findUserByUsername(String username) {
        for (User user : users) {
            if (user.getUsername().equals(username)) {
                return user;
            }
        }
        return null; // User not found
    }
}
