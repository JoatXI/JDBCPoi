<%-- 
    Document   : searchLocDao
    Created on : 21 Dec 2023, 22:58:24
    Author     : Joat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="com.mycompany.webpoi.Poi" %>
<%@page import="com.mycompany.webpoi.PoiDao" %>
<%@page import="com.mycompany.webpoi.User" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>SEARCH STUDENT BY LOCATION</h1>
        <br />
        <%

            Connection conn = null;

            try {
                Class.forName("org.sqlite.JDBC");
                conn = DriverManager.getConnection("jdbc:sqlite:E:\\GitWorks\\AE2\\Database\\poi.db");
                
                User user = (User) session.getAttribute("user");

                Statement stmt0 = conn.createStatement();
                stmt0.executeUpdate("CREATE TABLE if not exists poi(name string, type string, location string, likes integer)");

                PoiDao dao = new PoiDao(conn, "poi");
            
                String location = request.getParameter("location");

                ArrayList<Poi> venues = dao.findPoiByLocation(location);
                for(Poi p: venues) {
                    out.println(p + "<br />");
                }
                if(user.isAdmin()) {
                    out.println("Click to Return to <a href='./adminPage.jsp'>Homepage</a>.");
                } else {
                    out.println("Click to Return to <a href='./userPage.jsp'>Homepage</a>.");
                }
            }
            
            catch(SQLException e) {
                out.println("<strong>Error with database: " + e + "</strong>");
            }    
            finally {
                // Close the connection if it was made successfully
                if(conn != null) {
                    try {
                        conn.close();
                    }
                    catch(SQLException closeException) {
                        out.println("<strong>Error with closing database: " + closeException + "</strong>");
                    }
                }
            }
        %>
    </body>
</html>
