<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sales Report - buyMe</title>
</head>
<body>

<t:logged_in_header/>

<%--Contributers:
Amulya Mummaneni asm229
Michael Wang mtw95
--%>

<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>

<%--TOTAL EARNINGS --%>
<sql:query dataSource="${dataSource}" var="total_earnings">
    SELECT SUM(current_bid) as t_e 
    from Auction
    where closing_datetime< NOW() 
    	and current_bid>=min_price;
</sql:query>

<%--EARNINGS PER ITEM--%>
<sql:query dataSource="${dataSource}" var="earnings_per_item">
    SELECT p.auction_id as a, p.current_bid as b
    from Auction p 
    where closing_datetime< NOW() and current_bid>=min_price
    order by p.current_bid DESC;
</sql:query>

<%--EARNINGS PER ITEM TYPE--%>
<sql:query dataSource="${dataSource}" var="earnings_per_item_type">
    SELECT c.item_type as type, SUM(a.current_bid) as earnings
    FROM Clothing_Item c, Auction a
    WHERE c.item_id = a.item_id and a.closing_datetime< NOW() 
    	and a.current_bid>=a.min_price
    group by item_type
    order by earnings DESC;
</sql:query>

<%--EARNINGS PER END USER--%>
<sql:query dataSource="${dataSource}" var="earnings_per_end_user">
 	SELECT a.id as account_id, SUM(p.current_bid) as earnings
    from Auction p, Account_Sells_In_Auction ac, Account a
    where closing_datetime< NOW() and current_bid>=min_price and p.auction_id = ac.auction_id and ac.account_id = a.id
    GROUP BY a.id
    order by earnings DESC;
</sql:query>

<%--BEST SELLING ITEMS (best selling item = the items/auctions with most bids)--%>
<%-- top 5 items --%>
<sql:query dataSource="${dataSource}" var="best_selling_items">
    SELECT b.auction_id as auction_id, COUNT(distinct b.account_id) as count
    FROM Bids b
    group by b.auction_id
    order by count DESC 
    LIMIT 5;
</sql:query>

<%--BEST SELLING USERS (best selling users = the end users with most closed auctions)--%>
<%-- top 5 users --%>
<sql:query dataSource="${dataSource}" var="best_selling_users">
    SELECT id, t1.count as count
	from (
		SELECT c.id, COUNT(*) as count 
		from Account c, Auction d, Account_Sells_In_Auction p
		where d.auction_id = p.auction_id and p.account_id = c.id and
			d.closing_datetime< NOW() and d.current_bid>=d.min_price
 		group by c.id) t1 
 		order by t1.count DESC 
 		LIMIT 5;
</sql:query>

<h2>Sales Report</h2>

<h3>Total Earnings</h3>
<c:forEach var="row" items="${earnings_per_item.rows}">
<c:out value="${row.t_e}"></c:out>
</c:forEach>

<h3>Earnings Per Item</h3>
<table border="1" cellpadding="5">
<tr>
<th>Auction ID</th>
<th>Final Bid</th>
</tr>
<c:forEach var="row" items="${earnings_per_item.rows}">

        <tr>
            <td><c:out value="${row.a}"></c:out></td>
            <td><c:out value="${row.b}"></c:out></td>
        </tr>
</c:forEach>
</table>

<h3>Earnings Per Item Type</h3>
<table border="1" cellpadding="5">
<tr>
<th>Item Type</th>
<th>Earnings</th>
</tr>
<c:forEach var="row" items="${earnings_per_item_type.rows}">

        <tr>
            <td><c:out value="${row.types}"></c:out></td>
            <td><c:out value="${row.earnings}"></c:out></td>
        </tr>
</c:forEach>
</table>

<h3>Earnings Per End User</h3>
<table border="1" cellpadding="5">
<tr>
<th>Account ID</th>
<th>Total Earnings</th>
</tr>
<c:forEach var="row" items="${earnings_per_end_user.rows}">

        <tr>
            <td><c:out value="${row.account_id}"></c:out></td>
            <td><c:out value="${row.earnings}"></c:out></td>
        </tr>
</c:forEach>
</table>

<h3>Best Selling Items (assume best selling item = the items/auctions with most bids) (top 5)</h3>
<table border="1" cellpadding="5">
<tr>
<th>Auction ID</th>
<th>Number of Bids</th>
</tr>
<c:forEach var="row" items="${best_selling_items.rows}">
        <tr>
            <td><c:out value="${row.auction_id}"></c:out></td>
            <td><c:out value="${row.count}"></c:out></td>
        </tr>
</c:forEach>
</table>

<h3>Best Selling Users (assume best selling user = the users with most closed auctions) (top 5)</h3>
<table border="1" cellpadding="5">
<tr>
<th>Account ID</th>
<th>Number of Auctions Sold</th>
</tr>
<c:forEach var="row" items="${best_selling_users.rows}">

        <tr>
            <td><c:out value="${row.id}"></c:out></td>
            <td><c:out value="${row.count}"></c:out></td>
        </tr>
</c:forEach>
</table>

</body>
</html>