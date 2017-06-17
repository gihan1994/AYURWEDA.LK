<%-- 
    Document   : ProductOffer
    Created on : Jan 18, 2017, 9:16:42 AM
    Author     : Gihan
--%>

<%@page import="org.hibernate.criterion.Order"%>
<%@page import="DB.GrnHasProducts"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="DB.Productoffers"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="DB.Login"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>

<script>
    var offpid;
    
    function offerStatusChange(status, offid) {
        var xhttp2 = new XMLHttpRequest();
        xhttp2.onreadystatechange = function() {// 

            if (xhttp2.readyState === 4 && xhttp2.status === 200) {
                $("#offerdata").hide().html(xhttp2.responseText).fadeIn('slow');


            }
        };
        xhttp2.open("GET", "ProductOffer.jsp?offstatus=" + status + "&offerid=" + offid, true);

        xhttp2.send();

    }

    function grnSelectValueSetter(jdata) {
        var text = jdata;
        var j = JSON.parse(text);

        var values = [];
        values = j;
        var x;
        $('#grndrop')
                .find('option')
                .remove()
                .end();

        for (x in values) {
//                var dj=JSON.parse();
            $('#grndrop').append($('<option>', {
                value: values[x].grnhasp,
                text: "NO:" + values[x].grnid + ", Date:" + values[x].grndate + ", Supplier: " + values[x].grnsup
            }));
            document.getElementById('offpname').innerHTML=values[x].pname;
            offpid=values[x].pid;
        }

    }
    function OfferDataSend(url, mname) {
        var xhttp2 = new XMLHttpRequest();
        xhttp2.onreadystatechange = function() {// 

            if (xhttp2.readyState === 4 && xhttp2.status === 200) {

                if (mname == "checkpid") {
                    if (xhttp2.responseText == "0") {
                        $('#grndrop')
                                .find('option')
                                .remove()
                                .end();
                        $('#grndrop').append($('<option>', {
                            value: 0,
                            text: 'Select GRN'
                        }));
                        $("#offerdate").attr("readonly", "readonly");
                        $("#offerate").attr("readonly", "readonly");
                        $("#grndrop").attr("readonly", "readonly");
                        $('#offpnameorid').css("border-color", "red");
                          document.getElementById('offpname').innerHTML="";
                         offpid="";

                    } else {
                         $('#offpnameorid').css("border-color", "");
                         $("#offerdate").removeAttr("readonly");
                         $("#offerate").removeAttr("readonly");
                         $("#grndrop").removeAttr("readonly");
                        grnSelectValueSetter(xhttp2.responseText);
                    }

                }

                if(mname=="addoffer"){
                      $("#offerdata").hide().html(xhttp2.responseText).fadeIn('slow');
                    
                }
            }
        };
        xhttp2.open("GET", url, true);

        xhttp2.send();

    }

    function Checkpid() {
        var pidorpn = document.getElementById('offpnameorid').value;
        var url = "OfferManager?checkid=ok&pidorpn=" + pidorpn;
        OfferDataSend(url, 'checkpid');
    }
    function addOfferProduct(){
         var pidorpn = document.getElementById('offpnameorid').value;
         var offrate = document.getElementById('offerate').value;
         var offdate = document.getElementById('offerdate').value;
          var grnhaspid = $('#grndrop').find('option:selected').val();
        
        var url = "ProductOffer.jsp?addoffer=ok&grnhaspid="+grnhaspid+"&offdate="+offdate+"&offrate="+offrate;
        OfferDataSend(url, 'addoffer');
        
    }

</script>



<div style="display:inline-block " id="offerdata">
    <div class="col-md-6">
        <h4 style="font-weight: bold;margin-left:50px ">Existing Offers</h4>
        <%
            Session ofses = NewHibernateUtil.getSessionFactory().openSession();

            if (request.getParameter("offstatus") != null && request.getParameter("offerid") != null) {
                Productoffers pof = (Productoffers) ofses.load(DB.Productoffers.class, new Integer(request.getParameter("offerid")));
                if (pof != null) {
                    pof.setOfferstatus(request.getParameter("offstatus"));
                    ofses.update(pof);
                    ofses.flush();
                    ofses.beginTransaction().commit();

                }

            }
            
            //save offers
            if(request.getParameter("addoffer")!=null &&request.getParameter("grnhaspid")!=null &&
                    request.getParameter("offrate")!=null &&request.getParameter("offdate")!=null){
            
                GrnHasProducts ghp=(GrnHasProducts)ofses.load(DB.GrnHasProducts.class, new Integer(request.getParameter("grnhaspid")));
                if(ghp!=null){
                Productoffers pof=new Productoffers();
                pof.setDateofadded(new Date());
                try{
                    pof.setDateofview(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("offdate")));  
                }catch(Exception e){
                    System.out.println(e);
                }
              
                pof.setDatestatus("1");
                pof.setGrnHasProducts(ghp);
                pof.setOfferstatus("1");
                pof.setOfferqty(0);
                pof.setPresentage(new Integer(request.getParameter("offrate")));
                
                ofses.save(pof);
                    ofses.flush();
                    ofses.beginTransaction().commit();
                
                }
                
            }
            

            List<Productoffers> poffl = ofses.createCriteria(DB.Productoffers.class).addOrder(Order.desc("dateofadded")).list();
            if (poffl.size() > 0) {


        %>
        <table class="table table-bordered table-responsive" style="font-size:10px;width:100%; ">
            <th>NO</th>
            <th>GRN NO</th>
            <th>Product Name</th>
            <th>Added Date</th>
            <th>Offer Date</th>
            <th>Rate</th>
            <th>Sold Qty</th>
            <th>Status</th>
            <th>Option</th>

            <%                int offerno = 1;
                for (Productoffers pf : poffl) {
            %>

            <tr>
                <td><%=offerno%></td>
                <td><%= pf.getGrnHasProducts().getGrn().getIdGrn()%></td>


                <td><%=pf.getGrnHasProducts().getProducts().getProductName()%></td>
                <td><%out.print(new SimpleDateFormat("yyyy-MM-dd").format(pf.getDateofadded())); %></td>
                <td style="font-weight:bold;"><%out.print(new SimpleDateFormat("yyyy-MM-dd").format(pf.getDateofview()));%></td>
                <td style="font-weight:bold;color: #ff3333 "><%=pf.getPresentage()%>%</td>
                <td style="font-weight:bold;color: #330033 "><%=pf.getOfferqty()%></td>
                <td><%
                    if (pf.getOfferstatus().equalsIgnoreCase("0") && pf.getDatestatus().equalsIgnoreCase("1")) {
                        out.print("<span style=\"color: #ff3333\">De-active</span>");
                    }
                    if (pf.getOfferstatus().equalsIgnoreCase("1") && pf.getDatestatus().equalsIgnoreCase("1")) {
                        out.print("<span style=\"color: #00b40b\" >Active</span>");
                    }
                    if (pf.getDatestatus().equalsIgnoreCase("0")) {
                        out.print("<span style=\"color:#ff9933\">Date Expired</span>");
                    }
                    %></td>
                <td>
                    <%if (pf.getOfferstatus().equalsIgnoreCase("1") && pf.getDatestatus().equalsIgnoreCase("1")) {%>

                    <button class="btn btn-default btn-xs" style="font-size:10px " type="button" onclick="offerStatusChange('0',<%=pf.getIdProductOffers()%>)">De-active</button>
                    <%}%>
                    <%if (pf.getOfferstatus().equalsIgnoreCase("0") && pf.getDatestatus().equalsIgnoreCase("1")) {%>

                    <button class="btn btn-default btn-xs" style="font-size:10px;" type="button" onclick="offerStatusChange('1',<%=pf.getIdProductOffers()%>)">Active</button>
                    <%}%>
                </td>
            </tr>
            <%
                    offerno++;
                }%>
        </table> 
        <%
            } else {
                out.print("<h4 style=\"color:red\">No Offers</h4>");
            }
        %>
    </div>
    <div class="col-md-6">
        <h4 style="font-weight: bold;padding-left:200px ">Add Offer Plans</h4>
        <div style="display: inline-block">
            <div class="col-md-4" >
                <input type="text" id="offpnameorid" onkeyup="Checkpid()" class="form-control" style="margin-top:20px " placeholder="Enter Product id or Name"> 
            </div>
            <div class="col-md-3">
                <input type="number" id="offerate" class="form-control" style="margin-top:20px " placeholder="Rate" readonly="readonly">  
            </div>
            <div class="col-md-5">

                <input type="date" id="offerdate" class="form-control" style="margin-top:20px " min="01-18-2017" readonly="readonly" >     
            </div>





        </div> 
         <div style="margin-left:100px;margin-right:100px;margin-top:10px;margin-bottom:10px   ">
             <h4>Product Name <span class="badge" style="background-color: #009900" id="offpname"></span></h4>
        </div>
        <div style="margin-left:100px;margin-right:100px;margin-top:20px   ">
            <select class="form-control" id="grndrop" readonly="readonly">
                <option disabled selected value>Select GRN</option>
            </select>
        </div>
        <div style="display:inline-block ;padding:20px ">
            <button class="btn btn-success" type="button" onclick="addOfferProduct()">Set Offer</button>
        </div>

    </div>


</div>
