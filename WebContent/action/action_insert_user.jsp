<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");
String user_name = request.getParameter("user_name");
String user_id = request.getParameter("user_id");

try {
	Class.forName("oracle.jdbc.OracleDriver");
	Connection conn = DriverManager.getConnection
	("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
	Statement stmt = conn.createStatement();
	
	String query = "INSERT INTO chat_user(user_id, user_name) VALUES('%s', '%s')";
	
	ResultSet rs = stmt.executeQuery(String.format(query, user_id, user_name));
	
	conn.commit();
	
	stmt.close();
	conn.close();
}
catch (Exception e) {
	e.printStackTrace();
}

response.sendRedirect("../index.jsp");
%>