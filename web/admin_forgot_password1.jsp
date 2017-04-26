
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Forgot password_1</title>
        <%@include file="bootstrapfiles.jsp" %>
        <script>
            function go1()
            {
                var xmlhttp = new XMLHttpRequest();
                var email = document.getElementById("email").value;
                xmlhttp.onreadystatechange=function()
                {
                  if(xmlhttp.readyState == 4 && xmlhttp.status == 200)
                  {
                      document.getElementById("div1").style.display = "block";
                      document.getElementById("div1").innerHTML = xmlhttp.responseText;
                  }
                };
                xmlhttp.open("GET","./fetch_security_question.jsp?email="+email,true);
                xmlhttp.send();
            }
        
        
        
        </script>
            
    </head>
    <body>
        <div class="container">
            <input type="text" placeholder="Email id" name="email" id="email" required />
        <input type="button" class="btn btn-primary" id="go_button" value="Go" onclick="go1()"/>
        <br><hr>
        <div id="div1" style="border: 2px solid #262626; display: none;" class="btn"></div>
        </div>
    </body>
</html>
