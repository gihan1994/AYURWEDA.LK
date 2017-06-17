<%-- 
    Document   : ProductStockUpdate
    Created on : Oct 11, 2016, 10:50:08 AM
    Author     : Gihan
--%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.SQLQuery"%>
<%@page import="java.util.List"%>
<%@page import="DB.Supplier"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<script>

//  startUps();


    var tpid;
    var supid;
    var tpname;
    var tpcqty;
    var item;




    var itemcount = 0;

    function removeItem(rpid) {//this is same of send data method but pid is differant
        var xhttp1 = new XMLHttpRequest();
        var supidr = $('#supplierslist').find('option:selected').val();
        var url = "ProductStockManager?status=stockremove&pid=" + rpid + "&supid=" + supidr;
        xhttp1.onreadystatechange = function() {
            if (xhttp1.readyState === 4 && xhttp1.status === 200) {
                $('#loadtable').hide().html(xhttp1.responseText).fadeIn('slow');
            }

        };

        xhttp1.open("GET", url, true);
        xhttp1.send();

    }
    function removeGRN(){
              var xhttp1 = new XMLHttpRequest();
        var supidrg = $('#supplierslist').find('option:selected').val();
        var url = "ProductStockManager?cleargrn=ok&supid="+ supidrg;
        xhttp1.onreadystatechange = function() {
            if (xhttp1.readyState === 4 && xhttp1.status === 200) {
                $('#loadtable').hide().html("<h6>---- No Details Add yet -----</h6>").fadeIn('slow');
                clearAll();
            }

        };

        xhttp1.open("GET", url, true);
        xhttp1.send();

        
    }


    function clearAll() {
        $('#pnorid').val('');
        $('#qqty').val('');
        $('#addqty').val('');
        $('#buyprice').val('');
        $('#sellprice').val('');
//        $('#loadtable').html('<h6>---- No Details Add yet -----</h6>');
        $('#pbrands')
                .find('option')
                .remove()
                .end();
        $('#pbrands').append($('<option>', {
            value: 0,
            text: 'Select Brand'
        }));
        
                $('#curqqty').html('');
        $('#setpname').html('Product Name:-');
        $("#addqty").attr("readonly", "readonly");
                $("#buyprice").attr("readonly", "readonly");
                $("#sellprice").attr("readonly", "readonly");
                $('#pnorid').css("border-color", "");

    }

    function printGrn() {
              var xhttp1 = new XMLHttpRequest();
        var supidrg = $('#supplierslist').find('option:selected').val();
        alert(supidrg);
        var url = "ProductStockManager?getgrn=ok&supid="+ supidrg;
        xhttp1.onreadystatechange = function() {
            if (xhttp1.readyState === 4 && xhttp1.status === 200) {
                $('#loadtable').hide().html("<h6>---- No Details Add yet -----</h6>").fadeIn('slow');
             clearAll();    
            GRNModelView(xhttp1.responseText);
            getGrnId();
            $('#supplierslist').val("");
            supid="";
            $('#pnorid').attr("readonly","readonly");
            changeStockByProduct('pid', 'dropdown');
                
            }

        };

        xhttp1.open("GET", url, true);
        xhttp1.send();


    }

    function sendGrnData() {
        var newqty = document.getElementById("addqty").value;
        var buyprice = document.getElementById("buyprice").value;
        var sellprice = document.getElementById("sellprice").value;
        var pnorid = document.getElementById("pnorid").value;
        var suplid=$('#supplierslist').find('option:selected').val();
        if (suplid != null && suplid != "" && pnorid != "" && buyprice != "" && sellprice != ""
                && parseInt(buyprice) > 0 && parseInt(sellprice) > 0
                && parseInt(buyprice) <= parseInt(sellprice)) {
            $('#addqty').css("border-color", "");
            $('#buyprice').css("border-color", "");
            $('#sellprice').css("border-color", "");
            $('#pnorid').css("border-color", "");
            $('#supplierslist').css("border-color", "");


            var xhttp1 = new XMLHttpRequest();
            var url = "ProductStockManager?status=stockadd&nqty=" + newqty + "&buyprice=" + buyprice + "&sellprice=" + sellprice + "&pid=" + tpid + "&supid=" + suplid;
            xhttp1.onreadystatechange = function() {
                if (xhttp1.readyState === 4 && xhttp1.status === 200) {
//                        var myArr = xhttp1.responseText;

                    $('#loadtable').hide().html(xhttp1.responseText).fadeIn('slow');
                    clearAll();
                }

            };

            xhttp1.open("GET", url, true);
            xhttp1.send();

        } else {

            if (suplid == null || suplid == "") {
                $('#supplierslist').css("border-color", "red");
            } else {
                if (pnorid == "") {
                    $('#pnorid').css("border-color", "red");
                } else {
                    if (newqty == "") {
                        $('#addqty').css("border-color", "red");
                    }
                    if (buyprice == "" || parseInt(buyprice) < 0) {
                        $('#buyprice').css("border-color", "red");
                    }
                    if (sellprice == "" || parseInt(sellprice) < 0) {
                        $('#sellprice').css("border-color", "red");
                    }
                    if (parseInt(buyprice) > parseInt(sellprice)) {
                        $('#buyprice').css("border-color", "red");
                        $('#sellprice').css("border-color", "red");
                        alert("Sell Price should be entered bigger than or equal Buy price")
                    }
                }



            }




        }


    }

    function getGrnId() {


        var xhttp1 = new XMLHttpRequest();
        var url = "ProductStockManager?GetData=GrnId";
        xhttp1.onreadystatechange = function() {
            if (xhttp1.readyState === 4 && xhttp1.status === 200) {
//                        var myArr = xhttp1.responseText;

                document.getElementById("grnid").innerHTML = xhttp1.responseText;

            }

        };

        xhttp1.open("GET", url, true);
        xhttp1.send();

    }

    function fieldValSetter(val) {

        var j = JSON.parse(val);

        tpid = j.pid;


        $('#curqqty').hide().html(j.qqty).fadeIn('slow');
        tpcqty = j.qqty;
//        $('#setpname').html('Product Name:-'+' '+j.pname);
        $('#setpname').hide().html('Product Name:-' + ' ' + j.pname).fadeIn('slow');
        tpname = j.pname;


        var values = [];
        values = j.pbrand;
        var x;

        $('#pbrands')
                .find('option')
                .remove()
                .end();

        for (x in values) {

            $('#pbrands').append($('<option>', {
                value: values[x],
                text: values[x]
            }));
        }

        changeStockByProduct(j.pid, 'fild');

    }

    function viewStockData(url) {

        var xhttp1 = new XMLHttpRequest();

        xhttp1.onreadystatechange = function() {
            if (xhttp1.readyState === 4 && xhttp1.status === 200) {

                $('#stockdata').hide().html(xhttp1.responseText).fadeIn('slow');

            }

        };

        xhttp1.open("GET", url, true);
        xhttp1.send();
    }

    function changeStockByProduct(pid, rf) {
        var stokpid;
        //dropdown change
        if (rf == "dropdown") {
            stokpid = $('#stockpid').find('option:selected').val();
        }
//        when pid enter call from field setter function
        else {
            stokpid = pid;
            $('#stockpid').val(pid);
        }

        viewStockData("ProductStockManager?stockData=viewall&stockpid=" + stokpid);
    }
    function changeStockBySupplier() {
             var supidc = $('#supplierslist').find('option:selected').val();
        viewStockData("ProductStockManager?stockData=viewall&supid=" + supidc);    

    }
    function stockOptionChange(ctype, gnid) {
        var stokpid = $('#stockpid').find('option:selected').val();
        viewStockData("ProductStockManager?stockData=OptionData&stockpid=" + stokpid + "&optiontype=" + ctype + "&gnid=" + gnid);

    }

    $(document).ready(function() {
        //get viewdata when open first of all
        $('#stockdata').ready(function() {
            viewStockData("ProductStockManager?stockData=viewall");
        });
        //set grn id
        $('#grnid').ready(function() {

            getGrnId();
        });

//supplier change

var prev_val;

$('#supplierslist').focus(function() {
    prev_val = $(this).val();
}).change(function() {
     $(this).blur() ;// Firefox fix as suggested by AgDude
     
      if(supid == null || supid == ""){
         
             var supidc = $('#supplierslist').find('option:selected').val();
        viewStockData("ProductStockManager?stockData=viewall&supid=" + supidc);  
        supid = supidc;

            if (supid != "") {
                $("#pnorid").removeAttr("readonly");
                $("#warningmsg").hide();
            }
            $(this).css("border-color", "");
          
            
        }
        else{
          var s=confirm("The Supplier's GRN  will have been Destroyed if it be changed "); 
          if(s == true){
               var supidc = $('#supplierslist').find('option:selected').val();
        viewStockData("ProductStockManager?stockData=viewall&supid=" + supidc);   
        removeGRN();
        
       
          }else{
    $(this).val(prev_val);
        return false; 
            
          }
          
        }
   
});



        $('#pnorid').keyup(function() {
            var item = document.getElementById('pnorid').value;

            if (!this.value) {//check is empty text field
                    clearAll();

            } else { //not empty


                var url = 'ProductStockManager?pmodel=' + item;
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState === 4 && xhttp.status === 200) {
                        var myArr = xhttp.responseText;

                        if (myArr == "0") {
                            $('#pbrands')
                                    .find('option')
                                    .remove()
                                    .end();
                            $('#pbrands').append($('<option>', {
                                value: 0,
                                text: 'Select Brand'
                            }));

                            $('#curqqty').html('');
                            $('#setpname').html('Product Unavailable or De-active &nbsp; &nbsp;');
                            $("#addqty").attr("readonly", "readonly");
                            $("#buyprice").attr("readonly", "readonly");
                            $("#sellprice").attr("readonly", "readonly");
                            $('#pnorid').css("border-color", "red");

                        } else {
                            $('#pnorid').css("border-color", "");
                            $("#addqty").removeAttr("readonly");
                            $("#buyprice").removeAttr("readonly");
                            $("#sellprice").removeAttr("readonly");
                            fieldValSetter(myArr);

                        }


                    }

                };

                xhttp.open("GET", url, true);
                xhttp.send();


            }

        });

//        $('#dropDownId').val();
//        $('#supplierslist').on('change', function() {
//            supid = this.value;
//
//            if (supid != "") {
//                $("#pnorid").removeAttr("readonly");
//                $("#warningmsg").hide();
//            }
//
//
//            $(this).css("border-color", "");
//        });

    });


    function GRNModelView(grnid) {

        var xhttp1 = new XMLHttpRequest();
        var url = "GRN.jsp?grnid=" + grnid;
        xhttp1.onreadystatechange = function() {
            if (xhttp1.readyState === 4 && xhttp1.status === 200) {

                $('#Grncontent').hide().html(xhttp1.responseText).fadeIn('slow');
                $("#GrnModal").modal();
            }

        };

        xhttp1.open("GET", url, true);
        xhttp1.send();

    }


</script>
<%
    Session sus = NewHibernateUtil.getSessionFactory().openSession();
%>

<!--grn model view-->
<div class="modal fade" id="GrnModal" role="dialog" >
    <input type="text" style="display: none"  id="invoid" value="<%=request.getParameter("invoiceid")%>" >
    <div class="modal-dialog  modal-open">

        <!-- Modal content-->
        <div class="modal-content" >

            <div class="modal-body"  id="Grncontent">

            </div>


            <div class="modal-footer">
                <button  class="btn btn-default hedder-btn" type="button" onclick="">Print</button>
            </div>
        </div>

    </div>
</div> 
<!--model end-->

<div class="col-md-1"></div>
<div class="col-md-10 " style="font-size:10px; ">
    <div style="display: inline-block;width:100% ">
        <div class="col-md-12" style="border-color: ">
            <h3><strong>Products Stock Update</strong></h3> 
        </div>
        <br>
    </div>
    <div>
        <h4 style="margin-right:300px;  ">Existing Stock</h4>
        <div style="display: inline-block" > <select id="stockpid" onchange="changeStockByProduct('pid', 'dropdown')" style="font-size: 14px" >
                <option disabled selected value >Select Product Name</option>
                <option value="All" >All</option>
                <%
                    SQLQuery ss = sus.createSQLQuery("SELECT DISTINCT"
                            + "`products`.`ProductName`"
                            + ", `products`.`idProducts`"
                            + "FROM"
                            + "`grn_has_products`"
                            + "INNER JOIN `products` "
                            + "ON (`grn_has_products`.`Products_idProducts` = `products`.`idProducts`)");

                    List ll = ss.list();
                    if (ll.size() > 0) {
                        for (Object o : ll) {
                        Object[] oa = (Object[]) o;%>

                <option  value="<%=oa[1]%>"><%=oa[0].toString()%></option>

                <%}
                    }
                %>

            </select></div>
        <h6 style="color: #cccccc " >If you Want to active some stocks before should be selected the product name</h6>
        <div style="display:inline-block ;max-height:300px;overflow: auto;" id="stockdata">
            <!--stock content here-->

        </div>
    </div>
    <div style="display: inline">
        <h4 style="padding-top:25px   ">Updating Stock</h4>

        <div style="display: inline-block ;">
            <h6 style="font-weight: bold;font-size: 10px;color: #ff3300;" id="warningmsg">Compulsory Select Supplier First</h6> 
            <br>
        </div>
        <div style="display: inline-block ;margin-left: 200px">

            <h4 style="color:#ff3300"><strong>Next GRN NO- <span class="badge" style="background-color:#00b534;font-size: 18px " id="grnid"></span> </strong></h4> 

        </div>




    </div>
    <div style="display: inline-block">
        <br>
        <form>




            <div class="form-inline">
                <div class="form-group">
                    <label for="exampleInputFile">Select Supplier</label>
                    <select class="form-control" onchange=""   id="supplierslist" name="pcat" style="border-color: #00ff99" >
                        <option disabled selected value>Select Supplier</option>
                        <%
                            List<Supplier> supl = sus.createCriteria(DB.Supplier.class).add(Restrictions.eq("status", "1")).list();

                            for (Supplier si : supl) {

                        %>
                            <option value="<%= si.getIdSupplier()%>" ><%=si.getFullName()%></option>

                        <%
                            }
                        %>
                    </select>

                </div>
                <div class="form-group">

                    &nbsp;
                </div>
                <div class="form-group">

                    &nbsp;
                </div>  
                <div class="form-group">

                    &nbsp;
                </div>
                <div class="form-group">

                    &nbsp;
                </div>
                <div class="form-group">

                    &nbsp;
                </div>
                <div class="form-group">

                    <input type="text" class="form-control" readonly="readonly"  placeholder="Name or Id of Product" id="pnorid" >
                </div>
                <div class="form-group">

                    &nbsp;
                </div>
                <div class="form-group">
                    <label for="exampleInputFile">Select Brand</label>
                    <select class="form-control" id="pbrands" name="pcat">
                        <option disabled selected value>Select Brand</option>
                    </select>

                </div>
                <div class="form-group">

                    &nbsp;
                </div>
                <div class="form-group">
                    <button class="btn btn-info btn-sm" type="button" onclick="$('#collapseOne').collapse('show');">Add New Product</button>

                </div>



            </div>
            <center><strong><h5 id="setpname" style="color:#999999 ">Product Name:</h5></strong></center>

            <br>
            <br>
            <div class="form-inline">

                <div class="form-group">

                    <h5 style="color:#03a9f4 ">Current Total Stock :&nbsp;<span class="badge" style="background-color:#ff3300; " id="curqqty">0</span></h5>
                </div>
                <div class="form-group">

                    &nbsp;
                </div>
                <div class="form-group">

                    &nbsp;
                </div>
                <div class="form-group">

                    &nbsp;
                </div>
                <div class="form-group">

                    &nbsp;
                </div>
                <div class="form-group">

                    <input type="number" class="form-control" oncontextmenu="javascript:return false;"  placeholder="Enter New Qty" id="addqty" readonly="readonly">
                </div>
                <div class="form-group">

                    &nbsp;
                </div>
                <div class="form-group">

                    <input type="number" min="0" oncontextmenu="javascript:return false;" class="form-control"  placeholder="Buy Price" id="buyprice" readonly="readonly">
                </div>
                <div class="form-group">

                    &nbsp;
                </div>
                <div class="form-group">

                    <input type="number" min="0" oncontextmenu="javascript:return false;" class="form-control"  placeholder="Sell Price" id="sellprice" readonly="readonly">
                </div>
                <div class="form-group">

                    &nbsp;
                </div>
                <div class="form-group">
                    <button type="button" class="form-control btn btn-default admin-product-viewbtn" onclick="sendGrnData()"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> Add </button>
                </div>
            </div>
        </form>
    </div>
    <br>
    <br>
    <div style="display: inline-block">
        <strong><h4><b>Added Items</b></h4></strong>
    </div>
    <div id="loadtable" class="col-md-12 ">
        <!--load table when add button clocked-->
        <h6>---- No Details Add yet -----</h6>
    </div>



</div>
<div class="col-md-1"></div>



