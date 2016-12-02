/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import source.DatabaseClient;

/**
 *
 * @author k_p0w3r
 */
public class CheckOut extends HttpServlet {

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
        HttpSession ses = request.getSession();
        DatabaseClient db = (DatabaseClient) ses.getAttribute("Database");
        int cos_id = (Integer) ses.getAttribute("cos_id");
        String query = "SELECT * FROM buy_items WHERE Customer_ID=" + cos_id + " AND payment_status=0;";
        Vector<Vector<Object>> cartproducts = db.searchSQL(query);
        query = "SELECT * FROM kenessary_koishybay.product;";
        Vector<Vector<Object>> allproducts = db.searchSQL(query);
        for (Vector<Object> cartproduct : cartproducts) {
            int id = (Integer) cartproduct.get(2);
            int buyStock = (Integer) cartproduct.get(3);
            int j = 0;
            for (; j < allproducts.size(); j++) {
                int m = (Integer) allproducts.get(j).get(0);
                if (m == id) {
                    break;
                }
            }
            int stock = (Integer) allproducts.get(j).get(4) - buyStock;
            if (stock < 0) {
                stock = 0;
            }
            query = "UPDATE product SET Stock = " + stock + " WHERE ID=" + id + ";";
            db.insertSQL(query);
        }

        query = "DELETE FROM buy_items\n"
                + "WHERE Customer_ID=" + cos_id + ";";
        db.insertSQL(query);
        response.sendRedirect("cart.jsp");
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
