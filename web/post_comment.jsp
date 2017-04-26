<%@page import="java.sql.*" %>
<%
    String email = (String) session.getAttribute("user_email");
    int pid = Integer.parseInt(request.getParameter("pid"));
    String comment = request.getParameter("comment");
    //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin","root","root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from comment "); 
    
    rs.moveToInsertRow();
    rs.updateString("comment_by",email);
    rs.updateString("comment",comment);
    rs.updateInt("postid",pid);
    rs.insertRow();
    
    %>