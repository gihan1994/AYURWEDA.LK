<%-- 
    Document   : Invoice
    Created on : Sep 28, 2016, 11:44:28 AM
    Author     : Gihan
--%>

<%@page import="DB.Shippingorder"%>
<%@page import="DB.Shipping"%>
<%@page import="DB.InvoiceHasGrnHasProducts"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="DB.Productoffers"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="DB.Login"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="DB.Invoice"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>


        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <script src="js/jquery-3.1.0.min.js"></script>
        <script src="js/bootstrap.min.js"></script> 

        
        <script>
            
        </script>
        
        
    </head>
    <body>

        <%
          Session s=NewHibernateUtil.getSessionFactory().openSession();
            if(request.getSession().getAttribute("username")!=null){
                
                Login ul=(Login)s.createCriteria(DB.Login.class)
                        .add(Restrictions.eq("username",request.getSession().getAttribute("username") )).uniqueResult();
          
                if(request.getParameter("invoiceid")!=null&&ul!=null){
                Invoice invo=(Invoice)s.createCriteria(DB.Invoice.class).
                        add(Restrictions.and(Restrictions.eq("idInvoice", new Integer(request.getParameter("invoiceid"))),
                                Restrictions.eq("user",ul.getUser() ))).uniqueResult();      
                
                
                   if(invo!=null||ul.getUser().getUsertype().getTypeName().equals("Admin")){
                    
        %>
          
                        <div class="panel panel-body panel-default">

                                

                            <div style="display:inline-block ">
                                <div class="col-md-5">
                                    <img src="img/InvoiceCover.png" class="img-responsive" alt="Responsive image Cover">  
                                    
                                </div>
                                <div class="col-md-5">
                                    <center><h3><strong>INVOICE</strong></h3></center>
                                </div>
                                <div class="col-md-2"></div>
                            
                <%
                
               
                
               
             
                
                    Criteria ihp=s.createCriteria(DB.InvoiceHasGrnHasProducts.class)
                            .add(Restrictions.eq("invoice", invo));
                
                    
                    
                String uname=invo.getUser().getFname()+" "+invo.getUser().getLname();
                
                Shippingorder ship=(Shippingorder)s.createCriteria(DB.Shippingorder.class).add(Restrictions.eq("user", ul.getUser())).uniqueResult();
              
                
                
                %>
                            
                            
                            </div>
                            <div style="display:inline-block;width:100% ">
                                <div class="col-md-6" style="text-align:left "> <h5>For - <%=uname%><br>
                                    <%
                                    if(ship!=null){
                                     out.print(ship.getStreet1()+"<br>");
                                     out.print(ship.getStreet2()+"<br>");
                                     out.print(ship.getCity()+"<br>");
                                     out.print(ship.getPostalcode()+"<br>");
                                     out.print(ul.getUser().getTel());
                                    
                                    }
                                    %>
                                    </h5></div>
                                <div class="col-md-6" style="text-align:right ">
                                    <h6>Date of issued - <% 
                                    out.write(new SimpleDateFormat("yyyy-MM-dd").format(invo.getDate()));
                                    %></h6>
                                </div>
                               
                            
                            </div>
                            <div style="display:inline-block;width:100% ">
                                <table class="table table-condensed">
                                    
                                   
                                    <tr class="warning">
                                        <th>NO</th>
                                    <th>Item Name</th>
                                    <th>Price</th>
                                    <th>Offers</th>
                                    <th>Qty</th>
                                    <th>Amount</th>
                                    </tr>
                                     <%
                                    List<InvoiceHasGrnHasProducts> ihpl=ihp.list();
                                    
                                    int i=1;
                                    
                                    for(InvoiceHasGrnHasProducts ini:ihpl){
                                    
                                    
                                    %>

                                    <tr>
                                        <td><%=i%></td>
                                        <td><%=
                                        ini.getGrnHasProducts().getProducts().getProductName()
                                        %> </td>
                                        <td><%=
                                        ini.getGrnHasProducts().getSellprice()
                                        %></td>
                                        <td><%
                                              Productoffers poff=(Productoffers)s.createCriteria(DB.Productoffers.class)
                                        .add(Restrictions.and(Restrictions.eq("grnHasProducts", ini.getGrnHasProducts()),
                                                Restrictions.eq("dateofview", invo.getDate()))).uniqueResult();
                              
                                if(poff!=null&&poff.getOfferstatus().equalsIgnoreCase("1")){
                                   out.print(poff.getPresentage()+"%");
                                    }else{
                                out.print("No");
                                }
                                        
                                        %></td>
                                        <td><%=
                                        ini.getInvoqty()
                                        %></td>
                                        <td><%=
                                        ini.getTotal()
                                        %></td>

                                    </tr>
                                    
                                    <%
                                    i++;
                                    }%>
                                    
                                </table> 

                            </div>
                            <div style="display:inline-block;width:100%  ">

                                <table class="table table-condensed">
                                    <tr class="active">
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td><h4><strong>Grand Total</strong></h4></td>
                                        <td class="danger"><h4><strong><%
                                        out.print(new DecimalFormat("0.00").format(invo.getTotal())+" LKR");
                                        %></strong></h4></td>
                                    </tr>

                                </table>
                            </div>

                        </div>  
                 <%
                }else{
                   out.write("<h3 style=\"color: #cc0000\">Sorry You Have No Access this</h3>");
                   }
                
                %>   
                
                
<%
                }else{
                    
                    response.sendRedirect("Home.jsp");
                
                }
}else{
    
}
%>
    </body>
</html>
