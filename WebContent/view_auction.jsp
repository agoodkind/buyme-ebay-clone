<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%--
Contributers:
Alexander Goodkind amg540
--%>
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
    au.initial_price,
    ac.id as account_id
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
<p>Item Category: <c:out value="${item.rows[0].item_type}"/></p>
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
    <c:when test="${empty param.bid_auction_id}">
        <form>
            <input type="number" name="amount" placeholder="${item.rows[0].current_bid + 1}"/>
            <button formaction="view_auction.jsp" name="bid_auction_id" value="${item.rows[0].auction_id}" type="submit"
                    formmethod="post">Bid
                On This Item
            </button>
        </form>
    </c:when>
    <c:otherwise>
        <sql:transaction dataSource="${dataSource}">
            <sql:update var="place_bid">
                insert into Manually_Bid_On(amount, auction_id, account_id)
                values(${param.amount},${param.bid_auction_id},${cookie.account_id.value});
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
    b.amount,
    a.id,
    a.email_address
    from Bids b,
    Account a
    where a.id = b.account_id
    and b.auction_id = ${param.auction_id};
</sql:query>

<c:if test="${not empty param.delete_bid_auction_id}">
    <sql:update dataSource="${dataSource}" var="delete_from_bid_manual">
        delete from Manually_Bid_On where amount = param.amount and account_id = param.delete_bid_auction_id and auction_id = param.auction_id;
    </sql:update>
    <c:if test="${delete_from_bid_manual < 1}">
        <sql:update var="${dataSource}" var="delete_from_bid_manual">
            delete from Auto_Bid_On where amount = param.amount and account_id = param.delete_bid_auction_id and auction_id = param.auction_id;
        </sql:update>
    </c:if>

</c:if>

<c:choose>
    <c:when test="${not empty bid_history.rows}">
        <h3>Bid History:</h3>
        <table border="1" cellpadding="5">
            <tr>
                <th>User</th>
                <th>Amount</th>
            </tr>

            <c:forEach var="row" items="${bid_history.rows}">
                <tr>
                    <td><c:out value="${row.first_name}"/> <c:out value="${row.last_name}"/> <c:out
                            value="${row.email_address}"/>
                        <form>
                            <button value="${row.id}" name="account_id" formaction="view_user.jsp">View
                                User's Profile
                            </button>
                        </form>
                    </td>
                    <td><c:out value="${row.amount}"/></td>
                    <c:if test="${sessionScope.account_type == 'Administrator' or sessionScope.account_type == 'Customer Service Representative'}">
                        <td style="background-color: red">
                            <form>
                                <input type="hidden" name="amount" value="${row.amount}">
                                <input type="hidden" name="account_id" value="${row.account_id}">
                                <button formaction="view_auction.jsp" value="${row.auction_id}" name="delete_bid_auction_id" type="submit" formmethod="post">Delete Bid</button>
                            </form>
                        </td>
                    </c:if>
                </tr>
            </c:forEach>
        </table>
    </c:when>
    <c:otherwise>
        No bids yet, be the first one!
    </c:otherwise>
</c:choose>

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