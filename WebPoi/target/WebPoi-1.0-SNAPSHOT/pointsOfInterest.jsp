<%-- 
    Document   : pointsOfInterest
    Created on : 22 Dec 2023, 00:42:36
    Author     : Joat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="com.mycompany.webpoi.Poi" %>
<%@page import="com.mycompany.webpoi.PoiDao" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Points Of Interest</h1>
        
        <%
            Connection conn = null;

            try {
                Class.forName("org.sqlite.JDBC");
                conn = DriverManager.getConnection("jdbc:sqlite:S:\\GitWorks\\AE2\\Database\\poi.db");

                Statement stmt0 = conn.createStatement();
                stmt0.executeUpdate("CREATE TABLE if not exists poi(name string, type string, location string, likes integer)");

                PoiDao dao = new PoiDao(conn, "poi");
                
                
                ArrayList<Poi> poiList = dao.displayAllPois();

                // Loop through and display the POIs
                for (Poi currentPoi : poiList) {
                    // Display information about the current POI
                    %>
                    <p>POI Name: <%= currentPoi.getName() %></p>
                    
                    <form action="./likePoiDao.jsp" method="post">
                        <input type="hidden" name="poiName" value="<%=currentPoi.getName()%>" />
                        <input type="submit" value="Like" />
                    </form>
                    <%
                }
            } catch(SQLException e) {
                out.println("<strong>Error with database: " + e + "</strong>");
            }    
            finally {
                if(conn != null) {
                    try {
                        conn.close();
                    } catch(SQLException closeException) {
                        out.println("<strong>Error with closing database: " + closeException + "</strong>");
                    }
                }
            }
        %>
    </body>
</html>
