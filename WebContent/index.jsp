<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<br>
	<form method="post" action="create_account.jsp">
	<table>
	<tr>    
	<td>Email</td><td><input type="email" name="email"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="password" name="password"></td>
	</tr>
	</table>
	<input type="submit" value="create account">
	</form>
<br>

</body>
</html>