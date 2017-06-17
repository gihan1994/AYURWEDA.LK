/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Resources;

import Connection.NewHibernateUtil;
import DB.Login;
import DB.Shippingorder;
import DB.User;
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
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Gihan
 */
public class UserViewProfile extends HttpServlet {

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

            Session s = NewHibernateUtil.getSessionFactory().openSession();
            if (request.getSession().getAttribute("username") != null) {
                Login l = (Login) s.createCriteria(DB.Login.class)
                        .add(Restrictions.eq("username", request.getSession().getAttribute("username"))).uniqueResult();
                
               
                boolean isunpwchange = false;

              

                if (l != null) {
                    User u = (User) s.createCriteria(DB.User.class)
                            .add(Restrictions.eq("idUser",l.getUser().getIdUser())).uniqueResult();
                    if(u != null){
                        System.out.println(u.getIdUser());
  Shippingorder shpo = (Shippingorder) s.createCriteria(DB.Shippingorder.class)
                        .add(Restrictions.eq("user", u)).uniqueResult();
                Shippingorder shpon = new Shippingorder();
                    try {

                        FileItemFactory factory = new DiskFileItemFactory();
                        ServletFileUpload upload = new ServletFileUpload(factory);

                        List list = upload.parseRequest(request);

                        for (Object object : list) {
                            FileItem fileItem = (FileItem) object;

                            if (fileItem.isFormField()) {

                                if (fileItem.getFieldName().equals("uname")) {
                                    System.out.println(fileItem.getString());
                                    if ((!(fileItem.getString().equals("")))&&(!(fileItem.getString().equals(null)))) {
                                        if (!(fileItem.getString().equals(l.getUsername()))) {
                                            l.setUsername(fileItem.getString());
                                            isunpwchange = true;
                                        }

                                    }

                                }
                                if (fileItem.getFieldName().equals("fname")) {
                                    System.out.println(fileItem.getString());
                                    if ((!(fileItem.getString().equals("")))&&(!(fileItem.getString().equals(null)))) {
                                    u.setFname(fileItem.getString());
                                    }
                                    

                                }
                                if (fileItem.getFieldName().equals("lname")) {
                                    System.out.println(fileItem.getString());
                                    if ((!(fileItem.getString().equals("")))&&(!(fileItem.getString().equals(null)))) {
                                    }
                                    u.setLname(fileItem.getString());

                                }
                                if (fileItem.getFieldName().equals("utel")) {
                                    if ((!(fileItem.getString().equals("")))&&(!(fileItem.getString().equals(null)))) {
                                    }
                                    u.setTel(fileItem.getString());

                                }
                                if (fileItem.getFieldName().equals("cpw")) {
                                    System.out.println(fileItem.getString());
                                    if ((!(fileItem.getString().equals("")))&&(!(fileItem.getString().equals(null)))) {
                                        if (!(fileItem.getString().equals(l.getPassword()))) {
                                            l.setPassword(fileItem.getString());
                                           
                                        }
                                    }

                                }
                                if (fileItem.getFieldName().equals("uemail")) {
                                    System.out.println(fileItem.getString());
                                    if ((!(fileItem.getString().equals("")))&&(!(fileItem.getString().equals(null)))) {
                                         u.setEmail(fileItem.getString());
                                    }
                                   

                                }
                                if (fileItem.getFieldName().equals("ust1")) {
                                    System.out.println(fileItem.getString());
                                    if ((!(fileItem.getString().equals("")))&&(!(fileItem.getString().equals(null)))) {
                                        if (shpo != null) {
                                            shpo.setStreet1(fileItem.getString());
                                        }else{
                                        shpon.setStreet1(fileItem.getString());
                                        }

                                    }

                                }
                                if (fileItem.getFieldName().equals("ust2")) {
                                    System.out.println(fileItem.getString());
                                    if ((!(fileItem.getString().equals("")))&&(!(fileItem.getString().equals(null)))) {
                                         if (shpo != null) {
                                            shpo.setStreet2(fileItem.getString());
                                        }else{
                                        shpon.setStreet2(fileItem.getString());
                                        }
                                        
                                    }

                                }
                                if (fileItem.getFieldName().equals("ucity")) {
                                    System.out.println(fileItem.getString());
                                    if ((!(fileItem.getString().equals("")))&&(!(fileItem.getString().equals(null)))) {
                                         if (shpo != null) {
                                            shpo.setCity(fileItem.getString());
                                        }else{
                                        shpon.setCity(fileItem.getString());
                                        }
                                    }

                                }
                                if (fileItem.getFieldName().equals("upcode")) {
                                    System.out.println(fileItem.getString());
                                    if ((!(fileItem.getString().equals("")))&&(!(fileItem.getString().equals(null)))) {
                                         if (shpo != null) {
                                            shpo.setPostalcode(fileItem.getString());
                                        }else{
                                        shpon.setPostalcode(fileItem.getString());
                                        }
                                    }

                                }
                            } else {

                                if (fileItem.getFieldName().equals("uprofimg") && fileItem.getName() != null) {
                                    String thumb = "UserProfImg/" + Math.random() + fileItem.getName();
                                    System.out.println(thumb);
                                    File f = new File(getServletContext().getRealPath("/") + thumb);

                                    fileItem.write(f);
                                    

                                    u.setUimg(thumb);

                                }

                            }

                        }
                            if(shpo!=null){
                                s.update(shpo);}else{
                                shpon.setUser(u);
                                s.save(shpon);
                                 s.flush();
                 s.beginTransaction().commit(); 
                                }
                        s.update(l);
                        s.flush();
                 s.beginTransaction().commit(); 
                        s.update(u);
                      s.flush();
                 s.beginTransaction().commit(); 
                        
                        if(isunpwchange){
                            request.getSession().setAttribute("username", l.getUsername());
                        }
                        
                       
                        
                    } catch (Exception e) {
                        System.out.println(e);
                    }
                }
                }

            }

//               end ================================================
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
