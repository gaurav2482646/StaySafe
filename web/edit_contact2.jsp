<%@page import="java.sql.*" %>
<%
    int contactId = Integer.parseInt(request.getParameter("cid"));
    String contactName = request.getParameter("contactname");
    String contactNo = request.getParameter("contactnumber");
    String relation = request.getParameter("relation");

    
    //JDBC
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from user_contacts where cid=" + contactId);

    if (rs.next()) {
        rs.updateString("contact_name", contactName);
        rs.updateString("contact_no", contactNo);
        rs.updateString("relation", relation);
        rs.updateRow();
        response.sendRedirect("view_contacts1.jsp?msg=Contact Updated Successfully");
    } else {
        response.sendRedirect("view_contacts1.jsp?msg=Contact Not found");

    }

%>
