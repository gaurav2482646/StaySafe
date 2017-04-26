<%-- 
    Document   : live_tracking
    Created on : 9 May, 2016, 12:27:04 PM
    Author     : hp
--%>

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
            var zoom_level = 9;
            var myCenter = new google.maps.LatLng(31.633980, 74.872261);
            var pointArray = [];
            var i = 0;
            function initialize()
            {
                var mapProp = {
                    center: myCenter,
                    zoom: 9,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
                if (i == 1)
                {
                    fetchPoints();
                }
            }

            function incrementI()
            {
                var date = document.getElementById("date").value;

                if (date.length === 0)
                {
                    alert("Select a date first");
                }
                else
                {
                    i = 1;
                    initialize();
                }

            }

            function fetchPoints()
            {
                var date = document.getElementById("date").value;

                pointArray.splice(0, pointArray.length);

                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        var loc = xmlhttp.responseText;
//                        alert(loc);
//                        if (loc === "Cannot track the device on this day")
//                        {
//                            alert(loc);
//                        }
//                        else
                        {
                            var lat_lng = loc.split("^");
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
                                    if (pointArray.length == 1)
                                    {
                                        var marker = new google.maps.Marker({
                                            position: x,
                                            map: map
                                        });
                                    }

                                }
                            }
                            
                            else
                            {
                                alert("Cannot track the device on this date")
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
                };
                xmlhttp.open("GET", "./fetchlatlngonSpecificDateServlet?email=<%=email%>&date=" + date, true);
                xmlhttp.send();
            }
            google.maps.event.addDomListener(window, 'load', initialize);
        </script>

    </head>
    <body style="background-image: url(images/yellow_background.png); background-size: 100%; ">

        <div class="w3-container w3-animate-zoom">
            <div class="w3-card-2">
                <header class="w3-container " style="background-color: #ffd966;">
                    <h1>Find Me on Date</h1>
                    <div class="row">
                        <input id="date" type="date"/>
                        <button class="w3-btn w3-yellow w3-hover-amber" onclick="incrementI()">go</button>

                    </div>
                </header>


                <div id="googleMap" class="img-thumbnail center-block" style="width: 1500px; height:500px; 
                     padding-top: 10px;" ></div>

            </div>
        </div>

    </body>
</html>
