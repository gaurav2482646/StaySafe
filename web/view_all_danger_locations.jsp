
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="mynavbar.jsp" %>

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
            var zoom_level =8;
            var myCenter = new google.maps.LatLng(31.633980, 74.872261);

            function initialize()
            {
                var mapProp = {
                    center: myCenter,
                    zoom: zoom_level,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
                viewAllApprovedLoactions();
            }

            function viewAllApprovedLoactions()
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
                xmlhttp.open("GET", "./fetch_all_danger_locations.jsp", true);
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
                        alert("geo coder failed");
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
                    }
                };
                xmlhttp.open("GET", "./fetch_approved_addresses.jsp?msg=" + location.lat() + "^" + location.lng(), true);
                xmlhttp.send();
            }

            function goToHomePage()
            {
                window.location.href = "./user_home.jsp";
            }



            google.maps.event.addDomListener(window, 'load', initialize);
        </script>
    </head>
    <body style="background-image: url(images/yellow_background.png); background-size: 100%; ">
        <div class="w3-container w3-animate-zoom">
        <div class="w3-card-2">
            <header class="w3-container " style="background-color: #ffd966;">
                <h1>View All Danger Locations</h1>
            </header>

            
                <div id="googleMap" class="img-thumbnail center-block" style="width: 1560px; height:600px; 
                     padding-top: 10px;" ></div>
            
        </div>
        </div>
    </body>
</html>
