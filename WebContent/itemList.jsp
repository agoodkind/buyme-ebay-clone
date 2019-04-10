<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Item List - buyMe</title>
</head>
<body>

<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>

<sql:query dataSource="${dataSource}" var="all_items">
    select *
    from Clothing_Item;
</sql:query>

<c:forEach var="row" items="${all_items.rows}">
    Item name: <c:out value="${row.auction_id}"/>
    Gender: <c:out value="${row.gender}"/>
    Size: <c:out value="${row.size}"/>
    <c:choose>
        <c:when test="${row.item_type=='Accessories'}">
            <sql:query dataSource="${dataSource}" var="desc">
                select occasion
                from Accessories;
            </sql:query>
            Occasion: <c:out value="${desc.occasion}"/>
        </c:when>

        <c:when test="${row.item_type=='Pants'}">
            <sql:query dataSource="${dataSource}" var="desc">
                select *
                from Pants;
            </sql:query>
            Cut: <c:out value="${desc.pant_cut}"/>
            Fit: <c:out value="${desc.fit_type}"/>
        </c:when>

        <c:when test="${row.item_type=='Shirts'}">
            <sql:query dataSource="${dataSource}" var="desc">
                select *
                from Shirts;
            </sql:query>
            Sleeve type: <c:out value="${desc.sleeve_type}"/>
            Shrt fit: <c:out value="${desc.shirt_fit}"/>
        </c:when>

        <c:when test="${row.item_type=='Undergarments'}">
            <sql:query dataSource="${dataSource}" var="desc">
                select *
                from Undergarments;
            </sql:query>
            Body part: <c:out value="${desc.body_part}"/>
        </c:when>
    <c:choose>
</c:forEach>
</body>
</html>