<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.login.dto.LoginDto"%>
<%@ page import="com.login.dao.LoginDao "%>

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>

<%
	LoginDto dto = (LoginDto) session.getAttribute("dto");

	String myid = null;
	if (dto != null) {
		myid = dto.getMyid();
	} else {
		response.sendRedirect("controller.do?command=whatlog");
	}
%>

<%@ page import="com.about.dto.InfoBoardDto"%>
<%@ page import="com.about.dao.InfoBoardDao"%>

<%
	InfoBoardDto infodto = (InfoBoardDto)request.getAttribute("infodto");
	
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

<style type="text/css">
.table {
	      border-collapse: collapse;
	      border-top: 3px solid #4374D9;
	      font-size: 20px;
	    }  
	    .table th {
	      color: #168;
	      background: #B2CCFF;
	      text-align: center;
	      font-size: 20px;
	      
	    }
	    .table th, .table td {
	      padding: 10px;
	      border: 1px solid #ddd;
	      text-align: center;
	    }
	    
	    .table td{
	    background: #F8FFFF;
	    
	    }
	    
	    .table th:first-child, .table td:first-child {
	      border-left: 0;
	    }
	    .table th:last-child, .table td:last-child {
	      border-right: 0;
	    }
	    .table tr td:first-child{
	      text-align: center;
	    }
	    .table caption{caption-side: bottom; display: none;}

		.button {
		
		    width:125px;
		
		    background-color: #B2CCFF;
		
		    border: 1px;
		
		    color:black;
		
		    padding: 15px 0;
		
		    text-align: center;
		
		    text-decoration: none;
		
		    display: inline-block;
		
		    font-size: 15px;
		
		    margin: 4px;
		
		    cursor: pointer;
		    
		    border-radius:10px 10px 10px 10px;
		    
		    border: solid 3px #4374D9;
		
		}
		
		.button:hover{
			background-color: yellow;
		}

</style>


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

<script type="text/javascript">
	function tttt() {
		window.open('chating.jsp', 'ex', 'width=400,height=530');
	};
</script>

</head>

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
			<img alt="1" src="img/5.jpg" style="width: 100%; height: 100%" />
		</div>
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-md-10 mx-auto">
					<div class="page-heading">
						<h1>정보 게시판</h1>
						<span class="subheading">상세보기</span>
					</div>
				</div>
			</div>
		</div>
	</header>


	<!-- Main Content -->
	<div class="container" style="font-family: 맑은 고딕;">
	<div class="container">
		<div class="row">
			<div class="col-lg-8 col-md-10 mx-auto">
				<table border="1" class="table">
					<tr>
						<th>내용</th>
						<td><%=infodto.getMycontent()%></td>
					</tr>
					<tr>
						<td colspan="2" align="right"><input type="button" class="button" value="목록"
							onclick="history.back(-1);"></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>




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