<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
try {
	Class.forName("oracle.jdbc.OracleDriver");
	Connection conn = DriverManager.getConnection
	("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
	
%>
	<table border="1">
		<tr>
			<td>유저명</td>
			<td>채팅내용</td>
		</tr>
		<%
			Statement stmt_chat = conn.createStatement();
			String query = "SELECT CHAT_USER.USER_NAME, CHAT.MESSAGE " +
					"FROM CHAT_USER, CHAT " +
					"WHERE CHAT.USER_ID = CHAT_USER.USER_ID " +
					"ORDER BY CHAT.CID ";
			ResultSet rs = stmt_chat.executeQuery(query);
			while (rs.next()) {
				%>
					<tr>
						<td><%= rs.getString(1) %></td>
						<td><%= rs.getString(2) %></td>
					</tr>
				<%
			}
			stmt_chat.close();
		%>
	</table>
	<form action="action/action_insert_chatting.jsp" method="post">
		<table border="1">
			<tr>
				<td>
					<select name="user_id">
						<%
							Statement stmt_user = conn.createStatement();
							query = "SELECT CHAT_USER.USER_NAME, CHAT_USER.USER_ID " +
									"FROM CHAT_USER ";
							rs = stmt_user.executeQuery(query);
							while (rs.next()) {
								%><option value="<%= rs.getString(2) %>"><%= rs.getString(1) %></option><%
							}
							stmt_user.close();
						%>
					</select>
				</td>
				<td><input type="text" placeholder="채팅 메세지를 입력하세요" name="message"></td>
				<td><input type="submit" value="보내기"></td>
			</tr>
		</table>
	</form>
	<% 

	conn.close();
}
catch (Exception e) {
	e.printStackTrace();
}
	%>