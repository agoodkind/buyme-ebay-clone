<%--
Contributers:
Michael Wang mtw95
Alexander Goodkind amg540
--%>

<%--
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
<%@ page import="org.apache.commons.lang.StringUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create an Auction - buyMe</title>
</head>
<body>
<t:logged_in_header/>
<%
    try {

        //Get the database connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        //Create a SQL statement
        Statement stmt = con.createStatement();

        String size = (String) session.getAttribute("size");
        String gender = (String) session.getAttribute("gender");
        String item_name = (String) session.getAttribute("item_name");
        String item_type = (String) session.getAttribute("item_type");

        PreparedStatement ps;

        ps = con.prepareStatement("insert into Clothing_Item (size, gender, item_name, item_type) values(?, ?, ?, ?)");

        ps.setString(1, size);
        ps.setString(2, gender);
        ps.setString(3, item_name);
        ps.setString(4, item_type);
        //Run the query against the DB
        ps.executeUpdate();


        ps = con.prepareStatement("select max(item_id) as item_id from Clothing_Item");
        ResultSet result = ps.executeQuery();
        result.next();
        String item_id_string = result.getString("item_id");


        Object[] field_list_param = (Object[]) session.getAttribute("field_list");

        String[] field_list = new String[field_list_param.length];
        System.arraycopy(field_list_param, 0, field_list, 0, field_list_param.length);

        String[] field_values = new String[field_list.length];

        for (int i = 0; i < field_list.length; i++) {
            field_values[i] = request.getParameter(field_list[i]);
        }
// insert into relative clothing type
        String insert = "insert into " + item_type + "(item_id, " + StringUtils.join(field_list, ",") + ") values(" + item_id_string + "," + StringUtils.join(field_values, ",") + ")";

        ps = con.prepareStatement(insert);


        ps.executeUpdate();

        //Make an insert statement for the Sells table
        //String insert = "INSERT INTO Auction(initial_price, min_price, start_datetime, closing_datetime, item_id) VALUES(?, ?, ?, ?, ?)";
        insert = "insert into Wishlist(item_id, account_id) values(" +
                 "" + item_id_string + " , " +  (String) session.getAttribute("account_id") + " )";
        //Create a Prepared SQL statement allowing you to introduce the parameters of the query

        ps = con.prepareStatement(insert);

        //Run the query against the DB
        ps.executeUpdate();

        //Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
        con.close();

        out.print("<p>Added to wishlist! You will get an alert when a similar item is made available for auction.</p>");


    } catch (Exception ex) {
        out.print(ex.getStackTrace());
        out.print(ex);
        out.print("<p> failure</p>");
    }
%>
</body>
</html>
