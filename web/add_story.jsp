<%@page import="java.sql.*" %>
<%
    String email = (String)session.getAttribute("user_email");
//    String time = request.getParameter("time");
    String title = request.getParameter("title");
    String story = request.getParameter("story");
    String location = request.getParameter("location");
    //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin","root","root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from user_post"); 
    
    rs.moveToInsertRow();
    rs.updateString("posted_by",email);
//    rs.updateString("date",time);
    rs.updateString("story",story);
    rs.updateString("location",location);
    rs.updateString("title",title);
    rs.insertRow();
    
    response.sendRedirect("./user_home1.jsp");
    %>