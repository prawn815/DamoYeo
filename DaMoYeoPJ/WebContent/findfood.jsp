<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>    

<%@ page import="com.cal.dao.*" %>
<%@ page import="com.cal.dto.*" %>

<%@ page import="java.util.List" %>

<%@ page import="com.login.dto.LoginDto"%>
<%@ page import="com.login.dao.LoginDao " %>

<%
	LoginDto dto = (LoginDto)session.getAttribute("dto");

	String username = null;
	if(dto != null){
		username = dto.getMyid();
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript">
		function pushValue() {
			alert("검색 및 식품 선택 후 추가버튼을 눌러주세요.");
		}
		function closePopup() {
			window.close();
		}
	</script>
	
</head>
	
<body>

	<form action="controller.do" method="post">
		<input type="hidden" name="command" value="callfindfood">
		<table style="width: 100%; height: 100%">
			<tr>
				<td>
					<a style="font-size: 10px;">검색창의 입력 없이 검색버튼을 누르시면 목록을 볼 수 있습니다.</a><br/>
					<a style="font-size: 10px;">식품 데이터가 많아 전체 목록을 불러올 경우 다소 시간이 걸릴 수 있습니다.</a>
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" name="finditem">
					<input type="submit" value="검색">
				</td>
			</tr>
			<tr>
				<td>
					<select id="selectItem" style="width: 100%" size="10">
						<option></option>
					</select>
					<input id="addItem" type="button" value="추가" style="align: right;" onclick="pushValue();">
					<input type="button" value="닫기" onclick="closePopup();">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>