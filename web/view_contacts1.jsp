
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="mynavbar.jsp" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Contact</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.2.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>

        <script>
            function displayDivEditContact(cid)
            {
                var cId = cid;
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {

                        document.getElementById("innerEditDiv").innerHTML = xmlhttp.responseText;
                    }
                };
                xmlhttp.open("GET", "./edit_contact1.jsp?cid=" + cId, true);
                xmlhttp.send();
            }

            function deleteContact(cid)
            {
                var ans = confirm("Are you sure to delete this contact");
                if (ans == true)
                {
                    var xml = new XMLHttpRequest();
                    xml.onreadystatechange = function ()
                    {
                        if (xml.readyState == 4 && xml.status == 200)
                        {
                            window.location.reload();
                        }
                    };
                    xml.open("GET", "DeleteContactServlet?cid=" + cid, true);
                    xml.send();
                }

            }


            
        </script>
    </head>
    <body style="background-image: url(images/yellow_background.png); background-size: 100%; ">
        <div class="w3-container w3-animate-zoom">
            
            <%
                String userEmail = (String) session.getAttribute("user_email");
                //JDBC CODE
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
                Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                ResultSet rs = stmt.executeQuery("select * from user_contacts where user_email='" + userEmail + "'");

                if (rs.next())
                {
            %>
            <table class="w3-bordered w3-large  " border="1" cellpadding="5"  style="margin-top: 10px;">
                <thead>
                    <tr style="background-color: #ffd966;">
                <th>Contact Name</th>
                <th>Contact Number</th>
                <th>Relation</th>
                <th>Edit</th>
                <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        rs.beforeFirst();
                        while (rs.next())
                        {
                            int contactId = rs.getInt("cid");
                            String contactName = rs.getString("contact_name");
                            String contactNo = rs.getString("contact_no");
                            String relation = rs.getString("relation");

                    %>
                    <tr class="w3-hover-pale-yellow">
                        <td><%=contactName%></td>
                        <td><%=contactNo%></td>
                        <td><%=relation%></td>
                        <td><button class="btn btn-link" data-toggle="modal" data-target="#myModal" onclick="displayDivEditContact('<%=contactId%>')">Edit</button></td>
                        <td><button class="btn btn-link" onclick="deleteContact('<%=contactId%>')">Delete</button></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
            } else
            {
            %>
            <p style="color: red; font-style: italic">No records found !</p>
            <br>
            <a href="add_contact1.jsp">Add Contacts</a>

            <%
                }
                String msg = request.getParameter("msg");
                if (msg != null)
                {
            %>
            <div class="alert alert-success fade in">
                <a href="#" class="close" data-dismiss="alert" label="close">&times;</a>
                <strong><%=msg%>!</strong> 
            </div>
            <%
                }

            %>


        </div>

        <!-- Modal -->
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    
                    <div class="modal-header w3-yellow">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Edit contact</h4>
                    </div>
                    
                    <div id="innerEditDiv" class="modal-body "></div>
                    
                    <!--<div class="modal-footer"></div>-->
                    <br>
                    <br>
                </div>

            </div>
        </div>
    </body>
</html>
