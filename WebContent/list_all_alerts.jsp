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

<%-- comment --%>

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
        <th>Time</th>
        <th>Alert Type</th>
        <th>Message</th>
        <th>Alert Read</th>
    </tr>

    <c:if test="${not empty param.alert_id}">
        <sql:transaction dataSource="${dataSource}">
            <sql:update var="alert_marked">
                UPDATE Alerts
                SET alert_read = 1
                WHERE alert_id = ${param.alert_id}
            </sql:update>
            <c:if test="${alert_marked == 1}">
                <c:out value="Alert successfully marked as read. (Alert ID: ${param.alert_id}) Refresh page to reflect changes."/><br><br>
            </c:if>
        </sql:transaction>
    </c:if>

    <c:forEach var="row" items="${result.rows}">
        <tr>
            <td><fmt:formatDate value="${row.alert_timestamp}" pattern="h:mm a 'on' MM/dd/yyyy"/></td>
            <td><c:out value="${row.alert_type}"/></td>
            <td><c:out value="${row.alert_message}"/></td>
            <c:choose>
                <c:when test="${row.alert_read == true}">
                    <td><c:out value="Yes"/></td>
                </c:when>
                <c:otherwise>
                    <td><c:out value="No"/><br>
                        <form>
                            <button value="${row.alert_id}" name="alert_id" formaction="list_all_alerts.jsp">Mark as Read</button>
                        </form>
                    </td>
                </c:otherwise>
            </c:choose>
        </tr>
    </c:forEach>


</table>

</body>
</html>