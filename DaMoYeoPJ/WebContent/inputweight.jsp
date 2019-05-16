<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@page import="com.cal.dto.*"%>
<%@page import="com.cal.dao.*"%>

<%@page import="java.io.PrintWriter"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>

<%@page import="com.login.dto.*"%>
<%@page import="com.login.dao.*" %>

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
    		text-align: center;
		}
		.submenu > ul {
			overflow: hidden;
			list-style: none;
			padding : 0px;
			display: list-item;
			text-align: -webkit-match-parent;
			text-align: center;
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
		
	</style>
	<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript">

	</script>
	
	<script type="text/javascript">
		function tttt() {
			window.open('chating.jsp','ex','width=300,height=500');
		};
	</script>
</head>
<%
	InbodyDto inbodyDto = (InbodyDto)request.getAttribute("indto");
	String id = inbodyDto.getMyid();
	String pagename = (String)request.getAttribute("pagename");
	String msg = (String)request.getAttribute("msg");
	if(msg != null){
		String tmp = "<script type='text/javascript'>" + "alert('"+msg+"');" + "</script>";
		PrintWriter pout = response.getWriter();
		pout.print(tmp);
	}
	CalorieDao dao = new CalorieDao();
	LoginBoardDto loginDto = dao.selectMyid(id);
	String gender = null;
	String birth = null;
	if(loginDto.getMygender() == null || loginDto.getMybirthday() == 0){
		String tmp = "<script type='text/javascript'>" +"alert('신체 정보 입력 전 회원님의 성별, 생년월일이 필요합니다. 개인정보는 다이어리 데이터 산출에만 이용됩니다.');"+ "window.open('insertInfo.jsp', 'Info', 'width=500, height=230');" + "</script>";
		PrintWriter pout = response.getWriter();
		pout.print(tmp);
	}else{
		gender = loginDto.getMygender();
		birth = Integer.toString(loginDto.getMybirthday());
	}
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
								<li class="nav-item"><a class="nav-link" href="controller.do?command=adminpage">관리페이지</a></li>
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
	          	<h3 class="subtitle" align="center">신체 데이터 입력</h3>
	          	<form class="bmiform" action="controller.do" method="post">
	          		<input type="hidden" name="command" value="inputInfo">
	          		<input type="hidden" name="myid" value="<%=id%>">          		
	          		<input type="hidden" name="gender" value="<%=gender%>">          		
	          		<input type="hidden" name="birth" value="<%=birth%>">
	          		<input type="hidden" name="pagename" value="<%=pagename%>">
	          		<input type="hidden" id="alertmsg" value="<%=msg%>">
	          		<table class="" style="margin-left: auto; margin-right: auto;">
	          			<tr>
	          				<td><a>키</a></td>
	          				<td><input type="text" name="height"><a>cm</a></td>
	          			</tr>
	          			<tr class="space"></tr>
	          			<tr>
	          				<td><a>체중</a></td>
	          				<td><input type="text" name="weight"><a>kg</a></td>
	          				<td><input id="" type="submit" value ="입력하기" style="opacity: 0.6; font-style: bold;"></td>
	          			</tr>
	          			<tr class="space"></tr>
	          		</table>
	          		<div align="center">
	          			<a style="font-size: 13px;">- 회원님의 개인정보 및 산출된 데이터는 임의 저장되며, 칼로리 다이어리의 정보에 사용됩니다.</a>
	          		</div>	
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