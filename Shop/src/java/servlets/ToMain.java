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
import source.*;

/**
 *
 * @author k_p0w3r
 */
public class ToMain extends HttpServlet {

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

        DatabaseClient db = new DatabaseClient();

        String query = "";
        HttpSession ses = request.getSession();
        boolean goLog = true;

        if (ses.getAttribute("from").equals("login")) {

            String email = request.getParameter("email");
            String pass = request.getParameter("pass");

            query = "select *\n"
                    + "from customer\n"
                    + "where Email=\'" + email + "\';";

            Vector<Vector<Object>> data = db.searchSQL(query);
                      
            System.out.println("From Login");
            ses.setAttribute("LogError", "Incorrect Email");
            if (data.size() > 0) {
                Vector<Object> vec = data.get(0);
                
                if (vec.size() > 0) {
                    ses.setAttribute("LogError", "Incorrect Password");
                    
                    if (pass.equals(vec.get(3))) {
                        
                        ses.setAttribute("logon", true);
                        ses.setAttribute("nick", vec.get(1));
                        ses.setAttribute("cos_id", vec.get(0));
                        
                        query = "SELECT * FROM buy_items WHERE Customer_ID=" + vec.get(0) + " AND payment_status=0;";
                        Vector<Vector<Object>> cartproducts = db.searchSQL(query);
                        ses.setAttribute("cos_cart", cartproducts);
                        
                        ses.setAttribute("LogError", "");
                        ses.setAttribute("RegError", "");
                        ses.setAttribute("Database", db);
                        goLog = false;
                        response.sendRedirect("main.jsp");
                    }
                }
            }
        } else {
            System.out.println("Registration");            
            String reg_email = request.getParameter("reg_email");
            String reg_pass = request.getParameter("reg_pass");
            
            query = "select *\n"
                    + "from customer\n"
                    + "where Email=\'" + reg_email + "\';";

            Vector<Vector<Object>> data = db.searchSQL(query);
            
            if (data.size() == 0) {
                String payment = request.getParameter("payment");
                int max_id = 0;
                query = "SELECT max(Customer_ID)\n"
                        + "FROM customer";
                if (db.searchSQL(query).get(0).get(0) != null) {
                    max_id = (int) db.searchSQL(query).get(0).get(0);
                }

                max_id++;
                query = "INSERT INTO customer\n"
                        + "VALUES (" + max_id + ",\'" + reg_email + "\',\'" + payment + "\',\'" + reg_pass + "\');";

                db.insertSQL(query);
                ses.setAttribute("RegError", "");
            } else {
                ses.setAttribute("RegError", "Mail already exists");
                response.sendRedirect("registration.jsp");
                goLog = false;
            }
        }
        if (goLog) {
            response.sendRedirect("login.jsp");
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
