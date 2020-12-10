<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");
String user_id = request.getParameter("user_id");
String message = request.getParameter("message");

try {
	Class.forName("oracle.jdbc.OracleDriver");
	Connection conn = DriverManager.getConnection
	("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
	Statement stmt = conn.createStatement();
	
	String query = "INSERT INTO CHAT(CID, USER_ID, MESSAGE) " +
			"VALUES(CHATID.NEXTVAL, '%s', '%s') ";
	
	ResultSet rs = stmt.executeQuery(String.format(query, user_id, message));
	
	conn.commit();
	
	stmt.close();
	conn.close();
}
catch (Exception e) {
	e.printStackTrace();
}

response.sendRedirect("../index.jsp?section=lookup_chatting");
%>