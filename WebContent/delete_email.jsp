<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%--Contributers:
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
<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>

<sql:transaction dataSource="${dataSource}">
    <sql:update var="alert_marked">
        DELETE FROM Email
        WHERE message_id = ${param.message_id}
    </sql:update>
</sql:transaction>
<br><br>Email successfully deleted.<br>
<br>
<form>
    <button formmethod="get" type="submit" formaction="email_inbox.jsp">Go Back to Email Inbox</button>
</form>

</body>
</html>