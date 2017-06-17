<%-- 
    Document   : GRN
    Created on : Jan 23, 2017, 11:37:09 PM
    Author     : Gihan
--%>

<%@page import="java.util.Set"%>
<%@page import="DB.GrnHasProducts"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="DB.Grn"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
 <%
     if(request.getParameter("grnid")!=null){
 Session grnsess=NewHibernateUtil.getSessionFactory().openSession();
 Grn mgrn=(Grn)grnsess.load(DB.Grn.class, new Integer(request.getParameter("grnid")));
 
 %>
    <div >
        <h3 style="font-weight: bold">GRN<br>
            <small>NO:<%=mgrn.getIdGrn()  %></small>
        </h3>
        <h4>Supplier Name: <%=mgrn.getSupplier().getFullName()  %></h4>
        <h5>Date: <%out.print(new SimpleDateFormat("yyyy-MM-dd").format(mgrn.getDate()));  %></h5>
        <table class="table table-responsive table-bordered" style="box-shadow:10px #ffcc33 ">
            <th> product id</th>
            <th>product Name</th>
            <th>Buy Price(LKR)</th>
            <th>Buy Qty</th>
            
            <%
            Set<GrnHasProducts>ghps= mgrn.getGrnHasProductses();
            for(GrnHasProducts ghp: ghps){
            
            %>
            
            <tr>
                  <td> <%=ghp.getProducts().getIdProducts()  %></td>
            <td><%=ghp.getProducts().getProductName() %></td>
            <td><%=ghp.getBuyprice() %></td>
            <td><%=ghp.getSellprice() %></td>
            </tr>
            
            <%}%>
        </table>   
        
        <div style="margin-top:20px;display: inline-block;width:100%  ">
            <div class="col-md-8">
                <h3 style="font-weight: bold;color: #012231;padding-left:200px ">Grand Total </h3>
            </div>
            <div class="col-md-4">
                  <h3 style="font-weight: bold;color: #012231"><%=mgrn.getTotal() %> LKR </h3>
            </div>
        </div>
    </div>

<%}else{
         
      response.sendRedirect("AccessPrevent.jsp");
     }%>