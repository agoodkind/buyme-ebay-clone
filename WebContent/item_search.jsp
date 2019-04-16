<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%--
Contributers:
Alexander Goodkind amg540
--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search for an item - buyMe</title>
</head>
<body>

<t:logged_in_header/>

<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>


<input type="text" minlength="3" name="s_query" placeholder="Search.."/>
<input type="checkbox" name="advanced" value="true">Advanced Search<br/>
<button formmethod="post" formaction="item_search.jsp">Go</button>

<c:choose>
    <c:when test="${not empty param.advanced}">
        <c:set var="s_query" value="${param.s_query}" scope="request"/>
        <jsp:forward page="advanced_search.jsp"/>
    </c:when>
    <c:when test="${not empty param.s_query and empty param.advanced}">
        <sql:query var="${results}">
            select item_name, item_type, item_id from
            Clothing_Item
            where item_name LIKE '%${param.s_query}';
        </sql:query>

        <c:choose>
            <c:when test="${not empty results}">
                <table border="1" cellpadding="5">
                    <tr>
                        <th>Item Name</th>
                        <th>Item Category</th>
                        <th></th>
                    </tr>
                </table>
                <c:forEach var="row" items="${results.rows}">
                    <td><c:out value="${row.item_name}"/></td>
                    <td><c:out value="${row.item_type}"/></td>
                    <td>
                        <form>
                            <button value="${row.item_id}" name="auction_id" formaction="individual_item.jsp">View
                                Item
                            </button>
                        </form>
                    </td>
                </c:forEach>
            </c:when>
            <c:otherwise>
                No results found.
            </c:otherwise>
        </c:choose>
    </c:when>
</c:choose>


</body>
</html>