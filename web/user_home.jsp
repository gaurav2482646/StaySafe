
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="mynavbar.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Home</title>

        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.12.2.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <!--        <link rel="stylesheet" href="w3.css">-->
        <link href="w3.css" rel="stylesheet" type="text/css"/>

        <script>

        </script>
        <style>
            .carousel-inner > .item > img,
            .carousel-inner > .item > a > img {
                width: 70%;
                margin: auto;


            }
            #footer {
                position:absolute;
                bottom:0;
                width:100%;
                height:60px;   /* Height of the footer */
                background: transparent;
            }
        </style>
    </head>
    <body style="background-image: url(images/simple_background4.jpg); background-size: 100%;">
        <div class="container">
            <%
                String email = (String) session.getAttribute("user_email");
                String name = (String) session.getAttribute("user_name");
                String pic = (String) session.getAttribute("user_pic");
                String phone = (String) session.getAttribute("phone_no");
            %>
            <!--<button class="btn btn-li nk pull-right" style="color: red;" onclick="logOut(true)">Log Out</button>-->
            <!--            <div id="myCarousel"  class="carousel slide" data-ride="carousel">
                             Indicators 
                            <ol class="carousel-indicators">
                                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                                <li data-target="#myCarousel" data-slide-to="1"></li>
                                <li data-target="#myCarousel" data-slide-to="2"></li>
                                <li data-target="#myCarousel" data-slide-to="3"></li>
                            </ol>
            
                             Wrapper for slides 
                            <div class="carousel-inner" role="listbox" style=" width:100%; height: 300px !important;">
                                <div class="item active">
                                    <img src="images/image_1.jpg" alt="Chania">
                                </div>
            
                                <div class="item">
                                    <img src="images/image_2.jpg" alt="Chania">
                                </div>
            
                                <div class="item">
                                    <img src="images/image_3.png" alt="Flower">
                                </div>
            
                                <div class="item">
                                    <img src="images/image_6.jpg" alt="Flower">
                                </div>
                            </div>
            
                             Left and right controls 
                            <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>-->
            <div class="row">
                <br>
                <div class="col-sm-2 ">
                    <img img class="img img-rounded" src="<%=pic%>" alt="Profile Pic" width="100px" height="100px">
                </div>
                <div class="col-sm-8">
                    <h1 class="h1">Welcome <%=name%></h1>
                    <p><%=email%></p>
                    <p><%=phone%></p>
                </div>

            </div>
          
            <br>
            <br>
            <div class="col-sm-12" >
                <br>
                <h2 class="text-justify text-primary">About Us</h2>
                <p class="panel-heading">Stay Safe, is an emergency App that, at the click of the power button of your smartphone 3 times consecutively begins sending out alert messages  to your contacts that you feed into the app as the designated receivers or guardians.
                    The message says<strong> "I am in danger. My Google Location is ___."</strong>The receiver will receive a link to your location giving them your updated location. 
                    Last but not the least, if you have been a victim or witnessed a Crime you can share the incident  by posting it in the “Submit Your Story” option in the Menu Bar.</p>
            </div>
            <div id="footer" class="panel-footer">
                <br>
                @2016.StaySafe.com|Design by:Gauravjeet Singh &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Contact Us:staysafe.web199@gmail.com
            </div>

            <!--            <a href="user_change_password1.jsp">Change Password</a>
                        <br>
                        <a href="add_contact1.jsp">Add Contacts</a>
                        <br>
                        <a href="view_contacts1.jsp">View Contacts</a>
                        <br>
                        <a href="add_danger_locations.jsp">Mark Danger Locations</a>
                        <br>
                        <a href="view_all_danger_locations.jsp">View All Danger Locations</a>
                        <br>
                        <a href="user_home1.jsp">User Posts</a>
                        <br>
                        <a href="live_tracking.jsp">Live Tracking</a>
                        <br>
                        <a href="find_on_date.jsp">Find on Date</a>-->

            <%
                String msg = request.getParameter("msg");
                if (msg != null)
                {
            %>
            <!--<br><label style="color: green; font-style: italic;"><%=msg%></label>-->
            <div class="alert alert-danger fade in">
                <a href="#" class="close" data-dismiss="alert" label="close">&times;</a>
                <strong><%=msg%>!</strong> 
            </div>

            <%
                }
            %>
        </div>
    </body>
</html>
