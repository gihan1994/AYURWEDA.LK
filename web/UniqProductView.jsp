<%-- 
    Document   : UniqProductView
    Created on : Jan 15, 2017, 2:34:00 PM
    Author     : Gihan
--%>

<%@page import="org.hibernate.criterion.Order"%>
<%@page import="DB.Productreview"%>
<%@page import="DB.GrnHasProducts"%>
<%@page import="DB.Productoffers"%>
<%@page import="DB.ProductsHasBrands"%>
<%@page import="DB.Products"%>
<%@page import="org.hibernate.SQLQuery"%>
<%@page import="java.text.DecimalFormat"%>
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

        
        <script>
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
        
        
    </head>
    
    
    
    <body>
          
        <div style="display:inline;width:100%" >
            <%@include file="MyNavi.jspf"  %>

        </div>    
            <%
            Session upses=NewHibernateUtil.getSessionFactory().openSession();
            
            if(request.getParameter("repid")!=null){
                Products up=(Products)upses.createCriteria(DB.Products.class)
                        .add(Restrictions.eq("idProducts", new Integer(request.getParameter("repid")))).uniqueResult();
           if(up!=null){
           %>
           <div  style="display:inline-block;margin-bottom:50px;margin-top: 100px;margin-left:200px;margin-right:100px    ">
                            <div class="col-md-7">
                                <img src="<%=up.getImg()%>" alt="No Image" style="width:450px;height:500px  ">

                            </div>
               <div class="col-md-5">
                   <div style="margin-left:100px ">
                       <div style="display:inline; ">
                                
                                  <h1><%=up.getProductName() %></h1>
                                  <h4>Category<small> <%=up.getPCatergory().getCatName()%></small></h4>
                                </div>
                                <div style="display:inline ">
                                    <h4 style="font-weight:bold ">Description</h4>
                                    <p><%=up.getDescription()%></p>
                                </div>
                                <div style="display:inline ">
                                    <h4>
                                       <%
                                       ProductsHasBrands phb=(ProductsHasBrands)upses.createCriteria(DB.ProductsHasBrands.class)
                                               .add(Restrictions.eq("products", up)).uniqueResult();
                                       if(phb!=null){out.print(phb.getBrands().getBrandname());}
                                       %> 
                                    </h4>
                             

                                </div>
                                <div style="display:inline-block ">
                                               
                                     <%
                                    
                                         GrnHasProducts ghp=(GrnHasProducts)upses.createCriteria(DB.GrnHasProducts.class)
                                .add(Restrictions.and(Restrictions.eq("products", up),
                                        Restrictions
                                        .and(Restrictions.eq("grnpstatus", "1"), Restrictions.eq("qtystatus", "1")))).uniqueResult();
                                Double uniqprice=0.0;   
                                if(ghp!=null){
                                    out.print("<span style=\"font-weight:bold;font-size:20px;color: #00b40b\">In Stock<br></span>");
                                    Productoffers poff=(Productoffers)upses.createCriteria(DB.Productoffers.class).add(Restrictions.
                                            and(Restrictions.eq("grnHasProducts", ghp),
                                                    Restrictions.eq("dateofview", new Date()))).uniqueResult();
                                    if(poff!=null&&poff.getOfferstatus().equalsIgnoreCase("1")){
                                     out.print("<del style=\"color: #999999;font-size:16px\" >"+ghp.getSellprice()+" LKR</del>");
                                     out.print("<br>");
                                    out.print("<span style=\"font-weight:bold;color: #33004b;font-size:20px\">"+new DecimalFormat("0.00").format(ghp.getSellprice()-ghp.getSellprice()*poff.getPresentage()/100)+" LKR <br></span>");
                                    }else{
                                     out.print("<span style=\"font-weight:bold;font-size:20px\">"+ghp.getSellprice()+" LKR<br></span>");
                                    }
                                    uniqprice=ghp.getSellprice();
                                  
                                   }
                                     %>
                                         
                                               
                                           
                                </div>

                                <div style="display:inline-block;margin-top:50px   ">
                                    
                                    <button class="btn btn-default hedder-btn btn-lg" onclick="BuyNow(<%=up.getIdProducts()%>)"> Buy Now</button>
                                </div>
                                <div style="display:inline-block ">
                                    <h4 style="font-weight: bold">Reviews</h4>
                                    <%
                                   Criteria preview=upses.createCriteria(DB.Productreview.class).add(Restrictions.eq("products", up)).addOrder(Order.desc("reviewDate"));
                                   preview.setMaxResults(3);
                                   if(preview.list().size()>0){
                                   %>
                                    
                                    <ul>
                                      <%
                                      for(Productreview prw:(List<Productreview>)preview.list()){
                                      %>
                                      <li><%=prw.getReview()  %> <h6><small><%=new SimpleDateFormat("yyyy-MM-dd").format(prw.getReviewDate())  %></small></h6></li>  
                                      
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

<%
String sql="SELECT"+
   "  `products`.`idProducts`"+
   " , `products`.`ProductName`"+
   " , `grn_has_products`.`sellprice`"+
    ", `products`.`img`"+
    ", `brands`.`brandname`"+
    ", `p_catergory`.`idP_Catergory`"+
"FROM"+
    "`products_has_brands`"+
    "INNER JOIN `products` "+
        "ON (`products_has_brands`.`Products_idProducts` = `products`.`idProducts`)"+
    "INNER JOIN `brands` "+
        "ON (`products_has_brands`.`Brands_idBrands` = `brands`.`idBrands`)"+
    "INNER JOIN `grn_has_products`"+ 
        "ON (`grn_has_products`.`Products_idProducts` = `products`.`idProducts`)"+
   " INNER JOIN `p_catergory`"+ 
       " ON (`products`.`P_Catergory_idP_Catergory` = `p_catergory`.`idP_Catergory`) where GRNPstatus='1' AND qtystatus='1' "+
        "and idP_Catergory='"+up.getPCatergory().getIdPCatergory()+"'";
            SQLQuery pidq=upses.createSQLQuery(sql);
                                List cpidl=pidq.list();
                                if(cpidl.size()>0){
                                    int indicount=0; 

%>
<div id="carousel-example-generic2" class="carousel slide" data-ride="carousel">
     <h2 style="font-weight: bold;font-family:cursive;margin-left:100px ">More Products of <%=up.getPCatergory().getCatName() %> </h2>
                    

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
                                   up=(Products)upses.load(DB.Products.class, new Integer(oa[0].toString()));
                                      ghp=(GrnHasProducts)upses.createCriteria(DB.GrnHasProducts.class)
                                .add(Restrictions.and(Restrictions.eq("products", up),
                                        Restrictions
                                        .and(Restrictions.eq("grnpstatus", "1"), Restrictions.eq("qtystatus", "1")))).uniqueResult();
                                Double uniqpricecru=0.0;
                                int offrate=0;
                                if(ghp!=null){
                                    Productoffers poff=(Productoffers)upses.createCriteria(DB.Productoffers.class).add(Restrictions.
                                            and(Restrictions.eq("grnHasProducts", ghp),
                                                    Restrictions.eq("dateofview", new Date()))).uniqueResult();
                                    
                                    if(poff!=null&&poff.getOfferstatus().equalsIgnoreCase("1")){
                                        offrate=poff.getPresentage();
                                    }
                                    uniqprice=ghp.getSellprice();
                                  
                                   }   
                                   
                            %>
                            <div class="<%=dcls%>">
                                <%if(offrate!=0){%>
                                  <span class="badge" style="rotation:190deg;position: absolute;
                                      background-color:#ff3300;color:#ffffff;" >
                                    <h5 style="font-weight:bold;">
                                        <% 
                                        
                                    out.print("Offer "+offrate+"%"); %>   
                                    </h5>
                                
                                </span>
                                
                                <%}%>
                              
                            <div class="panel panel-body text-center" style="width:250px;box-shadow: 10px 10px 40px grey; ">
                            <div >
                                <img src="<%=oa[3].toString()%>"
                                      onclick="window.location.href='UniqProductView.jsp?repid=<%=oa[0].toString()%>'"
                                     alt="No Image" style="width:200px;height:200px;cursor: pointer  " >
                            </div>
                                <div >
                                    <h3 style="font-weight: bold"><%=oa[1].toString()%><br> 
                                        
                                        <small>
                                            <%=oa[4].toString()%>
                                           </small></h3>
                                </div>
                                           <div style="margin-left:20px;margin-right:20px;margin-top: 5px">
                                            <%
                                               if(offrate!=0){
                                        
                                     out.print("<del style=\"color: #999999;font-size:14px\" >"+ghp.getSellprice()+" LKR</del>");
                                     out.print("<br>");
                                    out.print("<span style=\"font-weight:bold;color: #33004b;font-size:18px\">"+new DecimalFormat("0.00").format(ghp.getSellprice()-ghp.getSellprice()*offrate/100)+"</span>");
                                    }else{
                                      out.print("<br>");             
                                     out.print("<span style=\"font-weight:bold;font-size:18px\">"+ghp.getSellprice()+" LKR</span>");
                                    }
                                            %>
                                           </div>     
                                <div >
                                    <button class="btn btn-default hedder-btn" style="margin-left:20px;margin-right:20px  ">Buy Now</button>
                                  
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

        <%
                                
           }else{ response.sendRedirect("AccessPrevent.jsp");}                     
        }else{
        
        response.sendRedirect("AccessPrevent.jsp");
        }
        
        %>
    
        <div style="display:inline-block;width:100% " >
            <%@include file="MyNaviFoot.jspf"  %>

        </div><!-- footer-->

    </body>
</html>
