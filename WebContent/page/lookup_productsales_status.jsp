<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<h3 style="text-align: center; ">상품별 매출 현황</h3>
	<table border="1">
		<tr>
			<td>피자 코드</td>
			<td>피자 명</td>
			<td>총매출액</td>
		</tr>
		<%
			try {
				Class.forName("oracle.jdbc.OracleDriver");
				Connection conn = DriverManager.getConnection
				("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
				Statement stmt = conn.createStatement();
				String query = "SELECT PIZZA.PCODE, PIZZA.PNAME, " +
						"SUM(PIZZA.COST * SALELIST.AMOUNT) TOTALSALE " +
						"FROM tbl_pizza_01 PIZZA, tbl_salelist_01 SALELIST " +
						"WHERE PIZZA.PCODE = SALELIST.PCODE " +
						"GROUP BY PIZZA.PCODE, PIZZA.PNAME " +
						"ORDER BY TOTALSALE DESC ";
				ResultSet rs = stmt.executeQuery(query);
				
				while (rs.next()) {
					double salePrice = rs.getInt(3);
					DecimalFormat formatter = new DecimalFormat("###,###");
					String totalSalePrice = "\\" + formatter.format(salePrice);
					%>
						<tr>
							<td><%= rs.getString(1) %></td>
							<td><%= rs.getString(2) %></td>
							<td><%= totalSalePrice %></td>
						</tr>
					<%
				}
				stmt.close();
				conn.close();
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		%>
	</table>