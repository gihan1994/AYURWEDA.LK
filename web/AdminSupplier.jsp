<%-- 
    Document   : AdminSupplier
    Created on : Feb 3, 2017, 8:15:58 PM
    Author     : Gihan
--%>

<%@page import="java.util.Date"%>
<%@page import="DB.Company"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.SQLQuery"%>
<%@page import="DB.Supplier"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<script>
    function changeSupplierStasus(status,supid){
        var url="AdminSupplier.jsp?status="+status+"&supid="+supid;
        AdminSupplierDataSend(url);
    }
    function searchSupplier(){
        var value=document.getElementById('supserfild').value;
           var url="AdminSupplier.jsp?searchvalue="+value;
        AdminSupplierDataSend(url);
    }
    function AdminSupplierDataSend(url){
          var xhttp2 = new XMLHttpRequest();
                xhttp2.onreadystatechange = function() {// 
                    
                    if (xhttp2.readyState === 4 && xhttp2.status === 200) {

                    $('#majordata').hide().html(xhttp2.responseText).fadeIn('slow');
                        
                    }
                };
                xhttp2.open("GET",url, true);

                xhttp2.send();  
        
        
    }
    function sendSupplerForm(){
            var myform = document.getElementById("supplerformdata");
    var fd= new FormData(myform);
   var ids = ['supname', 'supst1', 'supst2', 'supcity', 'suppcode', 'supemail', 'supmobi', 'comname', 
       'comregino', 'comdescrip', 'comregidate', 'comstartdate'];
            var i = 0;
            var status = false;
            for (i in ids) {

                if (document.getElementById(ids[i]).value !== '') {
                    document.getElementById(ids[i]).style.borderColor = "";
                    status = true;
                } else {
                    document.getElementById(ids[i]).style.borderColor = "red";
                    status = false;
                }
            }
    
    
    if(status){
         $.ajax({
        url: "AdminSupplier.jsp?submitdata=ok",
        data: fd,
        cache: false,
        processData: false,
        contentType:false,
        type: 'POST',
        success: function (dataofconfirm) {
           $('#majordata').hide().html(dataofconfirm).fadeIn('slow'); 
        }
    });   
        
    }
 
        
    }
    
</script>




   <%
   Session adsupses=NewHibernateUtil.getSessionFactory().openSession();
   String addsuplierCollapse="collapse";
   //add supplier data
   boolean supplierDataAddingStatus=false;
   String supplieraddingErrormsg="Before Submited data have not been saved.because of Already Exsit you have enterd ";
   if(request.getParameter("submitdata")!=null){
                List list = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                Supplier newsup=new Supplier();
                Company newsupcom=new Company();
                for (Object object : list) {
                    FileItem fileItem = (FileItem) object;
                    if (fileItem.isFormField()) {
                        if (fileItem.getFieldName().equals("supname")&&fileItem.getString()!=null) {
                            System.out.println(fileItem.getString());
                            Supplier checksup=(Supplier)adsupses.createCriteria(DB.Supplier.class)
                                    .add(Restrictions.eq("fullName", fileItem.getString())).uniqueResult();
                            if(checksup!=null){
                               supplierDataAddingStatus=true;//supplier name exsit
                               supplieraddingErrormsg+=" supplier name";
                              
                                
                            }else{
                               newsup.setFullName(fileItem.getString());
                            }
                        }
                          if (fileItem.getFieldName().equals("supst1")) {
                            System.out.println(fileItem.getString());
                            newsup.setStreet1(fileItem.getString());
                            
                        }
                            if (fileItem.getFieldName().equals("supst2")) {
                            System.out.println(fileItem.getString());
                             newsup.setStreet2(fileItem.getString());
                        }
                              if (fileItem.getFieldName().equals("supcity")) {
                            System.out.println(fileItem.getString());
                             newsup.setCity(fileItem.getString());
                        }
                                if (fileItem.getFieldName().equals("suppcode")) {
                            System.out.println(fileItem.getString());
                             newsup.setPcode(fileItem.getString());
                        }
                                  if (fileItem.getFieldName().equals("supmobi")&&fileItem.getString()!=null) {
                            System.out.println(fileItem.getString());
                             Supplier checksup=(Supplier)adsupses.createCriteria(DB.Supplier.class)
                                    .add(Restrictions.eq("tel", fileItem.getString())).uniqueResult();
                            if(checksup!=null){
                               supplierDataAddingStatus=true;//supplier mobile exsit
                               supplieraddingErrormsg+=" ,supplier Mobile no";
                           
                                
                            }else{
                               newsup.setTel(fileItem.getString());
                            }
                            
                        }
                                    if (fileItem.getFieldName().equals("supemail")&&fileItem.getString()!=null) {
                            System.out.println(fileItem.getString());
                              Supplier checksup=(Supplier)adsupses.createCriteria(DB.Supplier.class)
                                    .add(Restrictions.eq("email", fileItem.getString())).uniqueResult();
                            if(checksup!=null){
                               supplierDataAddingStatus=true;//supplier email exsit
                               supplieraddingErrormsg+=" ,supplier Email";
                            }else{
                               newsup.setEmail(fileItem.getString());
                            }
                            
                        }
                                      if (fileItem.getFieldName().equals("supweb")&&fileItem.getString()!=null) {
                            System.out.println(fileItem.getString());
                             Supplier checksup=(Supplier)adsupses.createCriteria(DB.Supplier.class)
                                    .add(Restrictions.eq("webSite", fileItem.getString())).uniqueResult();
                            if(checksup!=null){
                               supplierDataAddingStatus=true;//supplier website exsit
                               supplieraddingErrormsg+=" ,supplier Website";
                            }else{
                               newsup.setWebSite(fileItem.getString());
                            }
                            
                        }
                                        if (fileItem.getFieldName().equals("comname")&&fileItem.getString()!=null) {
                            System.out.println(fileItem.getString());
                            Company checkcom=(Company)adsupses.createCriteria(DB.Company.class).
                                    add(Restrictions.eq("name", fileItem.getString())).uniqueResult();
                            if(checkcom!=null){
                                 supplierDataAddingStatus=true;//supplier mobile exsit
                               supplieraddingErrormsg+=" ,company name";
                            }else{
                                newsupcom.setName(fileItem.getString());
                            }
                        }
                                          if (fileItem.getFieldName().equals("comregino")&&fileItem.getString()!=null) {
                            System.out.println(fileItem.getString());
                            Company checkcom=(Company)adsupses.createCriteria(DB.Company.class).
                                    add(Restrictions.eq("regiNo", fileItem.getString())).uniqueResult();
                            if(checkcom!=null){
                                 supplierDataAddingStatus=true;//supplier mobile exsit
                               supplieraddingErrormsg+=" ,company Regitration No";
                            }else{
                                newsupcom.setRegiNo(fileItem.getString());
                            }
                            
                            
                        }
                                            if (fileItem.getFieldName().equals("comregidate")&&fileItem.getString()!=null) {
                            System.out.println(fileItem.getString());
                            try{
                               newsupcom.setRegiDate(new SimpleDateFormat("yyyy-MM-DD").parse(fileItem.getString()));  
                            }catch(Exception e){
                               System.out.print(e); 
                            }
                            
                        }
                                              if (fileItem.getFieldName().equals("comstartdate")) {
                            System.out.println(fileItem.getString());
                               newsupcom.setStartDate(fileItem.getString());  
                           
                        }
                                       if (fileItem.getFieldName().equals("comdescription")) {
                            System.out.println(fileItem.getString());
                               newsupcom.setDescription(fileItem.getString());  
                           
                        }
                       
                    } else {


                    }
                }
                //after check all then data save 
               if(!supplierDataAddingStatus){//no errors
                   adsupses.save(newsupcom);
                   adsupses.flush();adsupses.beginTransaction().commit();
                   newsup.setCompany(newsupcom);
                   newsup.setRatings(0.0);
                   newsup.setJoinDate(new Date());
                   newsup.setStatus("1");
                   adsupses.save(newsup);
                    adsupses.flush();adsupses.beginTransaction().commit();
               } else{
                   supplieraddingErrormsg+=" check this field again";
                   addsuplierCollapse="collapse in";
               }
                
   }
   
   
   
   
   
   //supplier status change
   if(request.getParameter("status")!=null&&request.getParameter("supid")!=null){
    Supplier s=(Supplier)adsupses.load(DB.Supplier.class, new Integer(request.getParameter("supid")));
      if(s!=null){
       s.setStatus(request.getParameter("status"));
       adsupses.update(s);
       adsupses.flush();
        adsupses.beginTransaction().commit();
      }
   }
   
   
   %>
 <!--supplier details view-->
 <div id="majordata">
     <div class="panel panel-success" id="supplierdetails">
    <div class="panel-heading">
        <h4>Supplier Details</h4>
        <div class="input-group" style="margin-top: 10px;margin-left:300px;margin-right:300px   ">
            <input type="text" class="form-control" id="supserfild" placeholder="Search for suppliers">
      <span class="input-group-btn">
          <button class="btn btn-default" type="button" onclick="searchSupplier()">Search</button>
      </span>
    </div>
    </div>
    <div class="panel-body" style="max-height:500px;overflow: auto ">
         <%
         
         Criteria supcri=adsupses.createCriteria(DB.Supplier.class);
            
         //search supplier
         if(request.getParameter("searchvalue")!=null){
             
           try {
            //check is value id or name 
               Integer integer = new Integer(request.getParameter("searchvalue"));
            supcri.add(Restrictions.eq("idSupplier", new Integer(request.getParameter("searchvalue"))));
            
        } catch (Exception e) {
            supcri.add(Restrictions.eq("fullName", request.getParameter("searchvalue")));
            }   
         }
        
         
         List<Supplier> adsupl=supcri.list();
         if(adsupl.size()>0){
         %>   
        <table class="table table-bordered">
            <th>Supplier id</th>
            <th>Name</th>
            <th>Company Name</th>
            <th>Contacts</th>
            <th>Joined Date</th>
            <th>Supplier status </th>
            <th>Option</th>
            
          <%
           for(Supplier si:adsupl){
          %>  
        
            <tr>
                <td><%=si.getIdSupplier()  %></td>   
                <td><%=si.getFullName()  %></td>  
                <td><%=si.getCompany().getName()  %></td>
                
                <td><%=si.getTel()  %></td>   
                <td><%=new SimpleDateFormat("yyyy-MM-dd").format(si.getJoinDate())  %></td>   
               
                <%
                if(si.getStatus().equalsIgnoreCase("0")){%>
                <td style="color:#ff0033;font-weight: bold"><%out.print("De-active");%></td>   
                 <td style="color: #00b40b;font-weight: bold">
                    <button class="btn btn-xs btn-success" type="button" onclick="changeSupplierStasus('1',<%=si.getIdSupplier()  %>)">Active</button>
                     <button class="btn btn-default">View More</button>
                </td>  
              
                    <%}%>
                 <%
                if(si.getStatus().equalsIgnoreCase("1")){%>
                <td style="color: #00b40b;font-weight: bold"><%out.print("Active"); %></td>   
                <td style="color: #00b40b;font-weight: bold">
                    <button class="btn btn-xs btn-danger" type="button" onclick="changeSupplierStasus('0',<%=si.getIdSupplier()  %>)">De-active</button>
                    <button class="btn btn-default">View More</button>
                </td>  
               
                
                    <%}%>
                  
                 
                    
            </tr>
            <%}%>
        </table>
        <%
         }else{
        %>
        <h5 style="color: #ff0033;font-weight: bold;margin-left:300px ">There is No Suppliers in Database  </h5>
        
        <%}%>
    </div>
</div>
<!--supplier add-->
<div class="panel" id="suppliersadd">
    <div class="panel-group" id="addsuplliercollaps" role="tablist" aria-multiselectable="true">
        <div class="panel panel-default ">
            <div class="panel-heading" role="tab" style="background-color: #666666;color: #ffffff">
                <h4 class="panel-title">
                    <a id="addsupp" class="collapsed" role="button" data-toggle="collapse" style="font-weight: bold" data-parent="#addsuplliercollaps" href="#collapsesupbody" aria-expanded="true" aria-controls="collapseOne">
                        <span class="glyphicon glyphicon-user" aria-hidden="true" style="color: #ff6600"></span>   Add New Supplier
                    </a>
                </h4>
                
            </div>
            <div id="collapsesupbody" class="panel-collapse <%=addsuplierCollapse%>" role="tabpanel" aria-labelledby="headingOne">
                <div class="panel-body">
                    <form method="post" id="supplerformdata">
                    <!--add supplier area-->
                    <%
                    if(supplierDataAddingStatus){
                    %>
                    <div class="alert alert-danger alert-dismissible" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <strong>Error!</strong> <%=supplieraddingErrormsg%>.
                    </div>
                    
                    <%}%>
                     <h6 style="color: #ff0033;margin-left:500px;font-weight: bold">require fields have been marked by this  * </h6>
                    <div style="margin-left: 300px;margin-right:300px ">
                        <h4 style="font-weight:bold ">Supplier id</h4>
                        <div class="form-group">
                            <%
                            int nxtsupid=0;
                            List<Supplier> idsupl=adsupses.createCriteria(DB.Supplier.class).list();
                            if(idsupl.size()>0){
                              ArrayList<Integer> al =new ArrayList();
                              for(Supplier s:idsupl){al.add(s.getIdSupplier());}
                            nxtsupid=Collections.max(al)+1;
                            
                            }
                            
                            
                            %>
                            <input type="text" style="font-weight: bold;color: #03a9f4" readonly="readonly" class="form-control" value="<%=nxtsupid %>">
                    </div>
                    <h4 style="margin-top:10px;font-weight:bold  ">Supplier Name <span style="color: #ff0033">*</span></h4>
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Enter name of supplier" id="supname" name="supname">
                    </div>
                        <h4 style="margin-top:10px;font-weight:bold  ">Supplier Address <span style="color: #ff0033">*</span></h4>
                        <div class="form-group">
                            <input type="text"   class="form-control" placeholder="Street 1" name="supst1" id="supst1">
                            <input type="text"   class="form-control" style="margin-top:5px " name="supst2" placeholder="Street 2" id="supst2">
                            <input type="text"  class="form-control" style="margin-top:5px " name="supcity" placeholder="City" id="supcity">
                            <input type="number"  class="form-control" style="margin-top:5px " name="suppcode" placeholder="Postal code" id="suppcode">
                    </div>
                        <h4 style="margin-top:10px;font-weight:bold  ">Supplier Tele <span style="color: #ff0033">*</span></h4>
                        <div class="form-group">
                            <input type="number"   class="form-control" placeholder="Enter Mobile No" name="supmobi" id="supmobi">
                    </div><h4 style="margin-top:10px;font-weight:bold  ">Supplier Email <span style="color: #ff0033">*</span></h4>
                        <div class="form-group">
                            <input type="email"   class="form-control" placeholder="Enter E-mail Address" name="supemail" id="supemail">
                    </div>
                    <h4 style="margin-top:10px;font-weight:bold  ">Supplier Web<small>(optional)</small></h4>
                        <div class="form-group">
                            <input type="text" style="font-weight: bold;color: #03a9f4"  class="form-control" name="supweb" placeholder="Enter full url">
                    </div>
                    <h4 style="margin-top:20px;font-weight:bold ">Supplier Company Details</h4>
                      <h4 style="margin-top:10px;margin-left:10px ">Company Name <span style="color: #ff0033">*</span></h4>
                    <div class="form-group">
                            <input type="text"   class="form-control" placeholder="Enter name of Company" name="comname" id="comname">
                    </div>
                      <h4 style="margin-top:10px;margin-left:10px ">Company Description <span style="color: #ff0033">*</span></h4>
                    <div class="form-group">
                        <textarea class="form-control" placeholder="Add short description ..." name="comdescription" id="comdescrip">
                            
                        </textarea>
                    </div>
                      <h4 style="margin-top:10px;margin-left:10px ">Company Registration NO <span style="color: #ff0033">*</span></h4>
                    <div class="form-group">
                            <input type="text"  class="form-control" placeholder="Registration no" name="comregino" id="comregino">
                    </div>
                      <h4 style="margin-top:10px;margin-left:10px ">Register Date <span style="color: #ff0033">*</span></h4>
                    <div class="form-group">
                        <input type="date"   class="form-control" placeholder="Register Date of Company" name="comregidate" id="comregidate">
                    </div>
                      <h4 style="margin-top:10px;margin-left:10px ">Company Started Date <span style="color: #ff0033">*</span></h4>
                    <div class="form-group">
                        <input type="date"   class="form-control" placeholder="Date of started" name="comstartdate" id="comstartdate">
                    </div>
                    </div>
                   
                    <br>
                    <button class="btn btn-default btn-lg hedder-btn" style="margin-left:500px " type="button" onclick="sendSupplerForm()">Enter Details</button>
                    </form>
                </div>
            </div>
        </div>
        
</div>

 </div>
 </div>