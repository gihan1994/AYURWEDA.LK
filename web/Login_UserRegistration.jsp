<%-- 
    Document   : Login_UserRegistration
    Created on : Sep 27, 2016, 1:35:28 PM
    Author     : Gihan
--%>

<%@page import="Connection.NewHibernateUtil"%>
<%@page import="DB.Usertype"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ayurweda.lk</title>
         
           <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
           <link href="css/MyCs.css" rel="stylesheet" type="text/css">
        <script src="js/jquery-3.1.0.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </head>
    <body>
          <div style="display:inline-block;width:100%">
            <%@include file="MyNavi.jspf"  %>
        </div><!-- hedder-->
        <div class="row">
            <br>
            <br>
            <div class="container">
                <div class="col-md-6">
                    <!--Login view-->
                    <div class="panel panel-body " style="box-shadow: 10px 10px 40px grey;">
                        <center><h2 class="h2"><strong>User Login</strong></h2></center>
                        <form action="UserManagement" method="post">
                   
                               <div class="form-group">
                        <label for="recipient-name" class="control-label">User Name</label>
                        <input type="text" class="form-control" placeholder="Enter User Name"  id="bc" name="luname" >

                    </div>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">Password</label>
                        <input type="password" class="form-control" placeholder="Enter password"  id="bc" name="lpw" >

                    </div>
                              <input type="hidden" value="userlogin" name="formType">   
               
                              <center>   <button type="submit" class="btn btn-primary btn-lg" >Login</button> </center>
                
                </form>
                      
                    </div>
                    <!--for error msg-->
                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">
                                 <% 
                        if(request.getParameter("msg")!=null){
                        %>
                        <h3 class="h3 warning" style="color: #ff0000"><%
                        out.print(request.getParameter("msg").toString());
                        %></h3>
                        
                        <%}%>
                            
                        </div>
                        <div class="col-md-2"></div>
                            
                        
                        
                    </div>
                   
                    <!------->
                </div>
                <div class="col-md-6">
                    <!--Registration view-->
                    <div class="panel panel-body" style="box-shadow: 10px 10px 40px grey;">
                         <center><h3 class="h3"><strong>User Registration</strong></h3></center>
                        <form action="UserManagement" method="post">
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">First Name</label>
                        <input type="text" class="form-control"  name="ufname" >
                    </div>
                     <div class="form-group">
                        <label for="recipient-name" class="control-label">Last Name</label>
                        <input type="text" class="form-control"  name="ulname"  >

                    </div>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">Email</label>
                        <input type="text" class="form-control"  name="uemail"  >

                    </div>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">Mobile No</label>
                        <input type="text" class="form-control"  name="utel"  >

                    </div>
                    
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">Select Who You Are</label>
                        <select class="form-control" name="utype" >

                            <%
                                Criteria cur = NewHibernateUtil.getSessionFactory().openSession().createCriteria(DB.Usertype.class);
                                        cur.setFirstResult(1);
                                List<Usertype> utl = cur.list();
                                for (Usertype utl2 : utl) {
                                    if(!utl2.getTypeName().equals("SuperAdmin")){
                                    out.print(" <option value=" + utl2.getIdUserType() + " selected='selected'>" + utl2.getTypeName() + "</option>");
                                    }
                                    
                                }

                            %> 

                        </select>
                    </div>
                               <div class="form-group">
                        <label for="recipient-name" class="control-label">User Name</label>
                        <input type="text" class="form-control"  name="uruname" >

                    </div>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">Password</label>
                        <input type="password" class="form-control"  name="upw"  >

                    </div>
                              <input type="hidden" value="userregi" name="formType">   
               
                              <center>   <button type="submit" class="btn btn-primary btn-lg">Register</button> </center>
                
                </form>
                        
                    </div>
                    
                
                    
                    
                </div>
                
                
            </div> 
                
            
        </div>
        
        <div style="display:inline-block;width:100%">
            <%@include file="MyNaviFoot.jspf"  %>

        </div><!-- footer-->

        
    </body>
</html>
