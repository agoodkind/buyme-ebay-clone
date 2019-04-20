<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>

<%-- Mark alert as read --%>
<c:if test="${not empty param.alert_id}">
    <sql:transaction dataSource="${dataSource}">
        <sql:update var="alert_marked">
            UPDATE Alerts
            SET alert_read = 1
            WHERE alert_id = ${param.alert_id}
        </sql:update>
    </sql:transaction>
</c:if>

<%-- Query for alert info --%>
<sql:query dataSource="${dataSource}" var="result">
    select *
    from Alerts
    where alert_id = ${param.alert_id}
</sql:query>

<%--Contributers:
Amulya Mummaneni asm229
<--%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <c:set var="myTitle" value="${'View Individual Alert'}"/>
    <title>${myTitle} - buyMe</title>
</head>
<body>

<t:logged_in_header />

<%-- comment --%>

<h2>View Individual Alert</h2>
<table border="1" cellpadding="5">
    <tr>
        <th>Time of Alert</th>
        <th>Alert Type</th>
        <th>Message</th>
        <th></th>
    </tr>

    <tr>
        <td><fmt:formatDate value="${result.rows[0].alert_timestamp}" pattern="h:mm a 'on' MM/dd/yyyy"/></td>
        <td>
            <c:choose>
                <c:when test="${result.rows[0].alert_type == 'Bids_Alerts'}">
                    <c:out value="${'Bid Alert'}"/>
                </c:when>
                <c:when test="${result.rows[0].alert_type == 'Wishlist_Alerts'}">
                    <c:out value="${'Wishlist Alert'}"/>
                </c:when>
                <c:when test="${result.rows[0].alert_type == 'Auto_Bid_Alerts'}">
                    <c:out value="${'Auto Bid Alert'}"/>
                </c:when>
                <c:otherwise> <%-- Auction close alert--%>
                    <c:out value="${'Auction Close Alert'}"/>
                </c:otherwise>
            </c:choose>
        </td>
        <td>
            <c:out value="${result.rows[0].alert_message}"/>
        </td>
        <td>
            <form>
                <button value="${result.rows[0].auction_id}" name="auction_id" type="submit" formaction="view_auction.jsp">View Auction</button>
            </form>
        </td>
    </tr>
</table>
<br><br>
<form>
    <button formmethod="get" type="submit" formaction="list_all_alerts.jsp">Go Back to Alerts List</button>
</form>

</body>
</html>