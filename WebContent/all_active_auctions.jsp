<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%--Contributers: Alexander Goodkind amg540--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Active Auctions - buyMe</title>
</head>
<body>

<t:logged_in_header/>

<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>

<sql:query dataSource="${dataSource}" var="all_items">
    select *
    from List_Active_Auctions;
</sql:query>

<table border="1" cellpadding="5">
    <tr>
        <th>Item Name</th>
        <th>Item Category</th>
        <th>Current Bid</th>
        <th>End Date</th>
        <th>Seller</th>
    </tr>

    <c:forEach var="row" items="${all_items.rows}">
        <tr>
            <td><c:out value="${row.item_name}"/></td>
            <td><c:out value="${row.item_type}"/></td>
            <td><c:out value="${row.current_bid}"/></td>
            <td><c:out value="${row.closing_datetime}"/></td>
            <td><c:out value="${row.first_name}"/> <c:out value="${row.last_name}"/></td>
            <td>
                <form>
                    <button value="${row.auction_id}" name="auction_id" formaction="view_auction.jsp">View Auction</button>
                </form>
            </td>
            <c:if test="${sessionScope.account_type == 'Customer Service Representative' or sessionScope.account_type == 'Administrator'}">
                <td>
                    <form>
                        <button name="delete_auction_id" formaction="delete_auction.jsp" value="${row.auction_id}">delete</button>
                    </form>
                </td>
            </c:if>
        </tr>
    </c:forEach>
</table>

</body>
</html>