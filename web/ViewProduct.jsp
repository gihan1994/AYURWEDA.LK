<%--  
    Document   : ViewProduct
    Created on : Sep 13, 2016, 6:18:41 PM
    Author     : Gihan
--%>

<%@page import="Resources.PrevilageCheck"%>
<%@page import="DB.ProductsHasBrands"%>
<%@page import="DB.Brands"%>
<%@page import="javassist.bytecode.LineNumberAttribute.Pc"%>
<%@page import="DB.PCatergory"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="DB.Supplier"%>
<%@page import="java.util.List"%>
<%@page import="DB.Products"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
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
 
        </style>
        <script>

            //view Item Process Starting ========================================== 



            var sortcatid;
            var sortbrandid;
            var sortpricefrom;
            var sortpriceto;
            var sortrate;
            var arrangeby;
            var svalue;//for searching
            var setpageno = 1; // 1 pass for when page is resently loaded  
            var sortitemlable;
            var viewcount;
            // Bellow variables have been defined for change color of paenation





            function selectCat() {

                if ($('#secat').find('option:selected').val() == 'All') {
                    sortcatid = null;

                } else {

                    sortcatid = $('#secat').find('option:selected').val();

                }
                setpageno = 1;
                setViewDataCondition();

            }
            function selectBrand() {
                if ($('#sebrand').find('option:selected').val() == 'All') {
                    sortbrandid = null;


                } else {

                    sortbrandid = $('#sebrand').find('option:selected').val();

                }
                setpageno = 1;
                setViewDataCondition();


            }
            function selectRate(type) {

                sortrate = type;
                setpageno = 1;
                setViewDataCondition();

            }
            function selectPrice() {

                if (checkRangeTypeVal()) {

                    sortpricefrom = document.getElementById("pfrom").value;
                    sortpriceto = document.getElementById("pto").value;



                    if (document.getElementById("pfrom").value != '') {
//                      style=\"box-shadow: 10px 10px 40px grey\"
                        $('#pfrom').css('border-color', '');
                    }
                    if (document.getElementById("pto").value != '') {
                        $('#pto').css('border-color', '');
                    }



                } else {
                    sortpricefrom = null;
                    sortpriceto = null;


                    if (document.getElementById("pfrom").value == '') {
//                      style=\"box-shadow: 10px 10px 40px grey\"
                        $('#pfrom').css('border-color', 'red');
                    } else {
                        $('#pfrom').css('border-color', '');

                    }
                    if (document.getElementById("pto").value == '') {
                        $('#pto').css('border-color', 'red');
                    } else {
                        $('#pto').css('border-color', '');

                    }

                }
                setpageno = 1;
                setViewDataCondition();
            }

            function searchProduct() {


                if (document.getElementById("searchval").value != '') {
                    $('#searchval').css('border-color', '');
                    $('#searchval').css('box-shadow', '');
                    svalue = document.getElementById('searchval').value;
                    setpageno = 1;
                    setViewDataCondition();
                } else {
                    $('#searchval').css('border-color', 'red');
                    $('#searchval').css('box-shadow', '1px 1px 8px red');

                }
            }

            function setArrange(type) {

                arrangeby = type;
                document.getElementById("arrangeby").innerHTML = type;
                setViewDataCondition();
            }

            function changePage(methodpageno, range) {
                if (methodpageno == 'nxt') {
                    if (setpageno != range) {
                        setpageno = setpageno + 1;
                    }
                }
                if (methodpageno == 'prvs') {
                    if (setpageno != range) {
                        setpageno = setpageno - 1;
                    }
                }
                if (range === 'max') {
                    setpageno = methodpageno;
                }
                setViewDataCondition();
            }

            function changeViewCount() {
                viewcount = $('#viewcounts').find('option:selected').val();
                setpageno = 1;//set the page no as a default
                setViewDataCondition();
            }

            function setViewDataCondition() {

                var url = "ViewProductManager?status=viewitems";
                if (sortcatid != null) {

                    url = url + "&sortcatid=" + sortcatid;
                    sortitemlable = sortitemlable + "/Category" + " ";
                }
                if (sortbrandid != null) {
                    url = url + "&sortbrandid=" + sortbrandid;
                    sortitemlable = sortitemlable + "/Brand" + " ";

                }
                if (sortrate != null) {
                    url = url + "&sortrate=" + sortrate;
                    sortitemlable = sortitemlable + "/Rate by" + sortrate + " ";
                }
                if (sortpricefrom != null && sortpriceto != null) {
                    url = url + "&sortpricefrom=" + sortpricefrom;
                    url = url + "&sortpriceto=" + sortpriceto;

                    sortitemlable = sortitemlable + "/Price Range " + sortpricefrom + " to " + sortpriceto + " ";
                }
                if (svalue != null) {
                    url = url + "&searchval=" + svalue;
                    sortitemlable = sortitemlable + "/Search for " + svalue + " ";
                }
                if (viewcount != null) {
                    url = url + "&viewcount=" + viewcount;
                }
                if (setpageno != null) {
                    url = url + "&pageno=" + setpageno;

                }
                if (arrangeby != null) {
                    url = url + "&arrange=" + arrangeby;

                }

                if (sortitemlable == '' || sortitemlable == null) {

                    sortitemlable = "/Default";
                }

                sendGetSetData(url);
                //clear all the colors
                $('#pfrom').css('border-color', '');
                $('#pto').css('border-color', '');
                $('#searchval').css('border-color', '');
                $('#searchval').css('box-shadow', '');

            }

            function sendGetSetData(url) {
                
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState === 4 && xhttp.status === 200) {

                        $("#viewItemsData").hide().html(xhttp.responseText).fadeIn('slow');
                        if (sortitemlable != null) {

                            document.getElementById("sortedlable").innerHTML = sortitemlable;

                        }
                        sortitemlable = '';


                    }
                };
                xhttp.open("GET", url, true);

                xhttp.send();


            }

            function checkRangeTypeVal() {
                if (document.getElementById("pfrom").value != '' &&
                        document.getElementById("pto").value != '') {

                    var lno = parseInt(document.getElementById("pfrom").value);
                    var hno = parseInt(document.getElementById("pto").value);

                    if (lno <= hno) {
                        document.getElementById("pto").style.backgroundColor = "";
                        document.getElementById("pfrom").style.backgroundColor = "";
                        return true;

                    } else {

                        document.getElementById("pto").style.backgroundColor = "red";
                        document.getElementById("pfrom").style.backgroundColor = "red";
                        return false;
                    }

                } else {
                    return false;

                }
            }
            //end view item process==========================================


            //Start Add to Cart process ===============================================
            function addToCart(pid,type) {

                var xhttpAddCart = new XMLHttpRequest();
                xhttpAddCart.onreadystatechange = function() {// 
//                     alert("state changing now is in state ->" + xhttp.readyState+" and status is ->"+xhttp.status);                    
                    if (xhttpAddCart.readyState === 4 && xhttpAddCart.status === 200) {

                      if(type=='add'){
                         updateAndMsg('Product Added success','addcart'); 
                      }
                       if(type=='buy'){
                           window.location.href='Cart_test.jsp';
                       } 

                    }
                };
                xhttpAddCart.open("GET", "CartManager?Button=addcartbtn&pid=" + pid, true);
//                xhttp.open("GET", "chatApp.jsp", true)
                xhttpAddCart.send();

            }
            
            

            function updateAndMsg(msg,method) {
                if(method=='addcart'){
                     sendCartItemRequest();
                }
               if(method=='addwishlist'){
                    sendNotiItemRequest();
               }
                
                $('#myModal').ready(function (){
                    document.getElementById('modalmsg').innerHTML=msg;
                  $("#myModal").modal();
                setTimeout(function() {
                    $("#myModal").modal("hide");
                }, 1000);  
                    
                });

                

            }

// End Add to cart Process =================================================

            function addWishList(pid) {
                var xhttpwish = new XMLHttpRequest();
                xhttpwish.onreadystatechange = function() {
                    if (xhttpwish.readyState === 4 && xhttpwish.status === 200) {
                        
                            updateAndMsg(xhttpwish.responseText,'addwishlist');

                    }
                };
                xhttpwish.open("GET", "WishListManager?AddData=ok&pid=" + pid, true);

                xhttpwish.send();


            }



            $(document).ready(function() {

               
               //loaded page contect after document is ready
                sendGetSetData("ViewProductManager?status=viewitems");
//                alert($("#pagecontent").height()+100);
                $("#footer").css('top', ($("#viewItemsData").height()+100) + "px");

                $('[data-toggle="tab"]').tooltip({
                    trigger: 'hover',
                    placement: 'bottom',
                    animate: true,
                    delay: 500,
                    container: 'body'
                });

                //clear search filed values
                $('#searchval').keyup(function() {

                    if ($(this).val() == '') {
                        svalue = null;
                        //clear all sorted


                        document.getElementById('pfrom').value = ""
                        document.getElementById('pto').value = ""
                        setViewDataCondition();
                    }

                });


            });
        </script>


    </head>
    <body style="height:1000px ">


        <div style="display:inline-block;width: 100%" >
            <%@include file="MyNavi.jspf"  %>
        </div> 

        <%
        if(request.getSession().getAttribute("username")!=null){
                PrevilageCheck precheck=new PrevilageCheck();
                
                    if(precheck.checkManager(request.getSession().getAttribute("username").toString(),
                        request.getRequestURL().toString(),"Click Product View Button")){}
         }

        %> 

        <div style="display:inline-block;width:100%;background-color:" id="pagecontent">
            <!--body-->
            <div style="display:inline-block;">

                <br>
                <br>

            </div>
            <div  style="display:inline-block;width:100%;">
                <div class="container">
                    <div class="col-md-2 panel panel-body panel-info" style="border-right:2px solid #cccccc;position:relative;" id="sortingpanel">
                        <h4>Select Filters</h4>
                        <div class="form-group">
                            <label for="exampleInputFile">Sort Category</label>
                            <select class="form-control" id="secat" name="pcat" onchange="selectCat()">
                                <option value="All" selected='selected'>All</option>
                                <%                                    List<PCatergory> pdtcat = NewHibernateUtil.getSessionFactory().openSession()
                                            .createCriteria(DB.PCatergory.class).list();
                                    for (PCatergory pct : pdtcat) {

                                        out.print(" <option value=" + pct.getIdPCatergory() + " >" + pct.getCatName() + "</option>");
                                    }

                                %> 
                            </select>

                        </div>
                        <div class="form-group" >
                            <label for="exampleInputFile">Sort Brand</label>
                            <select class="form-control" id="sebrand" name="pbrand" onchange="selectBrand()">
                                <option value="All" selected='selected'>All</option>
                                <%   Criteria c = NewHibernateUtil.getSessionFactory().openSession().createCriteria(DB.Brands.class);

                                    List<Brands> brand = c.list();
                                    for (Brands bb : brand) {

                                        out.print(" <option value=" + bb.getIdBrands() + " >" + bb.getBrandname() + "</option>");
                                    }

                                %>
                            </select>
                            <!--<a onclick="addWishList()"></a>-->
                        </div>  
                        <div class="form-group">
                            <label for="exampleInputFile">Sort Price</label>
                            <small class="label" style="background-color: transparent">Set Range</small> 
                            <form>
                                <table>
                                    <tr>
                                        <td><input type="text" class="form-control" name="puprice" placeholder="min" id="pfrom" onkeyup="checkRangeTypeVal();"></td>
                                        <td>&nbsp;</td> 
                                        <td><input type="text" class="form-control" name="puprice" placeholder="max" id="pto" onkeyup="checkRangeTypeVal();"></td>
                                        <td>&nbsp;</td> 
                                        <td><button class="btn btn-sm btn-info" type="button" onclick="selectPrice()" >Sort</button></td>
                                    </tr>
                                </table>
                            </form>
                            <br>
                            <br>
                            <button type="button" class="btn btn-default " onClick="selectRate('ASC')">Sort Low Rates</button>
                            <br>
                            <br>
                            <button type="button"  class="btn btn-default " onClick="selectRate('DESC')">Sort High Rates</button>
                        </div>

                    </div>
                    <div class="col-md-10" style=" " id="contentpanel" >
                        <div class="row panel  panel-body " id="detailpanel" >
                            <div class="col-md-5">
                                <h4>Product View Sorted By<small id="sortedlable">/Default</small></h4>
                            </div>        
                            <div class="col-md-3">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Search for..." id="searchval">
                                    <span class="input-group-btn " >
                                        <button class="btn btn-default hedder-search-btn"  type="button" onclick="searchProduct()" >
                                            <span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
                                    </span>
                                </div>
                            </div>        
                            <div class="col-md-4">
                                <div style="display:inline-block">
                                    <h6 class="h6" style="font-weight: bold">View</h6>
                                    <select class="form-control" id="viewcounts" onchange="changeViewCount()">
                                        <option value="3">3</option>
                                        <option value="6">6</option>
                                        <option value="9">9</option>
                                        <option value="12">12</option>
                                        <option value="15">15</option>
                                    </select>
                                </div>
                                <div style="display:inline-block;">
                                    <div class="col-md-2"></div>
                                    <div class="col-md-5">
                                        <h6>Arrange by &nbsp;<span id="arrangeby" style="font-weight: bold;font-family: cursive">Grid</span></h6> 
                                    </div>
                                    <div class="col-md-5">
                                        <a href="#" class="img-thumbnail"  data-toggle="tab" data-original-title="List View" >
                                            <span class="glyphicon glyphicon-th-list"  onclick="setArrange('List')"></span></a>

                                        <a href="#" class="img-thumbnail"  data-toggle="tab" data-original-title="Grid View" >
                                            <span class="glyphicon glyphicon-th" onclick="setArrange('Grid')"></span></a>
                                    </div>

                                </div>

                            </div>  
                        </div>
                        <div style="display:inline-block;width: 100% " >


                            <div class="col-md-12" id="viewItemsData" style="overflow: auto; width: fit-content ">
                                <!--view products items area  -->
                            </div>



                            <br>
                            <br>

                            <!--<div class="col-md-1"></div>--> 

                        </div>
                    </div>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br> 
                </div>

                <!-- Modal -->
                <div class="modal fade" id="myModal" role="dialog">
                    <div class="modal-dialog  modal-open">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">

                                <h4 class="modal-title" style="font-size:28px;margin-left:200px;font-weight:bold;font-family: inherit">Message <span  class="glyphicon glyphicon-envelope" aria-hidden="true"></span></h4>

                            </div>
                            <div class="modal-body">
                                <span style="color: #009900" class="glyphicon glyphicon-ok" aria-hidden="true"></span><p style="color: #009900" id="modalmsg"></p>
                            </div>
                            <div class="modal-footer">

                            </div>
                        </div>

                    </div>
                </div>

            </div>




        </div>




                            <div style="display:inline-block;width:100%;position:relative" id="footer">
            <%@include file="MyNaviFoot.jspf"  %>

        </div><!-- footer-->



    </body>
</html>
