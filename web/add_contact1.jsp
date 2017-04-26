<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@include file="bootstrapfiles.jsp" %>
<%@include file="mynavbar.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Contact</title>
        <script>
            function checkLimitOfContacts()
            {
            <%
                String userEmail = (String) session.getAttribute("user_email");
                //JDBC CODE
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
                Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                ResultSet rs = stmt.executeQuery("select count(*) from user_contacts where user_email = '" + userEmail + "'");

                if (rs.next())
                {
                    int count = rs.getInt(1);
                    if (count == 5)
                    {
                        response.sendRedirect("user_home.jsp?msg=Cannot Add more contacts");
            %>
                return false;
            <%
            } else
            {
            %>
                return true;
            <%
                    }
                }

            %>
            }

            function validation()
            {
                var name = document.getElementById("contact_name").value;
                var num = document.getElementById("contact_no").value;
                if (!/^[a-zA-Z]+$/.test(name))
                {
                    alert("Name cannot have number or special character");
                    return false;
                }
                else if (name.length >15)
                {
                    alert("Name cannot be of more than 15 characters");
                    return false;
                }
                else if (num.length >10)
                {
                    alert("Name cannot be of more than 10 characters");
                    return false;
                }
                else if (isNaN(num))
                {
                    alert("invalid contact number");
                    return false;
                }
                else
                {
                    return true;
                }
            }

        </script>
    </head>
    <body style="background-image: url(images/yellow_background.png); background-size: 100%; " onload="return checkLimitOfContacts()">
        <div class="w3-container w3-animate-zoom">
            <div class="w3-card-2 " style="background-color: #ffd966;">
                <br>
                <h1>Add New Contact</h1>
                <p>Please Check The Credentials Twice</p>
                <br>
            </div>
            <br>
            <form role="form" action="add_contact2.jsp" method="post">
                <div class="form-group">
                    <input class="form-control" type="text" id="contact_name" name="contact_name" placeholder="Enter Contact Name" required/>

                </div>
                <div class="form-group">
                    <input class="form-control"  type="text" id="contact_no" name="contact_no" placeholder="Enter Contact Number" required/>

                </div>
                <div class="form-group">

                    <select  class="form-control" name="relation" required>
                        <option>Friends</option>
                        <option>Family</option>
                        <option>Colleagues</option>
                        <option>Work</option>
                        <option>Others</option>
                    </select>
                </div>
                <div class="form-group">
                    <input class="w3-btn w3-yellow w3-hover-amber" type="submit" value="Add" 
                           onclick="return validation()"/>
                </div>
            </form>

        </div>
    </body>
</html>
