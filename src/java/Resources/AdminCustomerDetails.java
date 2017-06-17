 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Resources;

import Connection.NewHibernateUtil;
import DB.Invoice;
import DB.Login;
import DB.Logintimes;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
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
public class AdminCustomerDetails extends HttpServlet {

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
            if(request.getParameter("userid")!=null){
            
            Login l=(Login) s.createCriteria(DB.Login.class)
                    .add(Restrictions.eq("idLogin",new Integer(request.getParameter("userid")) )).uniqueResult();
            
            if(l!=null){
            Criteria ult=s.createCriteria(DB.Logintimes.class).add(Restrictions.eq("login", l));
            Criteria uinvo=s.createCriteria(DB.Invoice.class).add(Restrictions.eq("user", l.getUser()));
            
            if(ult!=null&&uinvo!=null){
            
                out.write(" <table class='table table-responsive table-bordered'>");
                out.write("<th width='25%'>Login Times</th>");
                out.write(" <th width='75%'>Purchasing Details</th>");
                out.write("<tr>");
                
                out.write("<td>");
                if(ult.list().size()>0){
                out.write("<table class='table table-responsive'>");
                out.write("<th>Date</th>");
                out.write("<th>From</th>");
                out.write("<th>To</th>");
                
                    for (Logintimes ulti : (List<Logintimes>)ult.list()) {
                        
                        if(ulti!=null){
                        out.write("<tr>");
                         out.write("<td>"+new SimpleDateFormat("yyyy-MM-dd").format(ulti.getLogdate())+"</td>");
                         out.write("<td>"+new SimpleDateFormat("hh:mm a").format(ulti.getIntime())+"</td>");
                         if(ulti.getOuttime()!=null){
                          out.write("<td>"+new SimpleDateFormat("hh:mm a").format(ulti.getOuttime())+"</td>");
                         }
                        
                          out.write("</tr>");
                        }
                       
                    }
                    
                
                out.write(" </table>");
                
                }else{
                
                 out.write("  <h5>No Login Times </h5>");
                }
                
                out.write("</td>");
                
                out.write("<td>");
                if(uinvo.list().size()>0){
                 out.write("<table class='table table-responsive'>");
                out.write(" <th>Invoice id</th>");
                out.write("<th>Total Amount</th>");
                out.write("<th>Paid Date</th>");
                out.write("<th>Option</th>");
                
                
                
                for(Invoice uinvoi:(List<Invoice>)uinvo.list()){
                out.write(" <tr>");
                out.write(" <td>"+uinvoi.getIdInvoice()+"</td>");
                out.write(" <td>"+uinvoi.getTotal()+"</td>");
                out.write(" <td>"+new SimpleDateFormat("yyyy-MM-dd").format(uinvoi.getDate()).toString()+"</td>");
                out.write(" <td><button type='button' class='btn btn-info btn-sm' onclick=\"viewModelInvoice('"+uinvoi.getIdInvoice()+"')\">View</button></td>");
                out.write("</tr>");
                
                }
                
                out.write("</table>");
                }else{
                
                 out.write("  <h5>No Purchesing History </h5>");
                }
                 out.write("</td>");
                 
                out.write(" </tr> ");
                out.write(" </table> ");
 
            
                
                
            
            }
            
            
            }else{
            
              out.write("  <h5>No Customer's Detail Found</h5>");
            
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
