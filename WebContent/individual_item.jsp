<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Item Page - buyMe</title>
</head>
<body>

    <%-- comment --%>

    <sql:setDataSource var="dataSource"
                       driver="${initParam['driverClass']}"
                       url="${initParam['connectionURL']}"
                       user="${initParam['username']}"
                       password="${initParam['password']}"/>

    <sql:query dataSource="${dataSource}" var="result">
        select *
        from Item;
        <%--  where item_id = ??? --%>
    </sql:query>

    <button formaction="createBids.jsp" type="submit">Bid On This Item</button>


</body>
</html>