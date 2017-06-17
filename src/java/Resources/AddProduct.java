/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Resources;

import Connection.NewHibernateUtil;
import DB.Brands;
import DB.PCatergory;
import DB.Products;
import DB.ProductsHasBrands;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Gihan
 */
public class AddProduct extends HttpServlet {

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
            Session s = NewHibernateUtil.getSessionFactory().openSession();
           
            try {

                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                Products p = new Products();
                String bname="";

                List list = upload.parseRequest(request);

                
                
                for (Object object : list) {
                    FileItem fileItem = (FileItem) object;

                    if (fileItem.isFormField()) {
                        if (fileItem.getFieldName().equals("pname")) {
                            System.out.println(fileItem.getString());
                            p.setProductName(fileItem.getString());
                        }
                        if (fileItem.getFieldName().equals("pdescrip")) {
                            System.out.println(fileItem.getString());
                            p.setDescription(fileItem.getString());
                        }
                        if (fileItem.getFieldName().equals("puprice")) {
                            System.out.println(fileItem.getString());
//                            p.setUniqPrice(new Double(fileItem.getString()));
                        }
                        if (fileItem.getFieldName().equals("pcat")) {
                            System.out.println(fileItem.getString());

                          p.setPCatergory((PCatergory) s.createCriteria
      (DB.PCatergory.class).add(Restrictions.eq("idPCatergory", new Integer(fileItem.getString()))).uniqueResult());

                        }
                        if (fileItem.getFieldName().equals("pbrand")) {
                            System.out.println(fileItem.getString());
                        
                            bname=fileItem.getString();
                            
              
                            System.out.println(bname);
                            
                            
                        }
                        if (fileItem.getFieldName().equals("pstatus")) {
                            System.out.println(fileItem.getString());
                            
                            
                        }
                    } else {

                        if (fileItem.getFieldName().equals("pimg")&&fileItem.getName()!=null) {
                            String thumb = "ProductImg/" + Math.random() + fileItem.getName();
                            System.out.println(thumb);
                            File f = new File(getServletContext().getRealPath("/") + thumb);

                            fileItem.write(f);

                            p.setImg(thumb);
                            
                        }

                    }
                }
                p.setTolQty(0);
                p.setStatus(1);
                s.save(p);
                 s.flush();
                 s.beginTransaction().commit();
                              if(bname!=null){
                 Brands pbrand=(Brands) s.createCriteria(DB.Brands.class).
                              add(Restrictions.eq("idBrands", new Integer(bname))).uniqueResult();
                            
                 if(pbrand!=null){
                  ProductsHasBrands phb=new ProductsHasBrands();
                            phb.setIdProductBrand(1);
                            
                            phb.setBrands(pbrand);
                            phb.setProducts(p);
                            phb.setRating(0.0);
                            phb.setStatus("1");
                            
                            s.save(phb);
                 
                 s.flush();
                 s.beginTransaction().commit();
                 }
                 
                           
                
                }
                
                
                    
                   
                    response.sendRedirect("AdminPanel.jsp");
                
            } catch (Exception e) {
                System.out.println(e);
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
