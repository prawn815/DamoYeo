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
			var item = $("#selectItem option:selected").val();
			var itemtxt = $("#selectItem option:selected").text();
			var weight = window.opener.document.getElementById("weight").value;
			var itemArr = item.split("/");
			var common = parseInt(itemArr[0]);
			var calorie = parseFloat(itemArr[1]);
			var exminute =  parseFloat($("#exertime").val());
			var extime = exminute/60;
			if(isNaN(exminute)){
				alert("시간 입력 후 추가 버튼을 눌러주세요.");
			}
			else{
				if(common == 0){
					var calcal = (calorie * extime).toFixed(1);
					$(opener.document).find("#exer-box-select").append("<option value="+calcal+">"+itemtxt + " " + $("#exertime").val() + "분" +"</option>");
				}
				else{
					var calcal = (weight * calorie * extime).toFixed(1);
					$(opener.document).find("#exer-box-select").append("<option value="+calcal+">"+itemtxt + " " + $("#exertime").val() + "분" +"</option>");
				}
			}
		}
		function closePopup() {
			window.close();
		}
	</script>
</head>
	
<body>

	<form action="controller.do" method="post">
		<input type="hidden" name="command" value="callfindExer">
		<table style="width: 100%; height: 100%">
			<tr>
				<td>
					<a style="font-size: 10px;">검색창의 입력 없이 검색버튼을 누르시면 목록을 볼 수 있습니다.</a>
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" name="finditem" placeholder="검색할 단어를 입력해주세요." style="width: 200px;">
					<input type="submit" value="검색">
				</td>
			</tr>
			<tr>
				<td>
					<select id="selectItem" style="width: 100%" size="10">
<%
						List<CalorieDto> list = (List<CalorieDto>)request.getAttribute("list");
						if(list.get(0).getExname() != null){
							for(int i = 0; i < list.size(); i++){
								if(list.get(i).getCommon()==0){
									out.print("<option value="+list.get(i).getCommon()+"/"+list.get(i).getconsumed_calorie()+">"+list.get(i).getExname());
									out.print(" 공통 " + list.get(i).getconsumed_calorie() + "(kcal)");
								}else{
									out.print("<option value="+list.get(i).getCommon()+"/"+list.get(i).getconsumed_calorie()+">"+list.get(i).getExname());
									out.print(" 체중 * " + list.get(i).getconsumed_calorie() + "(kcal)");
								}
								out.print("</option>");
							}
						}
						else{
							out.print("<option></option>");
						}
%>
					</select>
					<a style="font-size: 10px;">종목 선택과 (분)단위 시간을 입력 후 추가버튼을 눌러주세요.</a><br/>
					<a style="font-size: 13px;">시간 입력 : </a>
					<input id="exertime" type="text" placeholder="분 단위" style="width: 50px;">
					<input id="addItem" type="button" value="추가" style="align: right;" onclick="pushValue();">
					<input type="button" value="닫기" onclick="closePopup();">	
				</td>
			</tr>
		</table>
	</form>
</body>
</html>