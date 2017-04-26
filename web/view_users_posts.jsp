<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="bootstrapfiles.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Users' Posts</title>

    </head>
    <body>
        <%
            String email = (String) session.getAttribute("user_email");
            String prof_pic = (String) session.getAttribute("user_pic");
            String user_name = (String) session.getAttribute("user_name");
        %>
        <div class="container" style="background-color: #d5d5d5;">
            <div class="row">

                <div id="sidebar1" class="col-sm-3" ></div>

                <div id="main" class="col-sm-6" >
                    <div id="my_story" class="row" style="background-color: white; padding: 10px;">
                        <ul class="nav nav-tabs">
                            <li class="active"><a data-toggle="tab" href="#post_story">Post Story</a></li>
                            <li><a data-toggle="tab" href="#add_loc">Add Location</a></li>
                            <li><a data-toggle="tab" href="#add_pic">Add Picture</a></li>
                        </ul>
                        <hr>
                        <div class="tab-content"style="background-color: white;">
                            <div id="post_story" class="tab-pane fade in active" >
                                <div class="row">
                                    <div class="col-sm-2">
                                        <img src="<%=prof_pic%>" width="95" height="95" />
                                    </div>
                                    <div class="col-sm-10">
                                        <!--<textarea type="text" class="form-control" style="border: 0px;" placeholder="Post your story here"></textarea>-->
                                        <form role="form-contorl" action="add_story.jsp" method="post">    
                                            <div class="form-group" style="padding-right: 10px;">
                                                <input class='form-control'  name="title" type="text" placeholder="Enter the title" required/>
                                            </div>
                                            <div class="form-group">                                    
                                                <textarea class="form-control" name="story" placeholder="Post your experiences" 
                                                          required></textarea>
                                            </div>

                                            <!--<textarea id="locationarea" name="location" style="display: none;"></textarea>-->

                                            <!--<label class="btn-link" data-toggle="modal" data-target="#myModal">Add Location <span class="glyphicon glyphicon-map-marker" ></span></label><br>-->

                                            <!--<input type="submit" class="btn  btn-warning  pull-right" style="position: relative; top:-5px; left: -15px;" value="post"/>-->

                                        </form>
                                        <hr>
                                        <button class="btn btn-success pull-right" onclick="changeTab()">Next</button>
                                    </div>

                                </div>
                            </div>
                            <div id="add_loc" class="tab-pane fade">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div id="googleMap" class="img-thumbnail center-block" style=" height: 200px;"></div>

                                    </div>
                                </div>
                            </div>
                            <div id="add_pic" class="tab-pane fade">

                            </div>
                        </div>


                    </div>

                    <br>

                    <%

                        // to show all posts
                        //JDBC CODE
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
                        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        ResultSet rs = stmt.executeQuery("select * from user_post,user_signup where user_post.posted_by=user_signup.email Order By date desc ;");

                        if (rs.next())
                        {
                            rs.beforeFirst();
                            while (rs.next())
                            {
                                String firstname = rs.getString("user_signup.firstname");
                                String lastname = rs.getString("user_post.lastname");
                                int pid = rs.getInt("user_post.pid");
                                String title = rs.getString("user_post.title");
                                String story = rs.getString("user_post.story");
                                String profile_pic = rs.getString("user_signup.profilepic");
                                String date_time = rs.getTimestamp("user_post.date").toString();
                                String location = rs.getString("user_post.location");
                                String posted_by = rs.getString("user_post.posted_by");
                    %>
                    <br>
                    <div class="row " style="background-color: whitesmoke;border: 2px orange solid;">
                        <div class="col-sm-12">
                            <%
                                if (posted_by.equals(email))
                                {
                            %>
                            <img src="icons/red_cross.png" style="margin-right: 5px; margin-top: 5px;" width="15" height="15" class=" pull-right" 
                                 title="Delete Post" onclick="deletePost(<%=pid%>)"/>

                            <img src="icons/document_edit.png" style="margin-right: 5px; margin-top: 5px;" width="15" height="15" class=" pull-right" 
                                 title="Edit Post" data-toggle="modal" data-target="#editModal" onclick="editPost(<%=pid%>)"/>

                            <%
                                }
                            %>

                            <div class="row" style="padding: 10px;">
                                <div class="col-sm-1" >
                                    <img class="img" src="<%=profile_pic%>" 
                                         width="80px" height="80px"/>
                                </div>
                                <div class="col-sm-11"style="position: relative;left: 50px;">
                                    <p class="lead"><%=firstname%> <%=lastname%></p>
                                    <p><%=date_time%></p>
                                </div>
                            </div>

                            <div class="row"  >
                                <div class="col-sm-12 btn-warning" style="text-align-last: center; font-size: medium;"><%=title%></div>
                            </div>
                            <div class="row" >
                                <div class="col-sm-12" style="padding: 30px;">
                                    <%=story%>
                                    <br>    
                                    <label class="btn-link" data-toggle="modal" data-target="#myModal" >Location
                                           <!--onclick="loadAlreadyMarked('<%=location%>')">Location--> 
                                        <span class="glyphicon glyphicon-map-marker" ></span></label>
                                </div>
                            </div>

                        </div>
                    </div>
                    <%
                            }
                        }
                    %>
                </div>

                <div id="sidebar2" class="col-sm-3" ></div>

            </div>


        </div>
    </body>
</html>
