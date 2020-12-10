<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/css.css">
</head>
<body>
	<%@ include file="static/header.jsp" %>
	<%@ include file="static/nav.jsp" %>
	
	<% 
		String parameter = request.getParameter("section") == null ? "" : request.getParameter("section");
		
		switch (parameter) {
			case "insert_sales_slip" :
				%><%@ include file="page/insert_sales_slip.jsp" %><%
				break;
			case "lookup_totalsales_status" :
				%><%@ include file="page/lookup_totalsales_status.jsp" %><%
				break;
			case "lookup_shopsales_status" :
				%><%@ include file="page/lookup_shopsales_status.jsp" %><%
				break;
			case "lookup_productsales_status" :
				%><%@ include file="page/lookup_productsales_status.jsp" %><%
				break;
			case "insert_user" :
				%><%@ include file="page/insert_user.jsp" %><%
				break;
			case "lookup_chatting" :
				%><%@ include file="page/lookup_chatting.jsp" %><%
				break;
			default :
				%><%@ include file="static/index.jsp" %><%
				break;
		}
	%>
	
	<%@ include file="static/footer.jsp" %>
</body>
</html>