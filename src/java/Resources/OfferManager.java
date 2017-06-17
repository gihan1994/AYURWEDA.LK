/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Resources;

import Connection.NewHibernateUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Gihan
 */
public class OfferManager extends HttpServlet {

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
           
            if(request.getParameter("checkid")!=null&&request.getParameter("pidorpn")!=null){
            
            String sql="SELECT\n" +
"    `grn`.`date`\n" +
"    , `grn`.`idGRN`\n" +
"    , `supplier`.`fullName`\n" +
    ", `products`.`ProductName`"+                
    ", `products`.`idProducts`"+                
    " , `grn_has_products`.`IdGRNhasProduct`"+                
"FROM\n" +
"    `grn_has_products`\n" +
"    INNER JOIN `grn` \n" +
"        ON (`grn_has_products`.`GRN_idGRN` = `grn`.`idGRN`)\n" +
"    INNER JOIN `products` \n" +
"        ON (`grn_has_products`.`Products_idProducts` = `products`.`idProducts`)\n" +
"    INNER JOIN `supplier` \n" +
"        ON (`grn`.`Supplier_idSupplier` = `supplier`.`idSupplier`)"
                    + " where qtystatus='1' AND `products`.`status`='1' AND idProducts='"+request.getParameter("pidorpn")+"' OR productname='"+request.getParameter("pidorpn")+"'";
               SQLQuery quary = s.createSQLQuery(sql);
               
                List ll=quary.list();
                if(ll.size()>0){
                    try {
                        
                         JSONArray ja=new JSONArray();
                    for (Object o : ll) {
                        Object oa[]=(Object[])o;
                        JSONObject jo=new JSONObject();
                        jo.put("grnid", oa[1].toString());
                        jo.put("grndate", oa[0].toString());
                        jo.put("grnsup", oa[2].toString());
                        jo.put("pname", oa[3].toString());
                        jo.put("pid", oa[4].toString());
                        jo.put("grnhasp", oa[5].toString());
                        
                      ja.put(jo);
                    }
                    out.print(ja);
                    
                    } catch (Exception e) {
                        System.out.println(e);
                    }
                
                }
                else{
                out.write("0");
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
