<%--
  Created by IntelliJ IDEA.
  User: Alexander Goodkind amg540
  Date: 2019-04-16
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Continue - buyMe</title>
</head>
<body>

<t:logged_in_header/>


<h2>Please select the specifics for this item.</h2>

<form>
    <%
        // from previous page

        int item_id;
        if (request.getParameterMap().containsKey("item_id")) {
            item_id = Integer.parseInt(request.getParameter("item_id"));
            session.setAttribute("item_id", request.getParameter("item_id"));
        } else {
            item_id = (int) session.getAttribute("item_id");
        }

        session.setAttribute("item_type", item_type);

        try {

            //Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            //Get parameters from the HTML form at the HelloWorld.jsp


            String select = "SHOW FULL COLUMNS FROM " + item_type;
            //Create a Prepared SQL statement allowing you to introduce the parameters of the query
            PreparedStatement ps = con.prepareStatement(select);

            //Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
            //Run the query against the DB
            ResultSet rs = ps.executeQuery();

            ArrayList<String> field_list = new ArrayList<String>();
            ArrayList<String> field_names = new ArrayList<String>();


            while (rs.next()) {


                if (rs.getString("Type").startsWith("enum")) {
                    String types = rs.getString(2).substring(5, rs.getString(2).length() - 1);
                    String[] enum_types = types.split(",");

                    for (int i = 0; i < enum_types.length; i++) {
                        enum_types[i] = enum_types[i].replaceAll("\'", "");
                    }

                    pageContext.setAttribute("enum_types", enum_types);
                    pageContext.setAttribute("label", rs.getString("Comment"));
                    pageContext.setAttribute("field", rs.getString("Field"));
                    field_list.add(rs.getString("Field"));


    %>
    <div>
        <c:out value="${label}"/>:
        <select name="${field}">
            <c:forEach items="${enum_types}" var="j">
                <option value="<c:out value="'${j}'"/>"><c:out value="${j}"/></option>
            </c:forEach>
        </select>
    </div>
    <%
                }
            }

            session.setAttribute("field_list", field_list.toArray());

            //Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
            con.close();


        } catch (Exception ex) {
            out.print(ex);
        }

        String forward_to = "index.jsp";
        if (request.getParameterMap().containsKey("forward_to")) {
            forward_to = request.getParameter("forward_to");
        } else {
            forward_to = (String) session.getAttribute("forward_to");
        }

        pageContext.setAttribute("forward_to", forward_to);


        RequestDispatcher rd = request.getRequestDispatcher(forward_to);
        rd.forward(request, response);

    %>
</form>

</body>
</html>