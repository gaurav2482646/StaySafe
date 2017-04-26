

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Change Password_1</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.2.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>

        <script>
            function go()
            {
                var np = document.getElementById("newpassword").value;
                var cp = document.getElementById("confirmpassword").value;
                if (np != cp)
                {
                    alert("new password and confirm password don't match !");
                    return false;
                }
                else
                {
                    return true;
                }

            }
        </script>
    </head>
    <body>
        <%
            String adminEmail = (String) session.getAttribute("admin_email");
        %>
        <div class="container">
            <h2>Change Password .. </h2>
            <form role="form" action="admin_change_password2.jsp" method="post" onsubmit="return go()">
                <div class="form-group">
                    <input  type="text" name="email" value="<%=adminEmail%>" readonly/>
                </div>
                <div class="form-group">
                    <input type="password" name="oldpassword" placeholder="Old Password" required/>
                </div>
                <div class="form-group">
                    <input  type="password" id="newpassword" name="newpassword" placeholder="New Password" required/>
                </div>
                <div class="form-group">
                    <input  type="password"  id = "confirmpassword" placeholder="Confirm Password" required/>
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-primary " value="Change"/>
                </div>  
            </form>
        </div> 
    </body>
</html>
