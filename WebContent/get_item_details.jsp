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
<link rel="stylesheet" type="text/css" href="style.css">
   
    <meta charset="UTF-8">
    <title>Continue - buyMe</title>
</head>
<body>

<t:logged_in_header/>

<form>
    <%
        // from previous page

        int item_id;
        if (request.getParameterMap().containsKey("item_id")) {
            item_id = Integer.parseInt(request.getParameter("item_id"));
            session.setAttribute("item_id", request.getParameter("item_id"));
        } else {
            item_id = Integer.getInteger((String) session.getAttribute("item_id"));
        }

        String item_type = "";

        if (request.getParameterMap().containsKey("item_type")) {
            item_type = request.getParameter("item_id");
            session.setAttribute("item_id", request.getParameter("item_id"));
        }

        try {

            //Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            String select = "select item_type from Clothing_Item where item_id = " + item_id;

            PreparedStatement ps = con.prepareStatement(select);

            //Get parameters from the HTML form at the HelloWorld.jsp
            ResultSet rs = ps.executeQuery();

            rs.next();


            if (!request.getParameterMap().containsKey("item_type")) {
                item_type = request.getParameter("item_type");
                item_type = rs.getString("item_type");
            }

            session.setAttribute("item_type", item_type);

            select = "SHOW FULL COLUMNS FROM " + item_type;
            //Create a Prepared SQL statement allowing you to introduce the parameters of the query
            ps = con.prepareStatement(select);

            //Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
            //Run the query against the DB
            rs = ps.executeQuery();


            ArrayList<String> field_list = new ArrayList<String>();
            ArrayList<String> field_values = new ArrayList<String>();
            ArrayList<String> field_names = new ArrayList<String>();


            while (rs.next()) {


                if (rs.getString("Type").startsWith("enum")) {
                    field_list.add(rs.getString("Field"));
                    field_names.add(rs.getString("Comment"));
                }
            }

            select = "select item_id, +" +
                    "  " + StringUtils.join(field_list, ",") + "  from " + item_type + " t1 where t1.item_id = " + item_id;
            //Create a Prepared SQL statement allowing you to introduce the parameters of the query
            ps = con.prepareStatement(select);

            //Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
            //Run the query against the DB
            rs = ps.executeQuery();

            rs.next();

            for (int i = 0; i < field_list.size(); i++) {

                field_values.add(rs.getString((String) field_list.get(i)));
            }

            session.setAttribute("field_values", field_values);

            session.setAttribute("field_list", field_list);

            session.setAttribute("field_names", field_names);

            request.setAttribute("field_list", field_list);

            request.setAttribute("field_values", field_values);

            request.setAttribute("field_names", field_names);

            request.setAttribute("item_id", item_id);


            //Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
            con.close();

            String forward_to = "index.jsp";
            if (request.getParameterMap().containsKey("forward_to")) {
                forward_to = request.getParameter("forward_to");
            } else {
                forward_to = (String) session.getAttribute("forward_to");
            }

            RequestDispatcher rd = request.getRequestDispatcher(forward_to);
            rd.forward(request, response);


        } catch (Exception ex) {
            out.print(ex);
            System.out.println(ex);
            out.print("error viewing item");
        }


    %>
</form>

</body>
</html>