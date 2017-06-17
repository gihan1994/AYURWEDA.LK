<%@page import="DB.Notifications"%>
<%@page import="javax.management.Notification"%>
<%@page import="DB.Invoice"%>
<%@page import="Resources.PrevilageCheck"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : UserView
    Created on : Nov 2, 2016, 2:45:09 AM
    Author     : Gihan
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayurweda.lk</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/MyCs.css" rel="stylesheet" type="text/css">
        <script src="js/jquery-3.1.0.min.js"></script>
        <script src="js/bootstrap.min.js"></script>

        <style>
            .useli:hover{
                background:#000000;color:#ffffff;
                box-shadow: 2px 2px 50px grey;
                cursor:pointer; 

            }
            .useli{
                background: #00ad34;
                border-color: #006600;

            }
            .useli:active{
                background:#000000;color:#ffffff;
                box-shadow: 2px 2px 50px grey;

            }
            .uselih3{
                font-weight:bold;font-size:22px;
                font-family:cursive;

            }
            .uselispan{
                position:absolute ;
                background: #ff0000;
                color:#000000;
                font-size:20px;   

            }


        </style>

        <script>



            //view Models
            function viewInprocessOrder(oid) {
                var url = "OrderManagement?GetData=inprocess&Oid=" + oid;
                SendModelData(url);
            }
            function viewDispatchOrder(oid) {
                var url = "OrderManagement?GetData=Dispatch&Oid=" + oid;
                SendModelData(url);
            }
            function ConfirmOrder(doid) {
                var url = "OrderManagement?conorder=ok&dOid=" + doid;
                SendModelData(url);
            }
            function viewMessage(msgid) {

                var url = "UserViewManager?Getdata=messageData&msgid=" + msgid;
                SendModelData(url);
            }

            function OpenLoad() {
                var xhttpPupdate = new XMLHttpRequest();

                xhttpPupdate.onreadystatechange =
                        function() {
                            if (xhttpPupdate.readyState === 4 && xhttpPupdate.status === 200) {

                                var j = JSON.parse(xhttpPupdate.responseText);

                                if (j.nwish != "0") {
                                    $("#wcount").css("display", "");
                                    document.getElementById("wcount").innerHTML = j.nwish;
                                } else {
                                    $("#wcount").css("display", "none");
                                }
                                if (j.norders != "0") {
                                    $("#ocount").css("display", "");
                                    document.getElementById("ocount").innerHTML = j.norders;
                                } else {
                                    $("#ocount").css("display", "none");
                                }
                                if (j.ninvoice != "0") {
                                    $("#icount").css("display", "");
                                    document.getElementById("icount").innerHTML = j.ninvoice;
                                } else {
                                    $("#icount").css("display", "none");

                                }
                                if (j.nmsg != "0") {
                                    $("#mcount").css("display", "");
                                    document.getElementById("mcount").innerHTML = j.nmsg;
                                } else {

                                    $("#mcount").css("display", "none");
                                }




                            }


                        };

                xhttpPupdate.open("GET", "UserViewManager?GetUpdate=ok", true);
                xhttpPupdate.send();

            }
            function loadProfile() {
                $("#sortsofproducts").css("display", "none");
                var url = "UserViewManager?Getdata=ProfData";
                SendUserLoadData(url);

            }
            function loadWishList() {
                $("#sortsofproducts").css("display", "none");
                var url = "UserViewManager?Getdata=WishData";
                SendUserLoadData(url);

            }
            function loadOrderData() {
                $("#sortsofproducts").css("display", "none");
                var url = "UserViewManager?Getdata=OrderData";
                SendUserLoadData(url);
            }
            function loadPurchesData() {
                var url = "UserViewManager?Getdata=PurcheseData";
                SendUserLoadData(url);
                $("#sortsofproducts").css("display", "");
            }
            function loadinvoiceData() {
                var url = "UserViewManager?Getdata=invoiceData";
                SendUserLoadData(url);
                $("#sortsofproducts").css("display", "none");
            }
            function loadMessageData() {
                var url = "UserViewManager?Getdata=messageData";
                SendUserLoadData(url);
                $("#sortsofproducts").css("display", "none");
            }
            //condition load
            //purches
            function loadPurchesByInvoiceId(val) {
                var url = "UserViewManager?Getdata=PurcheseData&invoid=" + val;
                SendUserLoadData(url);
                $("#sortsofproducts").css("display", "");

            }
            function loadPurchesByDate(val) {
                var url = "UserViewManager?Getdata=PurcheseData&date=" + val;
                SendUserLoadData(url);
                $("#sortsofproducts").css("display", "");

            }

            function test() {

            }
            function loadAddRateProduct(pid, type) {
                var url = "";
                if (type == 'addrate') {
                    var rate = document.getElementById(pid).value;
                    if (rate == "") {
                        var id = "#" + pid;
                        $(id).css("border-color", "#ff0000");
                    } else {
                        url = "UserViewManager?Getdata=PurcheseData&ratepid=" + pid + "&rate=" + rate;
                    }

                }
                if (type == 'addagain') {

                    url = "UserViewManager?Getdata=PurcheseData&ratepid=" + pid + "&addagain=ok";
                }

                SendUserLoadData(url);
                $("#sortsofproducts").css("display", "");

            }

            function BuyAgain(pid) {

                var xhttpAddCart = new XMLHttpRequest();
                xhttpAddCart.onreadystatechange = function() {// 
//                     alert("state changing now is in state ->" + xhttp.readyState+" and status is ->"+xhttp.status);                    
                    if (xhttpAddCart.readyState === 4 && xhttpAddCart.status === 200) {
                        window.location.href = 'Cart_test.jsp';

                    }
                };
                xhttpAddCart.open("GET", "CartManager?Button=addcartbtn&pid=" + pid, true);
//                xhttp.open("GET", "chatApp.jsp", true)
                xhttpAddCart.send();

            }


            //=============
            //send all processed Url
            function SendUserLoadData(url) {
                var xhttp = new XMLHttpRequest();

                xhttp.onreadystatechange =
                        function() {
                            if (xhttp.readyState === 4 && xhttp.status === 200) {
                                if (xhttp.responseText == "out") {

                                    window.location.href = 'Home.jsp';
                                }
                                else {
                                    $("#setDetails").hide().html(xhttp.responseText).fadeIn('slow');
                                    OpenLoad();
                                    sendNotiItemRequest();
                                }

                            }
                        };

                xhttp.open("GET", url, true);
                xhttp.send();

            }
            function SendModelData(url) {
                var xhttpm = new XMLHttpRequest();

                xhttpm.onreadystatechange =
                        function() {
                            if (xhttpm.readyState === 4 && xhttpm.status === 200) {

                                var output = xhttpm.responseText;
                                if (output == "out") {
                                    window.location.href = 'Home.jsp';
                                }
                                else {
                                    if (output == "1") {
                                        $("#thankModel").modal();
                                        setTimeout(function() {
                                            $("#thankModel").modal("hide");
                                        }, 3000);

                                    } else {
                                        document.getElementById("umodcontect").innerHTML = xhttpm.responseText;

                                        $("#userModel").modal();


                                    }
                                }



                            }
                        };

                xhttpm.open("GET", url, true);
                xhttpm.send();

            }


            function ProfileEdit(type) {

                if (type === 'edit') {
                    $("#uname").removeAttr("readonly");
                    $("#fname").removeAttr("readonly");
                    $("#lname").removeAttr("readonly");
                    $("#pw").removeAttr("readonly");
                    $("#utel").removeAttr("readonly");
                    $("#uemail").removeAttr("readonly");
                    $("#ust1").removeAttr("readonly");
                    $("#ust2").removeAttr("readonly");
                    $("#ucity").removeAttr("readonly");
                    $("#upcode").removeAttr("readonly");

                    $("#profpicbtn").css("display", "");
                    $("#cpw").css("display", "");
                    $("#cpwl").css("display", "");
                    $("#profsavebtn").css("display", "");
                    $("#editbtn").css("display", "none");
                }
                if (type === 'save') {
                    $("#uname").attr("readonly", "readonly");
                    $("#fname").attr("readonly", "readonly");
                    $("#lname").attr("readonly", "readonly");
                    $("#pw").attr("readonly", "readonly");
                    $("#utel").attr("readonly", "readonly");
                    $("#uemail").attr("readonly", "readonly");
                    $("#ust1").attr("readonly", "readonly");
                    $("#ust2").attr("readonly", "readonly");
                    $("#ucity").attr("readonly", "readonly");
                    $("#upcode").attr("readonly", "readonly");

                    $("#profpicbtn").css("display", "none");
                    $("#cpw").css("display", "none");
                    $("#cpwl").css("display", "none");
                    $("#profsavebtn").css("display", "none");
                    $("#editbtn").css("display", "");

                }

            }
            function profileSave() {

                var myform = document.getElementById("profDataform");


                var fd = new FormData(myform);
                $.ajax({
                    url: "UserViewProfile",
                    data: fd,
                    cache: false,
                    processData: false,
                    contentType: false,
                    type: 'POST',
                    success: function(dataofconfirm) {

                        location.reload();

                    }
                });
                ProfileEdit('save');
            }

//            comments and Review dispatched orders
            function dispatchedCommentsReviews(disid, type, repid) {
                alert('hi');
                var url = "";
                if (type == "review") {
                    var comment = document.getElementById("rp" + disid + repid).value;
                       url="OrderManagement?typecom=proReview&comment="+comment+"&disid="+disid+"&revpid="+repid;
                       document.getElementById("rp" + disid + repid).innerHTML="";
                }
                if (type == "ocomment") {
                    var comment = document.getElementById("com" + disid).value;
                   url="OrderManagement?typecom=ordercom&comment="+comment+"&disid="+disid;
                   document.getElementById("com" + disid).innerHTML="";
                }
                SendModelData(url);
                
            }


            $(document).ready(function() {


                $("#profpicbtn").click(function() {
                    $("#profpicbtn").change(function() {
                        $("#userviewpic").fadeIn("fast").attr('src', URL.createObjectURL(event.target.files[0]));
                    });
                });

                //for get change invoice idies
                $("#inidies").change(function()
                {
                    loadPurchesByInvoiceId($(this).val());
                });

                //get calander value
                $('#invodate').change(function() {
//        alert(this.value);        
                    loadPurchesByDate(this.value);
                });


            });

        </script>

    </head>
    <body onload="loadProfile()">

        <%                if (request.getSession().getAttribute("username") != null) {
                PrevilageCheck precheck = new PrevilageCheck();

                if (precheck.checkManager(request.getSession().getAttribute("username").toString(),
                        request.getRequestURL().toString(), "Click View User Button")) {

                    Session s = NewHibernateUtil.getSessionFactory().openSession();
                    Login l = (Login) s.createCriteria(DB.Login.class)
                            .add(Restrictions.eq("username", request.getSession().getAttribute("username"))).uniqueResult();

                    if (l != null) {
                        List<Notifications> upnl = s.createCriteria(DB.Notifications.class).add(Restrictions.eq("user", l.getUser())).list();
                        for (Notifications ni : upnl) {
                            ni.setStatus("0");
                            s.update(ni);
                            s.flush();
                            s.beginTransaction().commit();
                        }

                    }

        %> 

        <div style="display:inline-block;width:100%">
            <%@include file="MyNavi.jspf"  %>
        </div>

        <div style="display:inline;" class="container">
            <div class="panel panel-body">
                <div class="col-md-2">
                    <ul class="list-group text-center" style="width:100%;height:100%;box-shadow: 2px 2px 5px grey;    ">
                        <li class="list-group-item useli"  onclick="loadProfile()"><h3 class="uselih3">
                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                Profile<span class="badge uselispan"></span></h3></li>
                        <li class="list-group-item useli" onclick="loadWishList()"><h3 class="uselih3">
                                <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>
                                Wishlist<span class="badge uselispan" id="wcount" style="display:none" >1</span></h3></li>
                        <li class="list-group-item useli" onclick="loadOrderData()"><h3 class="uselih3">
                                <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>
                                Orders<span class="badge uselispan" id="ocount" style="display:none" >1</span></h3></li>
                        <li class="list-group-item useli" onclick="loadPurchesData()"><h3 class="uselih3">
                                <span class="glyphicon glyphicon-paste" aria-hidden="true"></span>
                                Purchases</h3></li>
                        <li class="list-group-item useli" onclick="loadinvoiceData()"><h3 class="uselih3">
                                <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>
                                Invoices<span class="badge uselispan" style="display:none" id="icount" >12</span></h3></li>
                        <li class="list-group-item useli" onclick="loadMessageData()"><h3 class="uselih3">
                                <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                                Messages<span class="badge uselispan" style="display:none " id="mcount" >1</span></h3></li>
                    </ul>

                </div>
                <div class="col-md-10" >
                    <!--code here-->
                    <div style="display:none " id="sortsofproducts">
                        <div style="display:inline">
                            <div class="col-md-5">
                                <div style="display:inline">
                                    <div class="col-md-6">
                                        <h4>Sort by Invoice id</h4>
                                    </div>
                                    <div class="col-md-6" >
                                        <select class="form-control" id="inidies">
                                            <option value="all">All</option>
                                            <%                                               if (l != null) {
                                                    List<Invoice> inv = s.createCriteria(DB.Invoice.class)
                                                            .add(Restrictions.eq("user", l.getUser())).list();

                                                    for (Invoice ii : inv) {


                                            %>
                                            <option value="<%=ii.getIdInvoice()%>">
                                                <%=ii.getIdInvoice()%>
                                            </option>

                                            <%}
                                            }%>
                                        </select>


                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"></div>
                            <div class="col-md-5">
                                <div style="display:inline">
                                    <div class="col-md-6">
                                        <h4>Sort by Invoice id</h4>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="date" class="form-control" id="invodate">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                        <br>
                        <br>
                    </div>
                    <div id="setDetails" style="overflow:auto;height:500px;overflow-style:panner;   ">


                    </div>  





                </div>
            </div>     

        </div>

        <!--Normal model content-->
        <div class="modal fade" id="userModel" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content text-center" id="umodcontect">

                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div>

        <!--confirmation modal-->
        <div class="modal fade" id="thankModel" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content text-center">
                    <div class="modal-header">
                        <h4 class="modal-title">Message</h4>
                    </div>
                    <div class="modal-body">
                        <div style="display: inline">
                            <img src="img/Like.png" style="width: 100px;height: 100px">
                            <h3 style="font-weight:bold;font-family: cursive;font-style:oblique;color: #660066  ">
                                Thank For Your Kindly Attention & Cooperation

                            </h3>
                        </div>

                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal --> 


        <div style="display:inline-block;width:100%">
            <%@include file="MyNaviFoot.jspf"  %>

        </div>
        <%

                } else {//no permission

                    response.sendRedirect("Home.jsp");
                }

            } else {//user is not sign no permision

                response.sendRedirect("Home.jsp");

            }

        %>
    </body>
</html>
