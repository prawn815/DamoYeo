<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>  

<%@ page import="com.cal.dto.*"%>
<%@ page import="com.cal.dao.*" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList"%>  

<%@ page import="com.login.dto.*"%>
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
		
		input{
			border : 1px solid gray;
			border-radius : 10px;
			font-family: font_sw;
			
		}
		table{
			table-layout: fixed;
		}
		
		a {
			padding-left: 10px;
			padding-right: 10px;
			font-family: font_sw;
			
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
		.subtitle{
			margin-top: 50px;
			margin-bottom: 50px;
		}
		
		tr.space {
 			 border-bottom: 10px solid #fff;
 			 height: 20px;
		}
		.food-box{
			width: 50%;
			height: 300px;
			display: table;
			float: left;
		}
		.food-box > tbody{
			width: 100%;
			height: 100%;
		}
		.exer-box{
			width: 50%;
			height: 300px;
			display: table;
			float: left;
		}
		.exer-box > tbody{
			width: 100%;
			height: 100%;
		}
	</style>
	<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript">
		function showPopup1() {
			window.open("findfood.jsp", "foodPopup", "width=500, height=300, left=100, top=50, scrollbars = no");
		}
		function showPopup2() {
			window.open("findexer.jsp", "exerPopup", "width=500, height=300, left=100, top=50, scrollbars = no");
		}
		function removefood() {
			var index = $("#food-box-select option").index($("#food-box-select option:selected"));
			$("#food-box-select option:eq("+index+")").remove();
		}
		function removeexer() {
			var index = $("#exer-box-select option").index($("#exer-box-select option:selected"));
			$("#exer-box-select option:eq("+index+")").remove();
		}
		$(document).ready(function() {
			$("#calcalorie").click(function() {
				var food_vals = [];
				var totalcal = 0;
				var meta = parseFloat($("#metabolism").val());
				$("#food-box-select option").each(function() {
					food_vals.push($(this).val());
				});
				for(var i = 0; i < food_vals.length; i++){
					var foodval = parseFloat(food_vals[i]);
					totalcal += foodval;
				}
				$("#totalcal").val((totalcal).toFixed(1));
				
				var exer_vals = [];
				var totalconsumed = meta;
				$("#exer-box-select option").each(function() {
					exer_vals.push($(this).val());
				});
				for(var i = 0; i < exer_vals.length; i++){
					totalconsumed += parseFloat(exer_vals[i]);
				}
				$("#totalconsumed").val((totalconsumed).toFixed(1));
				
				var subcal = (totalcal-totalconsumed).toFixed(1);
				if(subcal < 0){
					$("#subcal").val(subcal).css("color", "blue");
				}else{
					$("#subcal").val(subcal).css("color", "red");
					
				}
				
			});
			
			$(".checknull").on("click", function() {
				var meta = parseFloat($("#metabolism").val());
				var weight = $("#weight").val();
				if(isNaN(meta) || weight == 0.0 ){
					alert("올바른 산출을 위해 회원님의 신체 정보가 필요합니다.");
					window.location.href="controller.do?command=dailyNoInfo&myid="+myid;
				}
			});
			
		    $("#addItem").on("click", function() {
				alert("필수선택란을 선택 후 검색해주세요.");
			});
		});
		
	</script>
	
	<script type="text/javascript">
		function tttt() {
			window.open('chating.jsp','ex','width=400,height=530');
		};
	</script>
</head>
<%
	InbodyDto inbodydto = (InbodyDto)request.getAttribute("indto");
	String inbodymyid = inbodydto.getMyid();
	double weight = inbodydto.getWeight();
	double metabolism = inbodydto.getMetabolism();
	String mDate = (String)request.getAttribute("mDate");
	String year = mDate.substring(0, 4);
	String month = mDate.substring(4, 6);
	String date = mDate.substring(6, 8);
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
								<li class="nav-item"><a class="nav-link" href="controller.do?command=logout">로그아웃</a></li>
								<li class="nav-item"><a class="nav-link" onclick="tttt();">채팅방</a></li>
<%
							}
							else{
%>
								<li class="nav-item"><a class="nav-link" href="controller.do?command=userpage">마이페이지</a></li>
								<li class="nav-item"><a class="nav-link" href="controller.do?command=logout">로그아웃</a></li>
								<li class="nav-item"><a class="nav-link" onclick="tttt();">채팅방</a></li>
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
        	
				<h3 class="subtitle" align="center"><%=year %>년 <%=month %>월 <%=date %>일 다이어리 생성</h3>

				<form action="controller.do" method="post">
					<input type="hidden" name="command" value="commitDiaryInfo">
					<input type="hidden" name="myid" value="<%=inbodymyid%>">
					<input type="hidden" id="weight" name="weight" value="<%=weight%>">
					<input type="hidden" id="metabolism" name="metabolism" value="<%=metabolism%>">
					<input type="hidden" id="callinput" onclick="controller.do?command=dailyNoInfo&myid=<%=inbodymyid%>">
					<input type="hidden" name="mDate" value="<%=mDate %>">
					<table style="align-items: center; width: 100%;">
						<tr>
							<td>
								<input class="checknull" type="button" value="식품 검색" onclick="showPopup1();">
								<input class="checknull" type="button" value="운동 검색" onclick="showPopup2();">
							</td>
						</tr>
						<tr class="space"></tr>
						<tr>
							<td>	
								<table class="food-box">
									<tr>
										<td style="padding: 0px; border: 0px;">
											<select id="food-box-select" style="width: 100%; font-size: 12px;" size="17">
											
											</select>
										</td>
									</tr>
									<tr style="width: 100%" height="20px;">
										<td align="right" valign="bottom">
											<input class="checknull" type="button" value="빼기" onclick="removefood();">
										</td>
									</tr>
								</table>
								<table class="exer-box">
									<tr style="padding: 0px; border: 0px;">
										<td>
											<select id="exer-box-select" style="width: 100%; font-size: 12px;" size="17">
											
											</select>
										</td>
									</tr>
									<tr style="width: 100%" height="20px;">
										<td align="right" valign="bottom">
											<input class="checknull" type="button" value="빼기" onclick="removeexer();">
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr class="space"></tr>
						<tr style="display: inline; float: left;">
							<td>
								<a>총 섭취 칼로리</a><br/>
								<a>총 소모 칼로리</a><br/>
								<a>잔여 칼로리</a>
							</td>
							<td>
								<input id="totalcal" type="text" name="totalcal" value="" readonly="readonly" style="text-align: center; color:Red;"><a>kcal</a><br/>
								<input id="totalconsumed" type="text" name="totalconsumed" value="" readonly="readonly" style="text-align: center; color:Blue;"><a>kcal</a><br/>
								<input id="subcal" type="text" name="" value="" readonly="readonly" style="text-align: center; color:Green;"><a>kcal</a>
							</td>
						</tr>
						<tr>
							<td>
								<br/>
								<input id="calcalorie" class="checknull" type="button" value="칼로리 산출하기">
								<input class="checknull" type="submit" value="저장하기">
							</td>
						</tr>
						<tr class="space"></tr>
						<tr>
							<td>
								<a style="font-size: 13px;">- 소모 칼로리는 회원님의 기초대사량을 포함하여 출력됩니다.</a><br/>
								<a style="font-size: 13px;">- 기초대사량을 포함한 산출이므로 일상적인 생활 패턴 외의 활동 내역을 선택해야 합니다.</a><br/>
								<a style="font-size: 13px;">- 다이어리 저장 시 다이어리 화면으로 전환되므로 선택목록이 없어짐을 참고해주시기 바랍니다.</a>
							</td>
						</tr>
					</table>
				</form>
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
