<%-- 
    Document   : Admin_Usesr
    Created on : Oct 12, 2016, 12:41:25 AM
    Author     : Gihan
--%>

<%@page import="DB.Login"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="DB.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<script>

//   var stype="all"; 
//
  

    function getLcount() {
        var xhttp = new XMLHttpRequest();

        xhttp.onreadystatechange =
                function() {
                    if (xhttp.readyState === 4 && xhttp.status === 200) {


                        var counters = xhttp.responseText;
                        var jdata=JSON.parse(counters);

                        document.getElementById("vcount").innerHTML = jdata.vcount;
                        document.getElementById("lcount").innerHTML = jdata.lcount;
                        document.getElementById("aucount").innerHTML = jdata.ausers;
                        document.getElementById("bcount").innerHTML = jdata.busers;

                    }


                };

        xhttp.open("GET", "UserCountManager?rtype=usercount", true);
        xhttp.send();

    }

    $(document).ready(function (){
        $('#usercountdata').ready(function (){
            setInterval(function() {
        getLcount();

    }, 1000);
            
        });
        
    });

    function UserStatusChange(uid, status) {
        var usstatus = "";

        if (status === 'Block') {
            usstatus = "0";
        }
        if (status === 'Active') {
            usstatus = "1";
        }

              var url="UserManagement?changeUserStatus=" + usstatus + "&changeUserStatusId=" + uid + "";  
        $.ajax({
    url: url, 
    cache: false, 
    success: function(response) {
        
         $($.parseHTML(response)).filter("#myModal").modal(); 
      
           setTimeout(function(){ 
      
             $('#myModal').hide();
                $('.modal-backdrop').hide();
          
             if(stype==="all"){
                   getallusers("allusersdata");
                   
               }
               if(stype==="one"){
                   
                    getallusers("oneuser"); 
               }
                
           }, 2000); 
           
          $($.parseHTML(response)).filter("#myModal").html('');  
      
    }
    
});
    

    }

   

    function getallusers(status) {
        var xhttp1 = new XMLHttpRequest();
        
        var url="AdminUserDetails?rtype="+status;    
        stype="all";
        if(status==="oneuser"){
            
            url+="&value="+document.getElementById("typevalue").value;
            stype="one";
        }
        
        xhttp1.onreadystatechange =
                function() {
                    if (xhttp1.readyState === 4 && xhttp1.status === 200) {

                        document.getElementById("usersdetails").innerHTML = xhttp1.responseText;

                    }


                };

        xhttp1.open("GET", url, true);
        xhttp1.send();


    }


</script>




<div class="row" style="color:#009900;font-weight:bold ">
    <br>
    <br>

</div>           
<div class="row" id="webusers">

    <!--users-->

    <%
        Criteria adminusr = NewHibernateUtil.getSessionFactory().openSession().
                createCriteria(DB.User.class);


    %> 

    <div class="col-md-6" id="usercountdata">
        <ul class="list-group">
            <li class="list-group-item active">
                <h4><strong> Web Site Users Details</strong></h4>
            </li>
            <li class="list-group-item">
                <span class="badge" style="background-color:#ff3300">

                    <%                                    out.print(adminusr.list().size());

                    %>    
                </span>
                <h5><strong>Web Site Sign up Users Count</strong></h5>
            </li>
            <li class="list-group-item">
                <span class="badge" style="background-color:#ff3300" id="aucount">
                      

                </span>
                <h5><strong>Web Site Active Users Count</strong></h5>
            </li>
            <li class="list-group-item">
                <span class="badge" style="background-color:#ff3300" id="bcount">
                
                </span>
                <h5><strong>Web Site Block Users Count</strong></h5>
            </li>
            <li class="list-group-item">
                <span class="badge" style="background-color:#ff3300 " id="lcount">14</span>
                <h5><strong> Web Site Current Login Users Count</strong></h5>
            </li>
            <li class="list-group-item">
                <span class="badge" style="background-color:#ff3300" id="vcount">14</span>
                <h5><strong> Web Site Current viewed Users Count</strong></h5>
            </li>

        </ul>

    </div>
    <div class="col-md-6">

        <!--pie chart in here-->
    </div>



</div>

<div class="row">
    <br>
    <br>

</div>  
<div class="row">
    <!--signup users-->

    <div class="col-md-2"></div>
    <div class="col-md-8">
        <div class="row"> 
            <ul class="nav nav-tabs nav-justified">
                <li role="presentation" class="active"><h4><strong>Sign up Users Status</strong></h4></li>
                <li role="presentation" ><div class="input-group">
                        <input type="text" class="form-control" id="typevalue" placeholder="Enter User Name or Type">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" onclick="getallusers('oneuser')">Go!</button>
                        </span>
                    </div></li>
                <li role="presentation" class="active"><button class="btn btn-info btn-sm" type="button" onclick="getallusers('allusersdata')">View All</button></li>        
            </ul>
        </div> 
        
        <div class="row">
        <div class="col-12" id="usersdetails">
            <div class="panel panel-body panel-default">
                
                <br>
                <h5>No Select Details Yet</h5>
            </div>

        </div>



        </div>
    </div>
    <div class="col-md-2"></div>



</div>
