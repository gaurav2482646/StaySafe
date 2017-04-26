
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="mynavbar.jsp" %>
<!DOCTYPE html>
<%
    String email = (String) session.getAttribute("user_email");

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Live Tracking</title>
        <link href="w3.css" rel="stylesheet" type="text/css"/>
        <script src="http://maps.googleapis.com/maps/api/js"></script>
        <script>
            var map;

            var pointArray = [];

            function initialize()
            {
                var mapProp = {
                    zoom: 9,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
            }


            function goToHomePage()
            {
                window.location.href = "./user_home.jsp";
            }

            function fetchPoints()
            {


                setInterval(function ()
                {

                    pointArray.splice(0, pointArray.length);
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.onreadystatechange = function ()
                    {
                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                        {
                            document.getElementById("googleMap").style.display = "block";
                            document.getElementById("spinning_icon").style.display = "none";
                            var loc = xmlhttp.responseText;
                            var lat_lng = loc.split("^");
//                        console.log("length" + lat_lng.length);
                            if (lat_lng.length > 1)
                            {
                                for (var i = 0; i < lat_lng.length; i = i + 2)
                                {
                                    var lat = lat_lng[i].trim().valueOf();
                                    var lng = lat_lng[i + 1].trim().valueOf();
                                    var x = new google.maps.LatLng(lat, lng);
                                    map.setCenter(x);
                                    map.setZoom(18);
                                    pointArray[pointArray.length] = x;

                                }
                            }
                        }
                        var path = new google.maps.Polyline({
                            path: pointArray,
                            strokeColor: "#FF0000",
                            strokeOpacity: 0.8,
                            strokeWeight: 3
                        });

                        path.setMap(map);
//                        alert("length :  " + pointArray.length);

                    };
                    xmlhttp.open("GET", "./fetchlatlngServlet?email=<%=email%>", true);
                    xmlhttp.send();
                }, 10000);
            }

            google.maps.event.addDomListener(window, 'load', initialize);
        </script>

    </head>
    <body onload="fetchPoints()" style="background-image: url(images/yellow_background.png); background-size: 100%; ">

        <div class="w3-container w3-animate-zoom">
            <div class="w3-card-2">
                <header class="w3-container " style="background-color: #ffd966;">
                    <h1 >Live Tracking</h1>
                </header>

                <p id="spinning_icon" class="center-block"><i class="fa fa-spinner w3-spin" style="font-size:64px"></i></p>


                <div id="googleMap" class="img-thumbnail center-block" style="width: 1000px; height:600px; 
                     display: none; padding-top: 10px;" ></div>

            </div>
        </div>
    </body>
</html>
