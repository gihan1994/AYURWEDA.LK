<%--
    Document   : AddProductCategory
    Created on : Sep 13, 2016, 10:41:46 PM
    Author     : Gihan
--%>

<%@page import="DB.Brands"%>
<%@page import="DB.Shipping"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="java.util.List"%>
<%@page import="DB.PCatergory"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>JSP Page</title>



        <script>
            var addcatname;
            var catstatus;
            var vehitype;
            var shipcost;
            var type='addcat';
            var brandname;
            var country;

            sendData("ProductManage?status=onCatdata");
            type='addbrand';
            
            sendData2("ProductManage?bstatus=onBradata");


            function catstatusChange(id) {
                var url = 'ProductManage?status=onCatdata&change=ok&catid=' + id;
                
                sendData(url);

            }

            function GetBrandData(){
                brandname=document.getElementById('bname').value;
                country=document.getElementById('bcountry').value;
                
                if(document.getElementById('bname').value!=''&&document.getElementById('bcountry').value!='')
                {
                   
                   type='adbrand';
                   sendData2("ProductManage?bstatus=onBradata&bname="+brandname+"&bcountry="+country);
                }else{
                       alert("Some fields are empty");
                    if (document.getElementById("bname").value == '') {
//                      style=\"box-shadow: 10px 10px 40px grey\"
                        $('#bname').css('border-color', 'red');
                    }
                    if (document.getElementById("bcountry").value == '') {
                        $('#bcountry').css('border-color', 'red');
                    }
                    
                    
                }
                
                
            }

            function GetPcatData() {

                addcatname = document.getElementById("catname").value;
                shipcost = document.getElementById("scost").value;

                catstatus = $('input[name=status]:checked').val();
                vehitype = $('#smethod').find('option:selected').val();

                var antype = document.getElementById("newsmethodname").value;

                if (antype != '') {

                    vehitype = document.getElementById("newsmethodname").value;
                }

                if (document.getElementById("catname").value != '' && document.getElementById("scost").value != '') {
                    var url = 'ProductManage?status=onCatdata&adname=' + addcatname + "&catstatus=" + catstatus + "&vehitype=" + vehitype + "&scost=" + shipcost;
                    type = 'addcat';
                    sendData(url);

                } else {
                    alert("Some fields are empty");
                    if (document.getElementById("catname").value == '') {
//                      style=\"box-shadow: 10px 10px 40px grey\"
                        $('#catname').css('border-color', 'red');
                    }
                    if (document.getElementById("scost").value == '') {
                        $('#scost').css('border-color', 'red');
                    }

                }


            }


            function sendData(url) {

                var xhttp2 = new XMLHttpRequest();
                xhttp2.onreadystatechange = function() {// 

                    if (xhttp2.readyState === 4 && xhttp2.status === 200) {
  
                         document.getElementById("availablecat").innerHTML = xhttp2.responseText;   
                       
                    }
                };
                xhttp2.open("GET", url, true);

                xhttp2.send();
            }
            
            //for brand
               function sendData2(url) {

                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {// 

                    if (xhttp.readyState === 4 && xhttp.status === 200) {

                     
                            
                          document.getElementById("brandsitems").innerHTML = xhttp.responseText;  
                          document.getElementById("bname").value='';  
                          document.getElementById("bcountry").value='';  
                          
                       
                    }
                };
                xhttp.open("GET", url, true);

                xhttp.send();
            }

            function reset() {
                $('#scost').css('border-color', '');

                $('#catname').css('border-color', '');
                $('#bname').css('border-color', '');
                $('#bcountry').css('border-color', '');

                $("#addcat")[0].reset();
                $("#brands")[1].reset();
            }

            $(document).ready(function() {

                $('#smethod').change(function() {

                    document.getElementById("newsmethodname").value = '';
                });

            });

        </script>



    </head>
    <%
        Session apcs = NewHibernateUtil.getSessionFactory().openSession();
    %>
    <div class="row">
        <div class="col-md-5 " style="" >
            <!--add new category--> 
            <div class="col-md-12" >
                <div class="row"><h4><strong>Add New Product Category</strong></h4></div>
                <div class="row">
                    <h6> Currently Available Categories</h6>

                    <div class="col-md-12" id="availablecat" style="max-height:400px;overflow:auto;  ">


                    </div>

                </div> 
                <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-10">
                        <form action="ProductManage"  method="post"  id="addcat">

                            <div class="form-group">
                                <h6>Category Details<br><small>Category Name</small></h6>
                                <input type="text" class="form-control" id="catname" >
                            </div>
                            <div class="radio">
                                <h6><small>Category Status</small></h6>&nbsp;
                                <label class="radio-inline">
                                    <input type="radio" name="status" value="1"> Active
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="status" value="0"> De-active
                                </label>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-12">
                                        <h6>Shipping Details<br><small>Vehicle Type</small></h6> 

                                        <table>
                                            <tr>
                                                <td>
                                                    <select class="form-control"  id="smethod">

                                                        <%
                                                            List<Shipping> pll = apcs.createCriteria(DB.Shipping.class).list();
                                                            for (Shipping shp : pll) {

                                                                out.print(" <option value=" + shp.getIdShipping() + " selected='selected'>" + shp.getMthodName() + "</option>");
                                                            }

                                                        %> 
                                                    </select>   
                                                </td>
                                                <td>&nbsp;</td>
                                                <td>
                                                    <input type="text" class="form-control" id="newsmethodname" placeholder="New Method"  >    
                                                </td>
                                            </tr>
                                        </table>


                                    </div>

                                </div>
                            </div>
                            <div class="form-group">
                                <h6><small>Shipping Cost</small></h6>
                                <input type="text" class="form-control" id="scost">
                            </div>

                            <input type="hidden" value="addProductcat" name="formCondition">
                            <button type="button" class="btn btn-success" onclick="GetPcatData()">Add Category</button>
                            <br>
                            <br>
                            <br>
                            <br>
                        </form> 

                    </div>
                    <div class="col-md-1"></div>



                </div> 



            </div>
            <div class="col-md-1"></div>


        </div>   

        <div class="col-md-2">


        </div>                                
        <div class="col-md-5">
            <!--add new brand-->
            <div class="row">
                <h4><strong>Add New Brand</strong></h4>
            </div>
            <div class="row">
                <!--<div class="col-md-1"></div>-->
                <div class="col-md-12">
                    <form action="ProductManage" method="post"  id="brands" >

                        <div class="form-group">
                            <label class="control-label">Available Brand</label>
                            <div class="list-group" style="max-height:200px;overflow:auto;" id="brandsitems">


                            </div>
                        </div>
                        <div class="form-group">
                            <h6>New Brand Name</h6>
                            <input type="text" class="form-control"  id="bname" >
                        </div>
                        <div class="form-group">
                            <h6>Brand Country</h6>
                            <input type="text" class="form-control"  id="bcountry" >

                        </div>
                        <div class="form-group">
                            <input type="hidden" value="addbrand" name="formCondition">   
                            <input type="button" class="btn btn-info"  value="Add Brand" onclick="GetBrandData()">
                        </div>        


                    </form>

                </div>
                <!--<div class="col-md-1"></div>-->

            </div>

            <div class="row">

                <div type="hidden" class="alert alert-success" style="display:none " id="msg">
                    <strong>Success!</strong>Your Adding Successful 
                </div>
            </div>                 

        </div>


    </div>




</html>
