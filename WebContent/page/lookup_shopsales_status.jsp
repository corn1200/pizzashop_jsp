<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<h3 style="text-align: center; ">지점별 매출 현황</h3>
	<table border="1">
		<tr>
			<td>지점 코드</td>
			<td>지점 명</td>
			<td>총매출액</td>
		</tr>
		<%
			try {
				Class.forName("oracle.jdbc.OracleDriver");
				Connection conn = DriverManager.getConnection
				("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
				Statement stmt = conn.createStatement();
				String query = "SELECT SHOP.SCODE, SHOP.SNAME, " +
						"SUM(PIZZA.COST * SALELIST.AMOUNT) " +
						"FROM tbl_pizza_01 PIZZA, " +
						"tbl_salelist_01 SALELIST, tbl_shop_01 SHOP " +
						"WHERE SHOP.SCODE = SALELIST.SCODE " +
						"AND PIZZA.PCODE = SALELIST.PCODE " +
						"GROUP BY SHOP.SCODE, SHOP.SNAME " +
						"ORDER BY SHOP.SCODE ASC ";
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