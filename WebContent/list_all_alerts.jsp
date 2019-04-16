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
    <title>Alerts - buyMe</title>
</head>
<body>

<t:logged_in_header/>

<%--Contributers:
Amulya Mummaneni asm229
--%>

<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>

<sql:query dataSource="${dataSource}" var="result">
    select *
    from Alerts
    where account_id= ${cookie.account_id.value}
    order by alert_timestamp desc;
</sql:query>

<h2>View All Alerts</h2>
<table border="1" cellpadding="5">
    <tr>
        <th>Time of Alert</th>
        <th>Alert Type</th>
        <th>Message</th>
        <th>Alert Read</th>
        <th></th>
    </tr>

    <c:forEach var="row" items="${result.rows}">
        <tr>
            <td><fmt:formatDate value="${row.alert_timestamp}" pattern="h:mm a 'on' MM/dd/yyyy"/></td>
            <td>
                <c:choose>
                    <c:when test="${row.alert_type == 'Bids_Alerts'}">
                        <c:out value="${'Bid Alert'}"/>
                    </c:when>
                    <c:when test="${row.alert_type == 'Wishlist_Alerts'}">
                        <c:out value="${'Wishlist Alert'}"/>
                    </c:when>
                    <c:when test="${row.alert_type == 'Auto_Bid_Alerts'}">
                        <c:out value="${'Auto Bid Alert'}"/>
                    </c:when>
                    <c:otherwise> <%-- Auction close alert--%>
                        <c:out value="${'Auction Close Alert'}"/>
                    </c:otherwise>
                </c:choose>
            </td>
            <td><c:out value="${row.alert_message}"/></td>
            <td>
                <c:choose>
                    <c:when test="${row.alert_read == true}">
                        <c:out value="Yes"></c:out>
                    </c:when>
                    <c:otherwise>
                        <c:out value="No"></c:out>
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                <form>
                    <button value="${row.alert_id}" name="alert_id" formaction="view_individual_alert.jsp">View Alert</button>
                </form>
            </td>
        </tr>
    </c:forEach>


</table>

</body>
</html>