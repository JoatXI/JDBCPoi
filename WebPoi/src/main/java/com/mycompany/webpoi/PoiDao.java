package com.mycompany.webpoi;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Joat
 */
/**
 * Represents a collection of points of interest (POIs) for a specific location.
 * Each Location object has a name and stores POIs in an ArrayList.
 */
public class PoiDao {
    
    private Connection conn;
    private String table;

   
    public PoiDao(Connection conn, String table) {
        this.conn = conn;
        this.table = table;
    }
    
    public boolean addPoi(Poi p) throws SQLException {
        PreparedStatement pStmt = conn.prepareStatement("INSERT INTO poi(name, type, location, likes) VALUES (?, ?, ?, ?)");
        pStmt.setString(1, p.getName());
        pStmt.setString(2, p.getType());
        pStmt.setString(3, p.getLocation());
        pStmt.setInt(4, p.getLikes());

        int rowsAdded = pStmt.executeUpdate();

        // Was a row added successfully?
        if(rowsAdded > 0) {
            // If so, get the keys added
            return true;
        }
        return false;
    }
    
    /**
     * Finds a POI by its name.
     * 
     * @param poiName The name of the POI to find.
     * @return The found Poi object or null if not found.
     **/
    public ArrayList<Poi> findPoiByName(String name) throws SQLException {
        ArrayList<Poi> result = new ArrayList<>();
        PreparedStatement pStmt = conn.prepareStatement("SELECT * FROM " + table + " where name=?");
        pStmt.setString(1, name);
        ResultSet rs = pStmt.executeQuery();

        // Loop through the results
        while(rs.next()) {
            // Create an Event object with each result and add it to the
            // ArrayList

            Poi p = new Poi(
                    rs.getString("name"),
                    rs.getString("type"),
                    rs.getString("location")
            );
            result.add(p);
        }
        return result;
    }
    
    /**
     * Finds and returns all POIs with a specific type.
     * 
     * @param type The type of POIs to search for.
     * @return A list of Poi objects with the specified type.
     */
    public ArrayList<Poi> findPoiByType(String type) throws SQLException {
        ArrayList<Poi> result = new ArrayList<>();
        PreparedStatement pStmt = conn.prepareStatement("SELECT * FROM " + table + " where type=?");
        pStmt.setString(1, type);
        ResultSet rs = pStmt.executeQuery();

        // Loop through the results
        while(rs.next()) {
            // Create an Event object with each result and add it to the
            // ArrayList

            Poi p = new Poi(
                    rs.getString("name"),
                    rs.getString("type"),
                    rs.getString("location")
            );
            result.add(p);
        }
        return result;
    }
    
    /**
     * Finds and returns all POIs with a specific location.
     * 
     * @param searchLocation The location of POIs to search for.
     * @return A list of Poi objects at the specified location.
     */
    public ArrayList<Poi> findPoiByLocation(String location) throws SQLException {
        ArrayList<Poi> result = new ArrayList<>();
        PreparedStatement pStmt = conn.prepareStatement("SELECT * FROM " + table + " where location=?");
        pStmt.setString(1, location);
        ResultSet rs = pStmt.executeQuery();

        // Loop through the results
        while(rs.next()) {
            // Create an Event object with each result and add it to the
            // ArrayList

            Poi p = new Poi(
                    rs.getString("name"),
                    rs.getString("type"),
                    rs.getString("location")
            );
            result.add(p);
        }
        return result;
    }
    
    public boolean likePoi(String name) throws SQLException {
        // Check if "likes" column exists, and create it if not
        Statement stmt = conn.createStatement();
        stmt.executeUpdate("CREATE TABLE IF NOT EXISTS poi (name string, type string, location string, likes INTEGER DEFAULT 0)");
        
        PreparedStatement pStmt = conn.prepareStatement("UPDATE poi SET likes = likes + 1 WHERE name=?");
        pStmt.setString(1, name);

        int rowsUpdated = pStmt.executeUpdate();

        if(rowsUpdated > 0) {
            return true;
        }
        return false;
    }
    
    public ArrayList<Poi> displayAllPois() throws SQLException {
        ArrayList<Poi> poiList = new ArrayList<>();

        String query = "SELECT * FROM " + table;
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()) {
                String name = resultSet.getString("name");
                String type = resultSet.getString("type");
                String location = resultSet.getString("location");

                Poi poi = new Poi(name, type, location);
                poiList.add(poi);
            }
        }
        return poiList;
    }
}