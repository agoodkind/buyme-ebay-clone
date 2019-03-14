<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>

<br>
	<form method="post" action="login_account.jsp">
	<table>
	<tr>    
	<td>Email</td><td><input type="email" name="email"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="password" name="password"></td>
	</tr>
	</table>
	<input type="submit" value="login">
	</form>
<br>

</body>
</html>