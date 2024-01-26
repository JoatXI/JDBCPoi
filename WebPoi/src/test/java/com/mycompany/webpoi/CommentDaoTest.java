package com.mycompany.webpoi;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.AfterAll;

import java.sql.*;

/**
 *
 * @author Joat
 */
public class CommentDaoTest {
    
    static Connection connTest = null;
    
    @BeforeAll
    public static void setupDatabase() {
        try {
            Class.forName("org.sqlite.JDBC");
            connTest = DriverManager.getConnection("jdbc:sqlite:E:\\GitWorks\\AE2\\Database\\poi.db");
            CommentDao daoTest = new CommentDao(connTest, "comments");
            
            Comment c = new Comment(0, "Buka", "tboy", "Very tasty food");
            long id = daoTest.addComment(c);
            assertNotNull(daoTest.findPoiCommentById(id));
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
    public void testFindCommentById() throws Exception {
        CommentDao daoTest = new CommentDao(connTest, "comments");
        Comment c = new Comment(0, "Buka", "tboy", "Very tasty food");
        long id = daoTest.addComment(c);
        
        Comment foundComment = daoTest.findPoiCommentById(id);
        
        assertEquals(id, foundComment.getId());
        assertEquals("Buka", foundComment.getPoi());
        assertEquals("tboy", foundComment.getUser());
        assertEquals("Very tasty food", foundComment.getCommentText());
    }
    
    @Test
    public void testDisplayComments() throws Exception {
        CommentDao daoTest = new CommentDao(connTest, "comments");
        assertNotNull(daoTest.displayComments("Zenith"));
    }
    
    @Test
    public void testDeleteComment() throws Exception {
        CommentDao daoTest = new CommentDao(connTest, "comments");
        Comment c = new Comment(0, "Tokumbor", "kings", "Cheap prices");
        long id = daoTest.addComment(c);
        assertTrue(daoTest.deleteComment(id));
    }
    
    @Test
    public void testNonExistentId() throws Exception {

        CommentDao dao = new CommentDao(connTest, "student");
        Comment c = new Comment(0, "Small Chops", "kweku", "E be tins");
        long id = dao.addComment(c);
        assertNull(dao.findPoiCommentById(id + 1)); // will be null as the auto-allocated ID is the greatest so far
    }
}
