<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>

<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.List" %>
<%@ page import="com.cal.dto.*" %>
<%@ page import="com.cal.dao.*" %>

<%@ page import="com.login.dto.*" %>
<%@ page import="com.login.dao.*" %>

<%
	LoginDto dto = (LoginDto)session.getAttribute("dto");

	String myid = null;
	if(dto != null){
		myid = dto.getMyid();
	}
	System.out.println(myid + " / ");
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>다이어트필요한사람모두여기로!</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>

    <!-- Custom styles for this template -->
    <link href="css/clean-blog.min.css" rel="stylesheet">

	<style type="text/css">
		body {
			padding: 0px;
			margin: 0px;
			font-size: 16px;
		}
		
		input {
			border : 1px solid gray;
			border-radius : 10px;
			font-family: font_sw;
			
		}
		
		table {
			table-layout: fixed;
		}
		
		a {
			padding-left: 10px;
			padding-right: 10px;
			font-family: font_sw;
			text-decoration: none;
		}
		
		.submenu {
			color: #292929;
 			font-size: 20px;
			font-weight: bold;
			font-family: font_sw;
		    min-height: 60px;
    		padding: 0px;
    		margin-bottom: 1px;
    		display: block;
		}
		
		.submenu > ul {
			overflow: hidden;
			list-style: none;
			padding : 0px;
			display: list-item;
			text-align: -webkit-match-parent;
			align-items: center;
		}
		
		.submenu > ul > li {
			float: left;
			margin-left: 50px;
			margin-right: 50px;
		}
		
		.subtitle {
			margin-top: 50px;
			margin-bottom: 50px;
		}
		
		tr.space {
 			 border-bottom: 10px solid #fff;
 			 height: 20px;
		}
		
		#calendar{
			border-collapse: collapse;
			display: inline;
			float: left;
		}
		
		#calendar th{
			width: 60px;
			border: 1px solid gray;
		}
		
		#calendar td{
			width: 60px;
			height: 60px;
			border: 1px solid gray;
			text-align: left;
			vertical-align: top;
			position: relative;
		}
	
		.cPreview {
			position: absolute;
			top: -30px;
			left:  10px;
			background-color: skyblue;
			width:  40px;
			height: 40px;
			text-align: center;
			line-height: 40px;
			border-radius: 40px 40px 40px 1px;
		}
	
		.clist > p{
			font-size: 6px;
			margin: 1px;
		}
		
	</style>
	
	<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript">
	
		function isTwo(n) {
			return (n.length<2)?"0"+n:n;
		}
	
		$(function() {
			$(".d").click(function() {
				var year = $(".y").text().trim();
				var month = $(".m").text().trim();
				var date = $(this).text().trim();
				var mdate = year + isTwo(month) + isTwo(date);
				var myid = $("#myid").val();
				var ajaxcommand = $("#ajaxcommand").val();
				
				$("#mDate").val(mdate);
				$("#detailDate").text(year+"년 "+month+"월 "+date+"일");
				
				$.ajax({
					type: "post",
					url:"ajaxcontroller.do",
					data:"command="+ajaxcommand+"&id="+myid+"&mDate="+mdate,
					dataType:"json",
					async:false,
					success: function(msg) {
						var mtotalcal = msg.mtotalcal;
						var mtotalmeta = msg.mtotalmeta;
						var msubcal = (mtotalcal-mtotalmeta).toFixed(1);
						if(mtotalcal == 0 && mtotalmeta == 0){
							alert("해당 날짜에 저장된 데이터가 없습니다.");
							$(".mtotal").val("");
						}else{
							$("#mtotalcal").val(mtotalcal+" (kcal)").css("color", "red");
							$("#mtotalmeta").val(mtotalmeta+" (kcal)").css("color", "blue");
							$("#msubcal").val(msubcal+" (kcal)");
							if(msubcal < 0){
								$("#msubcal").css("color", "blue");
							}else{
								$("#msubcal").css("color", "red");
							}
						}
					},
					error: function() {
						alert("해당 날짜에 저장된 데이터가 없습니다.");
						$(".mtotal").val("");
					}
				});
			});
		
			$("#insertDiary").click(function() {
				if($("#mDate").val() == ""){
					alert("원하는 날짜를 선택 후 생성 버튼을 클릭해주세요.");
				}else{
					var mDate = $("#mDate").val();
					var myid = $("#myid").val();
					window.location.href = "controller.do?command=callinsert&myid="+myid+"&mDate="+mDate;
				}
			});
			
			$("#deleteDiary").click(function() {
				if($("#mDate").val() == ""){
					alert("원하는 날짜를 선택 후 생성 버튼을 클릭해주세요.");
				}else{
					$("form").submit();
				}
			});
			
			$("#diarychart").click(function() {
				var myid = $("#myid").val();
				var year = $("#selectYear").text();
				var bmonth = $("#selectMonth").text();
				var month = isTwo(bmonth);
				var diarylist = $("#diarylist").val();
				
				window.open("diarychart.jsp?year="+year+"&month="+month, "chartPopup", "width=800, height=600, left=100, top=50, scrollbars = no");
			})
		});
	</script>
</head>

<%
	Calendar cal = Calendar.getInstance();
	
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH) + 1;
	int day = cal.get(Calendar.DATE);

	String paramYear = request.getParameter("year");
	String paramMonth = request.getParameter("month");
	
	if(paramYear != null){
		year = Integer.parseInt(paramYear);
	}
	if(paramMonth != null){
		month = Integer.parseInt(paramMonth);
	}
	if(month > 12){
		month = 1;
		year++;
	}
	if(month < 1){
		month = 12;
		year--;
	}
	
	//현재 년도, 현재 월, 해당 월의 1일
	cal.set(year, month-1, 1);
	//1일의 요일
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	//현재 월의 마지막 일
	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	
	List<DiaryDto> list = (List<DiaryDto>)request.getAttribute("diarylist");
	
	////자바스크립트에 필요한 myid
	String dimyid = list.get(0).getMyid();
%>

<body>

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
		<div class="container">
			<a class="navbar-brand" href="controller.do?command=index">다모여</a>
			<button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
				Menu
          		<i class="fas fa-bars"></i>
        	</button>
        	<div class="collapse navbar-collapse" id="navbarResponsive">
          		<ul class="navbar-nav ml-auto">
          			<li class="nav-item">
						<a class="nav-link" href="controller.do?command=main">다모여샵</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="controller.do?command=about">정보사이트</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="controller.do?command=selectList&page=1">커뮤니티</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="controller.do?command=openkcal">kcal다이어리</a>
					</li>
<%
						if(myid == null){
%>
							<li class="nav-item"><a class="nav-link" href="controller.do?command=loginpage">로그인</a></li>
<%
						}
						else{
							if(dto.getMyrole().equals("ADMIN")){
								
%>
								<li class="nav-item"><a class="nav-link" href="controller.do?command=adminpage">관리자페이지</a></li>
<%
							}
							else{
%>
								<li class="nav-item"><a class="nav-link" href="controller.do?command=userpage">마이페이지</a></li>
<%
							}
						}
%>
          		</ul>
			</div>
		</div>
	</nav>

    <!-- Page Header -->
	<header class="masthead" style="">
		<div class="overlay">
      		<img alt="1" src="img/3.PNG" style="width:100%; height: 100%" />
      	</div>
      	<div class="container">
        	<div class="row">
          		<div class="col-lg-8 col-md-10 mx-auto">
            		<div class="page-heading">
             			 <h1>kcal다이어리</h1>
            		</div>
          		</div>
        	</div>
      	</div>
	</header>

    <!-- Main Content -->
    <div class="container">
		<div class="row">
        	<div class="col-lg-8 col-md-10 mx-auto">
        		<div class="submenu">
        			<ul>
	        			<li>
	        				<a href="controller.do?command=openkcal">BMI & 기초대사량</a>
	        			</li>
	        			<li>
	        				<a href="controller.do?command=opendaily&myid=<%=myid%>">Daily</a>
	        			</li>
	        			<li>
	        				<a href="controller.do?command=opendiary&myid=<%=myid%>">Calorie Diary</a>
	        			</li>
        			</ul>
        		</div>
        		<form action="controller.do" method="post">
          			<h3 class="subtitle" align="center">Calorie Diary</h3>
          			<input type="hidden" id="ajaxcommand" value="detailView">
          			<input type="hidden" name="command" value="deleteDiary">
 					<input type="hidden" id="myid" name="myid" value="<%=myid%>">
		 			<table id="calendar">
						<caption style="caption-side: top; text-align: center;">
							<a href="controller.do?command=moveyyyyMM&myid=<%=dimyid%>&year=<%=year-1%>&month=<%=month%>">◁</a>
							<a href="controller.do?command=moveyyyyMM&myid=<%=dimyid%>&year=<%=year%>&month=<%=month-1%>">◀</a>
							<span id="selectYear" class="y"><%=year %></span>년
							<span id="selectMonth" class="m"><%=month %></span>월
							<a href="controller.do?command=moveyyyyMM&myid=<%=dimyid%>&year=<%=year%>&month=<%=month+1%>">▶</a>
							<a href="controller.do?command=moveyyyyMM&myid=<%=dimyid%>&year=<%=year+1%>&month=<%=month%>">▷</a>
						</caption>
						<tr>
							<th>일</th>
							<th>월</th>
							<th>화</th>
							<th>수</th>
							<th>목</th>
							<th>금</th>
							<th>토</th>
						</tr>
						<tr>
<%
							//공백
							for(int i = 0; i < dayOfWeek-1; i++){
								out.print("<td>&nbsp;</td>");
							}
		
							for(int i = 1; i <= lastDay; i++){
%>			
								<td>
									<a class="d" href='javascript:void(0);' style="color:<%=Util.fontColor(i,dayOfWeek)%>"><%=i %></a>
									<div class="clist"><%=Util.getCalView(i,list,month) %></div>
								</td>		
<%			
								if((dayOfWeek-1+i)%7 == 0){
									out.print("</tr><tr>");
								}
							}
				
							for(int i = 0; i < (7 - (dayOfWeek-1+lastDay)%7)%7; i++){
								out.print("<td>&nbsp;</td>");
							}
%>
						</tr>	
					</table>
					
					<br/>
					<br/>
					<input type="hidden" id="mDate" name="mDate">
					<table style="display: inline; padding-left: 20px;">
						<tr>
							<td align="center"><a id="detailDate"></a></td>
						<tr>
						<tr class="space"></tr>
						<tr>
							<td><input id="mtotalcal" class="mtotal" type="text" readonly="readonly" placeholder="  총 섭취 kcal" style="text-align: center;"></td>
						</tr>
						<tr class="space"></tr>
						<tr>
							<td><input id="mtotalmeta" class="mtotal" type="text" readonly="readonly" placeholder="  총 소비 kcal" style="text-align: center;"></td>
						</tr>
						<tr class="space"></tr>
						<tr>
							<td><input id="msubcal" class="mtotal" type="text" readonly="readonly" placeholder="  잔여 kcal" style="text-align: center;"></td>
						</tr>
						<tr class="space"></tr>
						<tr>
							<td><input id="diarychart" type="button" value="차트 보러가기"></td>
						</tr>
						<tr class="space"></tr>
						<tr>
							<td><input id="insertDiary" type="button" value="다이어리 생성" onclick=""></td>
						</tr>
						<tr class="space"></tr>
						<tr>
							<td><input id="deleteDiary" type="button" value="다이어리 삭제"></td>
						</tr>
						<tr class="space"></tr>
					</table><br/>
				</form>
				<footer style="bottom:0px; width: 100%; height: 30px; padding: 0px; margin-top: 30px;">
						<a style="font-size: 13px;">- 다이어리가 생성되어있는 일자에 다이어리를 재생성하시면 최신 데이터로 업데이트 되며 기존 다이어리는 사라집니다.</a>
				</footer>	
          	</div>
      	</div>
    </div>

    <hr/>

    <!-- Footer -->
    <footer>
      <div class="container">
        <div class="row">
          <div class="col-lg-8 col-md-10 mx-auto">
            <p class="copyright text-muted">Copyright &copy; Your Website 2018</p>
          </div>
        </div>
      </div>
    </footer>

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Custom scripts for this template -->
    <script src="js/clean-blog.min.js"></script>

</body>
</html>