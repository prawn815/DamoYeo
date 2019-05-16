<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ page import="com.login.dto.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
	
	LoginDto dto = (LoginDto)session.getAttribute("dto");

	String myid = null;
	if(dto != null){
		myid = dto.getMyid();
	}
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
	table {
		border-collapse: separate;
		border-spacing: 1px;
		text-align: left;
		line-height: 1.5;
		border-top: 1px solid #ccc;
		margin: 20px 10px;
		font-size: 15px;
		width: 100%;
	}
	
	table th {
		padding: 10px;
		font-weight: bold;
		vertical-align: middle;
		border-bottom: 1px solid #ccc;
		text-align: center;
	}
	
	table td {
		padding: 10px;
		vertical-align: middle;
		border-bottom: 1px solid #ccc;
	}	
	 .button {
		
		    width:100px;
		
		    background-color: #f0f6f9;
		
		    border: 1px;
		
		    color:black;
		
		    padding: 15px 0;
		
		    text-align: center;
		
		    text-decoration: none;
		
		    display: inline-block;
		
		    font-size: 15px;
		
		    margin: 4px;
		
		    cursor: pointer;
		    
		    border-radius:10px 0 10px 0;
		
		}
		
		.button:hover{
			background-color: yellow;
		}
			
		.table {
	      border-collapse: collapse;
	      border-top: 3px solid #168;
	      font-size: 20px;
	    }  
	    .table th {
	      color: #168;
	      background: #f0f6f9;
	      text-align: center;
	      font-size: 20px;
	      
	    }
	    .table th, .table td {
	      padding: 10px;
	      border: 1px solid #ddd;
	      text-align: left;
	    }
	    .table th:first-child, .table td:first-child {
	      border-left: 0;
	    }
	    .table th:last-child, .table td:last-child {
	      border-right: 0;
	    }
	    .table tr td:first-child{
	      text-align: left;
	    }
	    .table caption{
	    caption-side: bottom; display: none;	
		
	}
	</style>
	
	<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript">
		$(function() {
			//전역변수선언
			var editor_object = [];
	
			nhn.husky.EZCreator.createInIFrame({
				oAppRef : editor_object,
				elPlaceHolder : "smarteditor",
				sSkinURI : "SmartEditor2Skin.html",
				htParams : {
					// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseToolbar : true,
					// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseVerticalResizer : true,
					// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
					bUseModeChanger : true,
				}
			});
	
			//전송버튼 클릭이벤트
			$("#savebutton").click(
				function() {
					//id가 smarteditor인 textarea에 에디터에서 대입
					editor_object.getById["smarteditor"].exec(
							"UPDATE_CONTENTS_FIELD", []);
						// 이부분에 에디터 validation 검증
	
						$("#frm").submit();
					
			});
			
		});
		
		function addrfun(val) {
			var se = document.getElementById("addre");
				
			if(val.value == 4){
				se.style.visibility = "visible";
			}
			else{
				se.style.visibility = "hidden";
			}
		}
		
		
	</script>
	
	<script type="text/javascript">
		function tttt() {
			window.open('chating.jsp','ex','width=400,height=530');
		};
	</script>

</head>

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
	<header class="masthead" style="background-image: url('img/post-bg.jpg')">
		<div class="overlay">
			<img alt="1" src="img/4.jpg" style="width: 100%; height: 100%">
		</div>
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-md-10 mx-auto">
					<div class="post-heading" align="center">
						<h1>커뮤니티</h1>
						<h2 class="subheading">내용 쓰기</h2>
					</div>
				</div>
			</div>
		</div>
	</header>

	<!-- Post Content -->
	<article>
		<div class="container" style="font-family: 맑은 고딕;">
			<div class="row">
				<div class="col-lg-8 col-md-10 mx-auto">
					<form action="controller.do" method="post" id="frm">
						<input type="hidden" name="command" value="insertBoard" /> 
						<input type="hidden" name="myid" value="<%=myid %>" readonly="readonly" />
						<!-- session으로 받아와야 합니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
				
							<table>
								<tr>
									<td>게시판</td>
									<td>
										<select name="boardno" onclick="addrfun(this);">
											<option value="1">자유게시판</option>
											<option value="2">질문게시판</option>
											<option value="3">팁게시판</option>
											<option value="4">지역게시판</option>
											<option value="5">성공후기게시판</option>
										</select>
										<select id="addre" name="addr" style="visibility: hidden;">
											<option>선택해주세요</option>
											<option>서울</option>
											<option>경기/인천</option>
											<option>강원도</option>
											<option>충청도</option>
											<option>전라도</option>
											<option>경상도</option>
											<option>제주도</option>
											<option>해외</option>
										</select>
									</td>
								</tr>
								<tr>
									<td style="vertical-align: middle;">제목</td>
									<td colspan="3"><input type="text" name="title" size="50%" /></td>
								</tr>
								
								<tr>
									<td colspan="4">
										<textarea name="smarteditor" id="smarteditor" rows="10" cols="100" style="width: 100%; height: 400px;" ></textarea>
									</td>
								</tr>
								
								<tr>
									<td colspan="4" style="text-align: right;">
										<input type="button" id="savebutton" class="button" value="게시하기"/>
										<input type="button" onclick="history.back(-1);" class="button" value="목록으로"/>
									</td>
								</tr>
				
							</table>
					</form>
				</div>
			</div>
		</div>
	</article>

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