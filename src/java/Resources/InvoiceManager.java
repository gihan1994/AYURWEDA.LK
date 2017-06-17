/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Resources;

import Connection.NewHibernateUtil;
import DB.Cart;
import DB.CartHasProducts;
import DB.GrnHasProducts;
import DB.Invoice;
import DB.InvoiceHasGrnHasProducts;
import DB.Login;
import DB.Notifications;
import DB.Ordering;
import DB.Productoffers;
import DB.Products;
import DB.Productselling;
import DB.Shippingorder;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
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
public class InvoiceManager extends HttpServlet {

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
          
   //get invoice when purchased
                 Session cs = NewHibernateUtil.getSessionFactory().openSession();
          
             if(request.getParameter("payButton") != null
                    && request.getParameter("payButton").equalsIgnoreCase("checkcart")
                    &&request.getSession().getAttribute("username")!=null){
                boolean checkqty=true;
                String msg="";
             
                     if (request.getParameter("cartid") != null) {

                Login l = (Login) cs.createCriteria(DB.Login.class).add(Restrictions.eq("username", request.getSession().getAttribute("username"))).uniqueResult();
                
               if(l!=null){
               
                Cart ccart = (Cart)cs.createCriteria(DB.Cart.class).add(Restrictions.eq("user",l.getUser() )).uniqueResult();
                if(ccart!=null){
                  Invoice invo = new Invoice();
                
                invo.setDate(new Date());
                invo.setTotal(new Double(ccart.getTotal().toString()));
                invo.setUser(l.getUser());
                invo.setTotal(ccart.getTotal());
                cs.save(invo);
                 cs.flush();
                 cs.beginTransaction().commit();

                    Ordering odr=new Ordering();
                    odr.setStatus("0");
                    odr.setOrderdate(new Date());
                    odr.setInvoice(invo);
                    odr.setUser(l.getUser());
                    
                    //set order address
                    Shippingorder orso=(Shippingorder) cs.createCriteria(DB.Shippingorder.class).add(Restrictions.eq("user", l.getUser())).uniqueResult();
                    if(orso!=null){
                    odr.setResName(orso.getRecieverName());
                    odr.setTel(orso.getUser().getTel());
                    odr.setStreet1(orso.getStreet1());
                    odr.setStreet2(orso.getStreet2());
                    odr.setCity(orso.getCity());
                    odr.setPcode(orso.getPostalcode());
                    }
                    cs.save(odr);
                    
                    cs.flush();
                 cs.beginTransaction().commit();
                

                List<CartHasProducts> chpforinvo = cs.createCriteria(DB.CartHasProducts.class).add(Restrictions.eq("cart", ccart)).list();

                for (CartHasProducts chpl : chpforinvo) {
                    
                     Products dp=(Products) cs.createCriteria(DB.Products.class)
                            .add(Restrictions.eq("idProducts", new Integer(chpl.getProducts().getIdProducts()))).uniqueResult();
                    
                    if(dp!=null){
                                  GrnHasProducts ghp=(GrnHasProducts)cs.createCriteria(DB.GrnHasProducts.class)
                                .add(Restrictions.and(Restrictions.eq("products",dp),
                                        Restrictions
                                        .and(Restrictions.eq("grnpstatus", "1"), Restrictions.eq("qtystatus", "1")))).uniqueResult();
                     
                     if(ghp!=null&&ghp.getQty()>=chpl.getQty()){
                      
                         
                   
                         InvoiceHasGrnHasProducts ihp = new InvoiceHasGrnHasProducts();

                     ihp.setGrnHasProducts(ghp);
                   ihp.setInvoice(invo);
                    ihp.setInvoqty(chpl.getQty());
                    ihp.setTotal(chpl.getPtotal());
                    cs.save(ihp);
                     cs.flush();
                 cs.beginTransaction().commit();
                    
                       
                  Notifications nn=new Notifications();
                                nn.setAdddate(new Date());
                                nn.setStatus("1");
                                nn.setTitle("Order has been processed");
                                nn.setUser(l.getUser());
                                cs.save(nn);
                                cs.flush();
                                cs.beginTransaction().commit();
                       
                    //update selling product count
                     Productselling ps=(Productselling) cs.createCriteria(DB.Productselling.class)
                            .add(Restrictions.eq("products", chpl.getProducts())).uniqueResult();
                    
                    if(ps!=null){
                            
                        ps.setSellQty(ps.getSellQty()+chpl.getQty());
                        cs.update(ps);
                         cs.flush();
                 cs.beginTransaction().commit();
                        
                    }else{
                    
                        ps=new Productselling();
                        
                        
                        ps.setProducts(chpl.getProducts());
                        ps.setStatus("1");
                        ps.setSellQty(chpl.getQty());
                        cs.save(ps);
                         cs.flush();
                 cs.beginTransaction().commit();
                        
                    }
                    
                    //update stock
                   
                    
                    dp.setTolQty(dp.getTolQty()-chpl.getQty());
                    cs.update(dp);
                     cs.flush();
                 cs.beginTransaction().commit();
                 
                 //GRN Stock Update
                 if(ghp.getQty()-chpl.getQty()==0){
                     //if set stock is Overed
                 ghp.setGrnpstatus("0");
                 ghp.setQtystatus("0");
                 }
                    ghp.setQty(ghp.getQty()-chpl.getQty());
                    cs.update(ghp);
                 cs.flush();
                 cs.beginTransaction().commit();
                 
                 //if product has been added offer update offerqty
                 
                 Productoffers poff = (Productoffers) cs.createCriteria(DB.Productoffers.class)
                                        .add(Restrictions.and(Restrictions.eq("grnHasProducts", ghp),
                                                        Restrictions.eq("dateofview", new Date()))).uniqueResult();
                 
                 if(poff!=null&&poff.getOfferstatus().equalsIgnoreCase("1")){
                     poff.setOfferqty(poff.getOfferqty()+chpl.getQty());
                     cs.update(poff);
                  cs.flush();
                 cs.beginTransaction().commit();
                 }
                    
                 //checked stock and changeed stock if current stock is empty
                 
                   new StockChangeManager().updateProductStock(chpl.getProducts().getIdProducts());
                 
                    cs.delete(chpl);
                cs.flush();
                 cs.beginTransaction().commit();
                     checkqty=true;
                     }
                     //out of stock
                     else{
                       msg=dp.getProductName()+" is "+"Out of Stock"+" Available Stock :"+dp.getTolQty();  
                         
                      checkqty=false;
                      break;
                     }
                }
                }
               
                if(checkqty){
                   List<Cart> dcl=cs.createCriteria(DB.Cart.class)
                           .add(Restrictions.eq("user", l.getUser())).list();
                    for (Cart cart : dcl) {
                        
                       cs.delete(cart);  
                       cs.flush();
                 cs.beginTransaction().commit();
                    }
                    
                 

                }else{

                
                }
                
              
               
                response.sendRedirect("Home.jsp?invoiceid="+invo.getIdInvoice());
                 
               
                System.out.println("okk invoice");
                }else{
                    System.out.println("invoice manager user haven't cart");
                }
              
               }else{
                   System.out.println("user not login or username error");
                    response.sendRedirect("Login_UserRegistration.jsp");
               }
                  
                
            }else{
                      response.sendRedirect("Login_UserRegistration.jsp");    
                     }

            }else{
            
                    response.sendRedirect("Login_UserRegistration.jsp");
                
            
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
