<%@page import="java.sql.*"%>
<%
    String pid = request.getParameter("pid");
    
    //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/withu","root","system");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("    ");
    if(rs.next())
    {
        
    }
    else
    {
    
    }




%>