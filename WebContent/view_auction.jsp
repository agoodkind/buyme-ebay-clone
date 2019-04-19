<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%--
Contributers:
Alexander Goodkind amg540
--%>

<%--TODO:  bid history--%>
<%--TODO:  similar items from past month--%>
<%--TODO: link to a user's profile where you can see all the auctions they participated in and started--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Auction ${param.auction_id} - buyMe</title>
</head>
<body>
<t:logged_in_header/>

<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>

<sql:query dataSource="${dataSource}" var="item">
    select distinct ac.first_name,
    au.auction_id,
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

<p>Item Name: <c:out value="${item.rows[0].item_name}"/></p>
<p>Item Category: <c:out value="${item.rows[0].item_category}"/></p>
<p>Auction Start: <c:out value="${item.rows[0].start_datetime}"/></p>
<p>Auction End: <c:out value="${item.rows[0].closing_datetime}"/></p>

<c:choose>
    <c:when test="${item.rows[0].initial_price >= item.rows[0].current_bid}">
        <p>Initial Price: <c:out value="${item.rows[0].initial_price}"/></p>
    </c:when>
    <c:otherwise>
        <p>Current Bid: <c:out value="${item.rows[0].current_bid}"/></p>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${item.rows[0].min_price <= item.rows[0].current_bid}">
        <p>Minimum Price Reserve has been met</p>
    </c:when>
    <c:otherwise>
        <p>Minimum Price Reserve has not been met</p>
    </c:otherwise>
</c:choose>

<p>Seller: <c:out value="${item.rows[0].first_name} ${item.rows[0].last_name}"/></p>
<c:choose>
    <c:when test="${empty param.amount}">
        <form>
            <input type="number" name="amount" placeholder="${item.rows[0].current_bid + 1}"/>
            <button formaction="view_auction.jsp" value="${item.rows[0].auction_id}" type="submit" formmethod="post">Bid
                On This Item
            </button>
        </form>
    </c:when>
    <c:otherwise>
        <sql:transaction dataSource="${dataSource}">
            <sql:update var="place_bid">
                insert into Manually_Bid_On(amount, auction_id, account_id)
                values(${param.amount},${param.auction_id},${cookie.account_id.value});
            </sql:update>

            <c:if test="${place_bid == 1}">
                A <c:out value="${param.amount}"/> placed successfully
            </c:if>
        </sql:transaction>
    </c:otherwise>
</c:choose>

<sql:query dataSource="${dataSource}" var="bid_history">
    select a.first_name,
    a.last_name,
    b.amount
    from Bids b,
    Account a
    where a.id = b.account_id
    and b.auction_id = ${param.auction_id};
</sql:query>

<c:if test="${not empty similar_items.rows}">
    <h3>Bid History:</h3>
    <table border="1" cellpadding="5">
        <tr>
            <th>User</th>
            <th>Amount</th>
        </tr>

        <c:forEach var="row" items="${similar_items.rows}">
            <tr>
                <td><c:out value="${row.first_name}"/> <c:out value="${row.last_name}"/></td>
                <td><c:out value="${row.amount}"/></td>
            </tr>
        </c:forEach>
    </table>
</c:if>


<sql:query dataSource="${dataSource}" var="similar_items">
    select distinct ac.first_name,
    au.auction_id,
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
    and ci.item_name LIKE '%${item.rows[0].item_name}%' and au.auction_id <> ${param.auction_id};
</sql:query>
<c:if test="${not empty similar_items.rows}">
    <h3>Similar Items up for Auction:</h3>
    <table border="1" cellpadding="5">
        <tr>
            <th>Item Name</th>
            <th>Item Category</th>
            <th>Current Bid</th>
            <th>End Date</th>
            <th>Seller</th>
        </tr>

        <c:forEach var="row" items="${similar_items.rows}">
            <tr>
                <td><c:out value="${row.item_name}"/></td>
                <td><c:out value="${row.item_type}"/></td>
                <td><c:out value="${row.current_bid}"/></td>
                <td><c:out value="${row.closing_datetime}"/></td>
                <td><c:out value="${row.first_name}"/> <c:out value="${row.last_name}"/></td>
                <td>
                    <form>
                        <button value="${row.auction_id}" name="auction_id" formaction="view_auction.jsp">View
                            Auction
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>


</body>
</html>