<%-- 
    Document   : AboutUs
    Created on : Nov 24, 2016, 3:13:24 PM
    Author     : Gihan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="css/MyCs.css" rel="stylesheet" type="text/css">

        <script src="js/jquery-3.1.0.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <title>Ayurweda.lk</title>
    </head>
    <body>
          <div >
            <%@include file="MyNavi.jspf"  %>

        </div>
            <br>
            <br>
            <div class="row">
                <div class="container">
                    <div class="col-md-8">
                        <div>
                            <h2 style="font-weight: bold;font-family:cursive ">Who are we?</h2>
                            <p>We have been offering new qualitative and healthy Ayurveda products to our customers since last decades.
                                Also we have been exporting good srilankan’s Ayurveda product to lot of foreign countries for many years. 
                                As well we have joined many ancestral Ayurveda doctors and Ayurveda academies there for we will have to 
                                chance to invention new Ayurveda products for society. </p>
                            
                        </div>
                        <br>
                        <br>
                          <div>
                            <h2 style="font-weight: bold;font-family:cursive; ">What have we?</h2>
                            <ul >
                                <li>Good Product Seller</li>
                                <li>Government Permit of selling and distributing Medicine</li>
                                <li>SLS Certification of All Selling  Products</li>
                                <li>ownership of Medicine product Storage</li>
                                
                            </ul>
                            
                        </div>
                         <br>
                        <br>
                          <div>
                            <h2 style="font-weight: bold;font-family:cursive ">Where are we?</h2>
                           
                            <map style="width:100%;height:500px  ">
                                
                            </map>
                            
                        </div>
                        
                    </div>
                    <div class="col-md-4">
                          <h2 style="font-weight: bold;font-family:cursive">Our Working Crew</h2> 
                                     <div class="panel panel-body" style="width:100%;max-height:700px;overflow: auto  ">
                                        
                                         
                                         <div class="row" style="   ">
                                             <div class="col-md-2">
                                                 <img src="img/myg.jpg" style="box-shadow: 2px 5px 10px grey;" alt="" width="50px" height="50px">
                                             </div> 
                                             <div class="col-md-10">
                                                 <h4>Director<br><small>Mr. Gihan Munasinghe</small></h4>
                                             </div> 
                                             
                                         </div>
                                         <br>
                                         
                                      <div class="row" style="   ">
                                             <div class="col-md-2">
                                                 <img src="img/anu.jpg" style="box-shadow: 2px 5px 10px grey;" alt="" width="50px" height="50px">
                                             </div> 
                                             <div class="col-md-10">
                                                 <h4>Managing Director<br>
                                                     <small>Mr. Anura Dissanayake</small>
                                                 </h4>
                                             </div> 
                                             
                                         </div>
                                          <br>
                                         
                                           <div class="row" style="   ">
                                             <div class="col-md-2">
                                                 <img src="img/sam.jpg" style="box-shadow: 2px 5px 10px grey;" alt="" width="50px" height="50px">
                                             </div> 
                                             <div class="col-md-10">
                                                 <h4>Operational Consultant<br>
                                                     <small>Dr. Saman Weerakkody</small>
                                                 </h4>
                                             </div> 
                                             
                                         </div>
                                  </div>  
                        
                    </div>
                    
                </div>
                
                
            </div>
            
      <div style="display:inline-block;width:100% " >
            <%@include file="MyNaviFoot.jspf"  %>

        </div><!-- footer-->
    </body>
</html>
