<%-- 
    Document   : Cart_test
    Created on : Sep 21, 2016, 1:28:22 AM
    Author     : Gihan
--%>

<%@page import="Resources.PrevilageCheck"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.HashMap"%>
<%@page import="DB.Login"%>
<%@page import="DB.User"%>
<%@page import="org.hibernate.Session"%>
<%@page import="DB.CartHasProducts"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="DB.Products"%>
<%@page import="java.util.List"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="DB.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayurweda.lk/Cart Process</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
         <link href="css/MyCs.css" rel="stylesheet" type="text/css">
        <script src="js/jquery-3.1.0.min.js"></script>
        <script src="js/bootstrap.min.js"></script>

        <script>

           var upids=[];
           
            
            $(document).ready(function() {
                $('[data-toggle="cartitemremove"]').popover();
                
                $('#cartmodelcontent').ready(function (){
                    
                    setCartModel();
                    
                });
               
           
            });
            
            $(document).keydown(function(event){
             
    if(event.keyCode==86){
    return false;
   }
else if(event.ctrlKey && event.shiftKey && event.keyCode==73){        
      return false;  //Prevent from ctrl+shift+i
   }
});

    // for set cart model content
    function setCartModel(){
          var xhttpCmodel = new XMLHttpRequest();
                xhttpCmodel.onreadystatechange = function() {// 
                    if (xhttpCmodel.readyState === 4 && xhttpCmodel.status === 200) {
                   //set itemcount lable before
                        $("#cartmodelcontent").hide().html(xhttpCmodel.responseText).fadeIn('slow');   
                         
                }
                };
                xhttpCmodel.open("GET", "CartModel.jsp", true);
               xhttpCmodel.send();
        
    }

            
            function qtyCheckAndUpdate(pid,evt){
                
                //alert(pid);
//             
              var charCode = (evt.which) ? evt.which : event.keyCode;
     
               var qty=parseInt(document.getElementById("q"+pid).value);
                
                //check first value is 0
                if($('#q'+pid).val().length<=0&&charCode==48){
                    return false;
                }
                
                //check enter value equals + - .
                else if(charCode==45||charCode==43||charCode==46){
                    return false; 
                    
                }else{
                    upids.push((pid));
                    
                   return true;
                }
                
              
       
        
            }
            
            function updateAndQtyCheck(upid){
           
            var uqty=document.getElementById('q'+upid).value;
                   var updatexhttp = new XMLHttpRequest();
                updatexhttp.onreadystatechange = function() {// 
                    if (updatexhttp.readyState === 4 && updatexhttp.status === 200) {

                    setCartModel();

                    }
                };
               updatexhttp.open("GET", "CartManager?CartUpdate=ok&upid="+upid+"&uqty="+uqty, true);
               
                updatexhttp.send();
                
                
            }
            
            function removeCartItem(pid, cartid) {
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {// 
                    if (xhttp.readyState === 4 && xhttp.status === 200) {

                         
                         setCartModel();
                         
                    }
                };
                xhttp.open("GET", "CartManager?RButton=removeitem&rpid=" + pid + "&cartid=" + cartid, true);
                xhttp.send();
           
            
            }
            
            function getInvoice(cartid){
               window.location.href = "BillingProcess.jsp?cartid="+cartid;
                    
                
            }
            
            function callCartItemcount(){
                sendCartItemRequest() ;
            }
            
            

        </script>



    </head>
    <body>
        
        <%
      
            if(request.getSession().getAttribute("username")!=null){
                PrevilageCheck precheck=new PrevilageCheck();
                
                    if(precheck.checkManager(request.getSession().getAttribute("username").toString(),
                        request.getRequestURL().toString(),"Click Cart  Button")){}}
                    
                    
           
      
      
      %> 
        
        
        <div>
            <%@include file="MyNavi.jspf"  %>
        </div><!-- hedder-->
        <br>
       
        <div style="display: inline-block;margin-bottom:100px " id="cartmodelcontent">
            My Cart
        </div>
                   
                        
        <div style="display:inline-block;width:100% ; position: relative;">
            <%@include file="MyNaviFoot.jspf"  %>

        </div><!-- footer-->  

    </body>
</html>
