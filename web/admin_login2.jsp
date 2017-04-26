<%@page import="java.sql.*"%>
<%
    String adminEmail = request.getParameter("email");
    String adminPassword = request.getParameter("password");
    
    //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin","root","root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from admin_login_details where email='"+adminEmail+"' and password='"+adminPassword+"'");
    if(rs.next())
    {
        session.setAttribute("admin_email", adminEmail);
        response.sendRedirect("admin_home.jsp");
    }
    else
    {
        response.sendRedirect("admin_login1.jsp?msg=Invalid username or password");
    }




%>