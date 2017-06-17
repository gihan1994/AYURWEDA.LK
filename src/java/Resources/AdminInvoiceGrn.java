/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Resources;

import Connection.NewHibernateUtil;
import DB.Grn;
import DB.Invoice;
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
public class AdminInvoiceGrn extends HttpServlet {

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
           
            //get invoice Data
            if(request.getParameter("invodata")!=null){
                Criteria invc=s.createCriteria(DB.Invoice.class);
                if(request.getParameter("invoid")!=null){
                invc.add(Restrictions.eq("idInvoice", new Integer(request.getParameter("invoid"))));
                
                }
              if(invc.list().size()>0){
                  out.print(" <table class=\"table table-bordered\">");
                  out.print("<th>InvoiceID</th>");
                  out.print(" <th>User</th>");
                  out.print("<th>Total Amount</th>");
                  out.print("<th>Date OF Issued</th>");
                  out.print("<th>Option</th>");
                  for(Invoice ii:(List<Invoice>)invc.list()){
                  out.print("  <tr>");
                  out.print(" <td>"+ii.getIdInvoice()+"</td>");
                  out.print("<td>"+ii.getUser().getFname()+" "+ii.getUser().getLname()  +"</td>");
                  out.print("   <td> Rs."+ii.getTotal()+"</td>");
                  out.print(" <td>"+new SimpleDateFormat("yyyy-MM-dd").format(ii.getDate())+"</td>");
                   out.write(" <td><button type='button' class='btn btn-info btn-sm' onclick=\"invoModel('"+ii.getIdInvoice()+"')\">View</button></td>");
                  out.print("  </tr>");
                  }
                  out.print("  </table>");
               
                  
              } else{
              
              out.print("No Invoices");
              } 
                
                
            }
            if(request.getParameter("Grndata")!=null){
             Criteria grn=s.createCriteria(DB.Grn.class);
                if(request.getParameter("grnid")!=null){
                grn.add(Restrictions.eq("idGrn", new Integer(request.getParameter("grnid"))));
                
                }
              if(grn.list().size()>0){
                  out.print(" <table class=\"table table-bordered\">");
                  out.print("<th>GRNID</th>");
                  out.print(" <th>Supplier</th>");
                  out.print("<th>Total Amount</th>");
                  out.print("<th>Date OF Issued</th>");
                  out.print("<th>Option</th>");
                  for(Grn ii:(List<Grn>)grn.list()){
                  out.print("  <tr>");
                  out.print(" <td>"+ii.getIdGrn()+"</td>");
                  out.print("<td>"+ii.getSupplier().getFullName()+"</td>");
                  out.print("   <td> Rs."+ii.getTotal()+"</td>");
                  out.print(" <td>"+new SimpleDateFormat("yyyy-MM-dd").format(ii.getDate())+"</td>");
                   out.write(" <td><button type='button' class='btn btn-info btn-sm' onclick=\"grnModel('"+ii.getIdGrn()+"')\">View</button></td>");
                  out.print("  </tr>");
                  }
                  out.print("  </table>");
               
                  
              } else{
              
              out.print("No Grn");
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
