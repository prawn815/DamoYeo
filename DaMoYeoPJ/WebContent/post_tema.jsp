<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.post.dao.*"%>
<%@ page import="com.post.dto.*" %>
<%@ page import="com.login.dto.LoginDto"%>
<%@ page import="com.login.dao.LoginDao " %>

<%
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
	
		.button {
		
		    width:75px;
		
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
	      font-size: 15px;
	    }  
	    .table th {
	      color: #168;
	      background: #f0f6f9;
	      text-align: center;
	      font-size: 15px;
	      
	    }
	    .table th, .table td {
	      padding: 10px;
	      border: 1px solid #ddd;
	      text-align: center;
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
		
		
		#paging{
			font-size: 12px;
			font-style: italic;
			text-align: center;
			width: 100%;
			word-spacing: 5px;
		}
		
		#searchtxt{
			font-size: 12px;
		}
		.submenu {
			color: #292929;
			font-size: 12px;
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
			margin-left: 40px;
			margin-right: 30px;
		}
		.subtitle{
			margin-top: 50px;
			margin-bottom: 50px;
		}
		
		.row li:hover{
			background-color: #f6f6f6;
		}
		
	</style>

<%
	List<boardDto> list = (List<boardDto>) request.getAttribute("list");
	DateFormat fom = new SimpleDateFormat("yyyy-MM-dd");
	ansDao ansdao = new ansDaoImpl();
	
	choiceDao cdao = new choiceDaoImpl();
	
	int cnt = (int)request.getAttribute("cnt");
	int pagecnt = (int)request.getAttribute("page");
	int boardno = (int)request.getAttribute("boardno");
%>

	<script type="text/javascript">

		window.onload=function(){
			var size = document.getElementById("cnt").value;
			var taga = document.getElementById("pager");
			var boardno = document.getElementById("boardno").value;
			
			
			for(var i=0; i < size/10; i++){
				taga.innerHTML += " <a href='controller.do?command=selectTema&boardno="+boardno+"&page="+ (i+1) +"')>"+ (i+1)+ "</a> ";
			}
		};
		
		function ale(msg) {
			alert(msg + " 페이지 입니다!");
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
		<div class="container" style="font-family: 맑은 고딕;">
			<div class="row">
				<div class="col-lg-8 col-md-10 mx-auto">
					<div class="post-heading" align="center">
						<h1>커뮤니티</h1>
						<h2 class="subheading">
							<%
										switch (boardno) {
											case 1:
%>
											자유게시판
<%
											break;
			
											case 2:
%>
											질문게시판
<%
											break;

											case 3:
%>
											팁게시판
<%
											break;
											case 4:
%>
											지역게시판
<%
											break;
											case 5:
%>
											후기게시판
<%
											break;
											default:
%>
											너는어디냐
<%
											break;

										}
%>
						</h2>
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
					<div class="submenu">
        				<ul>
        					<li>
        						<a href="controller.do?command=selectTema&pagecnt=1&boardno=1">자유게시판</a>
        					</li>
        					<li>
        						<a href="controller.do?command=selectTema&pagecnt=1&boardno=2">질문게시판</a>
        					</li>
        					<li>
        						<a href="controller.do?command=selectTema&pagecnt=1&boardno=3">팁게시판</a>
        					</li>
        					<li>
        						<a href="controller.do?command=selectTema&pagecnt=1&boardno=4">지역게시판</a>
        					</li>
        					<li>
        						<a href="controller.do?command=selectTema&pagecnt=1&boardno=5">다이어트 성공 후기</a>
        					</li>
        				</ul>
        			</div>

					<form action="#" method="post">
						<table class="table">
							<col width="210px">
							<col width="100px">
							<col width="600px">
							<col width="300px">
							<col width="100px">
							<col width="150px">
							<col width="200px">

						<tr>
							<th>게시판</th>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>O/X</th>
							<th>조회수</th>
							<th>작성일</th>
						</tr>

<%
							if (list.size() == 0) {
%>

								<tr>
									<td colspan="8">------------글이 존재하지 않습니다.---------------</td>
								</tr>

<%
							}

							else {
									
								for (boardDto boarddto : list) {
%>
									<tr>

<%										
										switch (boarddto.getBoardno()) {
											case 1:
%>
											<td align="center">자유<br>게시판</td>
<%
											break;
			
											case 2:
%>
											<td align="center">질문<br>게시판</td>
<%
											break;
	
											case 3:
%>
											<td align="center">팁<br>게시판</td>
<%
											break;
											case 4:
%>												<td align="center"><%=boarddto.getAddr() %></td>
<%
											break;
											case 5:
%>
											<td align="center">후기<br>게시판</td>
<%
											break;
											default:
%>
											<td align="center">너는<br>어디냐</td>
<%
											break;

										}
%>
										<td align="center"><%=boarddto.getBoardseq()%></td>
										<td>
											<a href="controller.do?command=boardOne&page=1&boardseq=<%=boarddto.getBoardseq()%>"><%=boarddto.getTitle()%></a>
<%
										 		int boardseq = boarddto.getBoardseq();
										 		int res = ansdao.getAnsCnt(boardseq);
%>
										 	<a style="color: red;"><%=res %></a>
										 </td>
										<td align="center"><%=boarddto.getMyid()%></td>
										<td align="center"><%=cdao.goodCnt(boarddto.getBoardseq())%>/<%=cdao.notgoodCnt(boarddto.getBoardseq())%></td>
										<td align="center"><%=boarddto.getVisitcnt()%></td>
										<td align="center"><%=fom.format(boarddto.getRegdate())%></td>
									</tr>
<%
									}
								}
%>
<%
						if(myid != null){
							
%>
						<tr align="right">
							<td colspan="8" align="right"><input type="button" class="button" value="글쓰기" onclick="location.href='post_insert.jsp'" /></td>
						</tr>
<%
							
						}
%>
					</table>
					<input type="hidden" value="<%=cnt %>" id="cnt"/>
					<input type="hidden" value="<%=boardno %>" id="boardno" />
				</form>
				
				<!-- 페이징 처리 -->
				<div id="paging">
					<%
						if(pagecnt != 1){
					%>
					<a href="controller.do?command=selectTema&boardno=<%=boardno %>&page=<%=pagecnt-1%>" id="pre">이전</a>
					<%
						}
						else{
					%>
					<a onclick="ale('처음');">이전</a>
					<%
						}
					%>
					
					<!-- 숫자처리  inner html로 처리하면 될듯-->
					<a id="pager">
						
					</a>
					<%
						if(pagecnt != (cnt/10)+1){
							
					%>
					<a href="controller.do?command=selectTema&boardno=<%=boardno %>&page=<%=pagecnt+1%>" id="next">다음</a>
					<%
							
						}
						else{
					%>
							<a onclick="ale('마지막');">다음</a>
					<%
						}
					%>
				</div>
				<br/>
				<div id="searchtxt" align="center">
					<form action="controller.do" method="post">
						<input type="hidden" name="command" value="searchTemaResult" />
						<input type="hidden" name="page" value="1" />
						<input type="hidden" name="boardno" value="<%=boardno %>" />
						<select name="sort">
							<option value="1">글제목</option>
							<option value="2">작성자</option>
						</select>
						<input type="text" name="searchtext" size="30%" />
						<input type="submit" class="button" value="검색"/>
					</form>
				</div>
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