<%-- 
    Document   : AdminAccount
    Created on : Mar 15, 2017, 11:07:20 AM
    Author     : Gihan
--%>

<%@page import="DB.Login"%>
<%@page import="DB.User"%>
<%@page import="DB.UsertypeHasPage"%>
<%@page import="DB.Usertype"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="java.util.List"%>
<%@page import="DB.Page"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script>
    function AdminChanges(task,remoid){

         var url="AdminAccount.jsp?";
        if(task=="addadmin"){
          var loginid = $('#undrop').find('option:selected').val();
        url+="task=addadmin" 
        if(loginid!=null){
            url+="&idlogin="+loginid;
        }    
        }
        if(task=="removeadmin"){
         url+="task=removeadmin&idlogin="+remoid;    
            
        }
          
        
         var xhttp2 = new XMLHttpRequest();
        xhttp2.onreadystatechange = function() {// 

            if (xhttp2.readyState === 4 && xhttp2.status === 200) {
                 $("#adacccontent").hide().html(xhttp2.responseText).fadeIn('slow');
            }
        };
        xhttp2.open("GET", url, true);

        xhttp2.send();
    }
    
</script>


<%
Session s=NewHibernateUtil.getSessionFactory().openSession();
 Login userlog=(Login)s.createCriteria(DB.Login.class).add(Restrictions.eq("username", request.getSession().getAttribute("username"))).uniqueResult();

 // Add and remove admins for the Admin Account access
 
if(request.getParameter("task")!=null&&request.getParameter("idlogin")!=null){
    Login updlog=(Login)s.load(DB.Login.class, new Integer(request.getParameter("idlogin")));
    if(request.getParameter("task").equals("addadmin")){
       Usertype ust=(Usertype)s.load(DB.Usertype.class, 1);
   
    if(updlog!=null){
     User u=updlog.getUser();
        u.setUsertype(ust);
        s.update(u);
        s.flush();
        s.beginTransaction().commit();
    }   
    }
   if(request.getParameter("task").equals("removeadmin")){
       Usertype ust=(Usertype)s.load(DB.Usertype.class, 2);
   
    if(updlog!=null){
     User u=updlog.getUser();
        u.setUsertype(ust);
        s.update(u);
        s.flush();
        s.beginTransaction().commit();
    }   
    }
    
} 

%>

<div id="adacccontent">
  <div class="panel-primary ">
    <div class="panel-heading">
        <h3>Admin Account Settings</h3>
    </div>
      <div class="panel-body" >
        
        
       <%
      
      if(userlog!=null){
       if(userlog.getUser().getUsertype().getTypeName().equals("SuperAdmin")){   
      
       %>
        <h5 style="margin-left:250px;font-weight: bold;margin-top:20px ">Set Admin Accesses</h5>
        <div style="margin-left:300px;margin-right:300px  " >
            
            <%
              Usertype aust=(Usertype)s.load(DB.Usertype.class, 1);
               if(aust.getUsers().size()>0){
            %>
            <table class="table table-bordered">
                <th>Username</th>
                <th>Options</th>
                <%
               for(User u:aust.getUsers()){%>
                <tr>
                    <td>
                     <%
                   int logid=0;
                     for(Login l:u.getLogins()){out.print(l.getUsername());logid=l.getIdLogin();}
                     %>   
                    </td>
                    <td>
                        <button class="btn btn-sm btn-danger" type="button" onclick="AdminChanges('removeadmin',<%=logid%>)">Remove</button>
                    </td>
                </tr>
                <% } 
      
                %>
            </table>
            <%
             }else{
                   out.print("No Other Admins");
               }
            %>
            <select class="form-control" id="undrop">
                <option selected disabled>Select User Name</option>
                <%
                for(Login lname:(List<Login>)s.createCriteria(DB.Login.class).list()){
                    if(!(lname.getUser().getUsertype().getTypeName().equals("SuperAdmin"))){
                
                %>
                <option value="<%=lname.getIdLogin()%>">
                    <%
                    out.print(lname.getUsername());
                    %>
                </option>
                <%}}%>
            </select>
            <button class="btn btn-primary" style="margin-top:20px " type="button" onclick="AdminChanges('addadmin',0)">ADD</button>
        </div>
          <%
      }}
          %>  
            
    </div>
</div>
<div class="panel-info">
    <div class="panel-heading">
        <h3>Privilege Management</h3>
    </div>
    <div class="panel-body">
        <table class="table table-bordered">
            <th>Privilege Owner</th>
            <th>Add More Privileges</th>
            <tr>
                <td style="font-size:18px;font-weight: bold;color: #ff3300">Admin</td>
                <td>
                    <ul>
                        <%
                        for(Page pages:(List<Page>)s.createCriteria(DB.Page.class).list()){
                            Usertype ut=(Usertype)s.load(DB.Usertype.class,1);
                            
                            UsertypeHasPage uthp=(UsertypeHasPage)s.createCriteria(DB.UsertypeHasPage.class).add(Restrictions.and
                            (Restrictions.eq("usertype", ut), Restrictions.eq("page", pages))).uniqueResult();
                            String status="";
                            if(uthp!=null){
                            status="checked";
                            }
                            
                        %>
                        
                        <li style="color: #009900;font-weight: bold">
                            
                            <%=pages.getName()  %>
                        </li>
                        
                        <% }
                        
                        %>
                    </ul>
                </td>
            </tr>
            <tr>
                <td style="font-size:18px;font-weight: bold;color: #ff3300">Customer</td>
                <td>
                 <ul>
                        <%
                        for(Page pages:(List<Page>)s.createCriteria(DB.Page.class).list()){
                            Usertype ut=(Usertype)s.load(DB.Usertype.class,2);
                            
                            UsertypeHasPage uthp=(UsertypeHasPage)s.createCriteria(DB.UsertypeHasPage.class).add(Restrictions.and
                            (Restrictions.eq("usertype", ut), Restrictions.eq("page", pages))).uniqueResult();
                            String status="";
                            if(uthp!=null){
                            status="checked";
                            }
                            
                        %>
                        
                        <li>
                            
                            <%=pages.getName()  %><input type="checkbox" class="form-control"  <%=status%>>
                        </li>
                        
                        <% }
                        
                        %>
                    </ul>
                </td>
            </tr>
        </table>
    </div>
</div>  
</div>


