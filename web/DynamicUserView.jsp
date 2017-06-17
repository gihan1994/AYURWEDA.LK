<%@page import="java.util.List"%>
<%@page import="DB.Notifications"%>
<%@page import="org.hibernate.Session"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : DynamicUserView
    Created on : Nov 21, 2016, 2:46:06 PM
    Author     : Gihan
--%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="DB.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/MyCs.css" rel="stylesheet" type="text/css">
        <script src="js/jquery-3.1.0.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <script>
//            $(document).ready(function (){
//                 $("#userviewpic").mouseenter(function() {
//            $(this).animate({'opacity': '0.9'}, {
//                duration: 0,
//                step: function() {
////                    $("#userviewpichover").css({'display':'block',
////                                                'position':'absolute',
////                                                'top':'30px',
////                                                'left':'700px'});
//
//    $("#userviewpichover").css('display','');
//    alert("awaaa");
//                }
//
//            });
//            ;
//
//        });
//        $("#userviewpic").mouseleave(function() {
//            $(this).animate({'opacity': '1'}, {
//                duration: 0,
//                step: function() {
//                    $("#userviewpichover").css('display', 'none');
//                }
//
//            });
//            ;
//        });
//                
//                
//            });
            
            
        </script>
        
        <style>
          
        </style>
    </head>
    
    <body>
           <%
                    String link = "Login_UserRegistration.jsp";
                    String link2 = "UserView.jsp";
                    String btnname = "Login";

                    if (request.getSession().getAttribute("username") != null) {

                        btnname = "LogOut";
                        link = "UserManagement?lstatus=logout";
                    } else {
                        link = "Login_UserRegistration.jsp";
                        btnname = "Login";
                    }

                %>
       
       
       
     
        <%
            if(request.getSession().getAttribute("username")!=null){
            Session lses=NewHibernateUtil.getSessionFactory().openSession();
                 Login uvl=(Login)lses.createCriteria(DB.Login.class)
                .add(Restrictions.eq("username",request.getSession().getAttribute("username"))).uniqueResult();
            
                 if(uvl!=null){
         
        %>
         <div class="panel-body panel-info ">
             
             <%
                 String imgpath="img/DefaltUser.png";    
                     if(uvl.getUser().getUimg()!=null){
                         imgpath=uvl.getUser().getUimg();
             } %>
             
             <div style="display: inline-block">
                 <div class="col-md-6">
                     <img src="<%=imgpath %>" id="userviewpic" alt="img/DefaltUserhover.png" style="position:relative;   top:0; left:0;" class="img-circle" width="100px" height="100px">
                        <img src="img/DefaltUserhover.png" id="userviewpichover" style="position:absolute; display:none;   top:30px; left:70px;" class="img-circle" width="100px" height="100px"> 
                 </div>
                 <div class="col-md-6">
                    <h3 style="font-weight:bold "><%=uvl.getUser().getFname() %><br><small><%=uvl.getUser().getUsertype().getTypeName()%></small></h3>     
                 </div>
             </div>  
                 
             
                 
                 <div style="display: inline-block">
                      <div class="col-md-5">
                        <button type="button" class="btn btn-info btn-lg" onclick="location.href ='<%=link2%>'">Profile</button>
                    </div>
                    <div class="col-md-2"></div>
                    <div class="col-md-5">
                        <button type="button" class="btn btn-default hedder-btn btn-lg" onclick="location.href = '<%=link%>'"><%=btnname%></button>
                      
                    </div>
                    </div>
                   
                    
                    </div>
            
        
        
        
        
        <%
        }
        }
            //for unknown users
            else{
            
            
        
        
        %>
         <div class="panel-body text-center panel-info">
            <img src="img/DefaltUser.png" id="userviewpic" style="position:relative;  top:0; left:0;" class="img-circle" width="150px" height="150px">
                        <img src="img/DefaltUserhover.png" id="userviewpichover" style="position:absolute; display:none;   top:30px; left:70px;" class="img-circle" width="150px" height="150px">
                      <br>      
                      <h3 style="font-weight:bold ">Guest</h3>    
                      <br>      
                        
                    <div class="col-md-5">
                        <button class="btn btn-info btn-lg">Profile</button>
                    </div>
                    <div class="col-md-2"></div>
                    <div class="col-md-5">
                        <button type="button" class="btn btn-default hedder-btn btn-lg" onclick="location.href = '<%=link%>'"><%=btnname%></button>
                      
                    </div>
                    
                    </div>
        
        
        
        <%
        }
        %>
        
    </body>
</html>
