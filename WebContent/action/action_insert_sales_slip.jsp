<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");
int saleno = Integer.parseInt(request.getParameter("saleno"));
String scode = request.getParameter("scode");
String saledate = request.getParameter("saledate");
String pcode = request.getParameter("pcode");
String amount = request.getParameter("amount");

try {
	Class.forName("oracle.jdbc.OracleDriver");
	Connection conn = DriverManager.getConnection
	("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
	Statement stmt = conn.createStatement();
	
	String query = "INSERT INTO TBL_SALELIST_01(SALENO, SCODE, SALEDATE, PCODE, AMOUNT) VALUES('%d', '%s', '%s', '%s', '%s')";
	
	ResultSet rs = stmt.executeQuery(String.format(query, saleno, scode, saledate, pcode, amount));
	
	conn.commit();
	
	stmt.close();
	conn.close();
}
catch (Exception e) {
	e.printStackTrace();
}

response.sendRedirect("../index.jsp");
%>