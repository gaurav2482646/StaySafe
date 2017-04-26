<%@page import="java.sql.*"%>
<%
    String email = (String) session.getAttribute("email");
    String sec_que = request.getParameter("security_question");
    String sec_ans = request.getParameter("security_answer");
    
    //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin","root","root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from admin where email='"+email+"' and security_ques='"+sec_que+"' and security_ans='"+sec_ans+"'");
    if(rs.next())
    {
        String password = rs.getString("password");
        response.sendRedirect("admin_login1.jsp?msg=Your Password is "+password);
    }
    else
    {
        response.sendRedirect("admin_login1.jsp?msg=You provide wrong info");
    }




%>