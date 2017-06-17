/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Resources;

import Connection.NewHibernateUtil;
import DB.GrnHasProducts;
import DB.Productoffers;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Gihan
 */
public class ViewProductManager extends HttpServlet {

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
            if (request.getParameter("status") != null && request.getParameter("status").equalsIgnoreCase("viewitems")) {

                String idcat = "idp_catergory Like '%'";
                String idbrand = "idBrands Like '%'";
                String rates = " ORDER BY sellprice ASC";
                String pricerange = "sellprice Like '%'";
                String pqty = "grn_has_products.qty>0";
                String arrangeby = "grid";
                String searchval = "";
                int pageno = 1;
                int setCount = 3;

                int minCount = 3;

                // change page types ========================
                if (request.getParameter("pageno") != null) {
                    pageno = new Integer(request.getParameter("pageno"));
                }

                if (request.getParameter("arrange") != null) {
                    arrangeby = request.getParameter("arrange");

                }
                if (request.getParameter("viewcount") != null) {

                    setCount = new Integer(request.getParameter("viewcount"));
                }

                //sorted conditions===============================
                if (request.getParameter("searchval") != null) {
                    searchval = "AND ProductName='" + request.getParameter("searchval") + "' OR brandname='" + request.getParameter("searchval") + "'";
                }

                if (request.getParameter("sortcatid") != null) {

                    idcat = "idp_catergory LIKE'" + request.getParameter("sortcatid") + "'";

                }
                if (request.getParameter("sortbrandid") != null) {

                    idbrand = "idBrands LIKE'" + request.getParameter("sortbrandid") + "'";
                }
                if (request.getParameter("sortrate") != null) {

                    rates = "ORDER BY sellprice " + request.getParameter("sortrate") + "";
                }
                if (request.getParameter("sortpricefrom") != null && request.getParameter("sortpriceto") != null) {

                    pricerange = "sellprice BETWEEN '" + request.getParameter("sortpricefrom") + "' AND '" + request.getParameter("sortpriceto") + "'";
                }

                String sql = "SELECT\n"
                        + "`grn_has_products`.`IdGRNhasProduct`\n"
                        + " , `products`.`idProducts`\n"
                        + " , `products`.`ProductName`\n"
                        + " , `grn_has_products`.`sellprice`\n"
                        + " , `products`.`img`\n"
                        + " , `brands`.`brandname`\n"
                        + " , `p_catergory`.`cat_name`\n"
                        + " , `products`.`description`\n"
                        + "FROM\n"
                        + "    `products_has_brands`\n"
                        + "    INNER JOIN `products` \n"
                        + "        ON (`products_has_brands`.`Products_idProducts` = `products`.`idProducts`)\n"
                        + "    INNER JOIN `brands` \n"
                        + "        ON (`products_has_brands`.`Brands_idBrands` = `brands`.`idBrands`)\n"
                        + "    INNER JOIN `p_catergory` \n"
                        + "        ON (`products`.`P_Catergory_idP_Catergory` = `p_catergory`.`idP_Catergory`)\n"
                        + "    INNER JOIN `grn_has_products` \n"
                        + "        ON (`grn_has_products`.`Products_idProducts` = `products`.`idProducts`)\n"
                        + " WHERE GRNPstatus='1'\n"
                        + "         AND qtystatus='1'  AND `products`.`status`='1' AND grn_has_products.`qty`>0 " + searchval + " AND " + idcat + " AND " + idbrand + " AND " + pricerange + rates;

                SQLQuery quary = s.createSQLQuery(sql);
                List tolitem = quary.list();

                //requested page set pagenation
                if (pageno == 1) {
                    quary.setFirstResult((pageno * setCount) - setCount);
                    quary.setMaxResults((pageno * setCount));
                } else {
                    quary.setFirstResult((pageno * setCount) - setCount);
                    quary.setMaxResults(setCount);
                }

                List l = quary.list();

                int count = 0;
                if (tolitem.size() > 0) {

                    for (Object o : l) {

                        Object[] oa = (Object[]) o;

                        String grnhaspid = oa[0].toString();
                        String idproduct = oa[1].toString();
                        String pname = oa[2].toString();
                        Double uniprice =new Double( oa[3].toString());
                        String img = oa[4].toString();
                        String bname = oa[5].toString();
                        String catname = oa[6].toString();
                        String descrip = oa[7].toString();

                        if (arrangeby.equalsIgnoreCase("list")) {
                            out.print("<div class=\"panel\">");

                            out.write("<div class=\"panel-body\" style=\"box-shadow: 2px 2px 10px 1px #cccccc;height:180px;width:1050px;\">");
                            out.write("<div style=\"display:inline\">");
                            out.write("<div class=\"col-md-2\">");
                            out.write("<img src=\"" + img + "\" "
                                    + "onclick=\"window.location.href='UniqProductView.jsp?repid=" + oa[0].toString() + "'\"  "
                                    + "style=\"width:120px;height:120px;cursor: pointer;\">");

//                         
                            int poffer = 0;//for set offer
                            GrnHasProducts ghp = (GrnHasProducts) s.load(DB.GrnHasProducts.class, new Integer(grnhaspid));
                            if (ghp != null) {
                                Productoffers poff = (Productoffers) s.createCriteria(DB.Productoffers.class)
                                        .add(Restrictions.and(Restrictions.eq("grnHasProducts", ghp),
                                                        Restrictions.eq("dateofview", new Date()))).uniqueResult();
                                if (poff != null&&poff.getOfferstatus().equalsIgnoreCase("1")) {
                                    System.out.println("in offer");
                                    poffer = poff.getPresentage();

                                    out.print(" <span class=\"badge\" style=\"rotation:190deg;\n"
                                            + "                                      background-color:#ff3300;color:#ffffff;position: absolute;\">");
                                    out.print("<h6 style=\"font-weight:bolder;\">");

                                    out.print("Offer " + poff.getPresentage() + "%");
                                    out.print("</h6>");

                                    out.print("</span>");

                                }
                            }
                            out.write("</div>");
                            out.write("<div class=\"col-md-3 text-center\">");

                            out.write("<div><h3 style=\"font-weight:bold \">" + bname + "</h3></div>");

                            out.write("<div><h4 style=\"font-weight:bold\">" + pname + "</h4></div>");
                            out.write("<div>");
                             if (poffer != 0) {
                                out.print("<del style=\"color: #999999;font-size:14px\" >" + uniprice + " LKR</del>");
                                out.print("<br>");
                                out.print("<span style=\"font-weight:bold;color: #33004b;font-size:18px\">" + new DecimalFormat("0.00").format(uniprice - uniprice * poffer / 100) + " LKR</span>");
                            } else {
                                out.print("<span style=\"font-weight:bold;font-size:18px\">" + uniprice + " LKR</span>");
                            }
                            out.write("</div>");
                            out.write("</div>");
                            out.write("<div class=\"col-md-1\"></div>");
                            out.write("<div class=\"col-md-3\">");
                            out.write("<div><h5 style=\"font-weight: bold\">Product Rating :</h5></div>");
                            String rate = new ProductRatingProvider().getRateOfProduct(idproduct).toString();
                            out.write("<p style=\"font-weight:bold;font-size:15px;color:green  \">" + rate + "</p>");
                            out.write(" <div >");
                            out.write(" <h5 style=\"font-weight:bold\">Description : </h5>");
                            out.write("<p class=\"text-center\" style=\"font-size:12px ;color: #cccccc\">");
                            out.write(" " + descrip + "");
                            out.write("<br>");
                            out.write(" Categoery :- " + catname + "");
                            out.write(" </p>");
                            out.write("</div>");
                            out.write(" </div>");
                            out.write("<div class=\"col-md-3 text-center\">");
                            if (request.getSession().getAttribute("username") != null) {
                                out.write("<span class=\"badge\" style=\"background-color:#cc0033;cursor:pointer \"  onclick=\"addWishList('" + idproduct + "')\"><span class=\"glyphicon glyphicon-eye-open\" aria-hidden=\"true\"></span>Add MyWish</span>");
                                out.write("<br>");
                                out.write("<br>");
                            }

                            out.write("<div><button  class=\"btn btn-default hedder-btn btn-lg\" type=\"button\" onclick=\"addToCart('" + idproduct + "','buy')\"  >Buy Now</button></div>");
                            out.write("<br>");

                            out.write("<div><button  class=\" btn btn-default addcart-btn\" type=\"button\"  onclick=\"addToCart('" + idproduct + "','add')\">Add To Cart</button></div>");
                            out.write("</div>");
                            out.write("</div>");
                            out.write("</div>");
                            out.print("</div>");

                        }
                        if (arrangeby.equalsIgnoreCase("grid")) {

                            if (count == 0) {
                                out.write("<div class=\"row\">");
                                out.write("<div class=\"col-md-12\">");
                            }
                            String imgid = "pro" + idproduct;
                            out.write("<div class=\"col-md-4\" style=\"width:33%\">");
                            int poffer = 0;//for set offer
                            GrnHasProducts ghp = (GrnHasProducts) s.load(DB.GrnHasProducts.class, new Integer(grnhaspid));
                            if (ghp != null) {
                                Productoffers poff = (Productoffers) s.createCriteria(DB.Productoffers.class)
                                        .add(Restrictions.and(Restrictions.eq("grnHasProducts", ghp),
                                                        Restrictions.eq("dateofview", new Date()))).uniqueResult();
                                if (poff != null&&poff.getOfferstatus().equalsIgnoreCase("1")) {
                                    System.out.println("in offer");
                                    poffer = poff.getPresentage();

                                    out.print(" <span class=\"badge\" style=\"rotation:190deg;\n"
                                            + "                                      background-color:#ff3300;color:#ffffff;position: absolute;\">");
                                    out.print("<h6 style=\"font-weight:bolder;\">");

                                    out.print("Offer " + poff.getPresentage() + "%");
                                    out.print("</h6>");

                                    out.print("</span>");

                                }
                            }
                            out.write("<div class=\"panel panel-body text-center\" style=\"box-shadow: 5px 5px 20px grey;max-height:500px;min-width:200px\" >");
                            out.write("<img src=\"" + img + "\" class=\"divpimg\" style=\"cursor: pointer;\"  "
                                    + "onclick=\"window.location.href='UniqProductView.jsp?repid=" + idproduct + "'\" id=\"" + imgid + "\" alt=\"...\" width=\"200px\" height=\"200px\">");
                            out.write(" <div class=\"caption\">");
                            out.write(" <div class=\"row\">");//rowstart
                            out.write("<div class=\"col-md-2\"></div>");
                            out.write("<div class=\"col-md-8\">");
                            out.write("<strong><h3 style=\"font-weight:bold\">" + pname + "</h3></strong>");
                            out.write("<h4>" + bname + "</h4>");
                            out.write("<h5>" + catname + "</h5>");
                            out.write(" </div>");
                            out.write("<div class=\"col-md-2\"></div>");
                            out.write("</div>");//row end
                            out.write("<div class=\"row\">");//row start
                            out.write("<div class=\"col-md-2\"></div>");
                            out.write("<div class=\"col-md-8\">");
                            if (poffer != 0) {
                                out.print("<del style=\"color: #999999;font-size:14px\" >" + uniprice + " LKR</del>");
                                out.print("<br>");
                                out.print("<span style=\"font-weight:bold;color: #33004b;font-size:18px\">" + new DecimalFormat("0.00").format(uniprice - uniprice * poffer / 100) + " LKR</span>");
                            } else {
                                out.print("<h4 style=\"color: #999999;font-size:14px;display: none\" >forhidden</h4>");
                                  out.print("<br>");
                                out.print("<span style=\"font-weight:bold;font-size:18px\">" + uniprice + " LKR</span>");
                            }
                            out.write("</div>");
                            out.write(" <div class=\"col-md-2\"></div>");
                            out.write("</div>");//row end
                            out.write("<br>");
                            if (request.getSession().getAttribute("username") != null) {
                                out.write("<span class=\"badge\" style=\"background-color:#cc0033;cursor:pointer \"  onclick=\"addWishList('" + idproduct + "')\"><span class=\"glyphicon glyphicon-eye-open\" aria-hidden=\"true\"></span>Add MyWish</span>");
                                out.write("<br>");
                                out.write("<br>");
//                     out.write("<a href=\"#\" onclick=\"addWishList('"+idproduct+"')\" style=\"color: #009900\"><span class=\"glyphicon glyphicon-eye-open\" aria-hidden=\"true\"></span>Add WishList</a>");
                            }
                            out.write(" <p><button  class=\" btn btn-default addcart-btn\" type=\"button\"  onclick=\"addToCart('" + idproduct + "','add')\">Add To Cart</button> ");
                            out.write("<button  class=\"btn btn-default hedder-btn\" type=\"button\" onclick=\"addToCart('" + idproduct + "','buy')\" >Buy Now</button></p>");
                            out.write("</div>");
                            out.write("</div>");
                            out.write("</div>");

                            count++;
                            if (count == 3 || tolitem.size() < minCount || l.size() < minCount) {
                                if ((tolitem.size() == 1 || l.size() == 1) && count == 1) {

                                    out.write("</div>");
                                    out.write("</div>");
                                }
                                if ((tolitem.size() == 2 || l.size() == 2) && count == 2) {

                                    out.write("</div>");
                                    out.write("</div>");
                                }
                                if (count == 3) {

                                    out.write("</div>");
                                    out.write("</div>");
                                }
                                count = 0;
                            }

                        }

                    }
                    //pagenation manage area =================
                    int pagecounts = 1;
                    if (tolitem.size() > minCount) {
                        pagecounts = tolitem.size() / setCount;
                        if (tolitem.size() % setCount > 0) {
                            pagecounts++;
                        }

                    }
                    out.write("<center>");
                    out.write("<div style=\"display:inline-block\" align=\"center\">");
                    out.write(" <br> <br> <br>");
                    out.write("<nav aria-label=\"Page navigation\">");
                    out.write("<ul class=\"pagination\">");
                    out.write("<li style=\"cursor:pointer\" onclick=\"changePage('prvs',1)\">");
                    out.write(" <a>");
                    out.write("<span aria-hidden=\"true\">&laquo;</span>");
                    out.write("</a>");
                    out.write("</li>");
                    for (int i = 1; i <= pagecounts; i++) {
                        String backcolor = "";
                        String pageid = "page" + i;
                        if (pageno == 1) {
                            backcolor = "#ffff66";
                        }
                        out.write("<li id=\"" + pageid + "\" style=\"cursor:pointer;background-color:" + backcolor + "\"  onclick=\"changePage('" + i + "','max')\"><a>" + i + "</a></li>");

                    }
                    out.write(" <li style=\"cursor:pointer\" onclick=\"changePage('nxt'," + pagecounts + ")\" >");
                    out.write("<a>");
                    out.write("<span aria-hidden=\"true\">&raquo;</span>");
                    out.write("</a>");
                    out.write("</li>");
                    out.write(" </ul>");
                    out.write("</nav>");
                    out.write("</div> ");
                    out.write(" </center>");

                } else {
                    out.write("<div class=\"row\">");
                    out.write("<div class=\"col-md-12\">");
                    out.write("<h4 style=\"color:#cc0000;font-weight:bold  \" >No Products Available</h4>");

                    out.write("</div>");
                    out.write("</div>");
                }

            }
            s.close();

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
