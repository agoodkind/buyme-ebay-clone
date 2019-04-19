<%-- contributers: Alexander Goodkind amg540 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.lang.reflect.Array" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Item Page - buyMe</title>
</head>
<body>

<t:logged_in_header/>

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


<c:choose>
    <%--TODO: add auction results too--%>

    <c:when test="${not empty results and not empty param.forward_to}">

        <c:set var="item" value="${results.rows[0]}"/>
        <%--        item id, gender, size, type --%>
        <h3>Here is the details of the item on your wishlist, you will be notified if there is a similar item up for
            auction:</h3>
        <b>Item Name:</b> <c:out value="${results.rows[0].item_name}"/><br/>
        <b>Type:</b> <c:out value="${results.rows[0].item_type}"/><br/>
        <b>Gender:</b> <c:out value="${results.rows[0].gender}"/><br/>
        <b>Size:</b> <c:out value="${results.rows[0].size}"/><br/>

        <c:if test="${not empty field_list}">
            <%
                ArrayList<Object> field_names = (ArrayList<Object>) session.getAttribute("field_names");
                ArrayList<Object> field_values = (ArrayList<Object>) session.getAttribute("field_values");
                for (int i = 0; i < field_names.size(); i++) {
                    out.print("<b>" + field_names.get(i).toString() + ":</b> " + field_values.get(i).toString() + " <br/>");
                }
            %>
        </c:if>


        <c:remove var="field_list" scope="session"/>
        <c:remove var="field_values" scope="session"/>
        <c:remove var="item_id" scope="session"/>
    </c:when>
    <c:when test="${empty results.rows}">
        Item not found.
    </c:when>
    <c:otherwise>
        <c:if test="${empty param.field_names}">
            <jsp:forward page="get_item_details.jsp">
                <jsp:param name="item_id" value="${param.item_id}"/>
                <jsp:param name="forward_to" value="individual_item.jsp"/>
            </jsp:forward>
        </c:if>
    </c:otherwise>
</c:choose>

</body>
</html>