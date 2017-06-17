/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Resources;

import Connection.NewHibernateUtil;
import DB.Cart;
import DB.CartHasProducts;
import DB.Login;
import DB.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
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
public class CartItemCount extends HttpServlet {

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

            Session ss = NewHibernateUtil.getSessionFactory().openSession();
          
            int cartitemscount=0;
            if (request.getParameter("itemcount") != null && request.getParameter("itemcount").equalsIgnoreCase("cartitem")) {
              
                if (request.getSession().getAttribute("username") != null) {
                  
                    //for Db cart item Count
                    Login l = (Login) ss.createCriteria(DB.Login.class).add(Restrictions.eq("username", request.getSession().getAttribute("username").toString())).uniqueResult();
                    
                    if (l != null) {
                      
                        Cart c = (Cart) ss.createCriteria(DB.Cart.class).
                                add(Restrictions.eq("user", l.getUser())).uniqueResult();

                        if (c != null) {
                          
                            List<CartHasProducts> chpl = ss.createCriteria(DB.CartHasProducts.class).add(Restrictions.eq("cart", c)).list();
                            int qty = 0;

                            for (CartHasProducts cart : chpl) {

                                qty += cart.getQty();

                            }
                            cartitemscount=qty;
                           


                        } else {
                            cartitemscount=0;
                            

                        }
                    } else {
                    //Guest Item Count
                        cartitemscount=0;
                       

                    }
                    

                } else {

                //session cart count
                    if (request.getSession().getAttribute("uscart") != null) {

                        HashMap<String, Integer> mic = (HashMap) request.getSession().getAttribute("uscart");

                        int itemcount = 0;

                        for (String pid : mic.keySet()) {

                            itemcount += mic.get(pid);

                        }
                        cartitemscount=itemcount;
                       


                    } else {

                       cartitemscount=0;
        }

                }
                
                out.write(cartitemscount+"");

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
