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
                    <button formaction="view_auction.jsp" value="${item.rows[0].auction_id}" type="submit" formmethod="post">Bid On This Item</button>
                </form>
            </c:when>
            <c:otherwise>
                <sql:transaction dataSource="${dataSource}">
                    <sql:update var="place_bid">
                        insert into Manually_Bid_On(amount, auction_id, account_id)
                        values(${param.amoun},${item.rows[0].auction_id},${cookie.account_id.value});
                    </sql:update>

                    <c:if test="${place_bid == 1}">
                        A <c:out value="${param.amount}"/> placed successfully
                    </c:if>
                </sql:transaction>
            </c:otherwise>
        </c:choose>

    </body>
</html>