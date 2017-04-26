
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Login_1</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.2.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="w3.css">
        <script>

            history.pushState(null, null, '');
            window.addEventListener('popstate', function (event) {
                history.pushState(null, null, 'user_login1.jsp');
            });
        </script>
        <!--        <style> 
                    html { 
                        background: url(images/login_background.jpg) no-repeat center center fixed; 
                        background-size: cover;
                    }
                </style>-->
    </head>
    <body style="background-image: url(images/background1.jpg); background-size: 100%;">

        <div class="w3-container w3-animate-opacity" style="padding-left: 20px">
            <div class="w3-xxlarge w3-amber">

                <p class="w3-text-shadow text-center w3-text">Login </p>
            </div>

            <br>
            <br>
            <div class="w3-container w3-card-4 w3-centered">
                <br>
                <form role="form"  action="user_login2.jsp" method="post">
                    <div class="form-group">
                        <label>Email:</label>
                        <input type="text" class=" w3-text-orange" name="email" placeholder="enter email" required/>

                    </div>

                    <div class="form-group">
                        <label>Password:</label>
                        <input type="password" class=" w3-text-khaki" name="password" placeholder="enter password" required/>

                    </div>
                    <br>

                    <div class="form-group">

                        <input class="btn btn-primary w3-btn w3-orange" type="submit" value="Login"/>

                    </div>


                </form>

                <br>
                <br>
                <a href="user_forgot_password1.jsp" class="w3-text-shadow w3-text-deep-orange">Forgot Password?</a>
                <br>
                <a href="user_signup1.jsp" class="w3-text-shadow w3-text-deep-orange" >Don't Have A Account ?</a>

                <br>
                <br>
                <a class="btn btn-primary w3-btn w3-small w3-khaki" href="verify_account1.jsp">Verify Existing Account</a>
                <br>
                <br>
            </div>
            <br>

            <%
                String msg = request.getParameter("msg");
                if (msg != null)
                {
            %>
            <div class="alert alert-danger fade in" >
                <a href="#" class="close" data-dismiss="alert" label="close">&times;</a>
                <strong><%=msg%> !</strong> 

            </div>

            <%
                }

            %>


<!--<footer class="w3-container w3-khaki">
  <h5>StaySafe</h5>
  <p>Developed and Designed By Gauravjeet Singh</p>
</footer>-->


        </div>
    </body>
</html>
