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
public class PoiDaoTest {
    
    static Connection connTest = null;
    
    @BeforeAll
    public static void setupDatabase() {
        try {
            Class.forName("org.sqlite.JDBC");
            connTest = DriverManager.getConnection("jdbc:sqlite:E:\\GitWorks\\AE2\\Database\\test_poi.db");
            Statement stmt0 = connTest.createStatement();
            stmt0.executeUpdate("CREATE TABLE if not exists poi(name string, type string, location string, likes INTEGER)");
            
            PoiDao daoTest = new PoiDao(connTest, "poi");
            Poi p1 = new Poi("Tokumbor", "Boutique", "Aba", 0);
            assertTrue(daoTest.addPoi(p1));
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
    public void testFindPoiByName() throws Exception {
        
        PoiDao daoTest = new PoiDao(connTest, "poi");
        Poi p2 = new Poi("Buka", "Restaurant", "Lagos", 2);
        daoTest.addPoi(p2);
        assertNotNull(daoTest.findPoiByName("Buka"));
    }
    
    @Test
    public void testFindPoiByLocation() throws Exception {
        
        PoiDao daoTest = new PoiDao(connTest, "poi");

        Poi p3 = new Poi("Zenith", "Bank", "Alaba", 1);
        daoTest.addPoi(p3);

        ArrayList<Poi> foundPoi = daoTest.findPoiByLocation("Alaba");
        for(Poi currPoi : foundPoi) {
            assertNotNull(currPoi);
            assertEquals("Alaba", currPoi.getLocation());
        }   
    }
    
    @Test
    public void testLikes() throws Exception {
        
        PoiDao daoTest = new PoiDao(connTest, "poi");
        assertTrue(daoTest.likePoi("Tokumbor"));
    }
    
    @Test
    public void testDisplayPoi() throws Exception {
        
        PoiDao daoTest = new PoiDao(connTest, "poi");

        ArrayList<Poi> foundPoi = daoTest.displayAllPois();
        for(Poi currPoi : foundPoi) {
            assertNotNull(currPoi);
        }   
    }
}
