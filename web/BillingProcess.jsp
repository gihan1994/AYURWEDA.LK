 <%-- 
    Document   : BillingProcess
    Created on : Jan 11, 2017, 10:46:01 AM
    Author     : Gihan
--%>

<%@page import="DB.Cart"%>
<%@page import="DB.Shippingorder"%>
<%@page import="Resources.PrevilageCheck"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
          <script type="text/javascript">
        window.history.forward();
        function noBack(){
         window.history.forward();   
            
        }
    </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayurweda.lk/Billing Process</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="css/MyCs.css" rel="stylesheet" type="text/css">
        <script src="js/jquery-3.1.0.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </head>
    <script>
           


        function DataSender(url) {
            var xhttpbill = new XMLHttpRequest();
            xhttpbillonreadystatechange = function() {// 
                if (xhttpbill.readyState === 4 && xhttpbill.status === 200) {
                    //set itemcount lable before
//                        $("#cartmodelcontent").hide().html(xhttpbill.responseText).fadeIn('slow');  

                }
            };
            xhttpbill.open("GET", url, true);
            xhttpbill.send();
        }

        function checkFields(cartid) {
            var ids = ['rname', 'rstr1', 'rstr2', 'rcity', 'rpcode', 'remail', 'rtel', 'rcardno', 'rcardscode'];
            var i = 0;
            var status = false;
            for (i in ids) {

                if (document.getElementById(ids[i]).value != '') {
                    document.getElementById(ids[i]).style.borderColor = "";
                    status = true;
                } else {
                    document.getElementById(ids[i]).style.borderColor = "red";
                    status = false;
                }
            }

            if (status) {

                var myform = document.getElementById("billinfor");


                var fd = new FormData(myform);
                $.ajax({
                    url: "BillingProcesser",
                    data: fd,
                    cache: false,
                    processData: false,
                    contentType: false,
                    type: 'POST',
                    success: function(dataofconfirm) {

                        window.location.href = "InvoiceManager?payButton=checkcart&cartid=" + cartid;
                    }

                });

            }

        }

        $(document).ready(function() {



        });

    </script>

    <body  onload="noBack()" onpageshow="if(event.persisted)noBack();" onunload="">
        <%              Session s = NewHibernateUtil.getSessionFactory().openSession();
            Login blog = (Login) s.createCriteria(DB.Login.class)
                    .add(Restrictions.eq("username", request.getSession().getAttribute("username"))).uniqueResult();
            if (blog != null) {
                PrevilageCheck precheck = new PrevilageCheck();

                if (precheck.checkManager(request.getSession().getAttribute("username").toString(),
                        request.getRequestURL().toString(), "Click Checkout  Button")) {

                    Cart ucc = (Cart) s.createCriteria(DB.Cart.class).add(Restrictions.eq("user", blog.getUser())).uniqueResult();

                    if (ucc != null && request.getParameter("cartid") != null) {
                        System.out.print("carid awaaa " + request.getParameter("cartid")+ucc.getIdCart());
                        //checked user cart id is equal request cart id
                        int reqcartid=new Integer(request.getParameter("cartid"));
                        if (reqcartid==ucc.getIdCart()) {

                            System.out.print("match carid awaaa " + request.getParameter("cartid"));


        %> 


        <div>
            <%@include file="MyNavi.jspf"  %>
        </div><!-- hedder-->

        <%            String str1 = "";
            String str2 = "";
            String city = "";
            String pcode = "";
            String email = "";
            String tel = "";
            String fname = "";
            String lname = "";
            Login l = (Login) s.createCriteria(DB.Login.class).add(Restrictions.eq("username", request.getSession().getAttribute("username"))).uniqueResult();
            if (l != null) {
                fname = l.getUser().getFname();
                lname = l.getUser().getLname();
                Shippingorder so = (Shippingorder) s.createCriteria(DB.Shippingorder.class)
                        .add(Restrictions.eq("user", l.getUser())).uniqueResult();
                //shpping details available
                if (so != null) {

                    if (so.getStreet1() != null) {
                        str1 = so.getStreet1();
                    }
                    if (so.getStreet2() != null) {
                        str2 = so.getStreet2();
                    }
                    if (so.getCity() != null) {
                        city = so.getCity();
                    }
                    if (so.getPostalcode() != null) {
                        pcode = so.getPostalcode();
                    }
                    if (l.getUser().getEmail() != null) {
                        email = l.getUser().getEmail();
                    }
                    if (l.getUser().getTel() != null) {
                        tel = l.getUser().getTel();
                    }

                } else {

                }

            }

        %>
        <form action="BillingProcesser"  method="post"  enctype="multipart/form-data" id="billinfor">
            <div style="display: inline-block;width: 100%;margin-top:30px " id="billcontent">
                <div class="col-md-6">
                    <div class="panel panel-success" style="margin-top:50px;margin-left:100px;margin-right: 50px;margin-bottom:50px   ">
                        <div class="panel-heading">
                            <h3 style="font-weight: bold;"> <span class="glyphicon glyphicon-list-alt" area-hidden="true"></span> Billing Process</h3>
                            <h6 style="font-size:10px ">Fields will be filled automatically your existing Details</h6>
                        </div>
                        <div class="panel-body">
                            <h4 style="font-weight: bold">Receiver Name <span class="glyphicon glyphicon-user" area-hidden="true"></span></h4>
                            <input type="text" id="rname" name="rname" value="<%out.print(fname + " " + lname);%>" placeholder="Enter Name of Receiver" class="form-control" style="padding:10px;font-family: monospace;font-size:16px;color: #330033 ">
                            <h4 style="font-weight: bold">Receiver Address <span class="glyphicon glyphicon-home" area-hidden="true"></span></h4>
                            <input type="text" id="rstr1" name="rstr1"  value="<%=str1%>" placeholder="Street 1" class="form-control" style="padding:10px;margin-bottom:5px;font-family: monospace;font-size:16px;color: #330033  ">
                            <input type="text" id="rstr2" name="rstr2" value="<%=str2%>" placeholder="Street 2"  class="form-control" style="padding-left:10px;padding-right:10px;padding-top:5px;margin-bottom:5px;font-family: monospace;font-size:16px;color: #330033 ">
                            <input type="text" id="rcity" name="rcity" value="<%=city%>" placeholder="City"  class="form-control" style="padding-left:10px;padding-right:10px;padding-top:5px;margin-bottom:5px;font-family: monospace;font-size:16px;color: #330033  ">
                            <input type="number" id="rpcode" name="rpcode" value="<%=pcode%>" placeholder="Postal Code"  class="form-control" style="padding-left:10px;padding-right:10px;padding-top:5px;padding-bottom:10px;font-family: monospace;font-size:16px;color: #330033 ">
                            <h4 style="font-weight: bold">Receiver Telephone <span class="glyphicon glyphicon-earphone" area-hidden="true"></span></h4>
                            <input type="number" id="rtel" name="rtel" value="<%=tel%>" placeholder="Enter Contact of Receiver"  onkeypress="" class="form-control" style="padding:10px;font-family: monospace;font-size:16px;color: #330033 ">
                            <h4 style="font-weight: bold">Receiver Email <span class="glyphicon glyphicon-envelope" area-hidden="true"></span></h4>
                            <input type="email" id="remail" name="remail"value="<%=email%>" placeholder="Enter email for Order Confirming"   class="form-control" style="padding:10px;font-family: monospace;font-size:16px;color: #330033 ">
                        </div>
                    </div> 
                </div>
                <div class="col-md-6">
                    <div class="panel panel-warning" style="margin-top:50px;margin-left:50px;margin-right: 100px;margin-bottom:50px " >
                        <div class="panel-heading">
                            <h3 style="font-weight: bold"> <span class="glyphicon glyphicon-exclamation-sign" area-hidden="true"></span> Secure Payment Process</h3> 
                            <h5>Provided by <img src="img/bank.png" style="width:60px;height:12px  "></h5>
                        </div>
                        <div class="panel-body">
                            <h4 style="font-weight: bold">Card No <span class="glyphicon glyphicon-credit-card" area-hidden="true"></span></h4>
                            <input type="text" id="rcardno" name ="rcardno" placeholder="Enter Credit card No" class="form-control" style="padding:10px;font-family: monospace;font-size:16px;color: #330033  ">
                            <h4 style="font-weight: bold">Security Code <span class="glyphicon glyphicon-lock" area-hidden="true"></span></h4>
                            <input type="text" id="rcardscode" name="rcardscode" id="rcardscode" placeholder="Enter 3 digits behind your Card" class="form-control" style="padding:10px;font-family: monospace;font-size:16px;color: #330033  ">
                            <h4 style="font-weight: bold">Card Type </h4>
                            <div class="btn-group" data-toggle="buttons">
                                <label class="btn btn-default active">
                                    <input type="radio" name="rctype" id="option1" autocomplete="off" checked> 
                                    <img src="img/visa.png" style="width:40px;height:25px  ">
                                </label>
                                <label class="btn btn-default">
                                    <input type="radio" name="rctype" id="option2" autocomplete="off"> 
                                    <img src="img/MasterCard-Logo.png" style="width:40px;height:25px  ">
                                </label>

                            </div>

                        </div>
                    </div> 

                    <button class="btn btn-lg cofirmbtn btn-default" id="confbtn" type="button" onclick="checkFields(<%=request.getParameter("cartid")%>)" style="font-family: cursive;font-size: 32px;font-weight:bold;margin-left:100px;margin-top:50px  "><span class="glyphicon glyphicon-send" area-hidden="true"></span> Confirm Ordering</button>  
                </div>


            </div>
        </form>
        <div style="display:inline-block;width:100% ">
            <%@include file="MyNaviFoot.jspf"  %>

        </div><!-- footer-->  

        <%

                        } else {
                            response.sendRedirect("AccessPrevent.jsp");
                        }
                    } else {

                        response.sendRedirect("ViewProduct.jsp");
                    }

                } else {
                    response.sendRedirect("AccessPrevent.jsp");
                }
            } else {
                response.sendRedirect("Login_UserRegistration.jsp");
            }
        %>
    </body>
</html>
