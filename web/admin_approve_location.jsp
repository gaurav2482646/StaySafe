<%@page import="java.util.StringTokenizer"%>
<%@page import="java.sql.*" %>
<%
    String msg = request.getParameter("msg");
    System.out.println("msg = " + msg);
    StringTokenizer st = new StringTokenizer(msg, "^");
    String lat = st.nextToken();
    String lng = st.nextToken();
    String fn = st.nextToken();
    String ln = st.nextToken();
    System.out.println("***** " + lat + lng + fn + ln);

    //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from unsafe_place where latitude = '" + lat + "' and longitude='" + lng + "' and marked_by = (select marked_by from user_signup,unsafe_place where user_signup.email = unsafe_place.marked_by and latitude='" + lat + "' and longitude='" + lng + "' and firstname='" + fn + "' and lastname='" + ln + "')");
    if (rs.next())
    {
        rs.updateString("status", "approved");
        rs.updateRow();
        out.println("Location Approved !");
    }

%>