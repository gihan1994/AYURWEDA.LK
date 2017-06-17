<%-- 
    Document   : Home
    Created on : Sep 16, 2016, 12:48:27 PM
    Author     : Gihan
--%>


<%@page import="org.hibernate.criterion.Order"%>
<%@page import="DB.Productreview"%>
<%@page import="DB.GrnHasProducts"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="DB.Productoffers"%>
<%@page import="org.hibernate.SQLQuery"%>
<%@page import="Resources.OfferProductProvider"%>
<%@page import="DB.ProductsHasBrands"%>
<%@page import="DB.Brands"%>
<%@page import="DB.Products"%>
<%@page import="Resources.ProductRatingProvider"%>
<%@page import="Resources.PrevilageCheck"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head> 
        
  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayurweda.lk</title>

        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="css/MyCs.css" rel="stylesheet" type="text/css">

        <script src="js/jquery-3.1.0.min.js"></script>
        <script src="js/bootstrap.min.js"></script>

        <style>
            .chatApp {
       position: fixed;
       z-index: 3;
       bottom:0px;
    left:1000px;
    right:0px;
    margin-bottom:0px;
    
    
}
 
        </style>
        
        
    </head>
    <script>
        //data sennder
         
        
        function sendHomepageData(url){
             var xhttpHome = new XMLHttpRequest();
                xhttpHome.onreadystatechange = function() {// 
                    if (xhttpHome.readyState === 4 && xhttpHome.status === 200) {
                        document.getElementById('invoicecontent').innerHTML=xhttpHome.responseText;
                    }
                };
                xhttpHome.open("GET", url, true);
                xhttpHome.send();
            
        }
      
        function viewModelInvoice(){
            
                          var url="Invoice.jsp?invoiceid="+document.getElementById('invoid').value;
                   sendHomepageData(url);
                   $('#invoModal').ready(function (){
                     $("#invoModal").modal();
                       
                       
                   });
        }
        function printDiv(divName) {
     var printContents = document.getElementById(divName).innerHTML;
     var originalContents;
     $("#invoModal").modal('hide');
     $('#myModal').on('hidden.bs.modal', function (e) {
 var originalContents = document.body.innerHTML;
});
     
     
     document.body.innerHTML = printContents;
     
     window.print();

     document.body.innerHTML = originalContents;
}
        $(document).ready(function (){
       
        });
        
            function BuyNow(pid) {

                var xhttpAddCart = new XMLHttpRequest();
                xhttpAddCart.onreadystatechange = function() {// 
//                     alert("state changing now is in state ->" + xhttp.readyState+" and status is ->"+xhttp.status);                    
                    if (xhttpAddCart.readyState === 4 && xhttpAddCart.status === 200) {
                           window.location.href='Cart_test.jsp';
                      
                    }
                };
                xhttpAddCart.open("GET", "CartManager?Button=addcartbtn&pid=" + pid, true);
//                xhttp.open("GET", "chatApp.jsp", true)
                xhttpAddCart.send();

            }
    </script>
    
    
    <body>
        
        
        <%      if (request.getSession().getAttribute("username") != null) {
                PrevilageCheck precheck = new PrevilageCheck();

                if (precheck.checkManager(request.getSession().getAttribute("username").toString(),
                        request.getRequestURL().toString(), "Click Home Button")) {
                }
            }

            //check offer outof date
       
        new OfferProductProvider().checkDateAvailable(); 
        
        
        %> 

        <!--invoice model content-->
        
            <%
            if(request.getParameter("invoiceid")!=null){
                //set view invoice for history
            if (new PrevilageCheck().checkManager(request.getSession().getAttribute("username").toString(),
                        request.getRequestURL().toString(), "Viewed Invoice id"+request.getParameter("invoiceid"))) {
                }
            %>
            <div class="modal fade" id="invoModal" role="dialog">
                   <input type="text" style="display: none"  id="invoid" value="<%=request.getParameter("invoiceid")%>" >
                    <div class="modal-dialog  modal-open">

                        <!-- Modal content-->
                        <div class="modal-content">
                            
                            <div class="modal-body" id="invoicecontent">
                                <img src="img/InvoiceCover.png" onload="viewModelInvoice()" width="100" height="132">
                            </div>
                            <div class="modal-footer">
                                <button  class="btn btn-default hedder-btn" type="button" onclick="printDiv('invoicecontent')">Print</button>
                            </div>
                        </div>

                    </div>
                </div> 
            
            <%}
            
            %>

        <div style="display:inline;width:100%" >
            <%@include file="MyNavi.jspf"  %>

        </div>
            <!--chat app--> 
<!--            <div class="panel panel-default chatApp" style="border-color: #012231;">
           <div class="panel-heading" role="tab" id="headingTwo" style="background-color: #012231;">
               <h3 class="panel-title" style="color: #ffffff;font-weight: bold;font-size: 16px;margin-left:80px "> 
        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
            <span class="glyphicon glyphicon-user"  area-hidden="true" style="margin-right:10px " ></span> Conversations
        </a>
      </h3>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
      <div class="panel-body">
          <div style="display: inline-block">
              <div class="col-md-6"><img src="img/DefaltUser.png" class="img-circle" style="width: 60px;height: 60px"></div>
              <div class="col-md-6">
                  <h5>Gihan Munasinghe</h5>
              </div>
          </div>
          
          <textarea  rows="2" cols="50" style="width:fit-content; position: fixed;bottom:0px;background-color:transparent;background-color: transparent;box-shadow: 1px 2px 3px transparent ">
              
          </textarea>
      </div>
    </div>
  </div>-->
        <div style="display:inline-block;width:100%;padding-top:50px  "  >
            <div style="display:inline-block;width:100%;height:600px  ">
                <div class="col-md-1"></div>  
                <div class="col-md-10">
                    <div class="col-md-12">
                        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                            <!-- Indicators -->
                            <ol class="carousel-indicators">
                                <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="3"></li>
                            </ol>

                            <!-- Wrapper for slides -->
                            <div class="carousel-inner" role="listbox">


                                <div class="item active">
                                    <img src="img/1.png" style="width:100%;height:100%" alt="...">
                                    <div class="carousel-caption">

                                    </div>
                                </div>
                                <div class="item ">
                                    <img src="img/2.jpg" style="width:100%;height:100%" alt="...">
                                    <div class="carousel-caption">
                                           
                                    </div>
                                </div>
                                <div class="item ">
                                    <img src="img/3.png" style="width:100%;height:100%" alt="...">
                                    <div class="carousel-caption">

                                    </div>
                                </div>
                                <div class="item ">
                                    <img src="img/4.jpg" style="width:100%;height:100%" alt="...">
                                    <div class="carousel-caption">

                                    </div>
                                </div>
                            </div>


                        </div>

                    </div>




                </div> 
                <div class="col-md-1"></div>


            </div>  


            <%
        Session homses=NewHibernateUtil.getSessionFactory().openSession();
            ProductRatingProvider prp=new ProductRatingProvider();
            int trpid=prp.getTopRateProduct();
            if(trpid!=0){
            
                
            GrnHasProducts rtp=(GrnHasProducts)homses.load(DB.GrnHasProducts.class, trpid);
            
            if(rtp!=null){
            %>
            <div style="display: inline-block;padding-left:100px " >
                <div class="container">
                    <div class="panel panel-success" style="box-shadow: 10px 10px 20px grey;">
                        <div class="panel-heading" style=" color:#ffffff ;background-color: #333333">
                            <h1 style="font-weight: bold;font-family:cursive">Today Top Rate Product</h1>

                        </div>
                        <div class="panel-body">
                            <div class="col-md-6">
                                <img src="<%=rtp.getProducts().getImg()%>" 
                                     onclick="window.location.href='UniqProductView.jsp?repid=<%=rtp.getProducts().getIdProducts()%>'" 
                                     alt="No Image" class="img-responsive" width="500px" height="1000px" 
                                     style="cursor: pointer" >

                            </div>
                            <div class="col-md-6">
                                <div style="display:inline ">
                                    <%
                                    ProductsHasBrands phb=(ProductsHasBrands)homses.createCriteria(DB.ProductsHasBrands.class)
                                            .add(Restrictions.eq("products", rtp)).uniqueResult();
                                    if(phb!=null){
                                        out.write("<h2 style=\"font-weight: bold\">"+phb.getBrands().getBrandname()+" <br>");
                                         
                                    }
                                    
                                    
                                    %>
                                    <small><%=rtp.getProducts().getProductName()  %></small></h2>
                                </div>
                                <div style="display:inline ">
                                    <h4 style="font-weight:bold ">Description</h4>
                                    <p><%=rtp.getProducts().getDescription()  %></p>
                                </div>
                                <div style="display:inline ">
                                    <h4><%=prp.getRateOfProduct(rtp.getProducts().getIdProducts().toString())  %></h4>
                             

                                </div>
                                <div style="display:inline ">
                                    <p>Price <%
                                       
                                Double uniqprice=0.0;   
                                
                                    Productoffers poff=(Productoffers)homses.createCriteria(DB.Productoffers.class).add(Restrictions.
                                            and(Restrictions.eq("grnHasProducts", rtp),
                                                    Restrictions.eq("dateofview", new Date()))).uniqueResult();
                                    if(poff!=null&&poff.getOfferstatus().equalsIgnoreCase("1")){
                                     out.print("<del style=\"color: #999999\" >"+rtp.getSellprice()+" LKR</del>");
                                     out.print("<br>");
                                    out.print("<span style=\"font-weight:bold;color: #33004b\">"+new DecimalFormat("0.00").format(rtp.getSellprice()-rtp.getSellprice()*poff.getPresentage()/100)+"</span>");
                                    }else{
                                     out.print("<span style=\"font-weight:bold;\">"+rtp.getSellprice()+" LKR</span>");
                                    }
                                    uniqprice=rtp.getSellprice();
                                  
                                   
                                    %> LKR</p>
                                    <h4>
                                    
                                    </h4>
                                </div>

                                <div style="display:inline ">
                                    <button class="btn btn-default hedder-btn" onclick="BuyNow(<%=rtp.getProducts().getIdProducts()  %>)"> Buy Now</button>
                                </div>
                                <div style="display:inline ">
                                    <h4>Reviews</h4>
                                   <%
                                   Criteria preview=homses.createCriteria(DB.Productreview.class).add(Restrictions.eq("products", rtp)).addOrder(Order.desc("reviewDate"));
                                   preview.setMaxResults(3);
                                   if(preview.list().size()>0){
                                   %>
                                    
                                    <ul>
                                      <%
                                      for(Productreview prw:(List<Productreview>)preview.list()){
                                      %>
                                       <li><%=prw.getReview()  %><br><h6><small><%=new SimpleDateFormat("yyyy-MM-dd").format(prw.getReviewDate())  %></small></h6></li> 
                                      
                                      <%}%>
                                    </ul>
                                  <%
                                  }else{
                                   out.print("No Reviews");
                                   }
                                  %>
                                </div>
                            </div>

                        </div>


                    </div>
                </div>
            </div>
            
            <%
            }
            }
            
            %>
<br>
<br>
<!--offer carousal-->
<%
String sql="SELECT\n" +
"    `productoffers`.`presentage`\n" +
"    , `products`.`idProducts`\n" +
"    , `products`.`ProductName`\n" +
"    , `grn_has_products`.`sellprice`\n" +
"    , `products`.`img`\n" +
"    , `brands`.`brandname`\n" +
"FROM\n" +
"    `products_has_brands`\n" +
"    INNER JOIN `products` \n" +
"        ON (`products_has_brands`.`Products_idProducts` = `products`.`idProducts`)\n" +
"    INNER JOIN `brands` \n" +
"        ON (`products_has_brands`.`Brands_idBrands` = `brands`.`idBrands`)\n" +
"    INNER JOIN `grn_has_products` \n" +
"        ON (`grn_has_products`.`Products_idProducts` = `products`.`idProducts`)\n" +
"    INNER JOIN `productoffers` \n" +
"        ON (`productoffers`.`grn_has_products_IdGRNhasProduct` = `grn_has_products`.`IdGRNhasProduct`) where GRNPstatus='1' AND qtystatus='1' "
        + "and dateofview='"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"' and offerstatus='1'";
            SQLQuery pidq=homses.createSQLQuery(sql);
                                List cpidl=pidq.list();
                                if(cpidl.size()>0){
                                    int indicount=0; 

%>
<div id="carousel-example-generic2" class="carousel slide" data-ride="carousel">
     <h2 style="font-weight: bold;font-family:cursive;margin-left:100px ">Special Offers </h2>
                    

                            <!-- Wrapper for slides -->
                            <div class="carousel-inner" role="listbox">
                                <%
                  
                                int citemcount=cpidl.size()/4;
                                if(cpidl.size()%4!=0){citemcount++;}
                                indicount=citemcount;
                                for(int i=0;i<citemcount;i++){
                                   String cls="item";
                                    if(i==0){
                                    cls="item active";
                                        pidq.setFirstResult(i);
                                    }else{
                                     pidq.setFirstResult((i*4)-1);
                                    }
                                   
                                   pidq.setMaxResults(4);
                                
                                %>

                                <div class="<%=cls%>">
                                  <!--1--><div style="display: inline-block;padding-left:100px ">
                <div class="container">
                   
                    <div class="panel panel-body " style="">
                        <div class=""> </div>
                        <div style="display: inline-block">
                          
                            <%
                                String dcls="col-md-3"; 
                                if(pidq.list().size()==1){dcls="col-md-12"; }
                                if(pidq.list().size()==2){dcls="col-md-6";}
                                if(pidq.list().size()==3){dcls="col-md-4";}
                                for(Object io:pidq.list()){
                                    Object[] oa=(Object[])io;
                                   
                            %>
                            <div class="<%=dcls%>">
                                <span class="badge" style="rotation:190deg;position: absolute;
                                      background-color:#ff3300;color:#ffffff;" >
                                    <h5 style="font-weight:bolder;">
                                        <% out.print("Offer "+oa[0].toString()+"%"); %>   
                                    </h5>
                                
                                </span>
                            <div class="panel panel-body text-center" style="width:250px;box-shadow: 10px 10px 40px grey; ">
                            <div >
                                <img src="<%=oa[4].toString()%>"
                                      onclick="window.location.href='UniqProductView.jsp?repid=<%=oa[1].toString()%>'"
                                     alt="No Image" style="width:200px;height:200px;cursor: pointer  " >
                            </div>
                                <div >
                                    <h3 style="font-weight: bold"><%=oa[2].toString()%><br> 
                                        
                                        <small>
                                            <%=oa[5].toString()%>
                                           </small></h3>
                                </div>
                                           <div style="margin-left:20px;margin-right:20px;margin-top: 5px">
                                               <h5 style="color: #999999 "><del><%=oa[3].toString()  %> LKR</del></h5>
                                               
                                               <h4 style="font-weight:bold;color:#00b40b;"><%
                                              out.print( new DecimalFormat("0.00").format(new Double(oa[3].toString())-(new Double(oa[3].toString())*new Integer(oa[0].toString())/100)));
                                               %> LKR</h4>
                                           </div>     
                                <div >
                                    <button class="btn btn-default hedder-btn" style="margin-left:20px;margin-right:20px  " onclick="BuyNow(<%=oa[1].toString()%>)">Buy Now</button>
                                  
                                </div>
                            
                        </div> 
                            </div>
                            <% }%>
                        </div>
                      
                        
                    </div>
                    
                </div>
                
            </div> 
                                </div>
                        <%}%>
                                
                               
                            </div>
            <!-- Indicators -->
            <ol class="carousel-indicators" >
      <%
                                
      for(int ind=0;ind<indicount;ind++){
          String icls="";
          if(ind==0){icls="active";}
      %>
      <li data-target="#carousel-example-generic2" style="background-color:#666675;" data-slide-to="<%=ind%>" class="<%=icls%>"></li>
    
    <%
    }
    %>
  </ol>

                        </div>
<!--offer is available check end-->
<% }%>
            
                        <br>
                        <br>
                        
                        <div style="display: inline-block;padding-left:100px ">
                            <div class="container">
                                <div class="col-md-8">
                                  <h2 style="font-weight: bold;font-family:cursive">Special News</h2>
                                  <div class="panel panel-body" style="width:100%;height:700px  ">
                                      <h3 style="font-weight:lighter">Ayurweda.lk will have arranged Yoga session in near future.</h3>
                                      <img src="img/as.jpg" class="img-responsive">
                                      
                                  </div>  
                                  
                                </div>
<!--                                <div class="col-md-4">
                                    <h2 style="font-weight: bold;font-family:cursive">Customer's Feed Backs</h2> 
                                     <div class="panel panel-body" style="width:100%;max-height:700px;overflow: auto  ">
                                        <%
                                        for(int it=0;it<8;it++){
                                        %>
                                         
                                         <div style="display: inline-block" style="   ">
                                             <div class="col-md-2">
                                                 <img src="img/DefaltUser.png" style="box-shadow: 2px 5px 10px grey;" alt="no image" width="50px" height="50px">
                                             </div> 
                                             <div class="col-md-10">
                                                 <p>kasdaskldjaskdljasdasddasld
                                                 aslkdjasdkljasdlk asjdaslkdj
                                                 sdklasdjaslkda sjlakdjasldkxxzxzdsffd</p>
                                             </div> 
                                             
                                         </div>
                                      <%
                                        }
                                      %>
                                  </div>  
                                    
                                </div>-->
                                
                                
                            </div>
                            
                        </div>         
                        

        </div><!-- boddy-->



        <div style="display:inline-block;width:100%;  position: relative; " >
            <%@include file="MyNaviFoot.jspf"  %>

        </div><!-- footer-->




    </body>
</html>
