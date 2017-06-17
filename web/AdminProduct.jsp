<%-- 
    Document   : AdminProduct
    Created on : Oct 10, 2016, 1:10:46 PM
    Author     : Gihan
--%>

<%@page import="DB.Products"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page import="DB.PCatergory"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.List"%>
<%@page import="DB.Brands"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

 <script>

    //product drop bar events
   function getCustomProductData(){
        var xhttp2 = new XMLHttpRequest();
                xhttp2.onreadystatechange = function() {// 
                    
                    if (xhttp2.readyState === 4 && xhttp2.status === 200) {

                      //  document.getElementById("cuspdata").innerHTML=xhttp2.responseText;
                        
                        $('#cuspdata').load(xhttp2.responseText);
                        
                    }
                };
                xhttp2.open("GET","ProductManage?type=GetPdata", true);

                xhttp2.send();  
        
       
       
   } 
    
//   function openManualCollapse(name){
//       alert(name);
//       $(name).collapse();
//   } 
    
    
    
//    $(document).ready(function(){
//    
//  $('#collapseTwo').on('show.bs.collapse', function() {
//  
//  getCustomProductData();
//  
//  
//});
//  
//    });

</script>   
   
       <br>
       <div class="container" style="margin-top:50px;margin-bottom: 50px " >

    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
        <div class="panel panel-default ">
            <div class="panel-heading" role="tab" id="headingOne"  style="background-color:#F5F6F7;text-decoration:none  ">
                <h4 class="panel-title">
                    <a id="addp" class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                        <span class="glyphicon glyphicon-baby-formula" aria-hidden="true"></span> Add New Product
                    </a>
                </h4>
            </div>
            <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                <div class="panel-body">
                    <!--add product area-->
                    <%@include file="AddProduct.jsp"  %>
                </div>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading " role="tab" id="headingThree"  style="background-color:#F5F6F7;text-decoration:none  ">
                <h4 class="panel-title">
                    <a class="collapsed" role="button"  data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                        <span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>  Add New Categories/Brands
                    </a>
                </h4>
            </div>
            <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                <div class="panel-body">
                    <!--add new category-->
                   <%@include file="AddProductCategory.jsp"  %>


                </div>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading" role="tab" id="headingTwo"  style="background-color:#F5F6F7;text-decoration:none  ">
                <h4 class="panel-title">
                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                        <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> Product Details
                    </a>
                </h4>
            </div>
            <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                <div class="panel-body" id="cuspdata">
                    <!--product Details-->
                    <%@include file="Customize_Products.jsp"  %>
                </div>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading " role="tab" id="headingOne"  style="background-color:#F5F6F7;text-decoration:none  ">
                <h4 class="panel-title">
                    <a class="collapsed" role="button"  data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                        <span class="glyphicon glyphicon-sort" aria-hidden="true"></span>  Product Stock Update
                    </a>
                </h4>
            </div>
            <div id="collapseThree" class="panel-collapse collapse" role="tabpanel"  aria-labelledby="headingThree">
                <div class="panel-body">
                    <!--stock update-->

                  <%@include file="ProductStockUpdate.jsp"  %> 

                </div>
            </div>
        </div>
           <div class="panel panel-default">
            <div class="panel-heading " role="tab" id="headingfive"  style="background-color:#F5F6F7;text-decoration:none  ">
                <h4 class="panel-title">
                    <a class="collapsed" role="button"  data-toggle="collapse" data-parent="#accordion" href="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                        <span class="glyphicon glyphicon-sort" aria-hidden="true"></span>Offering Products
                    </a>
                </h4>
            </div>
            <div id="collapseFive" class="panel-collapse collapse" role="tabpanel"  aria-labelledby="headingfive">
                <div class="panel-body">
                    <!--stock update-->

                    <%@include file="ProductOffer.jsp"  %> 

                </div>
            </div>
        </div>        
    </div>

</div>  
        

