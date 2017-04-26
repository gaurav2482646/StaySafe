<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Contact</title>
        <link href="w3.css" rel="stylesheet" type="text/css"/>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.2.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>

    </head>
    <body>
        <%
            int contactId = Integer.parseInt(request.getParameter("cid"));
            //JDBC
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = stmt.executeQuery("select * from user_contacts where cid=" + contactId);

            if (rs.next()) {
                String contactName = rs.getString("contact_name");
                String contactNo = rs.getString("contact_no");
                String relation = rs.getString("relation");

        %>
        
            <form role="form" action="edit_contact2.jsp?cid=<%=contactId%>" method="post">
                <div class="form-group">
                    <input type="text" class="form-control w3-hover-pale-yellow" name="contactname" value="<%=contactName%>"/>
                </div>        

                <div class="form-group">

                    <input type="text" class="form-control w3-hover-pale-yellow " name="contactnumber" value="<%=contactNo%>"/>
                </div>
                <div class="form-group">

                    <select class=" btn w3-hover-pale-yellow" name="relation" required>
                        <option>Friends</option>
                        <option>Family</option>
                        <option>Colleagues</option>
                        <option>Work</option>
                        <option>Others</option>
                    </select>
                </div>
                <div class="form-group">
                    <input type="submit" class="w3-btn w3-yellow w3-hover-amber pull-right" value="Save"/>
                </div>
            </form>

            <%
                }

            %>

    </body>
</html>
