<%@page import="java.sql.*" %>
<%
    int pid = Integer.parseInt(request.getParameter("pid"));
    //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin","root","root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from user_post where pid='"+pid+"'"); 
    
    if(rs.next())
    {
        rs.deleteRow();
        response.sendRedirect("./user_home1.jsp?msg=post deleted successfully");
    }
    
    %>