
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User SignUp_1</title>
        <%@include file="bootstrapfiles.jsp" %>
        <link rel="stylesheet" href="w3.css">

        <script>
            function validate()
            {
                var email = document.getElementById("email").value;
                var fn = document.getElementById("firstname").value;
                var ln = document.getElementById("lastname").value;
                var ulen = fn.length;
                var ph = document.getElementById("phone_no").value;

                var pwd = document.getElementById("password").value;
                var cpwd = document.getElementById("confirmpassword").value;
                var elen = email.length;
                var i = email.indexOf('@');
                var j = email.indexOf('.');
                var subemail = email.substring(i, elen);
                var k = subemail.indexOf('.');
                var plen = pwd.length;
                //alert(plen);
                if (ulen > 15)
                {
                    alert("First name cannot be of more than 15 characters");
                    return false;
                } else if (ln.length > 15)
                {
                    alert("Last name cannot be of more than 15 characters");
                    return false;
                } else if (!/^[a-zA-Z]+$/.test(fn))
                {
                    alert("First name cannot have number ");
                    return false;
                } else if (!/^[a-zA-Z]+$/.test(ln))
                {
                    alert("Last name cannot have number");
                    return false;
                } else if (plen < 8 || plen > 20)
                {
                    alert("Password length must be between 8 to 20 characters");
                    return false;
                } else if (pwd !== cpwd)
                {

                    alert("Password and confirm password should match");
                    return false;

                } else if (j === -1 || j === (i + 1))
                {

                    //alert("----");
                    alert("Invalid E-mail format");
                    return false;

                } else if (k === -1)
                {
                    alert("Invalid E-mail format");
                    return false;
                } else if (i === 0)
                {
                    alert("Invalid E-mail format");
                    return false;
                } else if (isNaN(ph))
                {
                    alert("invalid phone number");
                    //alert(ph);
                    return false;
                } else
                {
                    return true;
                }

            }
        </script>
    </head>
    <body style="background-image: url(images/signup_background.jpg); background-size: 100%;">
        <div class="w3-container w3-animate-zoom">
            <h2 >Sign Up </h2>
            <p>Please Note : After Sign Up ,you have to verify your account through the email sent.</p>
            <form role="form" action="user_signup_servlet" method="post" 
                  enctype="multipart/form-data">
                <div class="form-group">
                    <input type = "email" class="" id="email" name="email" placeholder="enter email" required/>
                </div>

                <div class="form-group">
                    <input type = "text" id="firstname" name="firstname" placeholder="first name" required/>
                </div>

                <div class="form-group">
                    <input type = "text" id="lastname" name="lastname" placeholder="last name" required/>
                </div>

                <div class="form-group">
                  <label>Profile Pic:</label>  <input type = "file" name="profile_pic"  required/>
                </div>
                <div class="form-group">
                    <input type = "text" id="phone_no" name="phone_no" placeholder="phone_no" required/>
                </div>

                <div class="form-group">
                    <input type = "password" id="password" name="password" placeholder="Enter Password" required/>
                </div>

                <div class="form-group">
                    <input type = "password" id="confirmpassword" name="confirmpassword" placeholder="Confirm Password" required/>
                </div>

                <div class="form-group">
                    <select name="security_question">
                        <option >What is you dog's name?</option>
                        <option >What is your favourite city?</option>
                        <option >What is your father's name?</option>
                        <option >What is your favourite food?</option>
                    </select>
                </div>

                <div class="form-group">
                    <input type = "text" name="security_answer" required/>

                </div>

                <div class="form-group">
                    <input type = "submit" class="w3-btn w3-orange" value="Submit" onclick="return validate()"/>
                </div>


            </form>

            <%
                String msg = request.getParameter("msg");
                if (msg != null)
                {
            %>
            <label style="color: red; font-style: italic;"><%=msg%></label>
            <%
                }
            %>
        </div>
    </body>
</html>
