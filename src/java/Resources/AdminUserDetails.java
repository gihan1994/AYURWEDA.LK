/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Resources;

import Connection.NewHibernateUtil;
import DB.Login;
import DB.User;
import DB.Usertype;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Gihan
 */
public class AdminUserDetails extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            Session s=NewHibernateUtil.getSessionFactory().openSession();
 Criteria ulogin = s.createCriteria(DB.Login.class);
                List<Login> userml = ulogin.list();
//check request type
            if (request.getParameter("rtype") != null && request.getParameter("rtype").equalsIgnoreCase("allusersdata")) {//for all users

               

                if (userml.size() > 0) {// check users in database
                    out.write("<table class=\"table table-responsive table-bordered\">");
                    out.write("<th class=\"active\">User Name</th>");
                    out.write("<th class=\"active\">Account Type</th>");
                    out.write("<th class=\"active\">View Profile</th>");
                    out.write(" <th class=\"active\">Current Status</th>");
                    out.write(" <th class=\"active\">Status Change</th>");

                    for (Login lmu : userml) { //get all users data
                        out.write("<tr  style=\"text-align:center \">");
                        out.write("<td>" + lmu.getUsername() + "</td>");
                        out.write("<td>" + lmu.getUser().getUsertype().getTypeName() + "</td>");
                        String ipath="img/DefaltUser.png";
                        if(lmu.getUser().getUimg()!=null&&!(lmu.getUser().getUimg().equals(""))){
                        ipath=lmu.getUser().getUimg();
                        }
                        
                        
                        out.write("<td><a href=\"\" data-toggle=\"tab\" data-original-title=\"Click here\"><img onclick=\"window.open('UsersActivity.jsp?lid="+lmu.getIdLogin()+"')\" src=\""+ipath+"\" alt=\"img/DefaltUser.png\"  width=\"30px\" height=\"30px\"></a></td>");
                        if (lmu.getUser().getStatus().equalsIgnoreCase("1")) {

                            out.write("<td class=\"success\" style=\"font-weight:bold \">Active</td>");
                        }
                        if (lmu.getUser().getStatus().equalsIgnoreCase("0")) {

                            out.write("<td class=\"danger\" style=\"font-weight:bold \">Block</td>");

                        }

                        if (lmu.getUser().getStatus().equalsIgnoreCase("1")) {
                            out.write("<td><button class=\"btn btn-danger\" onclick=\"UserStatusChange('" + lmu.getUser().getIdUser() + "','Block')\" >Block</button></td>");
                        }
                        if (lmu.getUser().getStatus().equalsIgnoreCase("0")) {
                            out.write("<td><button class=\"btn btn-success\" onclick=\"UserStatusChange('" + lmu.getUser().getIdUser() + "','Active')\" >Active</button></td>");

                        }
                        out.write("</tr>");
                    }
                    out.write("</table>");

                } else {
                    out.write("<br>");
                    out.write("<br>");
                    out.write("<br>");
                    out.write("<br>");
                    out.write("<h4>No User Available Database</h4>");
                }

            } 
            //for get one user or user type users
            
            else if(request.getParameter("rtype") != null && request.getParameter("rtype").equalsIgnoreCase("oneuser")
                    &&request.getParameter("value") !=null){
                
                Criteria uc=s.createCriteria(DB.User.class);
                
                Login tl=(Login) ulogin.add(Restrictions.eq("username", request.getParameter("value"))).uniqueResult();
                
                Usertype tut=(Usertype)s.createCriteria(DB.Usertype.class)
                        .add(Restrictions.eq("typeName",request.getParameter("value"))).uniqueResult();
                
                if(tl!=null||tut!=null){//check users or user types are available
                  out.write("<table class=\"table table-responsive table-bordered\">");
                    out.write("<th class=\"active\">User Name</th>");
                    out.write("<th class=\"active\">Account Type</th>");
                    out.write("<th class=\"active\">View Profile</th>");
                    out.write(" <th class=\"active\">Current Status</th>");
                    out.write(" <th class=\"active\">Status Change</th>");
                    
                    
                if(tl!=null){//user in login available
                    out.write("<tr  style=\"text-align:center \">");
                        out.write("<td>" +tl.getUsername() + "</td>");
                        out.write("<td>" + tl.getUser().getUsertype().getTypeName() + "</td>");
                        out.write("<td><a href=\"#\" data-toggle=\"tab\" data-original-title=\"Click here\"><img on src=\"img/myg.jpg\" alt=\"userImgdefaultjpg.jpg\"  width=\"30px\" height=\"30px\"></a></td>");
                        if (tl.getUser().getStatus().equalsIgnoreCase("1")) {

                            out.write("<td class=\"success\" style=\"font-weight:bold \">Active</td>");
                        }
                        if (tl.getUser().getStatus().equalsIgnoreCase("0")) {

                            out.write("<td class=\"danger\" style=\"font-weight:bold \">Block</td>");

                        }

                        if (tl.getUser().getStatus().equalsIgnoreCase("1")) {
                            out.write("<td><button class=\"btn btn-danger\" onclick=\"UserStatusChange('" + tl.getUser().getIdUser() + "','Block')\" >Block</button></td>");
                        }
                        if (tl.getUser().getStatus().equalsIgnoreCase("0")) {
                            out.write("<td><button class=\"btn btn-success\" onclick=\"UserStatusChange('" + tl.getUser().getIdUser() + "','Active')\" >Active</button></td>");

                        }
                        out.write("</tr>");
                    
                    
                
                }
                if(tut!=null){//types available
                
                    List<User> utl=uc.add(Restrictions.eq("usertype", tut)).list();
                    
                   if(utl.size()>0){
                   for(User mu:utl){

                   Login forl=(Login) s.createCriteria(DB.Login.class).add(Restrictions.eq("user", mu)).uniqueResult();
                    if(forl!=null){
                                              
                        
                    out.write("<tr  style=\"text-align:center \">");
                        out.write("<td>" +forl.getUsername() + "</td>");
                        out.write("<td>" + forl.getUser().getUsertype().getTypeName() + "</td>");
                        out.write("<td><a href=\"#\" data-toggle=\"tab\" data-original-title=\"Click here\"><img on src=\"img/myg.jpg\" alt=\"userImgdefaultjpg.jpg\"  width=\"30px\" height=\"30px\"></a></td>");
                        if (forl.getUser().getStatus().equalsIgnoreCase("1")) {

                            out.write("<td class=\"success\" style=\"font-weight:bold \">Active</td>");
                        }
                        if (forl.getUser().getStatus().equalsIgnoreCase("0")) {

                            out.write("<td class=\"danger\" style=\"font-weight:bold \">Block</td>");

                        }

                        if (forl.getUser().getStatus().equalsIgnoreCase("1")) {
                            out.write("<td><button class=\"btn btn-danger\" onclick=\"UserStatusChange('" + forl.getUser().getIdUser() + "','Block')\" >Block</button></td>");
                        }
                        if (forl.getUser().getStatus().equalsIgnoreCase("0")) {
                            out.write("<td><button class=\"btn btn-success\" onclick=\"UserStatusChange('" + forl.getUser().getIdUser() + "','Active')\" >Active</button></td>");

                        }
                        out.write("</tr>");
                    }
                      
                   
                   
                   }
                   
                   
                   } 
                    
                
                }
                
                 out.write("</table>");
                
                }else{ //not data
             
                    
                  out.write("<div class=\"panel panel-body panel-default\">");
                    out.write("<br>");
                    out.write("<h5  style=\"color: red\">No User Available Database</h5>");
                out.write("  </div>");
                
                }
               
                
                
            
            }
            
            
            else {
            out.write("<div class=\"panel panel-body panel-default\">");
                    out.write("<br>");
                    out.write("  <h5>No Select Details Yet</h5>");
                out.write("  </div>");

            }
            
           
            
            

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
