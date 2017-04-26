<%@page import="java.sql.*"%>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from user_signup where email='" + email + "' and password='" + password + "'");
    if (rs.next())
    {
        String user_pic = rs.getString("profilepic");
        String user_name = rs.getString("firstname") + " " + rs.getString("lastname");
        String phone_no=rs.getString("phoneno");
        String valid = rs.getString("varified_user");
        if (valid.equals("yes"))
        {
            session.setAttribute("user_email", email);
            session.setAttribute("user_pic", user_pic);
            session.setAttribute("user_name", user_name);
            session.setAttribute("phone_no",phone_no);
            response.sendRedirect("user_home.jsp");
        }
        else
        {
                    response.sendRedirect("user_login1.jsp?msg=First verfiy, to access your account");

        }

    } else
    {
        response.sendRedirect("user_login1.jsp?msg=Invalid username or password");
    }


%>