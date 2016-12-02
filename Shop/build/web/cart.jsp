<%-- 
    Document   : cart
    Created on : Nov 23, 2016, 1:59:41 PM
    Author     : k_p0w3r
--%>

<%@page import="java.util.Vector"%>
<%@page import="source.DatabaseClient"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>

        <%
            if (request.getSession().getAttribute("logon") != null) {
                if (!((Boolean) request.getSession().getAttribute("logon"))) {
                    response.sendRedirect("login.jsp");
                }
            } else {
                response.sendRedirect("login.jsp");
            }
        %>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
        <title>Cart</title>
        <link rel="stylesheet" href="css_cart/style.css" type="text/css" media="all" />

        <script src="main_css/js/jquery-1.4.1.min.js" type="text/javascript"></script> 
        <script src="main_css/js/jquery.jcarousel.pack.js" type="text/javascript"></script> 
        <script src="main_css/js/jquery.slide.js" type="text/javascript"></script> 
        <script src="main_css/js/jquery-func.js" type="text/javascript"></script>


    </head>

    <body>

        <%
            HttpSession ses = request.getSession();
            DatabaseClient db = (DatabaseClient) ses.getAttribute("Database");
            int cos_id = (Integer) ses.getAttribute("cos_id");
            String query = "SELECT * FROM kenessary_koishybay.product;";
            Vector<Vector<Object>> allproducts = db.searchSQL(query);

            query = "SELECT * FROM buy_items WHERE Customer_ID=" + cos_id + " AND payment_status=0;";
            Vector<Vector<Object>> cartproducts = db.searchSQL(query);
        %>
        <script type="text/javascript">
            function deleteProd(id) {
                var total = parseFloat(document.getElementById("totalprice").innerHTML);
                var price = parseFloat(document.getElementById("pr_" + id).innerHTML);
                var quantity = parseFloat(document.getElementById("sel_" + id).value);
                total = total - quantity * price;
                document.getElementById("totalprice").innerHTML = total + ".0";
            }

            function updateTotal(prod_id) {
                var total = parseFloat(0);

                var prices = document.getElementsByClassName("myprices");
                var selects = document.getElementsByClassName("selects");
                for (i = 0; i < prices.length; i++) {
                    var quantity = parseFloat(selects[i].value);
                    var id = prices[i].id;
                    id = id.substring(3, id.length);
                    if (prod_id == id) {
                        document.location.href = "AddQty?qty=" + quantity + "&prod_id=" + id;
                    }
                    total = total + quantity * parseFloat(prices[i].innerHTML);
                }
                document.getElementById("totalprice").innerHTML = parseFloat(total) + ".0";
            }
            function callSearch() {

                var myText = document.getElementById("find").value;
                document.location.href = "search.jsp?text=" + myText;
            }
            function callDelete(id) {
                var prod = document.getElementById(id);
                document.location.href = "Delete?id=" + id;
                deleteProd(id);
                prod.parentNode.removeChild(prod);
            }
        </script>
        <!-- Main -->
        <div id="main">
            <div class="shell">

                <!-- Search, etc -->
                <div class="options">
                    <div class="search"> 
                        <span class="field"><input type="text" id="find" class="blink" value="SEARCH" title="SEARCH" /></span> 
                        <img class="search-submit" onclick = "callSearch()" /> 
                    </div>

                    <div class="left">
                        <span class="cart">
                            <a href="main.jsp" class="cart-ico"></a>
                        </span>
                        <span class="left more-links"> 
                            <a href="main.jsp" >                           
                                Main</a>
                        </span>
                    </div>
                    <div class="right">
                        <span class="left more-links"> 
                            <a href="cart.jsp" >                           
                                My Cart</a>
                            <a href="/Logout">Logout</a>
                        </span>
                    </div>
                </div>
                <!-- End Search, etc -->

                <!-- Content -->
                <div id="content">

                    <!-- Tabs -->
                    <div class="tabs">
                        <ul>
                            <li><a href="#" class="active"><span>Checkout</span></a></li>

                        </ul>
                    </div>
                    <!-- Tabs -->

                    <!-- Container -->
                    <div id="container">

                        <div class="tabbed">

                            <!-- First Tab Content -->
                            <div class="tab-content" style="display:block;">
                                <div class="items">
                                    <div class="cl">&nbsp;</div>
                                    <div id="w">
                                        <header id="title">
                                            <h1>SHOPING CART</h1>
                                        </header>
                                        <div id="page">
                                            <table id="cart">
                                                <thead>
                                                    <tr>
                                                        <th class="first">Image</th>
                                                        <th class="second">Qty</th>
                                                        <th class="third">Name</th>
                                                        <th class="fourth">Price</th>
                                                        <th class="fifth">&nbsp;</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        float total = 0.f;
                                                        for (int i = 0; i < cartproducts.size(); i++) {
                                                            Vector<Object> buy_prod = cartproducts.get(i);
                                                            int id = (Integer) buy_prod.get(2);
                                                            int j = 0;
                                                            for (; j < allproducts.size(); j++) {
                                                                int m = (Integer) allproducts.get(j).get(0);
                                                                if (m == id) {
                                                                    break;
                                                                }
                                                            }

                                                            Vector<Object> product = allproducts.get(j);
                                                            int stock = (Integer) product.get(4);
                                                            total = total + (Float) product.get(2);
                                                    %>
                                                    <!-- shopping cart contents -->

                                                    <tr class="productitm" id="<%=id%>">
                                                        <td><img src="main_css/images/<%=id%>.jpg" height = "100" class="thumb"></td>
                                                        <td>
                                                            <select class= "selects" name ="sel_<%=id%>" id="sel_<%=id%>" onchange="updateTotal(<%=id%>);">
                                                                <%
                                                                    int amount = (Integer) buy_prod.get(3);
                                                                    for (int k = 1; k <= stock; k++) {
                                                                        if (amount == k) {
                                                                %>
                                                                <option selected ><%=k%></option>
                                                                <%
                                                                } else {
                                                                %>
                                                                <option value="<%=k%>"><%=k%></option>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </select>
                                                        </td>
                                                        <td><%=product.get(3)%></td>
                                                        <td class = "myprices" id="pr_<%=id%>"><%=product.get(2)%></td>
                                                        <td>
                                                            <span class="remove"><img onclick="callDelete(<%=id%>)" src="images/trash.png" alt="X"></img></span>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>

                                                    <!-- tax + subtotal -->

                                                    <tr class="totalprice">
                                                        <td class="light">Total:</td>
                                                        <td colspan="2">&nbsp;</td>

                                                        <td colspan="2"><span class="thick"
                                                            id="totalprice"><script>updateTotal(0);</script></span></td>
                                                    </tr>

                                                    <!-- checkout btn -->
                                                    <tr class="checkoutrow">
                                                        <td colspan="5" class="checkout"><button id="submitbtn" onclick="document.location.href='CheckOut';">Checkout Now!</button></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="cl">&nbsp;</div>
                                </div>
                            </div>
                            <!-- End First Tab Content -->



                        </div>

                        <!-- Brands -->


                        <!-- Footer -->
                        <div id="footer">
                            <div class="left">
                                <span>|</span>
                                <a href="main.jsp">The Store</a>
                                <span>|</span>
                            </div>
                            <div class="right">
                                &copy; FancyShop.com 
                            </div>
                        </div>
                        <!-- End Footer -->

                    </div>
                    <!-- End Container -->

                </div>
                <!-- End Content -->

            </div>
        </div>
        <!-- End Main -->

    </body>
</html>
