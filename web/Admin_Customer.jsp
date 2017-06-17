<%-- 
    Document   : Admin_Customer
    Created on : Nov 2, 2016, 4:20:04 PM
    Author     : Gihan
--%>

<%@page import="DB.Login"%>
<%@page import="java.util.List"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Criteria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<script>
    
    function sendUid(uid){
           var xhttp2 = new XMLHttpRequest();
                xhttp2.onreadystatechange = function() {// 
                    
                    if (xhttp2.readyState === 4 && xhttp2.status === 200) {

                        document.getElementById("otherdetailscontent").innerHTML=xhttp2.responseText;
                    }
                };
                xhttp2.open("GET","AdminCustomerDetails?userid="+uid, true);

                xhttp2.send();  
        
        
    }
      function viewModelInvoice(invoid){
                  var xhttp2 = new XMLHttpRequest();
                xhttp2.onreadystatechange = function() {// 
                    
                    if (xhttp2.readyState === 4 && xhttp2.status === 200) {

                        document.getElementById("invoicecontent").innerHTML=xhttp2.responseText;
                         $("#invoModal").modal();
                    }
                };
                xhttp2.open("GET","Invoice.jsp?invoiceid="+invoid, true);

                xhttp2.send(); 
        
        }
    
    $(document).ready(function (){
        
       $("#aduid").change(function() 
       { 
           
//        alert($(this).val());
    
        sendUid($(this).val());
    }); 
        
    });
    
    
</script>
 
<div style="display: inline-block;margin-top:50px ">
                  <!--other details-->
                  <div style="display: inline-block"> 
                            <ul class="nav nav-tabs nav-justified">
                                <li role="presentation" class="active"><h4><strong>Customer Details</strong></h4></li>
                                      <li role="presentation" ><div class="input-group">
                                           <select class="form-control" name="utype" id="aduid" >
                                               <option value="0" selected="selected">Select User Name Here</option>
                            <%
                                Criteria cur = NewHibernateUtil.getSessionFactory().openSession().createCriteria(DB.Login.class);
                                       
                                List<Login> utl = cur.list();
                                for (Login utl2 : utl) {
                                    out.print(" <option value=" + utl2.getIdLogin()+ " class='adcusuid' >" + utl2.getUsername()+ "</option>");
                                }

                            %> 

                        </select>
                                        
                                    </div></li>
                            </ul>
                        </div> 
                  <div style="display: inline-block">
                      <!--for customer-->
                      <div id="otherdetailscontent" class="panel panel-body" style="height:1000px;overflow:auto;max-height:1000px;overflow-style:move    ">
                         <h5>No Customer's Detail Found</h5> 
                          
                      </div>
                      
                      
                      
                  </div>
                  

                </div>
             <div class="modal fade" id="invoModal" role="dialog">
                    <div class="modal-dialog  modal-open">
                        <!-- Modal content-->
                        <div class="modal-content">
                            
                            <div class="modal-body" id="invoicecontent">
                               
                            </div>
                            <div class="modal-footer">
                                <button  class="btn btn-default hedder-btn" type="button" onclick="printDiv('invoicecontent')">Print</button>
                            </div>
                        </div>

                    </div>
                </div> 