<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Auction</title>
</head>
<body>
<%
    try {

        //Get the database connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        //Create a SQL statement
        Statement stmt = con.createStatement();
        //Get parameters from the HTML form at the HelloWorld.jsp
        String initial_price = request.getParameter("initial_price");
        String min_price = request.getParameter("min_price");
        String start_datetime = request.getParameter("start_datetime");
        String closing_datetime = request.getParameter("closing_datetime");


        String size = request.getParameter("size");
        String gender = request.getParameter("gender");
        String item_name = request.getParameter("item_name");
        String item_type = request.getParameter("item_type");

        PreparedStatement ps;

        ps = con.prepareStatement("insert into Clothing_Item (size, gender, item_name, item_type) values(?, ?, ?, ?)");

        ps.setString(1, size);
        ps.setString(2, gender);
        ps.setString(3, item_name);
        ps.setString(4, item_type);
        //Run the query against the DB
        ps.executeUpdate();


        ps=con.prepareStatement("select auction_id from Auction where closing_datetime=?");
        // check if emaila already exists
        //String checkString = "SELECT COUNT(*) FROM account WHERE email_address = ?";
        //ps = con.prepareStatement(checkString);
        ps.setString(1, initial_price);

        ps=con.prepareStatement("select max(item_id) from Clothing_Item");
        ResultSet result = ps.executeQuery();
        result.next();
        String item_id_string = result.getString("max(item_id)");

        System.out.print("here: " + item_id_string);

        //Make an insert statement for the Sells table
        //String insert = "INSERT INTO Auction(initial_price, min_price, start_datetime, closing_datetime, item_id) VALUES(?, ?, ?, ?, ?)";
        String insert = "insert into Auction(initial_price, min_price, start_datetime, closing_datetime, item_id) values(?, ?, ?, ?, ?)";
        //Create a Prepared SQL statement allowing you to introduce the parameters of the query

        ps = con.prepareStatement(insert);

        //Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
        ps.setString(1, initial_price);
        ps.setString(2, min_price);
        ps.setString(3, closing_datetime);
        ps.setString(4, closing_datetime);
        ps.setString(5, item_id_string);

        //Run the query against the DB
        ps.executeUpdate();

        //Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
        con.close();

        out.print("<p>Auction created!</p>");

    } catch (Exception ex) {
        out.print(ex);
        out.print("<p>Auction creation failed</p>");
    }
%>
</body>
</html>