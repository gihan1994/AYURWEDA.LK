<%-- 
    Document   : AdminPanel
    Created on : Sep 27, 2016, 10:03:52 AM
    Author     : Gihan
--%>

<%@page import="Resources.PrevilageCheck"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayurweda.lk/AdminPanel</title>
        
              <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
               <link href="css/MyCs.css" rel="stylesheet" type="text/css">
        <script src="js/jquery-3.1.0.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        
        <script>
            
   //for tab pane move         
            $('#users a').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
});
            
            $('#customers a').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
});
           $('#suppliers a').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
});
           $('#doctors a').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
});
           $('#spa a').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
});
           $('#yoga a').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
});
           $('#products a').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
});
           $('#admin a').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
});
//================================
        </script>
        

        
        
        
    </head>
    <body>
       
     
      <%
      
            if(request.getSession().getAttribute("username")!=null){
                PrevilageCheck precheck=new PrevilageCheck();
                
                    if(precheck.checkManager(request.getSession().getAttribute("username").toString(),
                        request.getRequestURL().toString(),"Click Adminpanel Button")){
                    
                    
           Session adminpanses = NewHibernateUtil.getSessionFactory().openSession();
      
      
      %> 
        
        
      <div style="display:inline;width:100%;height:800px;min-height:500px;background-image:url(img/backtest.jpg) " >
          <div class="container" style=" ">
            
                <h2 style="margin-left:400px "><strong>Administrative Area</strong></h2>   
         
                <div>

  <!-- Nav tabs -->
  <ul class="nav nav-tabs  nav-justified " role="tablist" style="background-color:#ffff99">
    <li role="presentation" class="active"><a href="#users" aria-controls="users" role="tab" data-toggle="tab" style="color: #000066;font-weight: bold;">Users</a></li>
    <li role="presentation"><a href="#customers" aria-controls="customers" role="tab" data-toggle="tab" style="color: #000066;font-weight: bold;">Customers</a></li>
    <li role="presentation"><a href="#suppliers" aria-controls="suppliers" role="tab" data-toggle="tab" style="color: #000066;font-weight: bold;">Suppliers</a></li>
    <li role="presentation"><a href="#Orders" aria-controls="doctors" role="tab" data-toggle="tab"  style="color: #000066;font-weight: bold;">Orders
        <% 
        List<Ordering> adminorcount = adminpanses.createCriteria(DB.Ordering.class).add(Restrictions.eq("status", "0")).list();
        if(adminorcount.size()>0){
        %>
        <span class="badge" style="background-color:#ff8d00 ;color: #000000; "><%=adminorcount.size()%></span>
        <%}%>
        </a></li>
    <li role="presentation"><a href="#invoGrn" aria-controls="invoGrn" role="tab" data-toggle="tab" style="color: #000066;font-weight: bold;">Invoices/GRN</a></li>
    <li role="presentation"><a href="#products" aria-controls="products" role="tab" data-toggle="tab" style="color: #000066;font-weight: bold;">Products</a></li>
    <%
    Login cheklog=(Login)adminpanses.createCriteria(DB.Login.class).add(Restrictions.eq("username", request.getSession().getAttribute("username"))).uniqueResult();
    if(cheklog!=null){
        if(cheklog.getUser().getUsertype().getTypeName().equals("SuperAdmin")){%>
   
    <li role="presentation"><a href="#admin" aria-controls="admin" role="tab" data-toggle="tab" style="color: #000066;font-weight: bold;">Admin Account</a></li>
    <%
                    }}
    %>
    
    <li role="presentation"><a href="#yoga" aria-controls="yoga" role="tab" data-toggle="tab" style="color: #000066;font-weight: bold;">Message<span class="badge" style="background-color:#9900ff;color: white; ">12</span></a></li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content">
      <div role="tabpanel" class="tab-pane fade in active" id="users">
          <!--Users-->
          <%@include file="Admin_Usesr.jsp"  %>
          
      </div>
      <div role="tabpanel" class="tab-pane fade" id="customers">
          <!--customers-->
          
          <%@include file="Admin_Customer.jsp"  %> 
          
                 
          
      </div>
      <div role="tabpanel" class="tab-pane fade" id="suppliers">
          <%@include file="AdminSupplier.jsp"  %> 
          
      </div>
      <div role="tabpanel" class="tab-pane fade" id="Orders">
          <!--orders-->
          <%@include file="AdminOrder.jsp"  %> 
      </div>
      <div role="tabpanel" class="tab-pane fade" id="invoGrn">
          <!--page content-->
            <%@include file="AdminInvoicesGrns.jsp"  %>
      </div>
    
      
      <%
      if(cheklog!=null){
        if(cheklog.getUser().getUsertype().getTypeName().equals("SuperAdmin")){%>
      
      <div role="tabpanel" class="tab-pane fade" id="products">
          <!--products-->
          <%@include file="AdminProduct.jsp"  %>
      </div>
      <%
        }}
      %>
      <div role="tabpanel" class="tab-pane fade" id="admin">
          <!--admin account-->
         
         <%@include file="AdminAccount.jsp"  %>
      </div>
  </div>

</div>
                 
                
            </div>
            
        </div>
       <%
                
                        }else{//no permission
                    
                    
                    response.sendRedirect("Home.jsp");
                    }
            
            
            
            }else{//user is not sign no permision
            
            response.sendRedirect("Home.jsp");
                
            }
       
       %>
       
       
        
    </body>
</html>
