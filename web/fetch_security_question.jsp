<%@page import = "java.sql.*" %>
<%

    String email = request.getParameter("email");
    //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from admin_login_details where email ='" + email + "'");
    if (rs.next())
    {
        session.setAttribute("email", email);
        String sec_ques = rs.getString("security_ques");
%>
<form role ="form-control" action='admin_forgot_password2.jsp' method='post' >
    <div class="form-group">
        <input class="form-control" type='text' name='security_question' value='<%=sec_ques%>'readonly/>
    </div>
    <div class="form-group">
        <input class = "form-control" type='text' name='security_answer' required/>
    </div>
    <div class="form-group">
        <input class="btn btn-success" type='submit' value='Submit' />

    </div>
</form>
<%
} else
{
%>


<p>Invalid Email</p>
<%
    }
%>