<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create an Auction - buyMe</title>
</head>
<body>
<t:logged_in_header/>
<h4>Please enter your auction and item details you would like to sell:</h4>
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

        <tr>
            <td>Initial Price</td>
            <td><input type="number" required="required" name="initial_price"></td>
        </tr>
        <tr>
            <td>Minimum Reserve Price</td>
            <td><input type="number" required="required"name="min_price"></td>
        </tr>
        <tr>
            <td>End Date (Number of days from now)</td>
            <td><input type="number" required="required" name="closing_datetime"></td>
        </tr>

    </table>
    <%
        Cookie forward_to =  new Cookie("forward_to", "create_auction.jsp");
        response.addCookie( forward_to );
    %>
    <button formaction="get_item_details.jsp" formmethod="get" type="submit">Continue</button>
</form>
</body>
</html>

<!-- INSERT INTO auction (Auction_id, initial_price, min_price, start_datetime, closing_datetime) VALUES (@auction_id, @user_id, @start_datetime, @closing_datetime);
-->