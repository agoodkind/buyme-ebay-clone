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
<link rel="stylesheet" type="text/css" href="style.css">
    <meta charset="UTF-8">
    <title>Create an Auction - buyMe</title>
</head>
<body>
<t:logged_in_header/>
<h4>Please enter the item you would like to get alerted for if it becomes available as an auction:</h4>
<form method="post">
    <table>
        <tr>
            <td>Size</td>
            <td><input type="number" maxlength="4" required="required" name="size"></td>
        </tr>
        <tr>
            <td>Gender</td>
            <td><input type="radio" required="required" name="gender" value="Male">Male</td>
            <td><input type="radio" required="required" name="gender" value="Female">Female</td>
            <td><input type="radio" required="required" name="gender" value="Unisex">Unisex</td>
        </tr>
        <tr>
            <td>Item Name</td>
            <td><input type="text" maxlength="50" required="required" name="item_name"></td>
        </tr>
        <tr>
            <td>Item Type</td>
            <td><input type="radio" required="required" name="item_type" value="Accessories">Accessories</td>
            <td><input type="radio" required="required" name="item_type" value="Pants">Pants</td>
            <td><input type="radio" required="required" name="item_type" value="Shirts">Shirts</td>
            <td><input type="radio" required="required" name="item_type" value="Undergarments">Undergarments</td>
        </tr>

    </table>
    <%
        Cookie forward_to =  new Cookie("forward_to", "add_alert_to_wishlist.jsp");
        response.addCookie( forward_to );
    %>
    <c:set var="forward_to" value="add_alert_to_wishlist.jsp"/>
    <button formaction="select_item_details.jsp" formmethod="get" type="submit">Continue</button>
</form>
</body>
</html>

<!-- INSERT INTO auction (Auction_id, initial_price, min_price, start_datetime, closing_datetime) VALUES (@auction_id, @user_id, @start_datetime, @closing_datetime);
-->