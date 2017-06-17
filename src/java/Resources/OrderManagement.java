/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Resources;

import Connection.NewHibernateUtil;
import DB.Dispatchorders;
import DB.InvoiceHasGrnHasProducts;
import DB.Ordering;
import DB.Productreview;
import DB.Products;
import DB.ProductsHasBrands;
import DB.Shippingorder;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
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
public class OrderManagement extends HttpServlet {

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
            
            //Order Confirmation===============================
            
            
            
            if(request.getParameter("conorder")!=null&&request.getParameter("dOid")!=null){
                
                  Dispatchorders dop=(Dispatchorders) s.createCriteria(DB.Dispatchorders.class)
                          .add(Restrictions.eq("idDispatchOrders",new Integer(request.getParameter("dOid")) )).uniqueResult();
            
            if(dop!=null){
                dop.setStatus("1");
                s.update(dop);
                 s.flush();
                 s.beginTransaction().commit();
                
                out.write("1");
                
            }
                  
            }
          //end =======================================================  
            
           //view  order Item============================================  
         if(request.getParameter("GetData")!=null&&request.getParameter("Oid")!=null){
             boolean type=false;
             if(request.getParameter("GetData").equalsIgnoreCase("Dispatch")){
             type=true;
             }
             Ordering or=(Ordering) s.createCriteria(DB.Ordering.class)
                     .add(Restrictions.eq("idOrder", new Integer(request.getParameter("Oid")))).uniqueResult();
             
             
             
             if(or!=null){
             out.write("<div class=\"modal-header\" style=\"background-color: #00cc66;color: #000000\">");
             out.write("<button type=\"button\" class=\"close\"  data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>");
             out.write("<h2 class=\"modal-title\" style=\"font-weight:bold \">Details Of Order : <small style=\"color: #ffffff\">"+request.getParameter("Oid")+"</small></h2>");
             out.write("</div>");
             out.write("<div class=\"modal-body\" id=\"modcontent\">");
             out.write("<h3 style=\"font-weight:bold \">Status ");
             if(type){
             out.write("<span class=\"badge\" style=\"color:#000000;background-color: #00cc66;color: #ffffff  \">Dispatched</span>");
             }else{
             out.write("<span class=\"badge\" style=\"color:#000000;background-color: #ffcc00  \">In Process</span>");
             }
             out.write("</h3> ");
             out.write("<h4 style=\"font-weight: bold\">Products</h4>");
             out.write("<div class=\"panel panel-body\">");
             out.write("<table class=\"table table-bordered\">");
             out.write("<th></th>");
             out.write("<th>Product Name</th>");
             out.write("<th>Quantity</th>");
                
                 for (InvoiceHasGrnHasProducts ohi : or.getInvoice().getInvoiceHasGrnHasProductses()) {
                     out.write("<tr>");
             out.write("<td><img src=\""+ohi.getGrnHasProducts().getProducts().getImg()+"\" style=\"width:30px;height:30px  \"></td>");
             out.write("<td>"+ohi.getGrnHasProducts().getProducts().getProductName()+"</td>");
             out.write(" <td>"+ohi.getInvoqty()+"</td>");
             out.write("</tr>");
                 }
             
             out.write("</table>");
             out.write("</div>");
             
             if(type){
             out.write("<br><h4 style=\"font-weight: bold\">Add Reviews Products</h4>");
             out.write("<div class=\"panel panel-success panel-body\">");
             out.write("<table class=\"table table-responsive table-bordered\">");
             out.write("<th>Details</th> <th>Review</th><th>Option</th>");
             
                 for (InvoiceHasGrnHasProducts ohi : or.getInvoice().getInvoiceHasGrnHasProductses()) {
                        out.write("<tr>");
             out.write("<td><img src=\""+ohi.getGrnHasProducts().getProducts().getImg()+"\" style=\"width:50px;height:50px\">");
             out.write("<h6>Product Name: "+ohi.getGrnHasProducts().getProducts().getProductName()+" </h6>");
             
                     ProductsHasBrands phb=(ProductsHasBrands) s.createCriteria(DB.ProductsHasBrands.class)
                             .add(Restrictions.eq("products", ohi.getGrnHasProducts().getProducts())).uniqueResult();
             out.write("<h6>Brand Name : "+phb.getBrands().getBrandname()+"</h6></td>");
             Dispatchorders dporeview=(Dispatchorders) s.createCriteria(DB.Dispatchorders.class)
                         .add(Restrictions.eq("ordering", or)).uniqueResult();
                         Productreview prcus=(Productreview) s.createCriteria(DB.Productreview.class)
                                 .add(Restrictions.and(Restrictions.eq("dispatchorders", dporeview), Restrictions.eq("products", ohi.getGrnHasProducts().getProducts()))).uniqueResult();
             if(prcus==null){
                           out.write("<td>");
             out.write("<textarea class=\"panel-body\" style=\"width:100%;height:100%\" id=\"rp"+dporeview.getIdDispatchOrders()+ohi.getGrnHasProducts().getProducts().getIdProducts()+"\" cols=\"4\" rows=\"2\"></textarea> ");
             out.write("</td><td>");
             
             out.write("<button class=\"btn btn-default\" type=\"button\" onclick=\"dispatchedCommentsReviews('"+dporeview.getIdDispatchOrders()+"','review','"+ ohi.getGrnHasProducts().getProducts().getIdProducts()+"')\">Send</button></td>");
             }
             else{
             out.print("<td>"+prcus.getReview()+"</td>");
             out.print("<td style=\"color:green\">Review Added</td>");
             }
             out.write(" </tr>"); 
                 }
         
             
             out.write("</table>");
             out.write("</div>");
             
             }
             
             
             out.write(" <h4 style=\"font-weight: bold\">Delivery Details");
             out.write("<br>");
             out.write("<small class=\"text-center\">");
             String Date="";
             if(type){
                 Dispatchorders dpo=(Dispatchorders) s.createCriteria(DB.Dispatchorders.class)
                         .add(Restrictions.eq("ordering", or)).uniqueResult();
                 if(dpo!=null){
                 Date=new SimpleDateFormat("yyyy-MM-dd").format(dpo.getDate());
                 }
                 
             }else{
             Date=new SimpleDateFormat("yyyy-MM-dd").format(or.getOrderdate());
             }
             
             out.write("Delivery Date: <i>"+Date+"</i>");
             out.write(" <br>Name of Client:<i>"+or.getUser().getFname()+" "+or.getUser().getLname()+"</i>");
             
             String address="";
             
           
             address+="<i>"+or.getStreet1()+"</i><br>";
             address+="<i>"+or.getStreet2()+"</i><br>";
             address+="<i>"+or.getCity()+"</i><br>";
             address+="postal code <i> "+or.getPcode()+".</i><br>";
             address+="Mobile <i>"+or.getUser().getTel()+"</i><br>";
             
             
                 
             out.write("<br>Shipping Address : <p> ");
             out.write(" "+address+"</p></small></h4>");
             out.write(" <br>");
             
              Dispatchorders dpocoment=(Dispatchorders) s.createCriteria(DB.Dispatchorders.class)
                         .add(Restrictions.eq("ordering", or)).uniqueResult();
             if(type&&dpocoment.getCusComent()==null){
               out.write("<div class=\"text-center\"><h4 style=\"font-weight: bold\">Messages or Complains of Order</h4>");
             out.write("<textarea class=\"panel-info panel-body\" cols=\"40\" rows=\"10\" id=\"com"+dpocoment.getIdDispatchOrders()+"\"></textarea>");
             out.write("<button class=\"btn btn-info\" type=\"button\" onclick=\"dispatchedCommentsReviews('"+dpocoment.getIdDispatchOrders()+"','ocomment','no')\">Send</button>");
             out.write("</div>");
             }
           
            
             out.write("</div>");
             
             Dispatchorders dpo=(Dispatchorders) s.createCriteria(DB.Dispatchorders.class)
                         .add(Restrictions.and(Restrictions.eq("status", "0"), Restrictions.eq("ordering", or))).uniqueResult();
             if(type&&dpo!=null){
               if(dpo.getStatus().equalsIgnoreCase("0")){
               out.write("<div class=\"modal-footer text-left\">");
             out.write("<center>");
             out.write("<button class=\"btn btn-default hedder-btn\"  type\"button\" data-dismiss=\"modal\" onclick=\"ConfirmOrder('"+dpo.getIdDispatchOrders()+"')\"><h2 style=\"font-weight:bold;font-family:cursive \">Delivery Confirm</h2></button>");
             out.write("</center></div>");
               }else{
                out.write("<div class=\"modal-footer text-left\">");
             out.write("</div>");
               
               }
                 
             
             }else{
             out.write("<div class=\"modal-footer text-left\">");
             out.write("</div>");
             }
             
             

         
             }
             
         
         
         }  
            
         // comments and review add ====================================
         if(request.getParameter("typecom")!=null&&request.getParameter("comment")!=null&&request.getParameter("disid")!=null){
              Dispatchorders d=(Dispatchorders) s.load(DB.Dispatchorders.class, new Integer(request.getParameter("disid")));
             if(request.getParameter("typecom").equalsIgnoreCase("ordercom")&&request.getParameter("disid")!=null){
             
                
                 if(d!=null){
                 d.setCusComent(request.getParameter("comment"));
                   s.update(d);s.flush();
                       s.beginTransaction().commit();
                 }
                 
             }
               if(request.getParameter("typecom").equalsIgnoreCase("proReview")&&request.getParameter("revpid")!=null){
             
                   Products p=(Products) s.load(DB.Products.class, new Integer(request.getParameter("revpid")));
                   if(p!=null&&d!=null){
                       Productreview pr=new Productreview();
                       pr.setDispatchorders(d);
                       pr.setProducts(p);
                       pr.setReview(request.getParameter("comment"));
                       pr.setReviewDate(new Date());
                       pr.setUser(d.getOrdering().getUser());
                       pr.setStatus("1");
                       
                       s.save(pr);s.flush();
                       s.beginTransaction().commit();
                   
                   }
             }
               
             out.write("1");
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
