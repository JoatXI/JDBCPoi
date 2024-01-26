<%-- 
    Document   : viewCommentsDao
    Created on : 24 Dec 2023, 21:26:54
    Author     : Joat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.util.ArrayList" %>
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
        <h1>VIEW COMMENTS</h1>
        <br />
        <%
            Connection conn = null;

            try {
                Class.forName("org.sqlite.JDBC");
                conn = DriverManager.getConnection("jdbc:sqlite:E:\\GitWorks\\AE2\\Database\\poi.db");

                User user = (User) session.getAttribute("user");

                Statement stmt0 = conn.createStatement();
                stmt0.executeUpdate("CREATE TABLE if not exists comments(name string, username string, password string)");

                CommentDao cDao = new CommentDao(conn, "comments");
                
                String poiName = request.getParameter("poiName");
                
                ArrayList<Comment> commentList = cDao.displayComments(poiName);

                for (Comment currComment : commentList) {
                    // Displays each POI comment details
                    %>
                    <p>ID: <%= currComment.getId() %></p>
                    <p>Username: <%= currComment.getUser() %></p>
                    <p>Comment: <%= currComment.getCommentText() %></p>
                    <hr>
                    <%
                    if(user.isAdmin()) {
                        %>
                        <form action="./deleteCommentDao.jsp" method="post">
                            <input type="hidden" name="id" value="<%=currComment.getId()%>" />
                            <input type="submit" value="Delete Comment" />
                        </form>
                        <%
                    }
                }
                %><br /><%
                if(user.isAdmin()) {
                    out.println("No Comment Found for " + poiName + " Click to Return to <a href='./adminPage.jsp'>Homepage</a>.");
                } else {
                    out.println("No Comment Found for " + poiName + " Click to Return to <a href='./userPage.jsp'>Homepage</a>.");
                }

            } catch (SQLException e) {
                out.println("<strong>Error with database: " + e + "</strong>");
            } finally {
                // Close the connection if it was made successfully
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException closeException) {
                        out.println("<strong>Error with closing database: " + closeException + "</strong>");
                    }
                }
            }
        %>
    </body>
</html>
