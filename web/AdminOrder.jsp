 <%@page import="org.hibernate.criterion.Order"%>
<%-- 
    Document   : AdminOrder
    Created on : Feb 5, 2017, 8:15:29 AM
    Author     : Gihan
--%>

<%@page import="DB.Notifications"%>
<%@page import="DB.Messages"%>
<%@page import="java.util.Date"%>
<%@page import="DB.InvoiceHasGrnHasProducts"%>
<%@page import="DB.Shippingorder"%>
<%@page import="DB.Login"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="DB.Dispatchorders"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.List"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page import="DB.Ordering"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<script>

    function searchAdminOrderdData(type) {
        var url;
        var value = document.getElementById(type).value;
        if (type == "ordersefield") {
            url = "AdminOrder.jsp?searchData=Order&value=" + value;
        }
        if (type == "dissefield") {
            url = "AdminOrder.jsp?searchData=dispatch&value=" + value;
        }

        if (document.getElementById(type).value != '') {
            document.getElementById(type).style.borderColor = "";
            adminOrderDataSend(url);
        } else {
            document.getElementById(type).style.borderColor = "red";
        }
    }
    function orderDispatching(orid) {
        var url = "AdminOrder.jsp?oderdispatch=ok&orid=" + orid;
        adminOrderDataSend(url);
                  $("#orderModal").modal();
              
    }
    function adminOrderDataSend(url) {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {// 
            if (xhttp.readyState === 4 && xhttp.status === 200) {

                $("#oderdatacontent").hide().html(xhttp.responseText).fadeIn('slow');

            }
        };
        xhttp.open("GET", url, true);
        xhttp.send();
    }

</script>



<%
    Session adorses = NewHibernateUtil.getSessionFactory().openSession();
    Criteria orcri = adorses.createCriteria(DB.Ordering.class).add(Restrictions.eq("status", "0"));
    orcri.addOrder(Order.desc("idOrder"));
    Criteria disorcri = adorses.createCriteria(DB.Dispatchorders.class).addOrder(Order.desc("idDispatchOrders"));

    //search data dispath or Oder
//    Order
    if (request.getParameter("searchData") != null
            && request.getParameter("searchData").equalsIgnoreCase("Order") && request.getParameter("value") != null) {
        try {
            new Integer(request.getParameter("value"));
            orcri.add(Restrictions.eq("idOrder", new Integer(request.getParameter("value"))));
        } catch (Exception e) {
            Login l = (Login) adorses.createCriteria(DB.Login.class).add(Restrictions.eq("username", request.getParameter("value"))).uniqueResult();
            if (l != null) {
                orcri.add(Restrictions.eq("user", l.getUser()));
            }
        }
    }
//    dispath
    if (request.getParameter("searchData") != null
            && request.getParameter("searchData").equalsIgnoreCase("dispatch") && request.getParameter("value") != null) {
        try {
            new Integer(request.getParameter("value"));
            Ordering o = (Ordering) adorses.load(DB.Ordering.class, new Integer(request.getParameter("value")));
            if (o != null) {
                disorcri.add(Restrictions.eq("ordering", o));
            }
        } catch (Exception e) {
            Login l = (Login) adorses.createCriteria(DB.Login.class).add(Restrictions.eq("username", request.getParameter("value"))).uniqueResult();
            if (l != null) {
                Ordering o = (Ordering) adorses.createCriteria(DB.Ordering.class).add(Restrictions.eq("user", l.getUser()));
                if (o != null) {
                    disorcri.add(Restrictions.eq("ordering", o));
                }
            }
        }
    }

    //dispathed oder
    if (request.getParameter("oderdispatch") != null && request.getParameter("orid") != null) {

        Ordering o = (Ordering) adorses.load(DB.Ordering.class, new Integer(request.getParameter("orid")));
        if (o != null) {
            o.setStatus("1");
            adorses.update(o);
            adorses.flush();
            adorses.beginTransaction().commit();
            Dispatchorders d = new Dispatchorders();
            d.setDate(new Date());
            d.setOrdering(o);
            d.setStatus("0");
            d.setTime(new Date());
            adorses.save(d);
            adorses.flush();
            adorses.beginTransaction().commit();

            //send msg
            Messages m = new Messages();
            m.setUser(o.getUser());
            m.setHeding("Oder Confirmation");
            m.setMdate(new Date());
            m.setMtime(new Date());
            m.setStatus("0");
            m.setMbody("Your Order has been Dispatched." + "Oderid: " + o.getIdOrder() + "invoice ID: " + o.getInvoice().getIdInvoice());
            adorses.save(m);
            adorses.flush();
            adorses.beginTransaction().commit();

            Notifications n = new Notifications();
            n.setAdddate(new Date());
            n.setStatus("1");
            n.setTitle("orderid"+o.getIdOrder()+"your Oder has been Dispatched");
            n.setUser(o.getUser());
            adorses.save(n);
            adorses.flush();
            adorses.beginTransaction().commit();
        }
    }

%>
<div class="panel panel-body" id="oderdatacontent">
    
    <div style="display: inline-block">
        <div class="col-md-6">
            <div class="panel">
                <div class="panel-heading">
                    <%                        List<Ordering> orl = orcri.list();%>
                    <h3 style="font-weight: bold">Orders <span class="badge" style="background-color: #ff6633"><%=orl.size()%></span></h3>
                    <div class="input-group" style="margin-left:50px;margin-right:50px   ">
                        <input type="text" class="form-control" id="ordersefield" placeholder="Search oderId or Username">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" onclick="searchAdminOrderdData('ordersefield')">Search</button>
                        </span>
                    </div>
                </div>
                <div class="panel-body" style="max-height: 400px;overflow-style: panner;overflow: auto">
                    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                        <%

                            if (orl.size() > 0) {
                                int i = 0;
                                for (Ordering ori : orl) {
                        %>

                        <div class="panel panel-warning">
                            <div class="panel-heading" role="tab" id="heading<%=i%>"color: #000000">
                                 <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=i%>" aria-expanded="false" aria-controls="collapse<%=i%>">
                                        <div style="display: inline-block;width: 100%;height:15px ">
                                            <div class="col-md-4"><h5 style="font-weight: bold">OderId <small><%=ori.getIdOrder()%></small></h5></div>
                                            <div class="col-md-4"><h5 style="font-weight: bold">User <small><%
                                                for (Login l : ori.getUser().getLogins()) {
                                                    out.print(l.getUsername());
                                                }
                                                        %></small></h5></div>
                                            <div class="col-md-4"><h5 style="font-weight: bold">Date <small><%=new SimpleDateFormat("yyyy-MM-dd").format(ori.getOrderdate())%></small> </h5></div>




                                        </div>
                                    </a>
                                </h4>
                            </div>
                            <div id="collapse<%=i%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<%=i%>">
                                <div class="panel-body">
                                    <div style="display: inline-block;width: 100%">
                                       
                                        <div class="col-md-6">
                                            <h5 style="font-weight: bold">Shipping Details</h5>
                                            <ul class="list-group">
                                                <li class="list-group-item">
                                                    <h5 style="font-size:10px;font-weight: bold">Receiver Name : <span style="font-weight: normal"><%=ori.getResName() %></span></h5>
                                                </li>
                                                <li class="list-group-item">
                                                    <h5 style="font-size:10px;font-weight: bold">Address :
                                                        <span style="font-weight: normal"><%out.print(ori.getStreet1() + ",<br>" + ori.getStreet2() + ",<br>" + ori.getCity() + ".<br>" + ori.getPcode());%></span></h5>
                                                </li>
                                                <li class="list-group-item">
                                                    <h5 style="font-size:10px;font-weight: bold">Mobile :<span style="font-weight: normal"><%=ori.getUser().getTel()%></span></h5>
                                                </li>
                                                <li class="list-group-item">
                                                    <h5 style="font-size:10px;font-weight: bold">Email :<span style="font-weight: normal"><%=ori.getUser().getEmail()%></span></h5>
                                                </li>

                                            </ul>
                                        </div>
                                       
                                        <div class="col-md-6">
                                            <h5 style="font-weight: bold">Invoice Details</h5>
                                            <ul class="list-group">
                                                <li class="list-group-item">
                                                    <h5 style="font-size:10px;font-weight: bold">Invoice id : <span style="font-weight: normal"><%=ori.getInvoice().getIdInvoice()%></span></h5>
                                                </li>
                                                <li class="list-group-item">
                                                    <h5 style="font-size:10px;font-weight: bold">Products : <span style="font-weight: normal">
                                                            <ul>
                                                                <% for (InvoiceHasGrnHasProducts ip : ori.getInvoice().getInvoiceHasGrnHasProductses()) {%>
                                                                <li><%out.print(ip.getGrnHasProducts().getProducts().getProductName() + " " + ip.getInvoqty()); %></li>
                                                                    <%}%>
                                                            </ul>

                                                        </span></h5>
                                                </li>
                                                <li class="list-group-item">
                                                    <h5 style="font-size:10px;font-weight: bold">Date : <span style="font-weight: normal"><%=new SimpleDateFormat("yyyy-MM-dd").format(ori.getOrderdate())%></span></h5>
                                                </li>
                                                <li class="list-group-item">
                                                    <h5 style="font-size:10px;font-weight: bold">User : <span style="font-weight: normal"><%=ori.getUser().getFname() + "" + ori.getUser().getLname()%></span></h5>
                                                </li>

                                            </ul>
                                        </div>
                                    </div>
                                    <button style="margin-left:150px; " class="btn btn-default hedder-btn" onclick="orderDispatching(<%=ori.getIdOrder()%>)">Dispatch</button>
                                </div>
                            </div>
                        </div>

                        <%
                                i++;
                            }
                        } else {%>
                        <h4>No Orders Yet</h4>

                        <%}%>
                    </div>
                    <!--end-->
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="panel">
                <div class="panel-heading">
                    <%

                        List<Dispatchorders> disorl = disorcri.list();%>
                    <h3 style="font-weight: bold">Dispatch Orders <span class="badge" style="background-color: #00b534"><%=disorcri.list().size()%></span></h3>
                    <div class="input-group" style="margin-left:50px;margin-right:50px   ">
                        <input type="text" class="form-control" id="dissefield" placeholder="Search oder Id or Username">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" onclick="searchAdminOrderdData('dissefield')">Search</button>
                        </span>
                    </div>
                    <div style="display: inline-block;width: 100%">
                        <div class="col-md-3">
                            <h5 style="font-weight: bold">Oderid</h5>
                        </div>
                        <div class="col-md-3">
                           <h5 style="font-weight: bold">User name</h5> 
                        </div>
                        <div class="col-md-3">
                              <h5 style="font-weight: bold;margin-left:20px ">Date</h5> 
                        </div>
                        <div class="col-md-3">
                              <h5 style="font-weight: bold">Status</h5> 
                        </div>
                    </div>
                </div>
                <div class="panel-body" style="max-height: 400px;overflow-style: panner;overflow: auto">
                    <div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
                        <%
                            if (disorcri.list().size() > 0) {
                                int i = 0;

                                for (Dispatchorders disori : disorl) {
                        %>

                        <div class="panel panel-success">
                            <div class="panel-heading" role="tab" id="heading<%=i + "dis"%>">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion2" href="#collapse<%=i + "dis"%>" aria-expanded="false" aria-controls="collapse<%=i + "dis"%>">
                                        <div style="display: inline-block;width: 100%;height:15px ">
                                            <div class="col-md-3"><h5 style="font-weight: bold"><small><%=disori.getOrdering().getIdOrder()%></small></h5></div>
                                            <div class="col-md-4"><h5 style="font-weight: bold"><small><%
                                                for (Login l : disori.getOrdering().getUser().getLogins()) {
                                                    out.print(l.getUsername());
                                                }
                                                        %></small></h5></div>
                                            <div class="col-md-3"><h5 style="font-weight: bold;padding-left: 0px "><small><%=new SimpleDateFormat("yyyy-MM-dd").format(disori.getDate())%></small> </h5></div>
                                            <%
                                            if(disori.getStatus().equalsIgnoreCase("1")){%>
                                            <div class="col-md-2"><h6 style="font-weight: bold"><span class="badge" style="background-color: #00cc00">Delivered </span></h6></div>
                                            <%}
                                            %>
                                            <%
                                            if(disori.getStatus().equalsIgnoreCase("0")){%>
                                            <div class="col-md-2"><h6 style="font-weight: bold"><span class="badge" style="background-color: #ff9900">Process</span></h6></div>
                                            <%}
                                            %>




                                        </div>
                                    </a>
                                </h4>
                            </div>
                            <div id="collapse<%=i + "dis"%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<%=i + "dis"%>">
                                <div class="panel-body">
                                  <div style="display: inline-block;width: 100%">
                                       
                                        <div class="col-md-6">
                                            <h5 style="font-weight: bold">Shipping Details</h5>
                                            <ul class="list-group">
                                                <li class="list-group-item">
                                                    <h5 style="font-size:10px;font-weight: bold">Receiver Name : <span style="font-weight: normal"><%=disori.getOrdering().getResName() %></span></h5>
                                                </li>
                                                <li class="list-group-item">
                                                    <h5 style="font-size:10px;font-weight: bold">Address :
                                                        <span style="font-weight: normal"><%out.print(disori.getOrdering().getStreet1() + ",<br>" + disori.getOrdering().getStreet2() + ",<br>" + disori.getOrdering().getCity() + ".<br>" + disori.getOrdering().getPcode());%></span></h5>
                                                </li>
                                                <li class="list-group-item">
                                                    <h5 style="font-size:10px;font-weight: bold">Mobile :<span style="font-weight: normal"><%=disori.getOrdering().getUser().getTel()%></span></h5>
                                                </li>
                                                <li class="list-group-item">
                                                    <h5 style="font-size:10px;font-weight: bold">Email :<span style="font-weight: normal"><%=disori.getOrdering().getUser().getEmail()%></span></h5>
                                                </li>

                                            </ul>
                                        </div>
                                       
                                        <div class="col-md-6">
                                            <h5 style="font-weight: bold">Invoice Details</h5>
                                            <ul class="list-group">
                                                <li class="list-group-item">
                                                    <h5 style="font-size:10px;font-weight: bold">Invoice id : <span style="font-weight: normal"><%=disori.getOrdering().getInvoice().getIdInvoice()%></span></h5>
                                                </li>
                                                <li class="list-group-item">
                                                    <h5 style="font-size:10px;font-weight: bold">Products : <span style="font-weight: normal">
                                                            <ul>
                                                                <% for (InvoiceHasGrnHasProducts ip : disori.getOrdering().getInvoice().getInvoiceHasGrnHasProductses()) {%>
                                                                <li><%out.print(ip.getGrnHasProducts().getProducts().getProductName() + " " + ip.getInvoqty()); %></li>
                                                                    <%}%>
                                                            </ul>

                                                        </span></h5>
                                                </li>
                                                <li class="list-group-item">
                                                    <h5 style="font-size:10px;font-weight: bold">Date : <span style="font-weight: normal"><%=new SimpleDateFormat("yyyy-MM-dd").format(disori.getOrdering().getOrderdate())%></span></h5>
                                                </li>
                                                <li class="list-group-item">
                                                    <h5 style="font-size:10px;font-weight: bold">User : <span style="font-weight: normal"><%=disori.getOrdering().getUser().getFname() + "" + disori.getOrdering().getUser().getLname()%></span></h5>
                                                </li>

                                            </ul>
                                        </div>
                                    </div>
                                                    <%if(disori.getStatus().equalsIgnoreCase("1")){%>
                                                <h5 style="font-weight: bold">Customer Comments</h5>
                                                <div class="panel panel-body">
                                                    <%
                                                    if(disori.getCusComent()!=null){%>
                                                     <p><%=disori.getCusComent() %></p>
                                                    <%}else{
                                                        out.print("No Customer comments");
                                                    }%>
                                                    <p></p>
                                                </div>
                                                    <%}%>
                                </div>
                            </div>
                        </div>

                        <%i++;
                            }
                        } else {%>
                        <h4>No orders Dispatched Yet</h4>  
                        <%}%>
                    </div>
                    <!--end-->
                </div>
            </div>
        </div>
    </div>
</div>
   <div class="modal fade" id="orderModal" role="dialog">
                    <div class="modal-dialog  modal-open">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">

                                <h4 class="modal-title" style="font-size:28px;margin-left:200px;font-weight:bold;font-family: inherit">Message <span  class="glyphicon glyphicon-envelope" aria-hidden="true"></span></h4>

                            </div>
                            <div class="modal-body">
                                        <span style="color: #009900" class="glyphicon glyphicon-ok" aria-hidden="true"></span><strong><p  style="color: #009900" id="modalmsg">
                                    That Oder has been Dispatched
                                    </p></strong>
                            </div>
                            <div class="modal-footer">

                            </div>
                        </div>

                    </div>
                </div>