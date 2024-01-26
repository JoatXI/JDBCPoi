package com.mycompany.webpoi;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.AfterAll;

import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author Joat
 */
public class UserDaoTest {
    
    static Connection connTest = null;
    
    @BeforeAll
    public static void setupDatabase() {
        try {
            Class.forName("org.sqlite.JDBC");
            connTest = DriverManager.getConnection("jdbc:sqlite:E:\\GitWorks\\AE2\\Database\\test_poi.db");
            Statement stmt0 = connTest.createStatement();
            stmt0.executeUpdate("CREATE TABLE if not exists users(name string, username string, password string, adminStatus boolean)");
            
            UserDao daoTest = new UserDao(connTest, "users");
            User u = new User("Omoohwo", "5ohwoo17", "access123", false);
            User u2 = new User("Tega", "tboy", "moneyman", true);
            daoTest.addUser(u);
            daoTest.addUser(u2);
        } catch(SQLException | ClassNotFoundException e) {
            System.out.println(e);
        }
    }
    
    @AfterAll
    public static void teardownDatabase() {
        if(connTest != null) {
            try {
                connTest.close();
            } catch(SQLException e) {
                System.out.println(e);
            }
        }
    }
    
    @Test
    public void testUpdateUser() throws Exception {
        
        UserDao daoTest = new UserDao(connTest, "users");
        assertTrue(daoTest.updateUser("5ohwoo17", "Ovie", "kings", "expo101"));
    }
    
    @Test
    public void testFindUserByUsername() throws Exception {
        
        UserDao daoTest = new UserDao(connTest, "users");
        User u = new User("Saka", "saka7", "playboy12", false);
        daoTest.addUser(u);
        assertNotNull(daoTest.findUserByUsername("tboy"));
    }
    
    @Test
    public void testDeleteUser() throws Exception {
        
        UserDao daoTest = new UserDao(connTest, "users");
        assertTrue(daoTest.deleteUser("saka7"));
    }
    
    @Test
    public void testAuthenticateLogin() throws Exception {
        
        UserDao daoTest = new UserDao(connTest, "users");
        User foundUser = daoTest.authenticateLogin("tboy", "moneyman");
        
        assertEquals("Tega", foundUser.getName());
        assertEquals("tboy", foundUser.getUsername());
        assertEquals("moneyman", foundUser.getPassword());
        assertEquals(true, foundUser.isAdmin());
    }
    
    @Test
    public void testCheckUsername() throws Exception {
        
        UserDao daoTest = new UserDao(connTest, "users");
        assertTrue(daoTest.checkUsername("kings"));
    }
    
    @Test
    public void testDisplayUsers() throws Exception {
        
        UserDao daoTest = new UserDao(connTest, "users");
        
        ArrayList<User> foundUser = daoTest.displayUsers();
        for(User currUser : foundUser) {
            assertNotNull(currUser);
        }   
    }
}
