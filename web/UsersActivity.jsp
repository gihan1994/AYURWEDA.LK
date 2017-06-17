<%-- 
    Document   : UsersActivity
    Created on : Nov 9, 2016, 11:44:57 AM
    Author     : Gihan
--%>

<%@page import="Resources.PrevilageCheck"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="DB.Logintimes"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page import="DB.Login"%>
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
        
            <script>
                
                function getActivityData(ltid){
                       var xhttp = new XMLHttpRequest();

        xhttp.onreadystatechange =
                function() {
                    if (xhttp.readyState === 4 && xhttp.status === 200) {

                        document.getElementById("useractivities").innerHTML=xhttp.responseText;

                    }


                };

        xhttp.open("GET", "UserActivityManager?ltid="+ltid, true);
        xhttp.send();
                    
                    
                }
                
                
                
            </script>
            
            
    </head>
    <body>
        
        
         
      <%

     
            if(request.getSession().getAttribute("username")!=null){
                PrevilageCheck precheck=new PrevilageCheck();
                
                    if(precheck.checkManager(request.getSession().getAttribute("username").toString(),
                        request.getRequestURL().toString(),"View UserActivity Button")){
                    
                    
           
      
      
      %> 
        
       <br>
    <center><h2 class="h2" style="color: #330033;font-weight:bold ">User Activity Profile</h2></center>
       
       <%
           if(request.getParameter("lid")!=null){
       Session s=NewHibernateUtil.getSessionFactory().openSession();
       Login l=(Login)s.createCriteria(DB.Login.class)
               .add(Restrictions.eq("idLogin", new Integer(request.getParameter("lid")))).uniqueResult();
       
       if(l!=null){
       
       %>
       
       
       <div class="container" style="color:#660000;">
            <div class="row">
                <div class="col-md-4">
                    <div class="col-md-1"></div>
                    <div class="col-md-6">
                        <h4 style="color:#999999 ">   User Name :</h4>
                    </div> 
                    <div class="col-md-4">
                        <strong><h4><%=
                        l.getUsername()
                        %></h4></strong>
                    </div> 
                    <div class="col-md-1"></div>
                </div>
                <div class="col-md-4">
                      <div class="col-md-6">
                        <h4 style="color:#999999">   Full Name :</h4>
                    </div> 
                    <div class="col-md-6">
                         <strong><h4><%
                       out.print(l.getUser().getFname()+" "+l.getUser().getLname());
                        %></h4></strong>
                    </div> 
                </div>
                <div class="col-md-4">
                      <div class="col-md-6">
                         <h4 style="color:#999999">   Date of Joined :</h4>
                    </div> 
                    <div class="col-md-6">
                           <strong><h4><%
                        out.print(new SimpleDateFormat("yyyy-MM-dd").format(l.getUser().getSignDate()).toString());
                        %></h4></strong>
                    </div> 
                </div>
                
            </div>
                    <div class="row" >
                <div class="panel panel-body panel-default" >
                    <div class="col-md-5">
                              <div class="panel panel-info" style="max-height:600px;overflow:auto;  ">
                        <div class="panel-heading "><strong><h4>Login Times</h4></strong></div>
                        <div class="panel-body">
                            <%
                            Criteria ltc=s.createCriteria(DB.Logintimes.class).add(Restrictions.eq("login", l));
                            
                            if(ltc!=null){
                            List<Logintimes> ltl=ltc.list();
                            %>
                            
                            <h5>Total Login Count :&nbsp; <span class="badge" style="background-color:#ff3300;color:#ffffff"><%
                            out.print(ltl.size()+"");
                            %></span></h5>
                            <table class="table table-bordered table-scroll">
                                
                                
                                <th>Date</th>
                                <th>Login Time</th>
                                <th>Logout Time</th>
                                <th>Option</th>
                            <% for(Logintimes lti:ltl){
                                if(lti!=null){%>
                                <tr>
                                    <td><%
                                    out.print(new SimpleDateFormat("yyyy-MM-dd").format((Date)lti.getLogdate()));
                                    %></td>
                                    <td><%
                                    if(lti.getIntime()!=null){
                                    out.print(new SimpleDateFormat("hh:mm a").format((Date)lti.getIntime()));
                                    }else{
                                    out.print("No Login");
                                    }
                                    
                                    %></td>
                                    <td><%
                                     if(lti.getOuttime()!=null){
                                    out.print(new SimpleDateFormat("hh:mm a").format((Date)lti.getOuttime()));
                                    }else{
                                    out.print("online");
                                    }
                                    %></td>
                                    <td><button class="btn btn-default btn-sm" type="button" onclick="getActivityData(<%= lti.getIdLoginTimes() %>)">More</button></td>
                                </tr>
                                <%
                                    }
                            }
                                %>
                            </table>
                            <%
                            }else{
                            out.print("<h5>User has No Login Times</h5>");
                            }
                             
                            
                            %>
                        </div>
                    </div>
                    
                    </div>
                    <div class="col-md-7" id="useractivities">
         
                        
                        <h5 style="color:#660000 ">A Specific Login Time has not Selected</h5>
                        
                    </div>
                    
              
                    
                </div>
                
            </div>
            
            
        </div>
        
        
      <%
           }
           }
           
          
      %>  
        
       <%
                
                        }else{//no permission
                    
                    
                    response.sendRedirect("Home.jsp");
                    }
            
            
            
            }else{//user is not sign no permision
            
            response.sendRedirect("Home.jsp");
                
            }
       
       %>
      
    </body>
</html>
