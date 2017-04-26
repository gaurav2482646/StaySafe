<%-- 
    Document   : verify_account1
    Created on : 11 May, 2016, 12:44:37 PM
    Author     : hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="bootstrapfiles.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <link href="w3.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify Account</title>
    </head>
    <body style="background-image: url(images/organic11.jpg); background-size: 100%;">
        <div class="w3-container">
            <!--            <form role="form" action="verfiy_account2.jsp" method="post">
                            <div class="form-group">
            
                                <input type="text" name="email" placeholder="enter email" required/>
            
                            </div>
                            <div class="form-group">
            
                                <input type="text" name="code" placeholder="enter verification code" required/>
            
                            </div>
                            <div class="form-group">
            
                                <input class="btn btn-primary w3-btn w3-orange" type="submit" value="Submit"/>
            
                            </div>
            
            
                        </form>-->

            <span class="glyphicon-alert "/> <h1 class="w3-border-khaki  w3-center w3-jumbo"  >Account Verification</h1>
            <br>
            <div class="w3-animate-zoom">
                <form class="form-horizontal " role="form" style="padding: 40px" action="verfiy_account2.jsp" method="post">
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="email">Email:</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="email" name="email" placeholder="enter email" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="pwd">Password:</label>
                        <div class="col-sm-10">          
                            <input type="text" class="form-control" id="pwd" name="code" placeholder="enter verification code" required>
                        </div>
                    </div>
                    <div class="form-group">        

                    </div>
                    <div class="form-group">        
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="submit" class="btn btn-danger">Submit</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
