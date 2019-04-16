<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Item Page - buyMe</title>
</head>
<body>

<t:logged_in_header />

    <%-- comment --%>

    <sql:setDataSource var="dataSource"
                       driver="${initParam['driverClass']}"
                       url="${initParam['connectionURL']}"
                       user="${initParam['username']}"
                       password="${initParam['password']}"/>

    <sql:query dataSource="${dataSource}" var="results">
        select *
        from Clothing_Item
        where item_id = ${param.item_id};
    </sql:query>

<%--TODO: add auction results too--%>
<c:choose>
    <c:when test="${not empty results}">
        <c:set var="item" value="${results.rows[0]}"/>
<%--        item id, gender, size, type --%>

        <table border="1" cellpadding="5">

            <tr>
                <th>Item Name</th>
                <th>Item Category</th>
            </tr>

            <c:forEach var="row" items="${results.rows}">
                <tr>
                    <td><c:out value="${row.item_name}"/></td>
                    <td><c:out value="${row.item_type}"/></td>

                    <td>
                        <form>

                            <button value="${row.item_id}" name="item_id"
                                    formaction="individual_item.jsp">
                                View
                                Item
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:when>
    <c:otherwise>
       Item not found.
    </c:otherwise>
</c:choose>

</body>
</html>