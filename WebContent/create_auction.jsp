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
    <link rel="stylesheet" type="text/css" href="style.css">
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


        //Get parameters from the session that were originally stored in continue_creating_item;
        String initial_price = (String) session.getAttribute("initial_price");
        String min_price = (String) session.getAttribute("min_price");
        String start_datetime = (String) session.getAttribute("start_datetime");
        String closing_datetime = (String) session.getAttribute("closing_datetime");
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


        ps = con.prepareStatement("select auction_id from Auction where closing_datetime=?");
        // check if emaila already exists
        //String checkString = "SELECT COUNT(*) FROM account WHERE email_address = ?";
        //ps = con.prepareStatement(checkString);
        ps.setString(1, initial_price);

        ps = con.prepareStatement("select max(item_id) from Clothing_Item");
        ResultSet result = ps.executeQuery();
        result.next();
        String item_id_string = result.getString("max(item_id)");

        // inserting item
        pageContext.setAttribute("item_id", item_id_string);
        pageContext.setAttribute("item_type_name", item_type);

        Object[] field_list_param = (Object[]) session.getAttribute("field_list");

        String[] field_list = new String[field_list_param.length];
        System.arraycopy(field_list_param, 0, field_list, 0, field_list_param.length);
//        Object[] field_list2 = field_list1.toArray();
//        String[] field_list = (String[]) field_list2;

        // String[] field_list = field_list_param.toArray(new String[field_list_param.size()]);
        String[] field_values = new String[field_list.length];

        for( int i = 0; i < field_list.length; i++ ) {
            field_values[i] = request.getParameter(field_list[i]);
        }


/*
        pageContext.setAttribute("field_list", );
        pageContext.setAttribute("field_values", StringUtils.join(field_values, ","));

<sql:update var="create_specific_item">
    insert into ${item_type_name}(item_id, ${field_list})
    values(${item_id},${field_values});
</sql:update>

*/
        String insert = "insert into "+item_type+"(item_id, "+StringUtils.join(field_list, ",")+") values("+item_id_string+","+StringUtils.join(field_values, ",")+")";

        ps = con.prepareStatement(insert);

//        ps.setString(1, item_type);
//        ps.setString(2, StringUtils.join(field_list, ","));
//        ps.setString(3, item_id_string);
//        ps.setString(4, StringUtils.join(field_values, ","));

        ps.executeUpdate();

        //Make an insert statement for the Sells table
        //String insert = "INSERT INTO Auction(initial_price, min_price, start_datetime, closing_datetime, item_id) VALUES(?, ?, ?, ?, ?)";
        insert = "insert into Auction(initial_price, min_price, start_datetime, closing_datetime, item_id) values(?, ?, NOW(), DATE_ADD(NOW(), INTERVAL ? DAY), ?)";
        //Create a Prepared SQL statement allowing you to introduce the parameters of the query

        ps = con.prepareStatement(insert);

        //Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
        ps.setString(1, initial_price);
        ps.setString(2, min_price);
        ps.setString(3, closing_datetime);
        ps.setString(4, item_id_string);

        //Run the query against the DB
        ps.executeUpdate();


        ps = con.prepareStatement("select auction_id from Auction where item_id = " + item_id_string);
        result = ps.executeQuery();
        result.next();
        String auction_id_string = result.getString("auction_id");

        insert = "insert into Account_Sells_In_Auction(auction_Id, account_Id) values( " + auction_id_string + " , " + session.getAttribute("account_id") + ")" ;
        //Create a Prepared SQL statement allowing you to introduce the parameters of the query

        ps = con.prepareStatement(insert);

        ps.executeUpdate();

        //Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
        con.close();

        out.print("<p>Auction created!</p>");

    } catch (Exception ex) {
        out.print(ex.getStackTrace());
        out.print(ex);
        out.print("<p>Auction creation failed</p>");
    }
%>
</body>
</html>