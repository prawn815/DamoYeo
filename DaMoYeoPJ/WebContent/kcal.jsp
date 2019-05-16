
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.cal.dao.*"%>
<%@ page import="com.cal.dto.*"%>

<%@page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>

<%@page import="com.login.dto.*"%>
<%@page import="com.login.dao.*"%>

<%
	LoginDto dto = (LoginDto) session.getAttribute("dto");

	String myid = null;
	if (dto != null) {
		myid = dto.getMyid();
	} else {
		response.sendRedirect("controller.do?command=whatlog");
	}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>다이어트필요한사람모두여기로!</title>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
	rel='stylesheet' type='text/css'>

<!-- Custom styles for this template -->
<link href="css/clean-blog.min.css" rel="stylesheet">

<style type="text/css">
body {
	padding: 0px;
	margin: 0px;
	font-size: 16px;
}

input {
	border: 1px solid gray;
	border-radius: 10px;
	font-family: font_sw;
}

table {
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
	text-align: center;
}

.submenu>ul {
	overflow: hidden;
	list-style: none;
	padding: 0px;
	display: list-item;
	text-align: -webkit-match-parent;
	text-align: center;
}

.submenu>ul>li {
	float: left;
	margin-left: 50px;
	margin-right: 50px;
}

.subtitle {
	margin-top: 50px;
	margin-bottom: 50px;
}

.bmiform {
	padding-top: 20px;
	padding-bottom: 20px;
	align-items: center;
}

.left-box {
	float: left;
	display: inline;
	width: 50%;
	padding-right: 10px;
}

.right-box {
	float: left;
	display: inline;
	width: 50%;
	padding-left: 10px;
}

tr.space {
	border-bottom: 10px solid #fff;
	height: 20px;
}

.axis text {
	font-family: sans-serif;
	font-size: 11px;
}

.axis path, .axis line {
	fill: none;
	stroke: black;
}
</style>
<script type="text/javascript" src="./d3/d3.js"></script>
<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
		
		$(document).ready(function() {
			$('#calc').click(function() {
			      var weight = $('#weight').val();
			      var height = $('#height').val();
			      var gender = $('#mygender').val();
			      var birth = $('#mybirth').val();
			      if(weight == null || weight == 0 || height == null || height == 0){
			    	  alert("키, 체중을 입력해주세요.");
			    	  return null;
			      }else{
			    	  var calc = weight/((height/100)*(height/100));
			    	  var bmi = calc.toFixed(1);
			    	  
				      $('#bmi').val(bmi);
			    	  
				      var metacal = 0.0;
				      var year= new Date().getFullYear();
				      var substr = parseInt(birth.substring(0,2));
				      var iage = 0;
				      if(substr > 19){
				    	  iage = substr+1900;
				      }else{
				    	  iage = substr+2000;
				      }
				      var age = year - iage + 1;
				      if(gender == "W"){
				    	  metacal = 655.1+(9.56*weight)+(1.85*height)-(4.68*age);
				      }else{
				    	  metacal = 66.47+(13.75*weight)+(5*height)-(6.76*age);
				      }
				      
				      var meta = metacal.toFixed(1);
				      $('#metabolism').val(meta);
				      var indice = null;
				      if(bmi <= 18.5){
				    	  indice = "저체중";
				    	  $('input[name=standardbmi]').val(indice).css("color", "#4000FF");
				      }else if(bmi <= 23){
				    	  indice = "정상";
				    	  $('input[name=standardbmi]').val(indice).css("color", "#01A9DB");
				      }else if(bmi <= 25){
				    	  indice = "과체중";
				    	  $('input[name=standardbmi]').val(indice).css("color", "#DBD703");
				      }else if(bmi < 30){
				    	  indice = "비만";
				    	  $('input[name=standardbmi]').val(indice).css("color", "#A4038C");
				      }else if(bmi >= 30){
				    	  indice = "고도비만";
				    	  $('input[name=standardbmi]').val(indice).css("color", "#E30202");
				      }
				      
				      if(indice != null){
				    	  var ajaxcommand = $("#ajaxcommand").val();
				    	  var kcalInfo = [$("#myid").val(), $("#weight").val(), $("#height").val(), $("#bmi").val(), $("#metabolism").val()];
				    	  $.ajax({
								type: "post",
								url:"ajaxcontroller.do",
								data:"command="+ajaxcommand+"&kcalInfo="+kcalInfo,
								dataType:"json",
								async:false,
								success: function(msg) {
									
								},
								error: function() {
									
								}
							});
							//버튼 클릭시 나오는 bmi 수치 그래프
							var bmidata = $("#bmi").val();
									  var txtwidth = 0;
									  var svg = d3.select("#myGraph");
									  
									  svg.selectAll("*").remove();
									  
									      svg.append("rect")
									      .data(bmidata)
									      .attr("class","axis")
									      .attr("x",60)
									      .attr("y",30)                                                                      
									      .attr("width",function(d){
									    	  if(bmidata<23){
									    		  txtwidth = bmidata*10;
									    	 return bmidata*10+"px";
									    	  }else{
									    		  txtwidth = bmidata*16;
									    		  return bmidata*16+"px";
									    	  }
									      })
									      .attr("height","20px")
									       .attr("fill", function(d){
                                    if(bmidata<=18.5){
                                       return "#7da4bd";
                                    }else if(18.5< bmidata && bmidata<=23){
                                       return "#557cd5";
                                    }else if(23<bmidata && bmidata<=25){
                                       return "#787ad6";
                                   }else if(25<bmidata && bmidata<=30){
                                       return "#ba78d9";
                                    }else{
                                       return "#f85264";
                                    }
                                 })
										 
									      svg.selectAll("text")
									      .data(bmidata)
									      .enter()
									      .append("text")
									      .text(function (d){
									    	  return d;
									      })
									      .attr("x",function(d,i){
									    	  return txtwidth+(i*10);
									      })
									      .attr("y",function(d){
									    	  return 28;
									      })
									      .attr("font-family","sens-serif")
									      .attr("font-size","14px")
									      .attr("fill","black")
							
				      }
				    
					        
			      }
			      
			    });
		});
		
		function tttt() {
			window.open('chating.jsp','ex','width=400,height=530');
		};
	
	</script>
</head>
<%
	CalorieDao dao = new CalorieDao();
	LoginBoardDto loginDto = dao.selectMyid(myid);

	String gender = null;
	String birth = null;
	if (loginDto.getMygender() == null || loginDto.getMybirthday() == 0) {
		String tmp = "<script type='text/javascript'>"
				+ "alert('신체 정보 입력 전 회원님의 성별, 생년월일이 필요합니다. 개인정보는 다이어리 데이터 산출에만 이용됩니다.');"
				+ "window.open('insertInfo.jsp', 'Info', 'width=500, height=230');" + "</script>";
		PrintWriter pout = response.getWriter();
		pout.print(tmp);
	} else {
		gender = loginDto.getMygender();
		birth = Integer.toString(loginDto.getMybirthday());
	}

	InbodyDto inbodyDto = new InbodyDto();
%>
<body>

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top"
		id="mainNav">
		<div class="container">
			<a class="navbar-brand" href="controller.do?command=index">다모여</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link"
						href="controller.do?command=main">다모여샵</a></li>
					<li class="nav-item"><a class="nav-link"
						href="controller.do?command=about">정보사이트</a></li>
					<li class="nav-item"><a class="nav-link"
						href="controller.do?command=selectList&page=1">커뮤니티</a></li>
					<li class="nav-item"><a class="nav-link"
						href="controller.do?command=openkcal">kcal다이어리</a></li>
					<%
						if (myid == null) {
					%>
					<li class="nav-item"><a class="nav-link"
						href="controller.do?command=loginpage">로그인</a></li>
					<%
						} else {
							if (dto.getMyrole().equals("ADMIN")) {
					%>
					<li class="nav-item"><a class="nav-link"
						href="controller.do?command=adminpage">관리자페이지</a></li>
					<li class="nav-item"><a class="nav-link"
						href="controller.do?command=logout">로그아웃</a></li>
					<li class="nav-item"><a class="nav-link" onclick="tttt();">채팅방</a></li>
					<%
						} else {
					%>
					<li class="nav-item"><a class="nav-link"
						href="controller.do?command=userpage">마이페이지</a></li>
					<li class="nav-item"><a class="nav-link"
						href="controller.do?command=logout">로그아웃</a></li>
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
			<img alt="1" src="img/3.PNG" style="width: 100%; height: 100%" />
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
						<li><a href="controller.do?command=openkcal">BMI & 기초대사량</a>
						</li>
						<li><a href="controller.do?command=opendaily&myid=<%=myid%>">Daily</a>
						</li>
						<li><a href="controller.do?command=opendiary&myid=<%=myid%>">Calorie
								Diary</a></li>
					</ul>
				</div>
				<h3 class="subtitle" align="center">비만도(BMI) & 기초대사량 측정</h3>
				<form class="bmiform">
					<input type="hidden" id="ajaxcommand" value="updateInbody">
					<input type="hidden" id="myid" value="<%=myid%>"> <input
						type="hidden" id="mygender" value="<%=gender%>"> <input
						type="hidden" id="mybirth" value="<%=birth%>">
					<table class="left-box">
						<tr>
							<td><a>키</a></td>
							<td><input type="number" id="height"><a>cm</a></td>
						</tr>
						<tr class="space"></tr>
						<tr>
							<td><a>체중</a></td>
							<td><input type="number" id="weight"><a>kg</a></td>
							<td><input id="calc" type="button" value="산출하기"
								style="opacity: 0.6; font-style: bold;"></td>
						</tr>
					</table>
					<table class="right-box">
						<tr>
							<td><a>비만도(BMI)</a></td>
							<td style="text-align: center;"><input type="text" id="bmi"
								readonly="readonly" style="text-align: center;"></td>
						</tr>
						<tr class="space"></tr>
						<tr>
							<td><a>기초대사량</a></td>
							<td style="text-align: center;"><input type="text"
								id="metabolism" readonly="readonly" style="text-align: center;"></td>
						</tr>
						<tr class="space"></tr>
						<tr>
							<td style="text-align: center;"><a>BMI 지표</a></td>
							<td style="text-align: center;"><input type="text"
								name="standardbmi" readonly="readonly"
								style="border: 0; text-align: center; font-weight: bold;"></td>
						</tr>
						<tr class="space"></tr>
						<tr class="space"></tr>
					</table>
					<br /> <br /> <br /> <br /> <br />
					<table border="0" style="width: 100%; height: 100px;">
						<tr>
							<td><svg id="myGraph" width="700" height="100">
		          				</svg> <!-- 		          				<svg id ="bmiGraph" width="700" height="100">
		          				</svg> --></td>
						</tr>
						<tr>
							<td align="center"><img src="./img/bimando.PNG"></td>
						</tr>
					</table>
					<br /> <br />
					<table style="width: 100%; height: 100px;">
						<tr>
							<td><a style="font-size: 13px;">- 비만도(BMI), 기초대사량은
									표준계산법에 의해 산출되며 임신, 질환 등 외적인 요인은 산출에 포함되지 않습니다.</a><br /> <a
								style="font-size: 13px;">- 회원님의 개인정보 및 산출된 데이터는 임의 저장되며, 칼로리
									다이어리의 정보에 사용됩니다.</a></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>

	<hr>

	<!-- Footer -->
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-md-10 mx-auto">
					<p class="copyright text-muted">Copyright &copy; Your Website
						2018</p>
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