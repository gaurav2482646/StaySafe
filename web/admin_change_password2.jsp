<%@page import="java.sql.*"%>
<%
    String adminEmail = request.getParameter("email");
    String oldPassword = request.getParameter("oldpassword");
    String newPassword = request.getParameter("newpassword");
    
    //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin","root","root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from admin_login_details where email='"+adminEmail+"' and password='"+oldPassword+"'");
    if(rs.next())
    {
        rs.updateString("password", newPassword);
        rs.updateRow();
        response.sendRedirect("admin_home.jsp?msg=Password changed successfully");
    }
    else
    {
        session.removeAttribute("admin_email");
        response.sendRedirect("admin_login1.jsp?msg=You provide wrong input");
    }






%>