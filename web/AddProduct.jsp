<%-- 
    Document   : AddProduct
    Created on : Sep 13, 2016, 6:14:05 PM
    Author     : Gihan
--%>


      


<%@page import="DB.Brands"%>
<%@page import="DB.PCatergory"%>
<%@page import="java.util.List"%>
<%@page import="DB.Products"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>


<script>
    
    
    
    
    
    function sendAddProductData(){
//          alert("awa");
         var pid=parseInt(document.getElementById('autopid').value);
         var myform = document.getElementById("myform");
        
      
    var fd= new FormData(myform);
    $.ajax({
        url: "AddProduct",
        data: fd,
        cache: false,
        processData: false,
        contentType:false,
        type: 'POST',
        success: function (dataofconfirm) {
//            alert("giya");
          $("form")[0].reset();  
          
         $("#autopid").attr('value',pid+1);
          
          $('#msg').css('display','inline-block');
          
          setTimeout(function (){
              
              $("#msg").animate({
        opacity: '0.0'
    }); 
    
          },2000);
            
        }
    }); 
        
        
//        //set new id
//        alert(parseInt(pid)===19);
//        var newpid=parseInt(pid)+1+"";
//        alert(newpid);
//          document.getElementById('pname').innerHTML=newpid;
    }
     
     
    $(document).ready(function (){
        
        $("#img1").change(function () {
        var tmppath = URL.createObjectURL(event.target.files[0]);
        $("#im1").fadeIn("fast").attr('src', URL.createObjectURL(event.target.files[0]));
    });
    }); 
     
    
    
</script>





<%
 
    Session aps = NewHibernateUtil.getSessionFactory().openSession();
            Criteria apc = aps.createCriteria(DB.Products.class);
            int i = apc.list().size();
            apc.addOrder(Order.asc("idProducts"));
            apc.setFirstResult(i - 1);

            Products app = (Products) apc.uniqueResult();
             int nxtId=0;
            if(app!=null){
             nxtId=app.getIdProducts() + 1;
            }
            
           

            apc = aps.createCriteria(DB.PCatergory.class);

            List<PCatergory> pdtcat = apc.list();


        %>



        <div class="row"  >

            <div class="col-md-4">
                <div class="row">
                    <div class="col-md-2"></div>
                    <div class="col-md-10">
                        <h2>Add New Products</h2>
                    </div>

                </div>
            </div>

            <div class="col-md-4">
                <div class="row">

                    <div class="row"><br><br></div>
                    <div class="row">
                        <form action="AddProduct"  method="post"  enctype="multipart/form-data" id="myform">
                            <div class="form-group">
                                <label >Product ID</label>
                                <input type="text" class="form-control" style="font-weight: bold;color:#ff3300 " name="pid" value="<%  out.print(nxtId); %>"  id="autopid" readonly="readonly">
                            </div>
                            <div class="form-group">
                                <label >Product Name</label>
                                <input type="text" class="form-control" name="pname" id="pname">
                            </div>
                            <div class="form-group">
                                <label >Product Description</label>
                                <textarea class="form-control" rows="3" name="pdescrip"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputFile">Product Image</label>
                                <div class="form-inline">
                                    <input type="file"  name="pimg" id="img1">
                                    <img src="img/noimg.png" style="width: 100px;height:100px " alt="No Image" id="im1">
                                </div>
                                
                                <p class="help-block">Select more than one Images</p>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputFile">Product Category</label>
                                <select class="form-control" id="sel1" name="pcat">
                                    <%
                                        for (PCatergory pct : pdtcat) {

                                            out.print(" <option value=" + pct.getIdPCatergory() + " selected='selected'>" + pct.getCatName() + "</option>");
                                        }

                                    %> 
                                </select>
                               
                            </div>
                            <div class="form-group">
                                <label for="exampleInputFile">Product Brand</label>
                                <select class="form-control" id="sel1" name="pbrand">
                                    <%    apc = aps.createCriteria(DB.Brands.class);

                                        List<Brands> brand = apc.list();
                                        for (Brands bb : brand) {

                                            out.print(" <option value=" + bb.getIdBrands() + " selected='selected'>" + bb.getBrandname() + "</option>");
                                        }

                                    %>
                                </select>
                               
                            </div>
                            


                            <div class="radio">
                                <label class="radio-inline">
                                    <input type="radio" name="pstatus"> Active
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="pstatus"> De-active
                                </label>
                            </div>
                            <input type="hidden" value="addProduct" name="formCondition">
                            <input type="button" value="Add Product" class="btn btn-success" onclick="sendAddProductData()">
                           
                            <div type="hidden" class="alert alert-success" style="display:none " id="msg">
                                            <strong>Success!</strong> Product Adding Successful 
                                </div>
                            
                            <br>
                            <br>
                            <br>
                            <br>
                        </form> 


                    </div>

                </div>
            </div>

    
                                                  


        </div>                          

        
