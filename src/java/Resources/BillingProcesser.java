/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Resources;

import Connection.NewHibernateUtil;
import DB.Brands;
import DB.Login;
import DB.PCatergory;
import DB.Products;
import DB.ProductsHasBrands;
import DB.Shippingorder;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Gihan
 */
public class BillingProcesser extends HttpServlet {

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
            Login l=(Login) s.createCriteria(DB.Login.class).add(Restrictions.eq("username", request.getSession().getAttribute("username"))).uniqueResult();
         
            try {
                
             FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                boolean shipstatus=false;
                Shippingorder so=(Shippingorder) s.createCriteria(DB.Shippingorder.class).add(Restrictions.eq("user", l.getUser())).uniqueResult();
                if(so==null){
                shipstatus=true;    
                so=new Shippingorder();
                }
                
                List list = upload.parseRequest(request);
                
                
                String cardno="";
                String cardscode="";
                String cardtype="";
                
                for (Object object : list) {
                    FileItem fileItem = (FileItem) object;

                    if (fileItem.isFormField()) {
                        if (fileItem.getFieldName().equals("rname")) {
                            System.out.println(fileItem.getString());
                            so.setRecieverName(fileItem.getString());
                        }
                        if (fileItem.getFieldName().equals("rstr1")) {
                            System.out.println(fileItem.getString());
                            so.setStreet1(fileItem.getString());
                        }
                        if (fileItem.getFieldName().equals("rstr2")) {
                            System.out.println(fileItem.getString());
                             so.setStreet2(fileItem.getString());
                        }
                        if (fileItem.getFieldName().equals("rcity")) {
                            System.out.println(fileItem.getString());
                            so.setCity(fileItem.getString());
                        }
                        if (fileItem.getFieldName().equals("rpcode")) {
                             so.setPostalcode(fileItem.getString());


                        }
                        if (fileItem.getFieldName().equals("remail")) {
                            System.out.println(fileItem.getString());
                        
                             l.getUser().setEmail(fileItem.getString());
                            
                        }
                        if (fileItem.getFieldName().equals("rtel")) {
                            System.out.println(fileItem.getString());
                            
                             l.getUser().setTel(fileItem.getString());
                        }
                        if (fileItem.getFieldName().equals("rcardno")) {
                            System.out.println(fileItem.getString());
                            
                             cardno=fileItem.getString();
                        }
                        if (fileItem.getFieldName().equals("rcardscode")) {
                            System.out.println(fileItem.getString());
                            
                            cardscode=fileItem.getString();
                        }
                        if (fileItem.getFieldName().equals("rctype")) {
                            System.out.println(fileItem.getString());
                            
                            cardtype=fileItem.getString();
                        }
                    } else {

                       

                    }
                }
              
                s.update(l);
               s.flush();
                 s.beginTransaction().commit();
                
                //is new adding
                if(shipstatus){
                 s.save(so);
                 s.flush();
                 s.beginTransaction().commit();
                }
                //update due to existing ship details 
                else{
                s.update(so);
                 s.flush();
                 s.beginTransaction().commit();
                }
               
                
                
            } catch (Exception ex) {
                Logger.getLogger(BillingProcesser.class.getName()).log(Level.SEVERE, null, ex);
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
