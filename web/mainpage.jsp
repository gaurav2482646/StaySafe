

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="bootstrapfiles.jsp" %>
<!DOCTYPE html>
<html>
    <link href="w3.css" rel="stylesheet" type="text/css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome Page</title>
    </head>
    <body>
        <div class="w3-container" >
            <div class="row">
                <div id="header"class="w3-col w3-container w3-amber" style="height: 100px;"></div>

            </div>
            <div class="row">
                <div id="main" class="w3-col w3-container w3-khaki" style="height: 600px;">
                    <div class="row">
                        <div class="w3-col m6 l6">
                            <p>jhvcuvscvsvdc</p>
                        </div>
                        <div class="w3-col m6 l6">
                            <div class="w3-card-4 " >

                                <header class="w3-container  w3-hover-border-brown">
                                    <h1>Welcome</h1>
                                </header>

                                <div class="w3-container">
                                    <form role="form" action="user_login2.jsp" method="post">
                                        <div class="form-group">

                                            <input class="form-control" type="text" name="email" placeholder="enter email" required/>

                                        </div>
                                        <div class="form-group">

                                            <input class="form-control" type="password" name="password" placeholder="enter password" required/>

                                        </div>
                                        <div class="form-group">

                                            <input class="btn btn-primary w3-btn w3-orange" type="submit" value="login"/>

                                        </div>


                                    </form>

                                </div>
                            </div>
                        </div>
                    </div>


                </div>
                <div class="row">
                    <div id="footer" class="w3-col w3-container w3-amber" style="height: 100px;" ></div>

                </div>
            </div>
    </body>
</html>
