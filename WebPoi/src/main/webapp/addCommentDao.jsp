<%-- 
    Document   : addCommentDao
    Created on : 23 Dec 2023, 22:43:46
    Author     : Joat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<%@page import="com.mycompany.webpoi.CommentDao" %>
<%@page import="com.mycompany.webpoi.Comment" %>
<%@page import="com.mycompany.webpoi.User" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>ADD COMMENT</h1>
        <br />
        <%
            
        Connection conn = null;
        
        try {
            Class.forName("org.sqlite.JDBC");
            conn = DriverManager.getConnection("jdbc:sqlite:E:\\GitWorks\\AE2\\Database\\poi.db");
            
            User user = (User) session.getAttribute("user");
            
            Statement stmt0 = conn.createStatement();
            stmt0.executeUpdate("CREATE TABLE if not exists comments(id INTEGER PRIMARY KEY AUTOINCREMENT, poiName String, username String, commentText text)");
            
            CommentDao cDao = new CommentDao(conn, "poi");
            
            String poiName = request.getParameter("name");
            String username = user.getUsername();
            String commentText = request.getParameter("comment");
            
            Comment c = new Comment(0, poiName, username, commentText);
            long id = cDao.addComment(c);
            
            if (id > 0) {
            
                if(user.isAdmin()) {
                    out.println("Comment successfully added. Click to Return to <a href='./adminPage.jsp'>Homepage</a>.");
                } else {
                    out.println("Comment successfully added. Click to Return to <a href='./userPage.jsp'>Homepage</a>.");
                }
            } else {
                    out.println("Error! Could not add comment. Click <a href='./commentForm.jsp'>HERE</a> to go back.");
            }
            
        } catch(SQLException e) {
            out.println("<strong>Error with database: " + e + "</strong>");
        }    
        finally {
            // Close the connection if it was made successfully
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
