

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="bootstrapfiles.jsp" %>
<%@include file="mynavbar.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Change Password_1</title>
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
            
            function goToHomePage()
            {
                window.location.href = "./user_home.jsp";
            }
        </script>
    </head>
    <body style="background-image: url(images/yellow_background.png); background-size: 100%; ">
        <%
            String userEmail = (String) session.getAttribute("user_email");
        %>
        <div class="w3-container w3-animate-zoom">
            <div class="w3-card-2" style="background-color: #ffd966;">
                <br>
                <h1>Change Password</h1>
                <br>
            </div>
            <br>
            <form role="form" action="user_change_password2.jsp" method="post" onsubmit="return go()">
                <div class="form-group">
                    <input class="form-control w3-pale-yellow"  type="text" name="email" value="<%=userEmail%>" readonly/>
                </div>
                
                <div class="form-group">
                    <input class="form-control" type="password" name="oldpassword" placeholder="Old Password" required/>
                </div>
                
                <div class="form-group">      
                    <input class="form-control" type="password" id="newpassword" name="newpassword" placeholder="New Password" required/>
                </div>
                
                <div class="form-group">
                    <input class="form-control" type="password"  id = "confirmpassword" placeholder="Confirm Password" required/>
                </div>
                
                <div class="form-group">
                    <input class="w3-btn w3-yellow w3-hover-amber" type="submit" value="Change"/>
                </div>
            </form>
        </div>
    </body>
</html>
