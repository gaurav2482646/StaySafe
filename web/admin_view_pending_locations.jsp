<%-- 
    Document   : view_all_danger_locations
    Created on : 15 Apr, 2016, 10:44:04 AM
    Author     : hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View All Danger Locations</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.2.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="http://maps.googleapis.com/maps/api/js"></script>
        <script>
            var map;
            var zoom_level = 9;
            var myCenter = new google.maps.LatLng(31.633980, 74.872261);

            function initialize()
            {
                var mapProp = {
                    center: myCenter,
                    zoom: zoom_level,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
                viewAllPendingLoactions();
            }

            function viewAllPendingLoactions()
            {
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        var loc = xmlhttp.responseText;
                        var lat_lng = loc.split("^");
//                        console.log("length" + lat_lng.length);
                        if (lat_lng.length > 1)
                        {
                            for (var i = 0; i < lat_lng.length; i = i + 2)
                            {
                                var lat = lat_lng[i].trim().valueOf();
                                var lng = lat_lng[i + 1].trim().valueOf();

                                getLocationDetails(lat, lng);
                            }
                        }
                    }
                };
                xmlhttp.open("GET", "./fetch_pending_danger_locations.jsp", true);
                xmlhttp.send();
            }

            function getLocationDetails(latitude, longitude)
            {
                var geocoder;
                geocoder = new google.maps.Geocoder();
                var latlng = new google.maps.LatLng(latitude, longitude);
                geocoder.geocode({'latLng': latlng}, function (results, status)
                {
                    if (status == google.maps.GeocoderStatus.OK)
                    {
                        if (results[0])
                        {
                            var add = results[0].formatted_address;
                            var value = add.split(",");
                            count = value.length;
                            country = value[count - 1];
                            state = value[count - 2];
                            var city = value[count - 3];
                            placeMarker(new google.maps.LatLng(latitude, longitude));

                        }
                        else
                        {
                            alert("no address found");
                        }
                    }
                    else
                    {
//                        console.log("geo coder failed with status " + status);
                        setTimeout(function () {
                            getLocationDetails(latitude,longitude);
                        }, 200);
//                        alert("geo coder failed with status " + status);
                    }
                }
                );
            }

            function placeMarker(location)
            {
                var marker;
                marker = new google.maps.Marker({
                    position: location,
                    map: map,
//                    title: 'lat: ' + location.lat() + ', long: ' + location.lng()
                });
                addInfoWindow(marker, location);
            }

            function addInfoWindow(marker, location)
            {
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        var address = xmlhttp.responseText;
                        marker.info = new google.maps.InfoWindow({
                            content: address
                        });

                        marker.addListener('mouseover', function () {
                            marker.info.open(map, marker);
                        });

                        marker.addListener('mouseout', function () {
                            marker.info.close();
                        });

                        marker.addListener('click', function ()
                        {
                            displayApproveDiv(location.lat(), location.lng(), address);
                        });

                    }
                };
                xmlhttp.open("GET", "./fetch_approved_addresses.jsp?msg=" + location.lat() + "^" + location.lng(), true);
                xmlhttp.send();
            }

            function displayApproveDiv(lat, lng, address)
            {
                document.getElementById("approveDiv").style.display = "block";
                var editContactDiv = document.getElementById("approveDiv");
                var divWidth = editContactDiv.clientWidth;
                var divHeight = editContactDiv.clientHeight;
                var screenWidth = window.innerWidth;
                var screenHeight = window.innerHeight;
                var l = screenWidth / 2 - divWidth / 2;
                var t = screenHeight / 2 - divHeight / 2;
                editContactDiv.style.left = l + "px";
                editContactDiv.style.top = t + "px";

                document.getElementById("lbAddress").innerHTML = address;
                document.getElementById("lbLatLng").innerHTML = lat + "^" + lng;
            }

            function hideApproveDiv()
            {
                document.getElementById("approveDiv").style.display = "none";
            }

            function ApproveMarkedLocation()
            {
//                    to get first name and last name from address
                var add = document.getElementById("lbAddress").innerHTML;
                var x = new Array();
                x = add.split(" ");
                var ln = x[x.length - 1];
                var fn = x[x.length - 2];

//                   to get latitude and longitude 
                var lat_lng = document.getElementById("lbLatLng").innerHTML;
                var y = new Array();
                y = lat_lng.split("^");
                var lat = y[0];
                var lng = y[1];

//                alert(fn + ", "+ln+" , "+lat+" , "+lng);  
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        var reply = xmlhttp.responseText;
                        alert(reply);
                        hideApproveDiv();
                        initialize();
                    }
                };
                xmlhttp.open("GET", "./admin_approve_location.jsp?msg=" + lat + "^" + lng + "^" + fn + "^" + ln, true);
                xmlhttp.send();
            }

            function deleteMarkedLocation()
            {
//                    to get first name and last name from address
                var add = document.getElementById("lbAddress").innerHTML;
                var x = new Array();
                x = add.split(" ");
                var ln = x[x.length - 1];
                var fn = x[x.length - 2];

//                   to get latitude and longitude 
                var lat_lng = document.getElementById("lbLatLng").innerHTML;
                var y = new Array();
                y = lat_lng.split("^");
                var lat = y[0];
                var lng = y[1];

                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        var reply = xmlhttp.responseText;
                        alert(reply);
                        hideApproveDiv();
                        initialize();
                    }
                };
                xmlhttp.open("GET", "./admin_delete_location.jsp?msg=" + lat + "^" + lng + "^" + fn + "^" + ln, true);
                xmlhttp.send();
            }

            google.maps.event.addDomListener(window, 'load', initialize);
        </script>
    </head>
    <body>
        <div class="container" >
            <br>
            <div id="googleMap" class="img-thumbnail center-block" style="width: 1000px; height:700px" ></div>
            <div id="approveDiv" style="display: none; width: 300px; height: 250px; background-color:#f7ecb5 ;position: fixed; 
                 padding: 10px; border: 2px solid buttontext; border-radius: 5px">

                <img src="icons/red_cross.png" style="width: 30px; height: 30px; position: relative; top: -5px;" 
                     class="pull-right" onclick="hideApproveDiv()" />
                <label id="lbLatLng" style="display: none;" >No lat_lng</label>
                <label id="lbAddress" >No address</label><br><br>
                <button id="btApprove" onclick="ApproveMarkedLocation()" >Approve</button>
                <button id="btDelete" onclick="deleteMarkedLocation()">Delete</button>


            </div>
        </div>    
    </body>
</html>
