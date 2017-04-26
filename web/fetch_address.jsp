<%@page import="java.util.StringTokenizer"%>
<%@page import="java.sql.*" %>
<%
     String msg = request.getParameter("msg") ;
     StringTokenizer st = new StringTokenizer (msg,"^");
     String lat = st.nextToken();
     String lng = st.nextToken();
    //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin","root","root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from unsafe_place where "
            + "latitude='"+lat+"' and longitude='"+lng+"'");
    if(rs.next())
    {
        out.println(rs.getString("location_address")+"<br>Approved Status : "+rs.getString("status"));
    }
    else
    {
        out.println("no address found");
    }
    
%>