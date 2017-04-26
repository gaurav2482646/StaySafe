<%@page import="java.sql.*"%>
<%
    String userEmail = request.getParameter("email");
    String oldPassword = request.getParameter("oldpassword");
    String newPassword = request.getParameter("newpassword");
    
    //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin","root","root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from user_signup where email='"+userEmail+"' and password='"+oldPassword+"'");
    if(rs.next())
    {
        rs.updateString("password", newPassword);
        rs.updateRow();
        response.sendRedirect("user_home.jsp?msg=Password changed successfully");
    }
    else
    {
        session.removeAttribute("user_email");
        response.sendRedirect("user_login1.jsp?msg=You provide wrong input");
    }






%>