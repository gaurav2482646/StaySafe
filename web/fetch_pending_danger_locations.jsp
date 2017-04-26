<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.*" %>

<%
    
    response.setContentType("text/plain");
        //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin","root","root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from unsafe_place where status='"+"pending"+"'");
    String points="";
    if(rs.next())
    {
        rs.beforeFirst();
        while(rs.next())
        {
            String latitude  = rs.getString("latitude");
            String longitude  = rs.getString("longitude");
            points = points+latitude+"^"+longitude+"^";
        }
        out.println(points.substring(0, (points.length()-1)));
    }

%>