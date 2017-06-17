/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Resources;

import Connection.NewHibernateUtil;
import DB.Dispatchorders;
import DB.GrnHasProducts;
import DB.Invoice;
import DB.InvoiceHasGrnHasProducts;
import DB.Login;
import DB.Messages;
import DB.Notifications;
import DB.Ordering;
import DB.Productoffers;
import DB.Products;
import DB.ProductsHasBrands;
import DB.Ratings;
import DB.Shippingorder;
import DB.Wishlist;
import DB.WishlistHasGrnHasProducts;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.json.JSONObject;

/**
 *
 * @author Gihan
 */
public class UserViewManager extends HttpServlet {

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
            // check user is available
            if (request.getSession().getAttribute("username") != null) {
                Session s = NewHibernateUtil.getSessionFactory().openSession();
                Login l = (Login) s.createCriteria(DB.Login.class)
                        .add(Restrictions.eq("username", request.getSession().getAttribute("username"))).uniqueResult();
                //get Profile Data
                if (request.getParameter("Getdata") != null && request.getParameter("Getdata").equalsIgnoreCase("ProfData")) {

                    if (l != null) {
                        
                    
                     
                        out.write("<div>");
                        out.write("<div class=\"col-md-1\"> </div>");
                        out.write("<div class=\"col-md-2\">");

                        String imgpath ="";
                        if (l.getUser().getUimg().equals(null)||l.getUser().getUimg().equals("")) {
                          imgpath = "img/DefaltUser.png";  
                        }else{
                        imgpath = l.getUser().getUimg();
                        }

                        out.write("<img src=\"" + imgpath + "\" id=\"userviewpic\" style=\"position:relative;  top:0; left:0;\" class=\"img-rounded\" width=\"150px\" height=\"150px\">");
                        out.write("</div>");
                        out.write("<div class=\"col-md-1\">");
                        out.write("</div>");
                        out.write("<div class=\"col-md-7\">");
                        out.write("<div>");
                        out.write("<div class=\"col-md-8\"></div>");
                        out.write("<div class=\"col-md-2\" style=\"\">");
                        out.write("<div class=\"col-md-6\">");
                        out.write("<button type=\"button\" class=\"btn btn-default\" id=\"editbtn\" onclick=\"ProfileEdit('edit')\" style=\"background: #0066ff;border-color:#0066ff;color:white  \">Edit</button>");
                        out.write("</div>");
                        out.write("<div class=\"col-md-6\">");
                        out.write(" <button class=\"btn btn-success\" type=\"button\" style=\"display:none\" id=\"profsavebtn\" onclick=\"profileSave()\">Save</button>");
                        out.write(" </div>");
                        out.write(" </div>");
                        out.write("<div class=\"col-md-2\"></div>");
                        out.write("</div>");
                        out.write("</div>");
                        out.write("</div>");

                        //form
                        out.write("<div>");
                        out.write("<form   method=\"post\"  enctype=\"multipart/form-data\" id=\"profDataform\">");
                        out.write("<input type=\"file\" style=\"display:none;background-color: #cccccc;font-weight:bold;  \"  name=\"uprofimg\" id=\"profpicbtn\">");
                        out.write("<div class=\"col-md-2\"></div>");
                        out.write("<div class=\"col-md-10\">");
                        out.write("<div class=\"col-md-6\" style=\"padding-top:50px \">");
                        out.write("<table style=\"width:100%;height:100% \">");
                        out.write("<tr>");
                        out.write("<td style=\"font-weight: bold\">User Name</td>");
                        out.write("<td><input type=\"text\" id=\"uname\" name=\"uname\" value=\"" + l.getUsername() + "\" class=\"form-control\" readonly=\"readonly\"></td>");
                        out.write("</tr>");
                        out.write("<tr><td>&nbsp;</td><td>&nbsp;</td></tr>");
                        out.write("<tr>");
                        out.write("<td style=\"font-weight: bold\">First Name</td>");
                        out.write("<td><input type=\"text\" id=\"fname\" name=\"fname\" value=\"" + l.getUser().getFname() + "\" class=\"form-control\" readonly=\"readonly\"></td>");
                        out.write("</tr>");
                        out.write("<tr>");
                        out.write("<td style=\"font-weight: bold\">Last Name</td>");
                        out.write("<td><input type=\"text\" id=\"lname\" name=\"lname\" value=\"" + l.getUser().getLname() + "\" class=\"form-control\" readonly=\"readonly\"></td>");
                        out.write("</tr>");
                        out.write("<tr><td>&nbsp;</td><td>&nbsp;</td></tr>");
                        out.write("<tr>");
                        out.write("<td style=\"font-weight: bold\">Contact</td>");
                        out.write("<td><input type=\"text\" id=\"utel\" name=\"utel\" value=\"" + l.getUser().getTel() + "\" class=\"form-control\" readonly=\"readonly\"></td>");
                        out.write("</tr>");
                        out.write("<tr><td>&nbsp;</td><td>&nbsp;</td></tr>");
                        out.write("<tr>");
                        out.write("<td style=\"font-weight: bold\">Password</td>");
                        out.write("<td><input type=\"password\" id=\"pw\" name=\"pw\" class=\"form-control\" value=\"" + l.getPassword() + "\" readonly=\"readonly\"></td>");
                        out.write("</tr>");
                        out.write("<tr><td>&nbsp;</td><td>&nbsp;</td></tr>");
                        out.write("<tr>");
                        out.write("<td style=\"font-weight: bold;display: none;\" id=\"cpwl\">Confirm Password</td>");
                        out.write("<td><input type=\"password\" style=\"display:none\" id=\"cpw\" name=\"cpw\" class=\"form-control\"></td>");
                        out.write("</tr>");
                        out.write("<tr><td>&nbsp;</td><td>&nbsp;</td></tr>");
                        out.write("</table>");
                        out.print("</div>");
                        out.print("<div class=\"col-md-6\" style=\"padding-top:50px;padding-left:30px\">");
                        out.print("<table style=\"width:100%;height:100%\">");
                        out.print("<tr>");
                        out.print("<td style=\"font-weight: bold\">Email</td>");
                        out.print("<td><input class=\"form-control\" id=\"uemail\" name=\"uemail\" value=\"" + l.getUser().getEmail() + "\" readonly=\"readonly\"></td>");
                        out.print("</tr>");
                        out.print("<tr><td>&nbsp;</td><td>&nbsp;</td></tr>");
                        out.print("<td style=\"text-align:match-parent;font-weight:bold  \">Shipping Address</td>");
                        out.print("<td>");
                        out.print("<table style=\"width:100%;height:100%  \">");

                        Shippingorder uso = (Shippingorder) s.createCriteria(DB.Shippingorder.class)
                                .add(Restrictions.eq("user", l.getUser())).uniqueResult();

                        String st1 = "";
                        String st2 = "";
                        String city = "";
                        String pcode = "";

                        // set address if it available
                        if (uso != null) {
                            if (!(uso.getStreet1().equals(null) || uso.getStreet1().equals(""))) {
                                st1 = uso.getStreet1();
                            }
                            if (!(uso.getStreet2().equals(null) || uso.getStreet2().equals(""))) {
                                st2 = uso.getStreet2();
                            }
                            if (!(uso.getCity().equals(null) || uso.getCity().equals(""))) {
                                city = uso.getCity();
                            }
                            if (!(uso.getPostalcode().equals(null) || uso.getPostalcode().equals(""))) {
                                pcode = uso.getPostalcode();
                            }

                        }
                        out.print("<tr><td><input class=\"form-control\" id=\"ust1\" name=\"ust1\" value=\"" + st1 + "\" placeholder=\"Street1\" readonly=\"readonly\"></td></tr>");
                        out.print("<tr><td><input class=\"form-control\" id=\"ust2\" name=\"ust2\" value=\"" + st2 + "\"  placeholder=\"Street2\" readonly=\"readonly\"></td></tr>");
                        out.print("<tr><td><input class=\"form-control\" id=\"ucity\" name=\"ucity\" value=\"" + city + "\"  placeholder=\"City\" readonly=\"readonly\"></td></tr>");
                        out.print("<tr><td><input class=\"form-control\" id=\"upcode\" name=\"upcode\" value=\"" + pcode + "\"  placeholder=\"Postal Code\" readonly=\"readonly\"></td></tr>");
                        out.print("</table>");
                        out.print("</td>");
                        out.print("</tr>");
                        out.print("</table>");
                        out.print("  </div>");
                        out.print("  </div>");
                        out.print("</form>");
                        out.print("</div>");

                        
                
                    }

                }

               
//            end==============================================================

                // Get WishList Data ===========================================
                if (request.getParameter("Getdata") != null && request.getParameter("Getdata").equalsIgnoreCase("WishData") && l != null) {

                    Wishlist uwl = (Wishlist) s.createCriteria(DB.Wishlist.class)
                            .add(Restrictions.eq("user", l.getUser())).uniqueResult();

                    if (uwl != null) {
                        List<WishlistHasGrnHasProducts> whpl = s.createCriteria(DB.WishlistHasGrnHasProducts.class)
                                .add(Restrictions.eq("wishlist", uwl)).list();
                        for (WishlistHasGrnHasProducts wli : whpl) {

                            out.write("<div class=\"panel panel-body\" style=\"box-shadow: 2px 2px 10px 1px #cccccc;height:150px;width:100%\">");
                            out.write("<div style=\"display:inline\">");
                            out.write("<div class=\"col-md-2\">");
                            out.write("<img src=\"" + wli.getGrnHasProducts().getProducts().getImg() + "\" onclick=\"window.location.href='UniqProductView.jsp?repid=" + wli.getGrnHasProducts().getProducts().getIdProducts() + "'\" style=\"width:120px;height:120px;cursor: pointer;  \">");
                              
                            if (wli.getGrnHasProducts() != null) {
                                Productoffers poff = (Productoffers) s.createCriteria(DB.Productoffers.class)
                                        .add(Restrictions.and(Restrictions.eq("grnHasProducts", wli.getGrnHasProducts()),
                                                        Restrictions.eq("dateofview", new Date()))).uniqueResult();
                                if (poff != null&&poff.getOfferstatus().equalsIgnoreCase("1")) {
                                    out.print(" <span class=\"badge\" style=\"rotation:190deg;\n"
                                            + "background-color:#ff3300;color:#ffffff;position: absolute;\">");
                                    out.print("<h6 style=\"font-weight:bolder;\">");

                                    out.print("Offer " + poff.getPresentage() + "%");
                                    out.print("</h6>");

                                    out.print("</span>");

                                }
                            }
                            
                            out.write("</div>");
                            out.write("<div class=\"col-md-3 text-center\">");

                            ProductsHasBrands phb = (ProductsHasBrands) s.createCriteria(DB.ProductsHasBrands.class)
                                    .add(Restrictions.eq("products", wli.getGrnHasProducts().getProducts())).uniqueResult();
                            if (phb != null) {
                                out.write("<div><h3 style=\"font-weight:bold \">" + phb.getBrands().getBrandname() + "</h3></div>");
                            }

                            out.write("<div><h4>" + wli.getGrnHasProducts().getProducts().getProductName() + "</h4></div>");
                            out.write("<div><h4 style=\"font-weight:bold \">" + wli.getGrnHasProducts().getSellprice() + "&nbsp;LKR</h4></div>");
                            out.write("</div>");
                            out.write("<div class=\"col-md-1\"></div>");
                            out.write("<div class=\"col-md-3\">");
                            out.write("<div><h5 style=\"font-weight: bold\">Product Rating :</h5></div>");
                            String rate=new ProductRatingProvider().getRateOfProduct(wli.getGrnHasProducts().getProducts().getIdProducts().toString()).toString();
                            out.write("<p style=\"font-weight:bold;font-size:15px;color:green  \">"+rate+"</p>");
                            out.write(" <div >");
                            out.write(" <h5 style=\"font-weight:bold\">Description : </h5>");
                            out.write("<p class=\"text-center\" style=\"font-size:12px ;color: #cccccc\">");
                            out.write(" " + wli.getGrnHasProducts().getProducts().getDescription() + "");
                            out.write(" </p>");
                            out.write("</div>");
                            out.write(" </div>");
                            out.write("<div class=\"col-md-3 text-center\">");
                            out.write("<div style=\"color: #999999\">Wished Date:- " + new SimpleDateFormat("yyyy-MM-dd").format(wli.getWishAddDate()).toString() + " </div>");
                            out.write("<br>");
                            out.write("<div><button  class=\"btn btn-default hedder-btn btn-lg\" type=\"button\" >Buy Now</button></div>");
                            out.write("<br>");
                            out.write("<div><button class=\"btn btn-danger btn-xs\">Remove</button></div>");
                            out.write("</div>");
                            out.write("</div>");
                            out.write("</div>");

                            wli.setStatus("1");
                            s.update(wli);
                           s.flush();
                 s.beginTransaction().commit(); 

                        }

                    } else {
                        out.write("<h3>You Have NO Wish Items</h3>");

                    }

                }
                //end====================================

                //get Order Data ============================================
                if (request.getParameter("Getdata") != null && request.getParameter("Getdata").equalsIgnoreCase("OrderData") && l != null) {

                    //in pRoccess Orders  
                    out.write("<div class=\"col-md-6\">");
                    out.write("<div class=\"panel-warning text-center\" style=\"height:30px;width:100%  \" >");
                    out.write("<div class=\"panel-heading\">");
                    out.write("<h3 style=\"font-weight:bold \">In process</h3>");
                    out.write("</div>");
                    out.write("<div class=\"panel-body\" style=\"overflow:auto;height:500px;overflow-style:panner;\">");

                    List<Ordering> uod = s.createCriteria(DB.Ordering.class)
                            .add(Restrictions.and(Restrictions.eq("user", l.getUser()), Restrictions.eq("status", "0"))).list();

                    if (uod.size() > 0) {
                        for (Ordering o : uod) {

                            out.write("<div class=\"panel-body\" style=\"width:100%;height:80px;box-shadow: 2px 2px 10px 1px #cccccc;  \">");
                            out.write("<div style=\"display:inline \">");
                            out.write("<div class=\"col-md-2\" >");
                            out.write("<span class=\"glyphicon glyphicon-refresh\" aria-hidden=\"true\" style=\"position: absolute;color:#ff0000\"></span>");
                            out.write("<img src=\"img/order.png\" style=\"width:60px;height:60px  \">");
                            out.write("</div>");
                            out.write("<div class=\"col-md-4\" >");
                            out.write("<div><h6 style=\"font-weight: bold \">Order id: <small>" + o.getIdOrder() + "</small></h6> </div>");
                            out.write("<div><h6 style=\"font-weight: bold \">Date:  <small> " + new SimpleDateFormat("yyyy-MM-dd").format(o.getOrderdate()) + "</small></h6> </div>");
                            out.write(" </div>");
                            out.write(" <div class=\"col-md-4\">");
                            out.write("<div><h6 style=\"font-weight: bold \">Products: <small>");

                         
                            String Pro = "";
                            for (InvoiceHasGrnHasProducts ohp : o.getInvoice().getInvoiceHasGrnHasProductses()) {
                                Pro += ohp.getGrnHasProducts().getProducts().getProductName() + " / ";

                            }

                            out.write("  <p>");
                            out.write("" + Pro + "");
                            out.write("</p></small></h6> </div>");
                            out.write("</div>");
                            out.write("<div class=\"col-md-2\">");
                            out.write(" <button class=\"btn btn-default\" onclick=\"viewInprocessOrder('" + o.getIdOrder() + "')\">View</button>");
                            out.write("</div>");
                            out.write(" </div>");
                            out.write(" </div>");
                            out.write(" <br>");

                        }
                    } else {
                        out.write("<h3 style=\"color:#cc0000 \">You have No in Process Orders</h3>");

                    }
                    out.write(" </div>");
                    out.write(" </div>");
                    out.write(" </div>");

                    //dispatched orders 
                    out.write("<div class=\"col-md-6\">");
                    out.write("<div class=\"panel-success text-center\" style=\"height:30px;width:100%  \" >");
                    out.write("<div class=\"panel-heading\">");
                    out.write("<h3 style=\"font-weight:bold \">Dispatched</h3>");
                    out.write("<h5 style=\"font-weight:bold;color:black \">If your Recevied your Packeges please be Confimed Delevering</h5>");
                    out.write("</div>");
                    out.write("<div class=\"panel-body\" style=\"overflow:auto;height:500px;overflow-style:panner;\">");
                    List<Ordering> uodd = s.createCriteria(DB.Ordering.class)
                            .add(Restrictions.and(Restrictions.eq("user", l.getUser()), Restrictions.eq("status", "1"))).addOrder(Order.desc("idOrder")).list();

                    if (uodd.size() > 0) {
                        for (Ordering o : uodd) {
                            Dispatchorders dpo = (Dispatchorders) s.createCriteria(DB.Dispatchorders.class)
                                    .add(Restrictions.eq("ordering", o)).uniqueResult();
                            if (dpo != null) {
                                out.write("<div class=\"panel-body\" style=\"width:100%;height:80px;box-shadow: 2px 2px 10px 1px #cccccc;  \">");
                                out.write("<div style=\"display:inline \">");
                                out.write("<div class=\"col-md-2\" >");
                                out.write("<span class=\"glyphicon glyphicon-ok\" aria-hidden=\"true\" style=\"position: absolute;color:#00ad34;\"></span>");
                                out.write("<img src=\"img/Dispatched.jpg\" style=\"width:60px;height:60px  \">");
                                out.write("</div>");
                                out.write("<div class=\"col-md-4\" >");
                                out.write("<div><h6 style=\"font-weight: bold \">Dispatched id: <small>" + dpo.getIdDispatchOrders() + "</small></h6> </div>");
                                out.write("<div><h6 style=\"font-weight: bold \">Delivery Date:<small>" + new SimpleDateFormat("yyyy-MM-dd").format(dpo.getDate()) + "</small></h6> </div>");
                                out.write(" </div>");
                                out.write(" <div class=\"col-md-4\">");
                                out.write("<div><h6 style=\"font-weight: bold \">Products: <small>");
                                
                                String Pro = "";
                                for (InvoiceHasGrnHasProducts ohp : o.getInvoice().getInvoiceHasGrnHasProductses()) {
                                    Pro += ohp.getGrnHasProducts().getProducts().getProductName() + " / ";

                                }
                                out.write("  <p>");
                                out.write("" + Pro + "");
                                out.write("</p></small></h6> </div>");
                                out.write("</div>");
                                out.write("<div class=\"col-md-2\">");
                                out.write(" <button class=\"btn btn-default\" onclick=\"viewDispatchOrder('" + o.getIdOrder() + "')\" >View</button>");
                                out.write("</div>");
                                out.write(" </div>");
                                out.write(" </div>");
                            }
//                       

                        }
                    } else {
                        out.write("<h3 style=\"color:#cc0000 \">You have No Dispatched Orders</h3>");
                    }
                    out.write(" </div>");
                    out.write(" </div>");
                    out.write(" </div>");

                }

                //end =======================================================
                //get User Purchesed Data
                if (request.getParameter("Getdata") != null && request.getParameter("Getdata").equalsIgnoreCase("PurcheseData") && l != null) {
                        
                    if(request.getParameter("ratepid")!=null){
                        Products rp=(Products) s.createCriteria(DB.Products.class)
                                .add(Restrictions.eq("idProducts", new Integer(request.getParameter("ratepid")))).uniqueResult();
                       
                        //add new product
                        if(rp!=null){
                          Ratings cr=(Ratings) s.createCriteria(DB.Ratings.class)
                                            .add(Restrictions.and(Restrictions.eq("products", rp), Restrictions.eq("user", l.getUser()))).uniqueResult();
                          if(cr==null&&request.getParameter("rate")!=null){
                          Ratings r=new Ratings();
                        r.setProducts(rp);
                        r.setRate(new Double(request.getParameter("rate")));
                        r.setRateDate(new Date());
                        r.setStatus("1");
                        r.setUser(l.getUser());
                        
                        s.save(r);
                         s.flush();
                 s.beginTransaction().commit(); 
                          } else{
                           //customer need to add again product rate
                        if(request.getParameter("addagain")!=null){
                            System.out.println("delete user rating of product");
                        s.delete(cr);    s.flush();
                 s.beginTransaction().commit(); 
                        }
                          
                          } 
                        
                        
                        }
                       
                        
                    }
                    
                    Criteria invo = s.createCriteria(DB.Invoice.class)
                            .add(Restrictions.eq("user", l.getUser()));
                    

                        if (request.getParameter("date") != null&&!(request.getParameter("date").equals("") )) {

                            try {
                                System.out.println(request.getParameter("date"));
                                String string = request.getParameter("date").toString();
                                DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
                                Date date = format.parse(string);
                        invo.add(Restrictions.eq("date", date));
                                
                            } catch (Exception ex) {
                                System.out.println(ex);
                            }

                        }

                        if (request.getParameter("invoid") != null&&!(request.getParameter("invoid").equals("all"))) {

                            invo.add(Restrictions.eq("idInvoice", new Integer(request.getParameter("invoid"))));
                        }
                        ArrayList<Products> pal=new ArrayList();
                        List<Invoice> inl = invo.list();
                    if (invo != null) {
                        
                        if(inl.size()>0){
                        for (Invoice ii : inl) {

                            List<InvoiceHasGrnHasProducts> ihpl = s.createCriteria(DB.InvoiceHasGrnHasProducts.class)
                                    .add(Restrictions.eq("invoice", ii)).list();

                            for (InvoiceHasGrnHasProducts ihpi : ihpl) {
                                Products pp = (Products) s.createCriteria(DB.Products.class)
                                        .add(Restrictions.and(Restrictions.eq("idProducts", ihpi.getGrnHasProducts().getProducts().getIdProducts()),
                                                        Restrictions.eq("status", 1))).uniqueResult();
                                
                                
                                if (pp != null) {
                                    
                                    //Manage repeat of view Product
                                    if(!(pal.contains(pp))){
                                     pal.add(pp);
                                    out.write("<div class=\"panel panel-body\" style=\"box-shadow: 2px 2px 10px 1px #cccccc;\">");
                                    out.write("<div style=\"display:inline \">");
                                    out.write("<div class=\"col-md-3\">");
                                    out.write("<img src=\"" + pp.getImg() + "\" style=\"width:150px;height:150px;cursor: pointer;\" onclick=\"window.location.href='UniqProductView.jsp?repid=" + pp.getIdProducts() + "'\" >");
                                    out.write(" </div>");
                                    out.write("<div class=\"col-md-3 text-center\">");

                                    ProductsHasBrands phb = (ProductsHasBrands) s.createCriteria(DB.ProductsHasBrands.class)
                                            .add(Restrictions.eq("products", pp)).uniqueResult();
                                    if (phb != null) {
                                        out.write("<h2 style=\"font-weight:bold\">"+phb.getBrands().getBrandname()+"</h2>");
                                    }

                                    out.write("<h3 style=\"font-weight:bold\">"+pp.getProductName()+"</h3>");
                                    out.write("<h4 style=\"font-weight:bold\" >"+pp.getPCatergory().getCatName()+"</h4>");
                                    
                                  String rate=new ProductRatingProvider().getRateOfProduct(pp.getIdProducts().toString()).toString();  
                                    out.write("<h4>Ratings <p style=\"font-weight:bold;color:green\">"+rate+"</p></h4>");
                                    out.write("</div>");
                                    out.write("<div class=\"col-md-3 text-center\">");
                                    out.write("<h5>"+new SimpleDateFormat("yyyy-MM-dd").format(ii.getDate())+"</h5>");
                                    out.write("<br>");
                                    out.write("<h4>Invoice Id : "+ii.getIdInvoice()+"</h4>");
                                    out.write("<br>");
                                    out.write("<button class=\"btn btn-default hedder-btn btn-lg\" type=\"button\" onclick=\"BuyAgain('" + pp.getIdProducts() + "')\">Buy Again</button>");
                                    out.write("<br>");
                                    out.write(" <br>");
                                    out.write(" </div>");
                                    out.write("<div class=\"col-md-3 text-center\">");
                                    
                                    Ratings cr=(Ratings) s.createCriteria(DB.Ratings.class)
                                            .add(Restrictions.and(Restrictions.eq("products", pp), Restrictions.eq("user", l.getUser()))).uniqueResult();
                                    if(cr!=null){
                                     out.write("<h5 style=\"color: #cc00ff;font-weight: bold;font-family: cursive\">Your have added "+cr.getRate()+" Rate for this Product</h5>");
                                    }
                                    else{
                                       out.write("<div style=\"display: inline\">");
                                    out.write(" <div class=\"col-md-8\"><input type=\"number\" id=\""+pp.getIdProducts()+"\" min=\"0\" onkeydown=\"return false;\" oncontextmenu=\"javascript:return false;\" max=\"10\" placeholder=\"Rate Me !\" class=\"form-control\">");
                                   out.write("<h6 style=\"color:#663941;font-size:8px\">Add Rate between 0 to 10</h6>");
                                    out.write("</div>");
                                    out.write("<div class=\"col-md-4\">");
                                    out.write(" <button class=\"btn btn-default btn-sm\" type=\"button\" onclick=\"loadAddRateProduct('"+pp.getIdProducts()+"','addrate')\">Add Rate</button></div>");
                                    out.write("</div>");  
                                        
                                   
                                    }
                                    
                                    out.write("<br>");
                                    
                                    out.write("<br><br><br><br>");
                                    
                                    out.write("<button type=\"button\" onclick=\"loadAddRateProduct('"+pp.getIdProducts()+"','addagain')\" class=\"btn btn-warning\">Rate Again</button> ");
                                    out.write(" </div> </div> </div>");
                                    
                                    }
                                   

                                } else {
                                    out.write("<h3>You have No purcheses </h3>");
                                    out.write("<br>");
                                    out.write("<br>");
                                    out.write("<h4>Sorry For  the Unconvenioun</h4>");
                                }

                            }

                        }
                    }else{
                     out.write("<br>");
                        out.write("<br>");
                        out.write("<br>");
                        out.write("<br>");
                        out.write("<center><h3 style=\"color: #ff0000\">You had Not Bought any Product this Day</h3></center>");
                        out.write("<br>");
                        out.write("<br>");
                        out.write("<br>");
                        out.write("<br>");
                    }
                    } else {
                        out.write("<br>");
                        out.write("<br>");
                        out.write("<br>");
                        out.write("<br>");
                        out.write("<center><h3 style=\"color: #ff0000\">Your have Never Bought ? </h3></center>");
                        out.write("<br>");
                        out.write("<br>");
                        out.write("<br>");
                        out.write("<br>");

                        out.write("<a href=\"ViewProduct.jsp\"><img src=\"img/continue-shopping-button.png\" class=\"img-responsive\" align=\"center\"></a> ");
                    }

//                        
                }

                // End =======================================================
             
                
                
                //get invioce of user
                   
                if(request.getParameter("Getdata") != null && request.getParameter("Getdata").equalsIgnoreCase("invoiceData") && l != null){
                
                        List<Invoice> inv=s.createCriteria(DB.Invoice.class)
                                .add(Restrictions.eq("user", l.getUser())).list();
                        
                        if(inv.size()>0){
                            for (Invoice i : inv) {
                              out.write("<div class=\"col-md-1\">\n" +
"                                <img src=\"img/invoice.png\" style=\"width:50px;height:60px  \"s>\n" +
"                            </div>");
                            out.write("<div class=\"panel panel-body\" style=\"box-shadow: 2px 2px 10px 1px #cccccc;\">");
                            out.write("<div style=\"display: inline\">");
                            out.write("<div class=\"col-md-3\">");
                            out.write("<h2 style=\"font-weight: bold\">Invoice Id :&nbsp;<small style=\"color: #990099\">"+i.getIdInvoice()+"</small></h2>");
                            out.write("</div>");
                            out.write("<div class=\"col-md-3\">");
                            out.write("<h2 style=\"font-weight: bold\">Amount :&nbsp;<small style=\"color: #990099\">"+i.getTotal()+"</small></h2>");
                            out.write(" </div>");
                            out.write(" <div class=\"col-md-3\">");
                            int qty=0;
                                List<InvoiceHasGrnHasProducts> ihp=s.createCriteria(DB.InvoiceHasGrnHasProducts.class)
                                        .add(Restrictions.eq("invoice", i)).list();
                                for (InvoiceHasGrnHasProducts ihpi : ihp) {
                                    qty+=ihpi.getInvoqty();
                                    
                                }
                                
                            out.write("<h2 style=\"font-weight: bold\">Quantity :&nbsp;<small style=\"color: #990099\">"+qty+"</small></h2>");
                            out.write("</div>");
                            out.write("<div class=\"col-md-2\">");
                            out.write("<h5 style=\"color:grey\" >Date :"+new SimpleDateFormat("yyyy-MM-dd").format(i.getDate())+" </h5>");
                            
                            out.write("<button class=\"btn btn-default btn-lg\" type=\"button\" onclick=\"window.open('Invoice.jsp?invoiceid="+i.getIdInvoice()+"')\">view</button>");
                           
                            out.write("</div>");
                            out.write("</div></div>");
                            out.write("");  
                                
                                
                            }
                            
                        }else{
                        
                         out.write("<center><h3 style=\"color: #ff0000\">Your have been no invoice </h3></center>");
                        
                        }
                        
                    
                }
                //end =======================================================
                
                //get Message of User================
                
                if(request.getParameter("Getdata") != null && request.getParameter("Getdata").equalsIgnoreCase("messageData") && l != null){
                   
                    if(request.getParameter("msgid")!=null){
                        
                       Messages mi=(Messages) s.createCriteria(DB.Messages.class)
                               .add(Restrictions.eq("idMessages",new Integer(request.getParameter("msgid")))).uniqueResult();
                        if(mi!=null){
                         out.write("<div class=\"modal-header\" style=\"background-color:#0099ff;color: #ffffff\">");
                        out.write("<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>");
                        out.write("<h2 class=\"modal-title\" style=\"font-weight: bold\"><img src=\"img/message.png\" style=\"width:50px;height:50px\"> Message View </h2>");
                        out.write("</div>");
                        out.write("<div class=\"modal-body\">");
                        out.write("<h3>"+mi.getHeding()+"</h3>");
                        out.write("<div style=\"display: inline\">");
                        out.write(" <div class=\"col-md-6\">");
                        out.write(" <h5 style=\"font-weight: bold\">Date :<small>"+new SimpleDateFormat("yyyy-MM-dd").format(mi.getMdate())+"</small></h5>");
                        out.write(" </div>");
                        out.write("<div class=\"col-md-6\">");
                        out.write("<h5 style=\"font-weight: bold\">From : <small>Administer</small></h5>");
                        out.write("</div> </div>");
                        out.write(" <br> <br> <br>");
                        out.write("<h5 style=\"font-weight: bold;\" class=\"text-left\">Message Body</h5>");
                        out.write("<div class=\"panel panel-body panel-info\">");
                        out.write("<p style=\"font-size:20px;font-family: cursive \">");
                        out.write(" "+mi.getMbody()+"");
                        out.write("</p>");
                        out.write(" </div>");
                        out.write("</div>");
                        out.write(" <div class=\"modal-footer\"> </div>");
                        
                        mi.setStatus("1");
                        s.update(mi);
                         s.flush();
                 s.beginTransaction().commit(); 
                        }
                       
                 
                    
                    }else{
                        List<Messages> um=s.createCriteria(DB.Messages.class)
                                .add(Restrictions.eq("user", l.getUser())).addOrder(Order.desc("idMessages")).list();
                        
                        if(um.size()>0){
                            for (Messages m : um) {
                                
                               
                                out.write("<div class=\"panel panel-body\" style=\"box-shadow: 2px 2px 10px 1px #cccccc;\">");
                                 if(m.getStatus().equals("0")){
                                out.write("<span class=\"badge\" style=\"background-color: #33cc00;left:200px\">New</span>");
                                }
                                out.write("<div style=\"display:inline \">");
                                out.write("<div class=\"col-md-1\">");
                                out.write("<img src=\"img/message.png\" style=\"width:60px;height:60px\">");
                                out.write("</div>");
                                out.write("<div class=\"col-md-4\">");
                                out.write("<h4 style=\"font-weight: bold\">"+m.getHeding()+"</h4>");
                                out.write("</div>");
                                out.write("<div class=\"col-md-4\" >");
                                out.write(" <h5 style=\"font-weight: bold\">From : <small>Administer</small></h5>");
                                out.write(" </div>");
                                out.write("<div class=\"col-md-2\" style=\"color: #999999\">");
                                out.write("<h6>Date : <small>"+new SimpleDateFormat("yyyy-MM-dd").format(m.getMdate())+"</small></h6>");
                                if(m.getMtime()!=null){
                                 out.write(" <h6>Time : <small>"+new SimpleDateFormat("hh:mm a").format(m.getMtime())+"</small></h6>");
                                }else{
                                 out.write(" <h6>Time : <small>12:15 pm</small></h6>");
                                }
                                
                               
                                out.write(" </div> ");
                                out.write("<div class=\"col-md-1\">");
                                out.write("<button class=\"btn btn-default btn-lg\" type=\"button\" onclick=\"viewMessage('"+m.getIdMessages()+"')\">View</button>");
                                out.write("</div>");
                                out.write("  </div>  </div>");
                                out.write("");
                                
                            }
                        
                        }else{
                        
                        out.write("<center><h3 style=\"color: #ff0000\">Your have been no Messages </h3></center>");
                        }
                        
                        
                        
                    }
                    
                }
                
                
                //end ===============================
               //check user new Updates================================================
                if (request.getParameter("GetUpdate") != null && l != null) {
                    int nwish = 0;
                    int nmsg = 0;
                    int norders = 0;
                    int ninvoice = 0;
                    Wishlist uwl = (Wishlist) s.createCriteria(DB.Wishlist.class)
                            .add(Restrictions.eq("user", l.getUser())).uniqueResult();
                    if (uwl != null) {
                        List<WishlistHasGrnHasProducts> whpl = s.createCriteria(DB.WishlistHasGrnHasProducts.class)
                                .add(Restrictions.and(Restrictions.eq("wishlist", uwl), Restrictions.eq("status", "0"))).list();
                        for (WishlistHasGrnHasProducts wishlistHasProducts : whpl) {
                            System.out.println(wishlistHasProducts);
                            nwish += 1;
                        }
                    }

                    List<Ordering> uod = s.createCriteria(DB.Ordering.class)
                            .add(Restrictions.and(Restrictions.eq("user", l.getUser()), Restrictions.eq("status", "0"))).list();
                    if (uod.size() > 0) {
                        for (Ordering order : uod) {
                            norders += 1;
                        }
                    }
                    List<Messages> um=s.createCriteria(DB.Messages.class)
                            .add(Restrictions.and(Restrictions.eq("user", l.getUser()), Restrictions.eq("status", "0"))).list();
                    for (Messages m : um) {
                        nmsg+=1;
                    }
                    try {
                        //for navibar new Notification
                        if(request.getParameter("totalcount")!=null){
                         List<Notifications> diso = s.createCriteria(DB.Notifications.class)
                            .add(Restrictions.and(Restrictions.eq("user", l.getUser()), Restrictions.eq("status", "1"))).list();
                    int notitol=0;
                    if (diso.size() > 0) {
                        for(Notifications nt:diso){
                        notitol++;
                         }
                    }
                        out.print(notitol+"");
                        }
                        //for view Profile
                        else{
                        JSONObject j = new JSONObject();
                        j.put("nwish", nwish);
                        j.put("nmsg", nmsg);
                        j.put("norders", norders);
                        j.put("ninvoice", ninvoice);
                        out.print(j);
                        }
                    } catch (Exception e) {
                        System.out.println(e);
                    }

                }  
                
            } //user not sign back to login
            else {
              //user not available redirect to home
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
