
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Resources;

import Connection.NewHibernateUtil;
import DB.LoginActivity;
import DB.Logintimes;
import DB.LogintimesHasPage;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Gihan
 */
public class UserActivityManager extends HttpServlet {

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
        
            Session s=NewHibernateUtil.getSessionFactory().openSession();
            
//============= get user avtivity data===========================================
            
           if(request.getParameter("ltid")!=null){
               Logintimes lt=(Logintimes) s.createCriteria(DB.Logintimes.class)
                       .add(Restrictions.eq("idLoginTimes", new Integer(request.getParameter("ltid")))).uniqueResult();
               if(lt!=null){
                 Criteria lthpc=s.createCriteria(DB.LogintimesHasPage.class).add(Restrictions.eq("logintimes", lt));
                   LoginActivity la=(LoginActivity) s.createCriteria(DB.LoginActivity.class).add(Restrictions.eq("logintimes", lt)).uniqueResult();
                 
                   out.write(" <div class=\"panel panel-danger\">");
                     out.write(" <div class=\"panel-heading\"><strong><h4>User All Activities</h4></strong></div>");
                     out.write(" <div class=\"panel-body\">");
                     
                     String intime="Not Login";
                     String outtime="online";
                      if(lt.getIntime()!=null){
                                   intime=new SimpleDateFormat("hh:mm a").format((Date)lt.getIntime());
                     }
                      if(lt.getOuttime()!=null){
                                   outtime=new SimpleDateFormat("hh:mm a").format((Date)lt.getOuttime());
                     }
                     out.write("<strong><h5 style=\"font-weight:bold \">Time:&nbsp;"+intime+"&nbsp; To &nbsp; "+outtime+"</h5></strong>");
                     out.write(" <div class=\"panel panel-default\">");
                     out.write("<div class=\"panel-heading\">Accessed Pages</div>");
                     out.write("<div class=\"panel-body\">");
                 
                 if(lthpc!=null){
                     List<LogintimesHasPage> lthpl=lthpc.list();
                   if(lthpl.size()>0){
                     
                     out.write(" <table class=\"table table-responsive table-bordered\">");
                     out.write(" <th>No</th>");
                     out.write("  <th>Page Name</th>");
                     out.write(" <th>Accessed Time</th>");
                     out.write(" <th>Access Count</th>");
                     
                     
 
                     int no=1;
                     for (LogintimesHasPage lthpi : lthpl) {
                         
                         out.write("<tr>");
                     out.write("<td>"+no+"</td>");
                     out.write("<td>"+lthpi.getPage().getName()+"</td>");
                     out.write("<td>"+new SimpleDateFormat("hh:mm a").format(lthpi.getViewTime()).toString()+"</td>");
                     out.write("<td>"+lthpi.getAccCount()+"</td>");
                     out.write("</tr>");
                         
                     no++;
                     }
                    out.write("</table>");
                   }else{
                    out.write("<h5>User had not accessed pages at that time</h5>");
                   }
                 }else{
                 
                 out.write("<h5>No Login Time Accessed Pages</h5>");
                 
                 }
                 
                   out.write(" </div>");
                   out.write(" </div>");
                   
                   
                   out.write("  <div class=\"panel panel-success\">");
                   out.write(" <div class=\"panel-heading\">What did user do at that time?</div>");
                   out.write("   <pre>");
                   if(la!=null){
                    
                       String[] des=la.getDescription().split("/");
                       
                       int no=1;
                       for(String ai:des){
                           out.write(no+" "+ai+".<br>");
                       
                       
                           no++;
                       }
                       
                   
                   }else{
                     out.write("User Didn't Do anythig at that time");
                   
                   }
                  
                   out.write(" </pre>");
                   out.write("   </div>");
                   out.write("   </div>");
                   out.write("   </div>");
                   out.write("   </div>");
                   
                 
                         
                         
               }
             
               
               
           
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
