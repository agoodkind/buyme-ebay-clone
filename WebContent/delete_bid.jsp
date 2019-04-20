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



<c:if test="${not empty param.delete_bid}">
    <sql:update dataSource="${dataSource}" var="delete_from_bid_manual">
        delete from Manually_Bid_On where amount = ${param.amount} and account_id = ${cookie.account_id.value} and auction_id = ${param.auction_id};
    </sql:update>
    <c:if test="${delete_from_bid_manual < 1}">
        <sql:update dataSource="${dataSource}" var="delete_from_bid_auto">
            delete from Auto_Bid_On where amount = ${param.amount} and account_id = ${cookie.account_id.value} and auction_id = ${param.auction_id};
        </sql:update>
    </c:if>

    <c:choose>
        <c:when test="${delete_from_bid_manual > 0 or delete_from_bid_auto > 0}">
            bid deleted
        </c:when>
        <c:otherwise>
            error
        </c:otherwise>
    </c:choose>
</c:if>




</body>
</html>