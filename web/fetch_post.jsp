<%@page import="java.sql.*" %>
<%
    int pid = Integer.parseInt(request.getParameter("pid"));
    //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/withu","root","system");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from user_posts where pid="+pid); 
    
    if(rs.next())
    {
        String title = rs.getString("title");
        String story = rs.getString("story");
        String location = rs.getString("location");
        String posted_by = rs.getString("posted_by");
        
                

    }
    
    %>