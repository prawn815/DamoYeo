<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>

<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.cal.dto.*" %>
<%@ page import="com.cal.dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	.chart{
		display: inline-block;
		width: 25px;
		height: 75px;
		margin-right: 2px;
		background-color: skyblue;
	}
	
	#footer {

    position:absolute;
    bottom:0;
    width:100%;
    height:50px;   
    background:#ccc;
	}
</style>
<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	function isTwo(n) {
		return (n.length<2)?"0"+n:n;
	}
	
	$(function() {
		var ajaxcommand = "makechart";
		var myid = $("#myid", opener.document).val();
		var year = $("#selectYear", opener.document).text();
		var month = isTwo($("#selectMonth", opener.document).text());
		var yyyyMM = year+month;
		var lastDay = $("#lastDay").val();
		
		google.charts.load('current', {'packages':['corechart']});
				
		google.charts.setOnLoadCallback(drawVisualization);
				
		function drawVisualization() {
			var jsonData = $.ajax({
				type: "post",
				url:"ajaxcontroller.do",
				data:"command="+ajaxcommand+"&myid="+myid+"&yyyyMM="+yyyyMM+"&lastDay="+lastDay,
				dataType:"json",
				async:false
				}).responseText;
			
			var data = new google.visualization.DataTable(jsonData);
					
			var options = {
				title : 'Monthly Calorie Chart',
				vaxis: {title: 'Days'},
				haxis: {title: 'Calories'},
				seriesType: 'bars'
				};
					
			var chart = new google.visualization.ComboChart(document.getElementById('chart'));
			chart.draw(data, options);
		}
			
	});
	
	function closePopup() {
		window.close();
	}
	
</script>


</head>
<%

	String year = (String)request.getParameter("year");
	String month = (String)request.getParameter("month");
	Calendar cal = Calendar.getInstance();
	int lastDay = cal.getActualMaximum(Integer.parseInt(month));

%>
<body>
	<h3 align="center"><%=year %>년 <%=month %>월 칼로리 차트</h3>
	
	<input type="hidden" id="lastDay" value="<%=lastDay%>">
	<div style="text-align: center;">
		<div id = "chart" style="width: 720px; height: 480px; margin: 0px; border: 0px; display: inline-block;"></div>
	</div>
	<footer style="text-align: center;"><input type="button" value="닫기" onclick="closePopup();"></footer>

</body>
</html>