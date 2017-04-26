<%-- 
    Document   : add_danger_locations
    Created on : 14 Apr, 2016, 8:32:23 PM
    Author     : hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="mynavbar.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Danger Locations</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.2.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <link href="w3.css" rel="stylesheet" type="text/css"/>

        <script src="http://maps.googleapis.com/maps/api/js"></script>
        <script>
            var map;
            var zoom_level = 12;
            var myCenter = new google.maps.LatLng(31.633980, 74.872261);

            function initialize()
            {
                var mapProp = {
                    center: myCenter,
                    zoom: zoom_level,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                map = new google.maps.Map(document.getElementById("googleMap"), mapProp);

                google.maps.event.addListener(map, 'click', function (event)
                {
                    var ans = confirm("Are you sure to mark this as Danger Location ?");
                    if (ans)
                    {
                        getLocationDetails(event.latLng.lat(), event.latLng.lng(), true);
                    }
                });
                loadAlreadyMarked();
            }

            function loadAlreadyMarked()
            {
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        var loc = xmlhttp.responseText;
                        var lat_lng = loc.split("^");
                        console.log("length" + lat_lng.length);
                        if (lat_lng.length > 1)
                        {
                            for (var i = 0; i < lat_lng.length; i = i + 2)
                            {
                                var lat = lat_lng[i].trim().valueOf();
                                var lng = lat_lng[i + 1].trim().valueOf();

                                getLocationDetails(lat, lng, false);
                            }
                        }
                    }
                };
                xmlhttp.open("GET", "./fetch_danger_locations.jsp", true);
                xmlhttp.send();


            }

            function placeMarker(location)
            {
                var marker;
                marker = new google.maps.Marker({
                    position: location,
                    map: map,
                    title: 'click to delete'
                });
                addInfoWindow(marker, location);
                marker.addListener('click', function () {
                    var ans = confirm("Are you sure to delete this marked loaction ?");
                    if (ans) {
                        deleteMarkedLocation(location.lat(), location.lng());
                    }
//                    alert("marker clicked"+location.lat());
                });
            }

            function getLocationDetails(latitude, longitude, flag)
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
                            if (flag == true)
                            {
                                storeToDatabase(latitude, longitude, add, city);
                            } else
                            {
                                placeMarker(new google.maps.LatLng(latitude, longitude));
                            }
                        } else
                        {
                            alert("no address found");
                        }
                    } else
                    {
//                        console.log("geo coder failed with status " + status);
                        setTimeout(function () {
                            getLocationDetails(latitude, longitude, flag);
                        }, 200);
//                        alert("geo coder failed with status " + status);
                    }
                }
                );
            }

            function storeToDatabase(latitude, longitude, add, city)
            {
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        placeMarker(new google.maps.LatLng(latitude, longitude));
                    }
                };
                xmlhttp.open("GET", "./add_danger_locations2.jsp?msg=" + latitude + "^" + longitude + "^" + add + "^" + city, true);
                xmlhttp.send();
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

                    }
                };
                xmlhttp.open("GET", "./fetch_address.jsp?msg=" + location.lat() + "^" + location.lng(), true);
                xmlhttp.send();
            }

            function deleteMarkedLocation(lat, lng)
            {
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        initialize();
                    }
                };
                xmlhttp.open("GET", "./delete_marked_location.jsp?msg=" + lat + "^" + lng, true);
                xmlhttp.send();
            }



            google.maps.event.addDomListener(window, 'load', initialize);
        </script>    
    </head>
    <body style="background-image: url(images/yellow_background.png); background-size: 100%; ">
        <div class="w3-container w3-animate-zoom">
            <div class="w3-card-2">
                <header class="w3-container " style="background-color: #ffd966;">
                    <h1>Add Danger Locations</h1>
                </header>


                <div id="googleMap" class="img-thumbnail center-block" style="width: 1560px; height:600px; 
                     padding-top: 10px;" ></div>

            </div>
        </div>
    </body>
</html>
