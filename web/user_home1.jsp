
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="mynavbar.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Home Page</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.2.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <link href="w3.css" rel="stylesheet" type="text/css"/>
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
                google.maps.event.addListener(map, 'click', function (event)
                {
                    var ans = confirm("Are you sure to mark this as Danger Location ?");
                    if (ans)
                    {
                        getLocationDetails(event.latLng.lat(), event.latLng.lng());
                    }

                });

            }

            function placeMarker(location)
            {
                var marker;

                marker = new google.maps.Marker({
                    position: location,
                    map: map
//                    title: 'click to delete'
                });

                marker.info = new google.maps.InfoWindow({
                    content: location + ""
                });

                marker.addListener('mouseover', function () {
                    marker.info.open(map, marker);
                });

                marker.addListener('mouseout', function () {
                    marker.info.close();
                });

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
                            document.getElementById("locationarea").innerHTML = latitude + "^" + longitude + "^" + add;
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

                        alert("geo coder failed with status " + status);
                    }
                }
                );
            }

            function loadAlreadyMarked(location)
            {
//                alert(location);
                initialize();
                var loc = location.split("^");
                var lat = loc[0];
                var long = loc[1];
//                alert(lat+", "+long);
                placeMarker(new google.maps.LatLng(lat, long));

            }

            function deletePost(pid)
            {
                var ans = confirm("Are you sure to delete this post ?");
                if (ans == true)
                {
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.onreadystatechange = function ()
                    {
                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                        {
                            window.location.reload();
                        }
                    };
                    xmlhttp.open("GET", "./delete_post.jsp?pid=" + pid, true);
                    xmlhttp.send();
                }
            }


            function postComment(pid)
            {
                if (event.keyCode == 13)
                {
                    var comment = document.getElementById("comment_text"+pid).value;
//                    alert(comment);
                    var xml = new XMLHttpRequest();
                    xml.onreadystatechange = function()
                    {
                        if(xml.readyState == 4 && xml.status ==200)
                        {
//                            document.getElementById("comment_text").value = "";
                            window.location.reload();
                            
                        }
                    };
                    xml.open("GET","./post_comment.jsp?pid="+pid+"&comment="+comment,true);
                    xml.send();

                }
            }
            
            function fetchcommentsonthispost(pid)
            {
                var xml = new XMLHttpRequest();
                xml.onreadystatechange = function()
                {
                    if(xml.readyState == 4 && xml.status==200)
                    {
                        document.getElementById("post_modal_body").innerHTML =xml.responseText;
                    }
                };
                xml.open("GET" , "./fetchcommentsonthispost.jsp?pid="+pid,true);
                xml.send();
                
                
                
            }

            google.maps.event.addDomListener(window, 'load', initialize);
        </script>
    </head>
    <body style="background-image: url(images/yellow_background.png); background-size: 100%;">
        <%
            String email = (String) session.getAttribute("user_email");
            String prof_pic = (String) session.getAttribute("user_pic");
        %>
        <div class="w3-container" style="background-image: url(images/simple_background3.jpg); background-size: 100%;">
            <div class="row">
                <div id="sidebar1" class="col-sm-2" >

                </div>
                <div id="main" class="col-sm-8" >
                    <div class="row " style="background-color: white; border: 2px navy groove;">
                        <%

                            // to post your experience

                            //JDBC CODE
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
                            Statement st = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            ResultSet rset = st.executeQuery("select * from user_signup where email='" + email + "'");
                            if (rset.next())
                            {
                                String myFn = rset.getString("firstname");
                                String myLn = rset.getString("lastname");
                                String myProfilepic = rset.getString("profilepic");
//                                String myTime = rset.getString("NOW()");

                        %>
                        <div class="row" style="padding: 10px;" >
                            <div class="col-sm-1" ><img class="img img-rounded" src="<%=myProfilepic%>" width="80" height="80"/></div>
                            <div class="col-sm-11" style="position: relative;left: 50px;"><label style="text-transform: capitalize; text-decoration-color: #23527c;"><u><%=myFn%> <%=myLn%></u></label><br></div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12" style="padding-left: 50px; padding-bottom: 10px;">
                                <form role="form" action="add_story.jsp" method="post">    
                                    <div class="form-group" style="padding-right: 10px;">
                                        <input class='form-control'  name="title" type="text" placeholder="Enter the title" required/>
                                    </div>
                                    <div class="form-group">                                    
                                        <textarea class="form-control" style="width:0 auto;" name="story" placeholder="Post your experiences" 
                                                  required></textarea>
                                    </div>

                                    <textarea id="locationarea" name="location" style="display: none;"></textarea>

                                    <label class="btn-link" data-toggle="modal" data-target="#myModal">Add Location <span class="glyphicon glyphicon-map-marker" ></span></label><br>

                                    <input type="submit" class="btn  btn-success  pull-right" style="position: relative; top:-5px; left: -15px;" value="post"/>
                                </form>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>    



                    <%
                            
                        // to show all posts\
                            
                        //JDBC CODE
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
                        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        ResultSet rs = stmt.executeQuery("select * from user_signup,user_post where user_signup.email = user_post.posted_by order by date desc");
                        if (rs.next())
                        {
                            rs.beforeFirst();
                            while (rs.next())
                            {
                                int pid = rs.getInt("user_post.pid");
                                String title = rs.getString("user_post.title");
                                String story = rs.getString("user_post.story");
                                String date_time = rs.getTimestamp("user_post.date").toString();
                                String location = rs.getString("user_post.location");
                                String posted_by = rs.getString("user_post.posted_by");
                                String firstname = rs.getString("user_signup.firstname");
                                String lastname = rs.getString("user_signup.lastname");
                                String profile_pic = rs.getString("user_signup.profilepic");
                    %>
                    <br>
                    <div class="row " style="background-color: white;box-shadow: 5px 5px 5px #245580;">
                        <div class="col-sm-12">
                            <%
                                if (posted_by.equals(email))
                                {
                            %>
                            <img src="icons/red_cross.png" style="margin-right: 5px; margin-top: 5px;" width="15" height="15" class=" pull-right" 
                                 title="Delete Post" onclick="deletePost(<%=pid%>)"/>

                            <%
                                }
                            %>
                            <div class="row" style="background-color: white;padding: 10px;">
                                <div class="col-sm-1" ><img class="img img-rounded" src="<%=profile_pic%>" 
                                                            width="80" height="80"/></div>
                                <div class="col-sm-11"style="position: relative;left: 50px;">
                                    <p class="lead"><%=firstname%> <%=lastname%></p>
                                    <p><%=date_time%></p>
                                </div>

                            </div>
                            <div class="row" style="background-color: white;" >
                                <div class="col-sm-12" style="text-decoration-color: navy;background-color: navajowhite;text-align-last: center; font-size: medium;"><%=title%></div>
                            </div>
                            <div class="row" style="background-color: white;">
                                <div class="col-sm-12" style="padding: 30px;">
                                    <%=story%>
                                    <br>    
                                    <label class="btn-link" data-toggle="modal" data-target="#myModal" 
                                           onclick="loadAlreadyMarked('<%=location%>')">Location 
                                        <span class="glyphicon glyphicon-map-marker" ></span></label>
                                </div>
                            </div>
                                        <div class="row" style="background-color: whitesmoke;">
                                            <div class="row ">
                                                <div class="col-sm-12">
                                                    <center><label class="btn btn-link" data-toggle="modal" 
                                                                   data-target="#postModal" onclick="fetchcommentsonthispost(<%=pid%>)">view all comments</label></center>
                                                </div>
                                            </div> 
                            <%
                                //       load comments on this post
                                //JDBC CODE
                                Statement stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                ResultSet rs1 = stmt1.executeQuery("select * from comment,user_signup where comment.comment_by = user_signup.email and comment.postid=" + pid + " order by date ");
                                if (rs1.next())
                                {
//                                    rs1.beforeFirst();
                                    rs1.absolute(-4);
                                    while (rs1.next())
                                    {
                                        String pic = rs1.getString("user_signup.profilepic");
                                        String fn = rs1.getString("user_signup.firstname");
                                        String ln = rs1.getString("user_signup.lastname");
                                        String comment = rs1.getString("comment.comment");
                                        String commentTime = rs1.getString("comment.date");

                            %>
                            <div id="comments_div"class="row" >
                                <div class="col-sm-1">
                                    <img src="<%=pic%>" width="50" height="50" />
                                </div>
                                <div class="col-sm-11">
                                    <p><b><%=fn%> <%=ln%></b><sub>
                                        <%=commentTime%></sub></p>
                                    <p><%=comment%></p>
                                </div>
                            </div>
                            <hr>
                            
                            <%

                                    }

                                }
                                %>
                                        </div>
                            <!--my comment-->         
                            <div id="mycomment" class="row" style="background-color: white;padding: 10px;">
                                <div class="col-sm-1" style=" position: relative; top: -20px;">
                                    <img class="img img-rounded" src="<%=prof_pic%>"
                                         style="position:relative; top:20px;left:18px;"
                                         width="35" height="35"/>
                                </div>
                                         <div class="col-sm-11">        
                                    <input id ="comment_text<%=pid%>" class="form-control" style="width:0 auto;"
                                           type="text" onkeypress="postComment(<%=pid%>)" placeholder="Comment"/>
                                </div>

                            </div>

                        </div>
                    </div>
                    <br>
                    <%
                            }
                        }
                    %>

                </div>
                <div class="sidebar2 col-sm-2" >

                </div>

            </div>

            <!-- Modal -->
            <div id="myModal" class="modal fade" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Mark Location</h4>
                        </div>
                        <div id="googleMap" class="modal-body img-thumbnail center-block" style="width:600px; height:500px; padding-top: 10px;">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>

                </div>
            </div> 
            <div id="postModal" class="modal fade" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Comments</h4>
                        </div>
                        <div id="post_modal_body" class="modal-body img-thumbnail center-block" style="height: 500px;overflow: auto">
                            
                        </div>
                        
                    </div>

                </div>
            </div> 
        </div>

    </body>
</html>
