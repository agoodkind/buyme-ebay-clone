<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Login - buyMe</title>
	</head>
	<body>
		<form method="post">
			<table>
				<tr>
					<td>Email</td>
					<td><input type="email" required="required" minlength="5" name="email"></td>
				</tr>
				<tr>
					<td>Password</td>
					<td><input type="password" required="required" minlength="1" name="password"></td>
				</tr>
			</table>
			<button formaction="login_account.jsp" type="submit">Login</button>
		</form>
	</body>
</html>