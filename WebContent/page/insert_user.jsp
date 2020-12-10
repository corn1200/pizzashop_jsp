<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1">
		<tr>
			<td>유저ID</td>
			<td>유저명</td>
		</tr>
		<% 
			try {
				Class.forName("oracle.jdbc.OracleDriver");
				Connection conn = DriverManager.getConnection
				("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
				Statement stmt = conn.createStatement();
				String query = "SELECT USER_ID, USER_NAME FROM CHAT_USER ";
				ResultSet rs = stmt.executeQuery(query);
				
				while (rs.next()) {
					%> 
						<tr>
							<td><%= rs.getString(1) %></td>
							<td><%= rs.getString(2) %></td>
						</tr>
					<%
				}
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		%>
	</table>
	
	<table border="1">
		<form action="action/action_insert_user.jsp" method="post">
			<tr>
				<td>유저명</td>
				<td><input type="text" name="user_name"></td>
			</tr>
			<tr>
				<td>유저ID</td>
				<td><input type="text" name="user_id"></td>
			</tr>
			<tr>
				<td><input type="submit" value="등록" ></td>
			</tr>
		</form>
	</table>
</body>
</html>