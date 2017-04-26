
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Login_1</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.2.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>

    </head>
    <body style="background-image: url(images/simple_background.jpg); background-size: 100%;">
        <div class="container">
            <div class="jumbotron" style="background: khaki">
            <h1  >Administator Login</h1>
            <p>Welcome Admin</p>
            </div>
            <form action="admin_login2.jsp" role="form" method="post">

                <div class="form-group">
                    <input type="text"  class="form-control" name="email" placeholder="Email" required/>
                </div>  
                <div class="form-group">

                    <input type="password" name="password" class="form-control" placeholder="Password" required/>
                </div>  

                <div class="form-group">

                    <input type="submit" class="btn btn-primary "value="Login"/>
                </div>  


            </form>
            <br>
            <a href ="admin_forgot_password1.jsp" class="text-primary badge">Forgot password ?</a>
            <%
                String msg = request.getParameter("msg");
                if (msg != null) {
            %>
            <div class="alert alert-danger fade in" >
                <a href="#" class="close" data-dismiss="alert" label="close">&times;</a>
                <strong><%=msg%> !</strong> 
            </div>
            <%
                }
            %>
        </div>
    </body>
</html>
