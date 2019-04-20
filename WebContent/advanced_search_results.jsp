<%--
  Created by IntelliJ IDEA.
  User: Alexander Goodkind amg540
  Date: 2019-04-15
  Time: 23:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="org.apache.commons.lang.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Results - buyMe</title>
</head>
<body>

<t:logged_in_header/>
<%
    try {

        //Get the database connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();


        //Get parameters from the session that were originally stored in continue_creating_item;
        String size = (String) session.getAttribute("size");
        String gender = (String) session.getAttribute("gender");
        String item_type = (String) session.getAttribute("item_type");
        String auction_search = (String) session.getAttribute("auction_search");
        String auction_current_bid_below = (String) session.getAttribute("auction_current_bid_below");
        String auction_ends_num_days_from_now = (String) session.getAttribute("auction_current_bid_below");
        String s_query = (String) session.getAttribute("s_query");


        Object[] field_list_param = (Object[]) session.getAttribute("field_list");

        String[] field_list = new String[field_list_param.length];
        System.arraycopy(field_list_param, 0, field_list, 0, field_list_param.length);

        // String[] field_list = field_list_param.toArray(new String[field_list_param.size()]);
        String[] field_values = new String[field_list.length];

        for (int i = 0; i < field_list.length; i++) {
            field_values[i] = request.getParameter(field_list[i]);
        }



        String queryBuilder = "";

        queryBuilder += "select ci.item_id, ci.item_name, if(t2.auction_id, t2.auction_id, 0) as auction_id, ci.item_type, ci.size, ci.gender, t2.auction_id, t2.current_bid, t2.closing_datetime, t2.start_datetime";


        for (String field_name : field_list) {
            queryBuilder += ", t1." + field_name;
        }

        queryBuilder += " from Clothing_Item ci inner join " + item_type + " t1 on ci.item_id = t1.item_id" +
                " left join (select * from Auction where closing_datetime > NOW()) t2 on ci.item_id = t2.item_id" +
                " where item_name LIKE '%" + StringEscapeUtils.escapeHtml(s_query) + "%'";

        queryBuilder += " AND";

        queryBuilder += " t1." + field_list[0] + "=" + field_values[0];

        if (field_values.length > 0) {
            for (int i = 1; i < field_values.length; i++) {
                queryBuilder += " AND t1." + field_list[i] + " ="  + field_values[i];
            }
        }
        if (auction_search == "true") {
            queryBuilder += " AND t2.auction_id > 0"; // only show items with auctions
        }

        queryBuilder += ";";

        //Create a Prepared SQL statement allowing you to introduce the parameters of the query
        PreparedStatement ps = con.prepareStatement(queryBuilder);

        //Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
        session.setAttribute("field_values", field_values);
        session.setAttribute("advanced_query", queryBuilder);


        con.close();

        response.sendRedirect("item_search.jsp");

    } catch (Exception ex) {
        out.print(ex.getStackTrace());
        out.print(ex);
        out.print("<p>Auction creation failed</p>");
    }
%>


</body>
</html>
