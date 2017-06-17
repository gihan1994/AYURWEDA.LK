<%-- 
    Document   : Navibar
    Created on : Sep 15, 2016, 5:58:11 PM
    Author     : Gihan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <script src="js/jquery-3.1.0.min.js"></script>
        <script src="js/bootstrap.min.js"></script>

        <style>
            .navbar-default .navbar-nav > li > a:hover, .navbar-default .navbar-nav > li > a:focus {
                background-color: #000000;
                color: #ffffff;
}
        </style>
        
        
    </head>
    <body>
        <div class="row" style="background-image: url(img/maincover.jpg)">
            <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10" >
                <div class="col-md-5">
                    <div class="row">
                        <img src="img/hedderCover.png" class="img-responsive" alt="Responsive image Cover"> 
                    </div>
                    <div class="row"></div>
                    <div class="row"></div>

                </div>  
                <div class="col-md-5">

                    <div class="row">
                        <br>
                        <br>
                        <br>
                        <br>

                    </div>

                    <div class="row">
                        <div class="col-md-8">

                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Search for...">
                                <span class="input-group-btn ">
                                    <button class="btn btn-default" type="button">
                                        <span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
                                </span>
                            </div><!-- /input-group -->

                            <!--<span class="glyphicon glyphicon-search" aria-hidden="true"></span>-->
                            <!--<span class="input-group-addon" id="basic-addon1">@</span>-->

                        </div>
                        <div class="col-md-4">
                            <a href="#advanceSearch">Advance Search</a>
                        </div>   

                    </div>
                    <div class="row"></div>



                </div>    


                <div class="col-md-2">
                    <div class="row">
                        <div class="col-md-4">

                            <button type="button" class="btn btn-info navbar-btn">My Account</button>
                        </div>
                        <div class="col-md-4"></div>
                        <div class="col-md-4">
                         
                            <div class="row">
                                <span class="badge">No Item</span>
                            </div>
                            <div class="row">
                                <a href="#viewCart">
                                    <img src="cart.png" class="img-responsive" alt="Responsive image">
                                </a>
                            </div>
                        </div>

                    </div>
                    <div class="row">
                        <br>
                        <br>
                        <br>
                        <br>
                        
                    </div>
                    <div class="row">
                        <div class="col-md-5">
                             <button type="button" class="btn btn-default navbar-btn">Register <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span></button>
                        </div>
                        <div class="col-md-2"></div>
                        <div class="col-md-5">
                             <button type="button" class="btn btn-default navbar-btn">Login <span class="glyphicon glyphicon-user" aria-hidden="true"></span></button>
                        </div>
                        
                    </div>


                </div>  


            </div> 
            <div class="col-md-1"></div> 

        </div>


        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10">

                <nav class="navbar navbar-default" style="background-color: transparent">
                    <div class="container-fluid">

                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                            <a class="navbar-brand" href="#"></a>
                        </div>


                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav">
                                
                                <li class="nav-item"><a href="Home.jsp" class="nav-link active">Home</a></li>
                                <li class="nav-item dropdown">
                                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown"  aria-haspopup="true" aria-expanded="false">Product<span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="#" class="dropdown-item">Health</a></li>
                                        <li><a href="#" class="dropdown-item">Beauty</a></li>
                                        <li><a href="#" class="dropdown-item">Supplement</a></li>
                                        <li><a href="#" class="dropdown-item">Niutrition</a></li>
                                        <li><a href="#" class="dropdown-item">Vitamins</a></li>
<!--                                        <li role="separator" class="divider"></li>
                                        <li><a href="#">Separated link</a></li>
                                        <li role="separator" class="divider"></li>
                                        <li><a href="#">One more separated link</a></li>-->
                                    </ul>
                                </li>
                                <li class="nav-item"><a href="#" class="nav-link ">Spa Centers</a></li>
                                    <li class="nav-item"><a href="#" class="nav-link ">Yoga Centers</a></li>
                                    <li class="nav-item"><a href="#" class="nav-link ">Hospitals</a></li>
                                      <li class="nav-item"><a href="#" class="nav-link ">Doctors</a></li>
                                      <li class="nav-item"><a href="#" class="nav-link ">About Us</a></li>
                            </ul>
                         
                        </div><!-- /.navbar-collapse -->
                    </div><!-- /.container-fluid -->
                </nav>


            </div>
            <div class="col-md-1"></div>  
        </div> 

        </div> 
        

    </body>
</html>
