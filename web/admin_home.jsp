
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Home</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.2.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>

        
    </head>
    <body style="background-image: url(images/pale-yellow.jpg); background-size: 100%;">
        <div class="container" >
            <%
                String adminEmail = (String) session.getAttribute("admin_email");

            %>
            <div class="jumbotron" style="background-color:  #f0e68c">
                <h2>Welcome Admin</h2>
                <p style="color: goldenrod"><%=adminEmail%><p>
            </div>
            <a href="admin_change_password1.jsp" class="btn btn-block btn-default">Change Password</a>
            <br>
            <a href="admin_view_pending_locations.jsp" class="btn btn-block btn-success btn-lg">View All Pending Locations</a>
            <br>
            <br>
            <a href="admin_login1.jsp" class="badge">Logout?</a>

            <%
                String msg = request.getParameter("msg");
                if (msg != null) {
            %>
            <div class="alert alert-success fade in">
                <a href="#" class="close" data-dismiss="alert" label="close">&times;</a>
                <strong><%=msg%>!</strong> 
            </div>

            <%
                }
            %>
        </div>
    </body>
</html>
