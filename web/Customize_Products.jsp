<%-- 
    Document   : Customize_Products
    Created on : Oct 6, 2016, 8:38:56 AM
    Author     : Gihan
--%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.List"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="DB.Products"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

 
    <script>
      
    
     
  function  productStatusChange(status,pid){
     
        var url="ProductManage?contype=GetAll&changestatus="+status+"&pid="+pid;
       productGetter(url);
      
  }
   
    
   function getAll(){
//       
       var url="ProductManage?contype=GetAll";
       productGetter(url);
       
   }
   function getActive(){
      
       var url="ProductManage?contype=GetAll&sertype=1";
       productGetter(url);
        
   }
   function getDeactive(){
     
        var url="ProductManage?contype=GetAll&sertype=0";
       productGetter(url);
       
   }
    function searchData(){
        var serchval=document.getElementById('serchval').value;
        var url="ProductManage?contype=GetAll&searchval="+serchval;
       productGetter(url);
       
   }
      
       function productGetter(url){
          var xhttp2 = new XMLHttpRequest();
                xhttp2.onreadystatechange = function() {// 
                    
                    if (xhttp2.readyState === 4 && xhttp2.status === 200) {

                     $('#allproducts').hide().html(xhttp2.responseText).fadeIn('slow');
                       
                    }
                };
                xhttp2.open("GET",url, true);

                xhttp2.send();  
        
    }   

    function productReviewModel(revpid){
          var xhttp2 = new XMLHttpRequest();
                xhttp2.onreadystatechange = function() {// 
                    
                    if (xhttp2.readyState === 4 && xhttp2.status === 200) {
                        document.getElementById("reviewModalcontent").innerHTML=xhttp2.responseText;
                     $('#reviewModal').modal();
                       
                    }
                };
                xhttp2.open("GET","ProductManage?reviewmodel=ok&revpid="+revpid, true);

                xhttp2.send();  
       
    }

    $(document).ready(function (){
        $('#allproducts').ready(function (){
            
            getAll();
        });
        
    });


     
        
        
    </script>
 
   
        
        <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-3">
            
            <h4 class="h4"><strong>Customize Products</strong></h4> 
            
        </div>
        <div class="col-md-3">
            <div class="input-group">
                <input type="text" class="form-control" id="serchval" placeholder="Search products">
      <span class="input-group-btn">
          <button class="btn btn-default" type="button" onclick="searchData()">Search</button>
      </span>
    </div> 
            
        </div>
          <div class="col-md-3"></div>
    </div>
    <div class="row">
        <br>
        <br>
        <div class="col-md-3"></div>
        <div class="col-md-6 btn-group-sm" >
            <button class="btn btn-success " type="button" onclick="getActive()"> Active Products</button>
            <button class="btn btn-default  admin-product-viewbtn" type="button" onclick="getAll()"> View All</button>
            <button class="btn btn-danger" type="button" onclick="getDeactive()"> De-active Products</button>
        </div>
        <div class="col-md-3"></div>
        
    </div>
    <div class="row" id="productDetails">
        <div class="col-md-12" data-spy="scroll" data-target="#myScrollspy" data-offset="20" id="pview">
         
            <section class="panel panel-default">
   
    <div class="panel-body " style="max-height: 332px;overflow:auto; " id="allproducts" >
     
        <!--product details-->
    </div>
    
</section>
   
            
        </div>
        
    </div>
 
 <!-- Modal -->
                <div class="modal fade" id="reviewModal" role="dialog">
                    <div class="modal-dialog  modal-open">

                        <!-- Modal content-->
                        <div class="modal-content" id="reviewModalcontent" >
                       <!--product review in here-->
                        </div>

                    </div>
                </div>