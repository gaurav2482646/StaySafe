<%@page import="java.sql.*"%>
<%
    String email = request.getParameter("email");
    String code = request.getParameter("code");

    //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from user_signup where email='" + email + "' and validation_code='" + code + "'");
    if (rs.next())
    {
        rs.updateString("varified_user", "yes");
        rs.updateRow();
        response.sendRedirect("user_login1.jsp?msg=Account verified");

    } else
    {
        response.sendRedirect("user_login1.jsp?msg=Invalid email or code");
    }


%>