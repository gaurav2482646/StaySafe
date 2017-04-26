<%@page import="java.util.StringTokenizer"%>
<%@page import="java.sql.*" %>
<%
     String msg = request.getParameter("msg") ;
     System.out.println("msg = "+msg);
     StringTokenizer st = new StringTokenizer (msg,"^");
     String lat = st.nextToken();
     String lng = st.nextToken();
    //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin","root","root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
//    ResultSet rs = stmt.executeQuery("select * from danger_locations where "
//            + "latitude='"+lat+"' and longitude='"+lng+"'");
    ResultSet rs = stmt.executeQuery("select * from user_signup,unsafe_place where user_signup.email = unsafe_place.marked_by and latitude='"+lat+"' and longitude='"+lng+"'");
    if(rs.next())
    {
        out.println(rs.getString("location_address")+"<br> MARKED_BY : "+rs.getString("firstname")+" "+rs.getString("lastname"));
    }
    else
    {
        out.println("no address found");
    }
    
%>