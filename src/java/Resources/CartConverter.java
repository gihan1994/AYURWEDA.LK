/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Resources;

import Connection.NewHibernateUtil;
import DB.Cart;
import DB.CartHasPCatergoryId;
import DB.CartHasProducts;
import DB.CartHasProductsId;
import DB.GrnHasProducts;
import DB.Login;
import DB.Productoffers;
import DB.Products;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Gihan
 */
public class CartConverter extends HttpServlet {

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
            Transaction t = s.beginTransaction();

            if (request.getParameter("username") != null && request.getSession().getAttribute("uscart") != null) {

                Login ll = (Login) s.createCriteria(DB.Login.class).add(Restrictions.eq("username", request.getParameter("username"))).uniqueResult();

                if (ll != null) {
                    Cart uc = (Cart) s.createCriteria(DB.Cart.class).
                            add(Restrictions.eq("user", ll.getUser())).uniqueResult();

                    if (uc != null) {//login user have cart

                        HashMap<String, Integer> ipid = (HashMap<String, Integer>) request.getSession().getAttribute("uscart");

                        for (String pid : ipid.keySet()) {
                            Products p = (Products) s.createCriteria(DB.Products.class).add(Restrictions.eq("idProducts", new Integer(pid))).uniqueResult();

                            if (p != null) {

                                GrnHasProducts ghp = (GrnHasProducts) s.createCriteria(DB.GrnHasProducts.class)
                                        .add(Restrictions.and(Restrictions.eq("products", p),
                                                        Restrictions
                                                        .and(Restrictions.eq("grnpstatus", "1"), Restrictions.eq("qtystatus", "1")))).uniqueResult();
                                Double uniqprice = 0.0;
                                if (ghp != null) {
                                    uniqprice = ghp.getSellprice();
                                }

                                int poffer = 0;
                                Productoffers poff = (Productoffers) s.createCriteria(DB.Productoffers.class)
                                        .add(Restrictions.and(Restrictions.eq("grnHasProducts", ghp),
                                                        Restrictions.eq("dateofview", new Date()))).uniqueResult();

                                if (ghp != null && poff != null&&poff.getOfferstatus().equalsIgnoreCase("1")) {
                                    poffer = poff.getPresentage();
                                }

                                CartHasProducts chp = (CartHasProducts) s.createCriteria(DB.CartHasProducts.class)
                                        .add(Restrictions.and(Restrictions.eq("cart", uc), Restrictions.eq("products", p))).uniqueResult();

                                if (chp != null) {//product is in the cart

                                    int nqty = chp.getQty() + ipid.get(pid);
                                    chp.setQty(nqty);
                                    double ptol = uniqprice * nqty;
                                    if (poffer != 0) {
                                        ptol = (uniqprice - (uniqprice * poffer / 100)) * nqty;
                                    }
                                    chp.setPtotal(ptol);
                                    s.update(chp);
                                    s.flush();
                                    s.beginTransaction().commit();
                                } //end
                                else {//product is not in the cart

                                    CartHasProductsId chpid = new CartHasProductsId();
                                    chpid.setCartIdCart(uc.getIdCart());
                                    chpid.setProductsIdProducts(p.getIdProducts());

                                    CartHasProducts nchp = new CartHasProducts();

                                    nchp.setCart(uc);
                                    nchp.setId(chpid);
                                    nchp.setQty(ipid.get(pid));
                                    double ptol = uniqprice * ipid.get(pid);
                                    if (poffer != 0) {
                                        ptol = (uniqprice - (uniqprice * poffer / 100)) * ipid.get(pid);
                                    }
                                    nchp.setPtotal(ptol);
                                    s.save(nchp);
                                    s.flush();
                                    s.beginTransaction().commit();

                                }
                         //  end

                            } else {
                                System.out.println("Cart Converter Product null");
                            }

                        }

                        //get full total of cart
                        List<CartHasProducts> lfortol = s.createCriteria(DB.CartHasProducts.class)
                                .add(Restrictions.eq("cart", uc)).list();
                        double total = 0.0;
                        for (CartHasProducts tolchp : lfortol) {

                            total += tolchp.getPtotal();
                        }

                        uc.setTotal(total);
                        s.update(uc);
                        s.flush();
                        s.beginTransaction().commit();

                        request.getSession().removeAttribute("uscart");
                        System.out.println("user have cart add exsiting cart");
                        response.sendRedirect("Cart_test.jsp");

      //=========  login user haven't cart add new cart  ================
                    } else {

                        Cart nc = new Cart();

                        nc.setUser(ll.getUser());
                        nc.setDate(new Date());
                        nc.setTotal(0.0);
                        nc.setPaystatus(0);
                        s.save(nc);
                        s.flush();
                        s.beginTransaction().commit();

                        HashMap<String, Integer> ipid = (HashMap<String, Integer>) request.getSession().getAttribute("uscart");

                        for (String pid : ipid.keySet()) {

                            CartHasProductsId chpid = new CartHasProductsId();
                            chpid.setCartIdCart(nc.getIdCart());

                            CartHasProducts chp = new CartHasProducts();
                            chp.setCart(nc);

                            Products p = (Products) s.createCriteria(DB.Products.class).add(Restrictions.eq("idProducts", new Integer(pid))).uniqueResult();
                            if (p != null) {
                                GrnHasProducts ghp = (GrnHasProducts) s.createCriteria(DB.GrnHasProducts.class)
                                        .add(Restrictions.and(Restrictions.eq("products", p),
                                                        Restrictions
                                                        .and(Restrictions.eq("grnpstatus", "1"), Restrictions.eq("qtystatus", "1")))).uniqueResult();
                                Double uniqprice = 0.0;
                                if (ghp != null) {
                                    uniqprice = ghp.getSellprice();
                                }

                                chpid.setProductsIdProducts(p.getIdProducts());
                                int poffer = 0;
                                Productoffers poff = (Productoffers) s.createCriteria(DB.Productoffers.class)
                                        .add(Restrictions.and(Restrictions.eq("grnHasProducts", ghp),
                                                        Restrictions.eq("dateofview", new Date()))).uniqueResult();

                                if (ghp != null && poff != null&&poff.getOfferstatus().equalsIgnoreCase("1")) {
                                    poffer = poff.getPresentage();
                                }

                                chp.setId(chpid);
                                chp.setProducts(p);
                                chp.setQty(ipid.get(pid));
                                double ptol = uniqprice * ipid.get(pid);
                                if (poffer != 0) {
                                    ptol = (uniqprice - (uniqprice * poffer / 100)) * ipid.get(pid);
                                }
                                chp.setPtotal(ptol);

                                s.save(chp);
                                s.flush();
                                s.beginTransaction().commit();
                            } else {
                                System.out.println("cart converter add new cart product null");
                            }

                        }

                        //get full total of cart
                        List<CartHasProducts> lfortol = s.createCriteria(DB.CartHasProducts.class)
                                .add(Restrictions.eq("cart", nc)).list();
                        double total = 0.0;
                        for (CartHasProducts tolchp : lfortol) {

                            total += tolchp.getPtotal();
                        }

                        nc.setTotal(total);
                        s.update(nc);
                        s.flush();
                        s.beginTransaction().commit();

                        request.getSession().removeAttribute("uscart");
                        System.out.println("user haven't cart add new cart");
                        response.sendRedirect("Cart_test.jsp");

                    }

                    //end add new cart for new user=======================
                } else {
                    System.out.println("cart converter Login user null");
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
