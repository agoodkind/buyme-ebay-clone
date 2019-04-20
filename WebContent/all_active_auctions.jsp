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
    from List_Active_Auctions
    where NOW() < closing_datetime
    order by closing_datetime desc;
</sql:query>

<table border="1" cellpadding="5">
    <tr>
        <th>Item Name</th>
        <th>Item Category</th>
        <th>Size</th>
        <th>Gender</th>
        <th>Current Bid</th>
        <th>End Date</th>
        <th>Seller</th>
        <th>Auction Status</th>
    </tr>

    <c:forEach var="row" items="${all_items.rows}">
        <tr>
            <td><c:out value="${row.item_name}"/></td>
            <td><c:out value="${row.item_type}"/></td>
            <td><c:out value="${row.size}"/></td>
            <td><c:out value="${row.gender}"/></td>
            <td><c:out value="${row.current_bid}"/></td>
            <td><c:out value="${row.closing_datetime}"/></td>
            <td><c:out value="${row.first_name}"/> <c:out value="${row.last_name}"/></td>
            <td><c:choose>
                <c:when test="${row.auction_closed == 1 && row.reserve_not_met == 1}">
                    reserve not met. no one won.
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${row.auction_closed == 1 && row.lost_auction == 1}">
                            you lost the auction
                        </c:when>

                        <c:when test="${row.auction_closed == 1 && row.lost_auction == 0}">
                            You won the auction
                        </c:when>
                        <c:otherwise>
                            Auction has not ended
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose></td>
            <td>
                <form>
                    <button value="${row.auction_id}" name="auction_id" formaction="view_auction.jsp">View Auction</button>
                </form>
            </td>

            <c:choose>
                <c:when test="${sessionScope.account_type == 'Customer Service Representative' or sessionScope.account_type == 'Administrator'}">
                    <td style="background-color: red">
                        <form>
                            <button name="delete_auction_id" formaction="delete_auction.jsp" value="${row.auction_id}">Delete Auction</button>
                        </form>
                    </td>
                    <td style="background-color: red">
                        <form>
                            <button name="update_auction_id" formaction="edit_auction.jsp" value="${row.auction_id}">Edit Auction</button>
                        </form>
                    </td>
                </c:when>
            </c:choose>

        </tr>
    </c:forEach>
</table>

</body>
</html>