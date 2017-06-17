/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Resources;

import Connection.NewHibernateUtil;
import DB.GrnHasProducts;
import DB.Login;
import DB.Notifications;
import DB.Products;
import DB.Wishlist;
import DB.WishlistHasGrnHasProducts;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Gihan
 */
public class WishListManager extends HttpServlet {

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
            if(request.getParameter("AddData")!=null&&request.getParameter("pid")!=null){
                    
                if(request.getSession().getAttribute("username")!=null){
                    Login l=(Login) s.createCriteria(DB.Login.class)
                            .add(Restrictions.eq("username", request.getSession().getAttribute("username"))).uniqueResult();
                     
                    Products p=(Products) s.createCriteria(DB.Products.class)
                            .add(Restrictions.eq("idProducts", new Integer(request.getParameter("pid")))).uniqueResult();
                    if(l!=null&&p!=null){
                                   GrnHasProducts ghp=(GrnHasProducts)s.createCriteria(DB.GrnHasProducts.class)
                                .add(Restrictions.and(Restrictions.eq("products",p),
                                        Restrictions
                                        .and(Restrictions.eq("grnpstatus", "1"), Restrictions.eq("qtystatus", "1")))).uniqueResult();
                    
                        Wishlist wl=(Wishlist) s.createCriteria(DB.Wishlist.class)
                                .add(Restrictions.eq("user", l.getUser())).uniqueResult();
                    if(ghp!=null){
                        // user have wishlist
                        if(wl!=null){
                            WishlistHasGrnHasProducts wlhs=(WishlistHasGrnHasProducts) s.createCriteria(DB.WishlistHasGrnHasProducts.class)
                            .add(Restrictions.and(Restrictions.eq("wishlist", wl),Restrictions.eq("grnHasProducts", ghp))).uniqueResult();
                        
                            if(wlhs!=null){
                            
                                out.write("Product All Ready in Your Wish List");
                            }
                            else{
                                
                                WishlistHasGrnHasProducts nwhp=new WishlistHasGrnHasProducts();
                                
                                nwhp.setGrnHasProducts(ghp);
                                nwhp.setStatus("0");
                                nwhp.setWishAddDate(new Date());
                                nwhp.setWishAddTime(new Date());
                                nwhp.setWishlist(wl);
                                
                                s.save(nwhp);
                                 s.flush();
                                 s.beginTransaction().commit(); 
                                wl.setItemCount(wl.getItemCount()+1);
                                s.update(wl);
                                s.flush();
                 s.beginTransaction().commit(); 
                    
                 // set Notification
                                Notifications nn=new Notifications();
                                nn.setAdddate(new Date());
                                nn.setStatus("1");
                                nn.setTitle("Add Product in your Wishlist");
                                nn.setUser(l.getUser());
                                s.save(nn);
                                s.flush();
                                s.beginTransaction().commit();
                                
                                 out.write("Product Add in Your Wish List");
                            }
                            
                        
                        }
                        
                        //user haven't wishlist add as new one
                        else{
                            Wishlist nwl=new Wishlist();
                            nwl.setItemCount(0);
                            nwl.setStatus("1");
                            nwl.setUser(l.getUser());
                            nwl.setItemCount(1);
                            
                            s.save(nwl);
                             s.flush();
                 s.beginTransaction().commit(); 
                 
                                WishlistHasGrnHasProducts nwhp=new WishlistHasGrnHasProducts();
                               
                                nwhp.setGrnHasProducts(ghp);
                                nwhp.setStatus("0");
                                nwhp.setWishAddDate(new Date());
                                nwhp.setWishAddTime(new Date());
                                nwhp.setWishlist(nwl);
                                
                                s.save(nwhp);
                                s.flush();
                 s.beginTransaction().commit(); 
                 //set Notification for new wishlist
                  Notifications nn=new Notifications();
                                nn.setAdddate(new Date());
                                nn.setStatus("1");
                                nn.setTitle("Add Product in your Wishlist");
                                nn.setUser(l.getUser());
                                s.save(nn);
                                s.flush();
                                s.beginTransaction().commit();
                                out.write("Product Add in Your Wish List");
                            
                        
                        }
                    }
                    }
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
