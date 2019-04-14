<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Auction ${request.auction_id} - buyMe</title>
</head>
<body>

<t:logged_in_header />

<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>

<sql:query dataSource="${dataSource}" var="all_items">
    select ac.first_name,
    ac.email_address,
    ac.last_name,
    au.current_bid,
    au.closing_datetime,
    au.start_datetime,
    ci.item_type,
    ci.item_name,
    au.min_price,
    au.initial_price
    from Auction au,
    Account ac,
    Clothing_Item ci,
    Account_Sells_In_Auction asi
    where ac.id = asi.account_id
    and asi.auction_id = au.auction_id
    and au.item_id = ci.item_id
    and au.auction_id = ${param.auction_id};
</sql:query>



<p>Item Name: <c:out value="${all_items.rows[0].item_name}"/></p>
<p>Item Category: <c:out value="${all_items.rows[0].item_category}"/></p>
<p>Auction Start: <c:out value="${all_items.rows[0].start_datetime}"/></p>
<p>Auction End: <c:out value="${all_items.rows[0].closing_datetime}"/></p>

<c:choose>
    <c:when test="${all_items.rows[0].initial_price >= all_items.rows[0].current_bid}">
        <p>Initial Price: <c:out value="${all_items.rows[0].initial_price}"/></p>
    </c:when>
    <c:otherwise>
        <p>Current Bid: <c:out value="${all_items.rows[0].curren_bid}"/></p>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${all_items.rows[0].min_price <= all_items.rows[0].current_bid}">
        <p>Minimum Price Reserve has been met</p>
    </c:when>
    <c:otherwise>
        <p>Minimum Price Reserve has not been met</p>
    </c:otherwise>
</c:choose>

<p>Seller: <c:out value="${all_items.rows[0].first_name}"/> <c:out value="${all_items.rows[0].last_name}"/> <form><button></button></form></p>

</body>
</html>