<%-- 
    Document   : AdminInvoices
    Created on : Mar 15, 2017, 3:56:45 PM
    Author     : Gihan
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="DB.Invoice"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<script>
    function LoadInvoData(invoid){
        var url="AdminInvoiceGrn?invodata=ok" 
        if(invoid!="all"){
            url+="&invoid="+invoid;
        }
        sendInvoGrnData(url,"invo");
    }
    function LoadGrnData(grnid){
          var url="AdminInvoiceGrn?Grndata=ok" 
        if(grnid!="all"){
            url+="&grnid="+grnid;
        }
        sendInvoGrnData(url,"Grn");
    }
    function invosearch(){
        var id=document.getElementById("invoserch").value;
        if(id==null||id==""){
            id="all";//for get all invoices
        }
        LoadInvoData(id);
    }
    function grnSerch(){
          var id=document.getElementById("grnserch").value;
        if(id==null||id==""){
            id="all";//for get all invoices
        }
        LoadGrnData(id);
        
    }
    function grnModel(grnid){
        var url="GRN.jsp?grnid="+grnid;
        sendInvoGrnData(url,"model");
    }
    function invoModel(invoid){
         var url="Invoice.jsp?invoiceid="+invoid;
        sendInvoGrnData(url,"model");
    }
    function sendInvoGrnData(url,method){
          var xhttp2 = new XMLHttpRequest();
                xhttp2.onreadystatechange = function() {// 
                    
                    if (xhttp2.readyState === 4 && xhttp2.status === 200) {
                            if(method=="invo"){
                                  $("#serinvodata").hide().html(xhttp2.responseText).fadeIn('slow');
                            }
                            if(method=="Grn"){
                                 $("#sergrndata").hide().html(xhttp2.responseText).fadeIn('slow');
                            }
                            if(method=="model"){
                              
                                      document.getElementById("modcontent").innerHTML=xhttp2.responseText;
                         $("#invogrnModal").modal();
                            }

                    }
                };
                xhttp2.open("GET",url, true);

                xhttp2.send(); 
    }
    
    $(document).ready(function (){
        
        $("#serinvodata").ready(function (){
            LoadInvoData('all');
        });
         $("#sergrndata").ready(function (){
            LoadGrnData('all');
        });
    });
</script>


<%
Session invoGrnses=NewHibernateUtil.getSessionFactory().openSession();
%>
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true" style="margin-top:50px ">
        <div class="panel panel-default ">
            <div class="panel-heading" role="tab" id="headingOne"  style="background-color:#F5F6F7;text-decoration:none  ">
                <h4 class="panel-title">
                    <a id="addp" class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                        <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>  INVOICE
                    </a>
                </h4>
            </div>
            <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                <div class="panel-body">
                    <!--Invoice area-->
                    <div class="input-group" style="margin-left:350px;margin-right:350px  ">
                        <input type="text" class="form-control" placeholder="Search Invoices" id="invoserch" onkeyup="invosearch()">
     
                    </div>          
                    <div id="serinvodata">
                        
                    </div>    
                  
                </div>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading " role="tab" id="headingThree"  style="background-color:#F5F6F7;text-decoration:none  ">
                <h4 class="panel-title">
                    <a class="collapsed" role="button"  data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                        <span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>  GRN
                    </a>
                </h4>
            </div>
            <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                <div class="panel-body">
                    <!--GRN category-->
                         <div class="input-group" style="margin-left:350px;margin-right:350px  ">
                             <input type="text" class="form-control" placeholder="Search GRN" id="grnserch" onkeyup="grnSerch()">
     
                         </div>     
                     <div id="sergrndata">
                        
                    </div>  


                </div>
            </div>
        </div>
       
    </div>
<!--Models-->
 <div class="modal fade" id="invogrnModal" role="dialog">
                    <div class="modal-dialog  modal-open">
                        <!-- Modal content-->
                        <div class="modal-content">
                            
                            <div class="modal-body" id="modcontent">
                               
                            </div>
                            <div class="modal-footer">
                                <button  class="btn btn-default hedder-btn" type="button" onclick="printDiv('invoicecontent')">Print</button>
                            </div>
                        </div>

                    </div>
                </div> 