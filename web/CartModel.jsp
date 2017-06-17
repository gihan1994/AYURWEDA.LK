<%-- 
    Document   : CartModel
    Created on : Jan 10, 2017, 10:59:45 AM
    Author     : Gihan
--%>

<%@page import="DB.GrnHasProducts"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Date"%>
<%@page import="DB.Productoffers"%>
<%@page import="java.util.HashMap"%>
<%@page import="DB.Products"%>
<%@page import="DB.CartHasProducts"%>
<%@page import="java.util.List"%>
<%@page import="DB.Login"%>
<%@page import="DB.Cart"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<div style="display: inline-block">
    <div class="container" style="padding-top:50px ">
                <div style="display: inline-block">
                    <h2 style="padding-left:150px;font-family:cursive;font-weight: bold  ">Your Product Cart</h2>
                    

                </div>
                <br>
                <br>
                <div style="display: inline-block;padding-left:200px ">
                     <%                        Session ss = NewHibernateUtil.getSessionFactory().openSession();

                        if (request.getSession().getAttribute("username")!= null) {

                            Login l = (Login) ss.createCriteria(DB.Login.class).add(Restrictions.eq("username", request.getSession().getAttribute("username"))).uniqueResult();
//                            User u = (User) ss.createCriteria(DB.User.class).add(Restrictions.eq("idUser", l.getUser().getIdUser())).uniqueResult();

                            Cart c = (Cart) ss.createCriteria(DB.Cart.class).
                                    add(Restrictions.eq("user", l.getUser())).uniqueResult();

                            

                     
                            Double grandTotal = 0.0;
                            if (c!=null) {
                                
                                List<CartHasProducts> chpl = ss.createCriteria(DB.CartHasProducts.class).add(Restrictions.eq("cart", c)).list();
                    %>

                    <table class="table table-bordered">
                        <tr>
                            <th width="15%"></th>
                            <th width="15%">Product</th>
                            <th width="15%">Price</th>
                            <th width="15%" >Offers</th>
                            <th width="10%">Quantity</th>
                            <th width="15%">Amount</th>
                            <th width="15%">Option</th>
                        </tr>

                        <%
                            //this work only when the cart has available braduct 
                            for (CartHasProducts ci : chpl) {


                        %>  

                        <tr style="text-align: center">

                            <td > 
                                <a href="">
                                    <img src="<%                                        Products p = (Products) NewHibernateUtil.getSessionFactory().openSession().createCriteria(DB.Products.class).
                                                add(Restrictions.eq("idProducts", ci.getProducts().getIdProducts())).uniqueResult();

                                        out.print(p.getImg());

                                         %>" alt="..." class=" img-responsive" height="50" width="50">
                                </a>
                            </td>
                            <td ><%                            out.print(p.getProductName());
                                %></td>
                            <td >
                                <%
                              GrnHasProducts ghp=(GrnHasProducts)ss.createCriteria(DB.GrnHasProducts.class)
                                .add(Restrictions.and(Restrictions.eq("products", p),
                                        Restrictions
                                        .and(Restrictions.eq("grnpstatus", "1"), Restrictions.eq("qtystatus", "1")))).uniqueResult();
                                Double uniqprice=0.0;   
                                if(ghp!=null){
                                    uniqprice=ghp.getSellprice();
                                   out.print(ghp.getSellprice()+" LKR");
                                   }else{
                                   out.print("Out Of Stock");
                                   }
                                %>
                            </td>
                            <td style="font-weight: bold" >
                                <%
                                    int poffer=0; 
                                       Productoffers poff=(Productoffers)ss.createCriteria(DB.Productoffers.class)
                                        .add(Restrictions.and(Restrictions.eq("grnHasProducts",ghp),
                                                Restrictions.eq("dateofview", new Date()))).uniqueResult();
                              
                                if(poff!=null&&ghp!=null&&poff.getOfferstatus().equalsIgnoreCase("1")){
                                    poffer=poff.getPresentage();
                                        out.print(poff.getPresentage()+"%");    
                                    }else{out.print("NO"); }
                                %>
                            </td>
                            <td >
                                <input type="number" onchange="updateAndQtyCheck(<%=ci.getProducts().getIdProducts() %>)"  class="form-control" value="<%= ci.getQty()%>" max="<%=p.getTolQty()%>" min="1" 
                                       onkeypress="return false;" onkeydown="return false;"  oncontextmenu="javascript:return false;"  id="<%out.print("q"+ci.getProducts().getIdProducts());%>">
                            </td>
                            <td>
                        <lable id="pamount"><%
                             Double amont= uniqprice * ci.getQty();
                             if(poffer!=0){
                             amont=( uniqprice-( uniqprice*poffer/100))*ci.getQty();
                             }
                            grandTotal +=amont;
                            
                            out.print(new DecimalFormat("0.00").format(amont)+" LKR");

                            %> </lable> 
                        </td>
                        <td >
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                 <button type="button" class="btn btn-xs btn-warning" style="font-weight: bold"  onclick="removeCartItem(<%out.print(p.getIdProducts());%>,<%out.print(ci.getCart().getIdCart());%>)">
                                 <span class="glyphicon glyphicon-remove" area-hidden="true"></span>
                                 </button>
                            </div>
                            <div class="col-md-1"></div>   
                        </td>

                        </tr>  

                        <%}
                        %>
                    </table> 
                </div>
                    <div style="background-color:#ffff99 ;display: inline-block; margin-left:200px;width:82% ">
                        
                    <div class="col-md-5">
                        <h3 style="font-weight:bold;font-family: monospace;font-size:28px">Grand Total<span style="color: #330033"> <%
                            out.print(new DecimalFormat("0.00").format(grandTotal )+ " LKR");
                            %></span></h3>
                    </div>
                    <div class="col-md-2"></div>
                    <div class="col-md-5">
                        <div style="display: inline-block;padding-bottom:20px ">
                            <br>
                            
                            <div class="col-md-6">
                                <div class="btn-group"> 
                                    <button type="button" class="btn btn-danger" onclick="location.href = 'CartManager?CButton=clearcart&cartid=<%
                                        out.print(c.getIdCart());
                                            %>'">Clear All</button>
                                            

                                </div>
                            </div>

                                            <div class="col-md-6"><button class="btn btn-default hedder-btn btn-lg" type="button" onclick="getInvoice(<%out.print(c.getIdCart());%>)"><span class="glyphicon glyphicon-briefcase" aria-hidden="true"></span> Checkout Cart</button></div>
                      
                        </div>
                       
                    </div>

                
                    </div> 

                
                <%} else {%>  

                <div style="display: inline-block;width:100%" >
                    <div class="col-md-1">

                    </div>
                    <div class="col-md-10">
                        <h3 style="color:#ff0000; "><strong>No Items Available</strong></h3>  

                    </div>
                    <div class="col-md-1">

                    </div>

                </div>

                <%}%>

<!--------------------------------------------session cart area----------------------------------------------->

                <%} else {

                            if(request.getSession().getAttribute("uscart")!=null){
                            
                    HashMap<String, Integer> itemid = (HashMap) request.getSession().getAttribute("uscart");
                
                Double sgrandTotal=0.0;
                
                
                if(itemid.keySet().size()>0){
               
                %>

                   

                <table class="table table-bordered" style="padding-left:150px;width: 100%">
                        <tr>
                            <th width="15%"></th>
                            <th width="15%">Product</th>
                            <th width="15%">Price</th>
                            <th width="15%">Offers</th>
                            <th width="10%">Quantity</th>
                            <th width="15%">Amount</th>
                            <th width="15%">Option</th>
                        </tr>

                        <%
                            //this work only when the cart has available product 
                            for (String pid : itemid.keySet()) {


                        %>  

                        <tr style="text-align: center">

                            <td > 
                                <a href="">
                                    <img src="<%                                        Products sp = (Products) ss.createCriteria(DB.Products.class).
                                                add(Restrictions.eq("idProducts", new Integer(pid))).uniqueResult();

                                        out.print(sp.getImg());

                                         %>" alt="..." class=" img-responsive" height="50" width="50">
                                </a>
                            </td>
                            <td ><%                            out.print(sp.getProductName());
                                %></td>
                            <td >
                                <%
                                  GrnHasProducts ghp=(GrnHasProducts)ss.createCriteria(DB.GrnHasProducts.class)
                                .add(Restrictions.and(Restrictions.eq("products", sp),
                                        Restrictions
                                        .and(Restrictions.eq("grnpstatus", "1"), Restrictions.eq("qtystatus", "1")))).uniqueResult();
                                Double uniqprice=0.0;   
                                if(ghp!=null){
                                    uniqprice=ghp.getSellprice();
                                   out.print(ghp.getSellprice()+" LKR");
                                   }else{
                                   out.print("Out Of Stock");
                                   }
                                %>
                            </td>
                            <td style="font-weight: bold" >
                                <%
                                     int poffer=0; 
                                       Productoffers poff=(Productoffers)ss.createCriteria(DB.Productoffers.class)
                                        .add(Restrictions.and(Restrictions.eq("grnHasProducts",ghp),
                                                Restrictions.eq("dateofview", new Date()))).uniqueResult();
                              
                                if(poff!=null&&ghp!=null){
                                    poffer=poff.getPresentage();
                                        out.print(poff.getPresentage()+"%");    
                                    }else{out.print("NO"); }
                                %>
                            </td>
                            <td >
                                <input type="number" onchange="updateAndQtyCheck(<%=sp.getIdProducts() %>)"  class="form-control" value="<%= itemid.get(pid)%>" min="1" max="<%=sp.getTolQty()  %>" 
                                       onkeypress="return false;" onkeydown=" return false;"  oncontextmenu="javascript:return false;"   id="<%out.print("q"+pid);%>">
                         
                                
                               
                            </td>
                            <td>
                        <lable id="pamount"><%
                              Double amont=uniqprice * itemid.get(pid);
                             if(poffer!=0){
                             amont=(uniqprice-(uniqprice*poffer/100))*itemid.get(pid);
                             }          
                            sgrandTotal +=amont;
                            out.print(new DecimalFormat("0.00").format(amont)+" LKR");

                            %> </lable> 
                        </td>
                        <td >
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <button type="button" class="btn btn-warning" style="font-weight: bold"  onclick="removeCartItem(<%out.print(pid);%>,1)"><span class="glyphicon glyphicon-remove" area-hidden="true"></span></button>
                            <div class="col-md-1"></div>   
                        </td>

                        </tr>  

                        <%}
                        %>
                    </table>
                    <div  style="background-color:#ffff99 ;display: inline-block;width:100%">
                    <div class="col-md-5">
                         <h3 style="font-weight:bold;font-family: monospace;font-size:28px">Grand Total<span style="color: #330033;font-family:'Bitstream Vera Sans Mono',Times,serif">  <%
                            out.print(new DecimalFormat("0.00").format(sgrandTotal )+ " LKR");
                            %></span></h3>
                    </div>
                    <div class="col-md-2"></div>
                    <div class="col-md-5">
                        
                        <div style="display: inline-block;padding-bottom:20px ">
                            <br>


                            <div class="col-md-6">
                                <div class="btn-group"> 
                                    <button type="button" class="btn btn-danger" onclick="location.href = 'CartManager?CButton=clearcart&cartid=<%
                                        out.print(1);
                                            %>'">Clean Cart</button>
                                            
                                </div>
                            </div>

                                            <div class="col-md-6"><button class="btn btn-default btn-lg hedder-btn" type="button" onclick="location.href='InvoiceManager?payButton=checkcart'"><span class="glyphicon glyphicon-briefcase" aria-hidden="true"></span> Checkout Cart</button></div>
                       
                        </div>
                        
                    </div>

                </div> 

                        
                        
                        
                        
                        
                        
                        
                
                    <%
                               
                            
                            }else{%>
                               <div style="display: inline-block" >
                    <div class="col-md-1">

                    </div>
                    <div class="col-md-10">
                        <h3 style="color:#ff0000; "><strong>No Items Available</strong></h3>  

                    </div>
                    <div class="col-md-1">

                    </div>

                </div>  
                            
                            <%}}//end if of is null uscart object
                        
                else{%>          
                            
                      <div style="display: inline-block">
                    <div class="col-md-1">

                    </div>
                    <div class="col-md-10">
                        <h3 style="color:#ff0000; "><strong>No Items Available</strong></h3>  

                    </div>
                    <div class="col-md-1">

                    </div>

                </div>        
    
    <%}
                        }%>





                <br>
                <br>
               
                    <div style="display: inline-block;margin-left:400px;">
                    
                         <div class="col-md-2"></div>
                    <div class="col-md-8">
                        <a href="ViewProduct.jsp"><img src="img/continue-shopping-button.png" onload="callCartItemcount()" class="img-responsive" align="center"></a> 
                    </div>
                    <div class="col-md-2"></div>
                </div>
               
                


                <br>
                <br>


            </div>

</div>

