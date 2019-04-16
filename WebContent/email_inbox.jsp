<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%--Contributers:
Alexander Goodkind amg540,
Amulya Mummaneni asm229
--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inbox - buyMe</title>
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
    select e.from_account_id,
    e.timesent,
    e.message_subject,
    e.message_id,
    a.first_name,
    a.last_name,
    a.email_address
    from Email e, Account a
    where e.from_account_id = a.id and e.to_account_id = ${cookie.account_id.value}
    order by e.timesent desc;
</sql:query>

<h2>View All Email</h2>
<table border="1" cellpadding="5">
    <tr>
        <th>From</th>
        <th>Subject</th>
        <th>Time</th>
    </tr>

    <c:forEach var="row" items="${result.rows}">
        <tr>
            <td><c:out value="${row.first_name} ${row.last_name}"/>&comma;&nbsp;<i>&lt;<c:out value="${row.email_address}"/>&gt;</i></td>
            <td><c:out value="${row.message_subject}"/></td>
            <td><fmt:formatDate value="${row.timesent}" pattern="h:mm a 'on' MM/dd/yyyy"/></td>
            <td>
                <form>
                    <button value="${row.message_id}" name="message_id" formaction="individual_email.jsp">Open</button>
                </form>
            </td>
            <td>
                <form>
                    <button value="${row.email_address}" name="email_address" formaction="contact_form.jsp">Reply</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>