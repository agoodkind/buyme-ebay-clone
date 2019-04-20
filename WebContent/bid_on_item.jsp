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
    <title>Delete Bid From Auction ${param.auction_id} - buyMe</title>
</head>
<body>
<t:logged_in_header/>


<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>


<c:if test="${empty param.delete_bid and not empty param.amount}">


    <c:if test="${not empty param.upper_limit}">
        <sql:update dataSource="${dataSource}" var="abo">
            insert into Account_Bids_On_Auction(account_id, auction_id, current_bid, upper_limit)
            values
            (${cookie.account_id.value}, ${param.auction_id}, ${param.amount}, ${param.upper_limit});
        </sql:update>


    </c:if>


    <sql:update dataSource="${dataSource}" var="place_bid">
        insert into Manually_Bid_On(amount, auction_id, account_id) values (${param.amount},${param.auction_id},${cookie.account_id.value});
    </sql:update>

    <c:choose>
        <c:when test="${place_bid > 0 or not empty param.upper_limit and abo > 0}">
            A $<c:out value="${param.amount}"/> bid placed successfully
        </c:when>
        <c:otherwise>error placing bid</c:otherwise>
    </c:choose>
</c:if>


</body>
</html>