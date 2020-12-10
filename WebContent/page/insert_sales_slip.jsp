<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<script type="text/javascript">
function submit_form() {
	if (document.input_form.saleno.value === "") {
		alert("매출전표번호가 입력되지 않았습니다!");
		document.input_form.saleno.focus();
		return;
	}
	if (document.input_form.scode.value === "") {
		alert("지점코드가 입력되지 않았습니다!");
		document.input_form.scode.focus();
		return;
	}
	if (document.input_form.saledate.value === "") {
		alert("판매일자가 입력되지 않았습니다!");
		document.input_form.saledate.focus();
		return;
	}
	if (document.input_form.pcode.value === "0") {
		alert("피자코드가 선택되지 않았습니다!");
		document.input_form.pcode.focus();
		return;
	}
	if (document.input_form.amount.value === "") {
		alert("판매수량이 입력되지 않았습니다!");
		document.input_form.amount.focus();
		return;
	}
	alert("정상적으로 처리되었습니다!");
	document.input_form.submit();
}
function reset_form() {
	document.input_form.reset();
}
</script>
<h3 style="text-align: center; ">매출전표등록</h3>
	<form action="action/action_insert_sales_slip.jsp" method="post" name="input_form">
		<table border="1">
			<tr>
				<td>매출전표번호</td>
				<td><input type="text" name="saleno"></td>
			</tr>
			<tr>
				<td>지점코드</td>
				<td><input type="text" name="scode"></td>
			</tr>
			<tr>
				<td>판매일자</td>
				<td><input type="date" name="saledate"></td>
			</tr>
			<tr>
				<td>피자코드</td>
				<td>
					<select name="pcode">
						<option value="0">피자선택</option>
						<%	
							try {
								Class.forName("oracle.jdbc.OracleDriver");
								Connection conn = DriverManager.getConnection
								("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
								Statement stmt_pizza = conn.createStatement();
								String query = "SELECT PIZZA.PCODE, PIZZA.PNAME " +
										"FROM tbl_pizza_01 PIZZA " +
										"ORDER BY PIZZA.PCODE ASC ";
								ResultSet rs_pizza = stmt_pizza.executeQuery(query);
								while (rs_pizza.next()) {
									%>
										<option value="<%= rs_pizza.getString(1) %>"> [<%= rs_pizza.getString(1) %>] <%= rs_pizza.getString(2) %></option>
									<%
								}
								stmt_pizza.close();
								conn.close();
							}
							catch (Exception e) {
								e.printStackTrace();
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>판매수량</td>
				<td><input type="number" name="amount"></td>
			</tr>
			<tr>
				<td><input type="button" onclick="submit_form()" value="전표등록"><input type="button" onclick="reset_form()" value="다시쓰기"></td>
			</tr>
		</table>
	</form>