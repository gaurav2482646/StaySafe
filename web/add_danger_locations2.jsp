<%@page import="java.util.StringTokenizer"%>
<%@page import="java.sql.*" %>
<%
    String email = (String)session.getAttribute("user_email");
    String msg = request.getParameter("msg");
    StringTokenizer st = new StringTokenizer(msg,"^");
    String latitude = st.nextToken();
    String longitude = st.nextToken();
    String address = st.nextToken();
    String city = st.nextToken();

        //JDBC CODE
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin","root","root");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("select * from unsafe_place");
    
    rs.moveToInsertRow();
    rs.updateString("latitude", latitude);
    rs.updateString("longitude",longitude);
    rs.updateString("location_address",address);
    rs.updateString("location_name",city);
    rs.updateString("marked_by",email);
    rs.insertRow();
    
    response.sendRedirect("add_danger_locations.jsp");



%>