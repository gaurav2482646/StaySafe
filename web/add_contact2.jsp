<%@page import="java.sql.*"%>
<%
    String userEmail = (String) session.getAttribute("user_email");
    String contactName = request.getParameter("contact_name");
    String contactNo = request.getParameter("contact_no");
    String relation = request.getParameter("relation");
    
    //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin","root","root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from user_contacts ");
    
    rs.moveToInsertRow();
    rs.updateString("contact_name", contactName);
    rs.updateString("contact_no", contactNo);
    rs.updateString("relation", relation);
    rs.updateString("user_email",userEmail);
    rs.insertRow();
    
    response.sendRedirect("view_contacts1.jsp?msg=Contact added successfully");


%>