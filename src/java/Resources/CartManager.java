/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Resources;

import Connection.NewHibernateUtil;
import DB.Cart;
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
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Gihan
 */
public class CartManager extends HttpServlet {

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

            //============ for add to cart method 
            if (request.getParameter("pid") != null && request.getParameter("Button") != null && request.getParameter("Button").equalsIgnoreCase("addcartbtn")) {

               

                if (request.getSession().getAttribute("username") != null) {
                    //Using DB Cart for Adding items
                   

                    Login l = (Login) s.createCriteria(DB.Login.class).add(Restrictions.eq("username", request.getSession().getAttribute("username"))).uniqueResult();

                    Products p = (Products) s.createCriteria(DB.Products.class).
                            add(Restrictions.eq("idProducts", new Integer(request.getParameter("pid")))).uniqueResult();

                    
                    if (l != null && p != null) {
                        GrnHasProducts ghp=(GrnHasProducts)s.createCriteria(DB.GrnHasProducts.class)
                                .add(Restrictions.and(Restrictions.eq("products",p),
                                        Restrictions
                                        .and(Restrictions.eq("grnpstatus", "1"), Restrictions.eq("qtystatus", "1")))).uniqueResult();
                                 Double uniqprice=0.0;
                                 if(ghp!=null){
                                 uniqprice=ghp.getSellprice();
                                 
                           int poffer=0; 
                                       Productoffers poff=(Productoffers)s.createCriteria(DB.Productoffers.class)
                                        .add(Restrictions.and(Restrictions.eq("grnHasProducts", ghp),
                                                Restrictions.eq("dateofview", new Date()))).uniqueResult();
                              
                                if(poff!=null&&poff.getOfferstatus().equalsIgnoreCase("1")){
                                    poffer=poff.getPresentage();
                                    }
                       

                        Criteria criteriaCart = s.createCriteria(DB.Cart.class);
                        criteriaCart.add(Restrictions.eq("user", l.getUser()));

                        Cart c = (Cart) criteriaCart.uniqueResult();

                        //check request user has already unpayble cart 
                        if (c != null) { // already Exsit cart

                           

                        
                            CartHasProducts chpex = (CartHasProducts) s.createCriteria(DB.CartHasProducts.class).
                                    add(Restrictions.and(Restrictions.eq("cart", c), Restrictions.eq("products", p))).uniqueResult();

                            if (chpex != null) { // request product has existed in cart already

                              

                                int i = chpex.getQty() + 1;
                                double ptol=i * uniqprice;
                                if(poffer!=0){ptol=(uniqprice-(uniqprice*poffer/100))*i;}
                                chpex.setQty(i);
                                chpex.setPtotal(ptol);
                                s.update(chpex);
                                s.flush();
                 s.beginTransaction().commit(); 

                            } else { //not exist cart add to cart as a newone

                                CartHasProductsId chpi = new CartHasProductsId();
                                chpi.setCartIdCart(c.getIdCart());
                                chpi.setProductsIdProducts(p.getIdProducts());

                                chpex = new CartHasProducts();

                                chpex.setCart(c);
                                chpex.setProducts(p);
                                chpex.setQty(1);
                                double ptol=uniqprice;
                                if(poffer!=0){ptol=(uniqprice-(uniqprice*poffer/100));}
                                chpex.setPtotal(ptol);
                                chpex.setId(chpi);

                                s.save(chpex);
                                s.flush();
                 s.beginTransaction().commit();

                            }
                            Criteria criteriaCHP = s.createCriteria(DB.CartHasProducts.class);
                            criteriaCHP.add(Restrictions.eq("cart", c));
                            criteriaCHP.setProjection(Projections.sum("ptotal"));

                            Double total = Double.parseDouble(criteriaCHP.uniqueResult().toString());
                            c.setTotal(total);
                            s.update(c);

                          s.flush();
                 s.beginTransaction().commit();

                        } else {//not already exsit add new cart

                            Cart c1 = new Cart();
                            c1.setDate(new Date());
                            c1.setTotal(0.0);
                            c1.setUser(l.getUser());
                            c1.setPaystatus(0);

                            s.save(c1);
                           s.flush();
                 s.beginTransaction().commit();

                            CartHasProductsId chpi = new CartHasProductsId();
                            chpi.setCartIdCart(c1.getIdCart());
                            chpi.setProductsIdProducts(p.getIdProducts());

                            CartHasProducts chp = new CartHasProducts();
                            chp.setCart(c1);
                            chp.setProducts(p);
                            chp.setQty(1);
                               double ptol=uniqprice;
                                if(poffer!=0){ptol=(uniqprice-(uniqprice*poffer/100));}
                            chp.setPtotal(ptol);
                            chp.setId(chpi);

                            s.save(chp);
                          s.flush();
                 s.beginTransaction().commit();
                            //set cart total for new cart
                            List<CartHasProducts> carttol = s.createCriteria(DB.CartHasProducts.class).add(Restrictions.eq("cart", c1)).list();

                            Double total = 0.0;
                            for (CartHasProducts chpfortol : carttol) {

                                total += chpfortol.getPtotal();

                            }
                            System.out.println(c1.getIdCart());
                            System.out.println(total);
                            c1.setTotal(total);
                            s.update(c1);
                           s.flush();
                 s.beginTransaction().commit();
//                            s.close();

                        }
                    } } else {
                        System.out.println("else 3");
                        System.out.println("user or product null");
                    }

                    //============================= end
                } else {

//session cart start=========
                    System.out.println("else 4");
                    HashMap nitem = new HashMap();

                    if (request.getSession().getAttribute("uscart") == null) {//cart not exsiting

                        System.out.println("if 6");

                        nitem.put(request.getParameter("pid"), 1);
                        request.getSession().setAttribute("uscart", nitem);

                    } else { // cart exsit for user
                        HashMap<String, Integer> exitem = (HashMap) request.getSession().getAttribute("uscart");

                        System.out.println("else 5");

                        if (exitem.get(request.getParameter("pid")) == null) {//item is not in here

                            System.out.println("if 7");

                            exitem.put(request.getParameter("pid"), 1);

                            request.getSession().setAttribute("uscart", exitem);

                        } else {// item is in here

                            System.out.println("else 6");

                            int qty = exitem.get(request.getParameter("pid"));

                            exitem.replace(request.getParameter("pid"), qty + 1);

                            request.getSession().setAttribute("uscart", exitem);

                        }

                    }

                    // session cart insert there
                    System.out.println("session cart wadaaa");

                }

            }
        //============================ end   

            // remove cart item
            if (request.getSession().getAttribute("username") != null) {//db cart remove

                Session rs = NewHibernateUtil.getSessionFactory().openSession();
               
                if (request.getParameter("cartid") != null && request.getParameter("rpid") != null && request.getParameter("RButton") != null
                        && request.getParameter("RButton").equalsIgnoreCase("removeitem")) {
                    Login l = (Login) rs.createCriteria(DB.Login.class).add(Restrictions.eq("username", request.getSession().getAttribute("username"))).uniqueResult();

                    Cart c = (Cart) rs.createCriteria(DB.Cart.class).add(Restrictions.eq("user", l.getUser())).uniqueResult();

                    Products p = (Products) rs.createCriteria(DB.Products.class).add(Restrictions.eq("idProducts", new Integer(request.getParameter("rpid")))).uniqueResult();

                    if (c != null && p != null) {

                        CartHasProducts rchp = (CartHasProducts) rs.createCriteria(DB.CartHasProducts.class).
                                add(Restrictions.and(Restrictions.eq("cart", c), Restrictions.eq("products", p))).uniqueResult();

                        if (rchp != null) {
                            
                            
                            rs.delete(rchp);
                             rs.flush();
                 rs.beginTransaction().commit();
                            System.out.println("in delete item");
                        }

//                    //check cart item is available
                       List<CartHasProducts> dcl = rs.createCriteria(DB.CartHasProducts.class).add(Restrictions.eq("cart", c)).list();
                        System.out.println(dcl.size()+"cart items");
                       if (dcl.size()==0) {
                            rs.delete(c);
                            rs.flush();
                 rs.beginTransaction().commit();
                           
                        }
                       //cart total update
                       else{
                         Double total = 0.0;
                            for (CartHasProducts chpfortol : dcl) {

                                total += chpfortol.getPtotal();

                            }
                            c.setTotal(total);
                            rs.update(c);
                         rs.flush();
                 rs.beginTransaction().commit();
                       
                       
                       }

                      

                    }

                    System.out.println("elaaaa awaaa remove items");
                    response.sendRedirect("Cart_test.jsp");

                }

            } else { //session cart remove

                if (request.getParameter("rpid") != null && request.getParameter("RButton") != null
                        && request.getParameter("RButton").equalsIgnoreCase("removeitem") && request.getSession().getAttribute("uscart") != null) {

                    HashMap<String, Integer> rhp = (HashMap) request.getSession().getAttribute("uscart");

                    if (rhp.containsKey(request.getParameter("rpid"))) {
                        rhp.remove(request.getParameter("rpid"));
                    }

                    request.getSession().setAttribute("uscart", rhp);
//                    out.write("item remove");
                }

            }

            // clear cart Items ==============================================================
            if (request.getSession().getAttribute("username") != null) {//Db cart clear all
                if (request.getParameter("cartid") != null && request.getParameter("CButton") != null && request.getParameter("CButton").equalsIgnoreCase("clearcart")) {

                    Cart ct = (Cart) s.createCriteria(DB.Cart.class).add(Restrictions.eq("idCart", new Integer(request.getParameter("cartid")))).uniqueResult();

                    List<CartHasProducts> chs = s.createCriteria(DB.CartHasProducts.class).add(Restrictions.eq("cart", ct)).list();

                    for (CartHasProducts cchp : chs) {

                        s.delete(cchp);
                       s.flush();
                 s.beginTransaction().commit();
                    }
                    s.delete(ct);
                    s.flush();
                 s.beginTransaction().commit();
                    
                    response.sendRedirect("Cart_test.jsp");

                }

            } else {
                if (request.getSession().getAttribute("uscart") != null && request.getParameter("CButton") != null && request.getParameter("CButton").equalsIgnoreCase("clearcart")) {

                    request.getSession().removeAttribute("uscart");

                    response.sendRedirect("Cart_test.jsp");

                }

            }

          // cart update area ====================================================  
            
            if (request.getParameter("CartUpdate") != null && request.getParameter("CartUpdate").equalsIgnoreCase("ok")
                    &&request.getParameter("upid")!=null&&request.getParameter("uqty")!=null) {
                System.out.println("innn updaterrrr");
                //DB cart updater
                if(request.getSession().getAttribute("username")!=null){
                    Login ul=(Login) s.createCriteria(DB.Login.class).add(Restrictions.eq("username", request.getSession().getAttribute("username"))).uniqueResult();
                    if(ul!=null){
                        
                        Cart uc=(Cart) s.createCriteria(DB.Cart.class).add(Restrictions.eq("user", ul.getUser())).uniqueResult();
                        Products up = (Products) s.createCriteria(DB.Products.class).add(Restrictions.eq("idProducts", new Integer(request.getParameter("upid")))).uniqueResult();
                       if(uc != null && up != null){
                            GrnHasProducts ghp=(GrnHasProducts)s.createCriteria(DB.GrnHasProducts.class)
                                .add(Restrictions.and(Restrictions.eq("products",up),
                                        Restrictions
                                        .and(Restrictions.eq("grnpstatus", "1"), Restrictions.eq("qtystatus", "1")))).uniqueResult();
                                 Double uniqprice=0.0;
                                 if(ghp!=null){
                                 uniqprice=ghp.getSellprice();
                           
                            int poffer=0; 
                                       Productoffers poff=(Productoffers)s.createCriteria(DB.Productoffers.class)
                                        .add(Restrictions.and(Restrictions.eq("grnHasProducts", ghp),
                                                Restrictions.eq("dateofview", new Date()))).uniqueResult();
                              
                                if(poff!=null&&poff.getOfferstatus().equalsIgnoreCase("1")){
                                    poffer=poff.getPresentage();
                                    }
                           
                           
                       CartHasProducts rchp = (CartHasProducts) s.createCriteria(DB.CartHasProducts.class).
                                add(Restrictions.and(Restrictions.eq("cart", uc), Restrictions.eq("products", up))).uniqueResult();
                       if(rchp!=null){
                       int pqty=Integer.parseInt(request.getParameter("uqty"));
                       rchp.setQty(pqty);
                          double ptol=uniqprice*pqty;
                                if(poffer!=0){ptol=(uniqprice-(uniqprice*poffer/100))*pqty;}
                       rchp.setPtotal(ptol);
                       s.update(rchp);
                      s.flush();
                 s.beginTransaction().commit();
                       }
                      //update cart item and total 
                      List<CartHasProducts> uchpl=s.createCriteria(DB.CartHasProducts.class).add(Restrictions.eq("cart", uc)).list();
                      if(uchpl.size()>0){
                          Double total=0.0;
                          for (CartHasProducts ci : uchpl) {
                                total=+ci.getPtotal();
                              
                          }
                          uc.setTotal(total);
                          s.update(uc);
                         s.flush();
                 s.beginTransaction().commit();
                          
                      } 
                      
                      
                       } }
                    
                    }
                }
                //session cart updater
                else{
                    HashMap<String, Integer> rhp = (HashMap) request.getSession().getAttribute("uscart");
                     if (rhp.containsKey(request.getParameter("upid"))) {
                        
                         rhp.replace(request.getParameter("upid"), new Integer(request.getParameter("uqty")));
                    }

                    request.getSession().setAttribute("uscart", rhp);
                
                
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
