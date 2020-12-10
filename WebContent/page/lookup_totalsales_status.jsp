<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<h3 style="text-align: center; ">통합매출현황조회</h3>
	<table border="1">
		<tr>
			<td>매출전표번호</td>
			<td>지점</td>
			<td>판매일자</td>
			<td>피자코드</td>
			<td>피자명</td>
			<td>판매수량</td>
			<td>매출액</td>
		</tr>
		<%
			try {
				Class.forName("oracle.jdbc.OracleDriver");
				Connection conn = DriverManager.getConnection
				("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
				Statement stmt = conn.createStatement();
				String query = "SELECT SALELIST.SALENO, " +
						"SHOP.SCODE, SHOP.SNAME, " +
						"SALELIST.SALEDATE, SALELIST.PCODE, " +
						"PIZZA.PNAME, SALELIST.AMOUNT, PIZZA.COST " +
						"FROM tbl_salelist_01 SALELIST, " +
						"tbl_pizza_01 PIZZA, tbl_shop_01 SHOP " +
						"WHERE PIZZA.PCODE = SALELIST.PCODE " +
						"AND SHOP.SCODE = SALELIST.SCODE " +
						"ORDER BY SALELIST.SALENO ASC ";
				ResultSet rs = stmt.executeQuery(query);
				
				while (rs.next()) {
					String shopName = rs.getString(2) + "-" + rs.getString(3);
					String saleDate = rs.getString(4).substring(0, 10);
					double salePrice = rs.getInt(7) * rs.getInt(8);
					DecimalFormat formatter = new DecimalFormat("###,###");
					String totalSalePrice = "\\" + formatter.format(salePrice);
					%>
						<tr>
							<td><%= rs.getInt(1) %></td>
							<td><%= shopName %></td>
							<td><%= saleDate %></td>
							<td><%= rs.getString(5) %></td>
							<td><%= rs.getString(6) %></td>
							<td><%= rs.getInt(7) %></td>
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