<%-- 
    Document   : DemoPage
    Created on : 16 Apr, 2016, 8:34:31 PM
    Author     : hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="bootstrapfiles.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Demo Test Page</title>
        <script>
            function go()
            {
                var date = document.getElementById("date").value;
                if (date.length === 0)
                {
                    document.getElementById("demo_heading").innerHTML = "empty";

                }
                else
                {
                    document.getElementById("demo_heading").innerHTML = date;

                }
            }
        </script>
    </head>
    <body>
        <h1 id="demo_heading">Demo page</h1>
        <input type="date" id="date"/>
        <button onclick="go()">Go</button>
    </body>
</html>
