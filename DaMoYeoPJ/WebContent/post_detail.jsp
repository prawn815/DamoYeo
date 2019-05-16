
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="com.post.dto.*"%>
<%@ page import="com.post.dao.*"%>
<%@ page import="com.login.dto.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

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
		vertical-align: top;
		border-bottom: 1px solid #ccc;
		text-align: center;
	}
	
	table td {
		padding: 10px;
		vertical-align: top;
		border-bottom: 1px solid #ccc;
	}
	
	img {
		max-width: 100%;
	}
	
	#paging{
		font-size: 12px;
		font-style: italic;
		text-align: center;
		width: 100%;
		word-spacing: 5px;
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
		
		.button {
		
		    width:50px;
		
		    background-color: #f0f6f9;
		
		    border: 1px;
		
		    color:black;
		
		    padding: 15px 0;
		
		    text-align: center;
		
		    text-decoration: none;
		
		    display: inline-block;
		
		    font-size: 12px;
		
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
		
	</style>
	
	<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
	
	<script type="text/javascript">
		window.onload=function(){
			var anscnt = document.getElementById("anscnt").value;
			var taga = document.getElementById("pager");
			var boardseq = document.getElementById("seq").value;
		
			for(var i=0; i < anscnt/5; i++){
				taga.innerHTML += " <a href='controller.do?command=boardOne&boardseq=" + boardseq + "&page="+ (i+1) +"')>"+ (i+1)+ "</a> ";
			}
		};
		
		function ale(msg) {
			alert(msg + " 댓글 페이지 입니다!");
		}
		
		function deleteOne(boardseq) {
			var rechk = confirm("삭제하시겠습니까??");
			
			if(rechk){
				location.href="controller.do?command=deleteOne&boardseq="+boardseq;
			}
			else{
				alert("되돌아 갑니다.");
			}
		}
		
		function updateOne(boardseq) {
			location.href="controller.do?command=updateOne&boardseq="+boardseq;
		}
		
		$(function() {
			$("#YYYY").click(function() {
				var boardseq = $("#boardseq").val();
				var myid = $("#myid").val();
				
				$.ajax({
					type: "post",
					url: "controller.do",
					data: "command=choice&boardseq="+ boardseq + "&myid="+ myid + "&choice=Y",
					async: false,
					success: function() {
						location.reload();
					},
					error: function() {
						alert("다시 시도해주세요");
					}
				});
			});
			
			$("#NNNN").click(function() {
				var boardseq = $("#boardseq").val();
				var myid = $("#myid").val();
				
				$.ajax({
					type: "post",
					url: "controller.do",
					data: "command=choice&boardseq="+ boardseq + "&myid="+ myid + "&choice=N",
					async: false,
					success: function() {
						location.reload();
					},
					error: function() {
						alert("다시 시도해주세요");
					}
				});
			});
			
			$("#ansinsert").click(function() {
				var boardseq = $("#boardseq").val();
				var myid = $("#myid").val();
				var anscontent = $("#anscon").val();
				
				$.ajax({
					type: "post",
					url: "controller.do",
					data: "command=insertAns&boardseq="+ boardseq + "&myid="+ myid + "&anscontent="+anscontent,
					async: false,
					success: function() {
						location.reload();
					},
					error: function() {
						alert("다시 시도해주세요");
					}
				});
			});
			
			$("#deleteAns").click(function() {
				var boardseq = $("#boardseq").val();
				var ansno = $("#ansno").val();
				
				$.ajax({
					type: "post",
					url: "controller.do",
					data: "command=deleteAns&boardseq="+ boardseq + "&ansno="+ ansno ,
					async: false,
					success: function() {
						location.reload();
					},
					error: function() {
						alert("다시 시도해주세요");
					}
				});
			});
			
		});
	</script>
	
	<script type="text/javascript">
		function tttt() {
			window.open('chating.jsp','ex','width=400,height=530');
		};
		
		
	</script>

</head>
<body>

<%
	boardDto boarddto = (boardDto)request.getAttribute("boarddto");
	DateFormat fom = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	//ans
	int anscnt = (int)request.getAttribute("anscnt");
	int pagecnt = Integer.parseInt(request.getParameter("page"));
	
	
	//초이스
	choiceDto cdto = new choiceDto();
	cdto.setBoardseq(boarddto.getBoardseq());
	//여기에도 세션 아이디로 받아오
	cdto.setMyid(myid);
	choiceDao cdao = new choiceDaoImpl();
	String choice = cdao.getCInfo(cdto);
%>

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
						<h2 class="subheading">내용 보기</h2>
					</div>
				</div>
			</div>
		</div>
	</header>

	<!-- Post Content -->
	<article>
		<div class="container">
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
				
					<form action="controller.do" method="post" id="frm">
						<input type="hidden" name="command" value="" />


<%
							switch (boarddto.getBoardno()) {
							case 1:
%>
							<h2>자유게시판</h2>
<%
							break;

							case 2:
%>
							<h2>질문게시판</h2>
<%
							break;

							case 3:
%>
							<h2>팁게시판</h2>
<%
							break;

							case 4:
%>
							<h2>지역게시판(<%=boarddto.getAddr() %>)</h2>
<%
							break;

							case 5:
%>
							<h2>후기게시판</h2>
<%
							break;

							default:
%>
							<h2>너는 어디냐</h2>
<%
							break;

							}
%>


						<input type="hidden" value="<%=boarddto.getBoardseq() %>" id="seq" />
						<table>
							
							<tr>
								<td colspan="8"><h3><%=boarddto.getTitle()%></h3></td>
							</tr>
							<tr>
								<td colspan="7"><%=boarddto.getMyid()%></td>
								<td align="right"><%=fom.format(boarddto.getRegdate())%> / <%=boarddto.getVisitcnt()%></td>
							</tr>

							<tr>
								<td colspan="8"><%=boarddto.getContent()%><br />
									<div align="center">
										<!-- 뒤에 유저 아이디에 세션을 넣어줘야합니다. 정확히는 세션아이디. -->
										<!-- 이미지 버튼을 쓸거 같은데 조건문을 걸어서 선택한거에는 미리 체크를 해놓읍시다. img같은 경우는 이미지를 바꾸면 되겟죠?? -->
										<%-- <input type="button" value="공감 : <%=cdao.goodCnt(boarddto.getBoardseq()) %>" onclick="location.href='controller.do?command=choice&boardseq=<%=boarddto.getBoardseq() %>&myid=<%=myid%>&choice=Y'" />
										<input type="button" value="비공감 : <%=cdao.notgoodCnt(boarddto.getBoardseq()) %>" onclick="location.href='controller.do?command=choice&boardseq=<%=boarddto.getBoardseq() %>&myid=<%=myid %>&choice=N'" />
										 --%>
										 
										 <%
										 	if(cdao.checkChoice(boarddto.getBoardseq(), myid) != null){
										 		
											 	if(cdao.checkChoice(boarddto.getBoardseq(), myid).equals("Y")){
											 		
											 		
											 %>
											 		<a>O</a>
											 		<input type="button" class="button" value="공감:<%=cdao.goodCnt(boarddto.getBoardseq()) %>" id="YYYY" />
											 		<input type="button" class="button" value="비공감:<%=cdao.notgoodCnt(boarddto.getBoardseq()) %>" id="NNNN" />
											 <%
											 		
											 	}
											 	else if(cdao.checkChoice(boarddto.getBoardseq(), myid).equals("N")){
											 	
											 %>
													 	
													<input type="button" class="button" value="공감:<%=cdao.goodCnt(boarddto.getBoardseq()) %>" id="YYYY" />
													<input type="button" class="button" value="비공감:<%=cdao.notgoodCnt(boarddto.getBoardseq()) %>" id="NNNN" />
													<a>O</a>
											<%
											 	}
										 	}
										 
										 	else{
										 		%>
										 		<input type="button" class="button" value="공감:<%=cdao.goodCnt(boarddto.getBoardseq()) %>" id="YYYY" />
												<input type="button" class="button" value="비공감:<%=cdao.notgoodCnt(boarddto.getBoardseq()) %>" id="NNNN" />
													
										 		<%
										 	}
										 %>
										 
										 
										 
									</div>
								</td>
							</tr>

							<tr>
								<td colspan="8" align="right">
									<%
										//세션 아이드를 받아옵니다.!!!
										if(boarddto.getMyid().equals(myid)){
									%>
									<input type="button" value="수정" class="button" onclick="updateOne(<%=boarddto.getBoardseq() %>);" />
									<input type="button" value="삭제" class="button" onclick="deleteOne(<%=boarddto.getBoardseq() %>);" />
									<%
										}
									%>
									<input type="button" class="button" value="목록으로" onclick="history.back(-1);"/>
								</td>
							</tr>
						</table>
					</form>
					
					<!-- 답글을 해보장 -->
						<div id="ansKing">
						
							<div id="ansinput" align="center">
								<form action="controller.do" method="post">
									<input type="hidden" name="command" value="insertAns" />
									<input type="hidden" name="page" value="<%=(anscnt/5)+1 %>" />
									<input type="hidden" name="page12" value="<%=request.getParameter("page") %>" id="anspage" />
									<input type="hidden" name="myid" value="<%=myid %>" id="myid" />
									
									<!-- 세션으로 받아와야 합니다.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
									<input type="hidden" name="boardseq" value="<%=boarddto.getBoardseq() %>" id="boardseq" />
									<!-- 가장 기본적인 형태의 댓글만 달 수 있는 형식입니다. -->
									
									<textarea id="anscon" name="anscontent" style="font-size: 12px; font-style: italic; width: 80%; display: inline;"></textarea>
									&nbsp;&nbsp;&nbsp;
									<input type="button" class="button" value="입력" id="ansinsert" />
									
									<!-- 페이징 관련 -->
									
									<input type="hidden" value="<%=anscnt %>" id="anscnt" />
									
									
								</form>
							</div>
							<hr/>
							<div id="ansarea" align="center">
								<table>
									<col width="100" />
									<col width="300" />
									<col width="120" />
									<col width="50" />
									
									<c:choose>
										<c:when test="${empty anslist }">
											<tr>
												<th colspan="3">-----댓글이 없습니다.-----</th>
											</tr>
										</c:when>
										
										<c:otherwise>											
											<c:forEach items="${anslist }" var="ansdto">
											
												<tr>
													<td>${ansdto.myid }</td>
													<td>
														<c:forEach begin="1" end="${ansdto.ttab }">
															&nbsp;
														</c:forEach>
														<a>${ansdto.anscontent }</a>
													</td>
													<td><fmt:formatDate value="${ansdto.ansregdate }" pattern="yyyy-MM-dd HH:mm" /></td>
													<c:choose>
														<c:when test="${ansdto.myid eq sessionScope.dto.getMyid() }">
															<td>
																<input type="hidden" value="${ansdto.ansno }" id="ansno">
																<input type="button" class="button" value="삭제" id="deleteAns">
															</td>
														</c:when>
														<c:otherwise>
															<td></td>
														</c:otherwise>
													</c:choose>
												</tr>
												
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</table>
							</div>
							
					<!-- 페이징 처리 -->
					
					<div id="paging">
					<%
						if(pagecnt != 1){
					%>
					<a href="controller.do?command=boardOne&boardseq=<%=boarddto.getBoardseq() %>&page=<%=pagecnt-1%>" id="pre">이전</a>
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
						if(pagecnt != (anscnt/5)+1){
							
					%>
					<a href="controller.do?command=boardOne&boardseq=<%=boarddto.getBoardseq() %>&page=<%=pagecnt+1%>" id="next">다음</a>
					<%
							
						}
						else{
					%>
							<a onclick="ale('마지막');">다음</a>
					<%
						}
					%>
				</div>
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
					<ul class="list-inline text-center">
						<li class="list-inline-item"><a href="#"> <span
								class="fa-stack fa-lg"> <i
									class="fas fa-circle fa-stack-2x"></i> <i
									class="fab fa-twitter fa-stack-1x fa-inverse"></i>
							</span>
						</a></li>
						<li class="list-inline-item"><a href="#"> <span
								class="fa-stack fa-lg"> <i
									class="fas fa-circle fa-stack-2x"></i> <i
									class="fab fa-facebook-f fa-stack-1x fa-inverse"></i>
							</span>
						</a></li>
						<li class="list-inline-item"><a href="#"> <span
								class="fa-stack fa-lg"> <i
									class="fas fa-circle fa-stack-2x"></i> <i
									class="fab fa-github fa-stack-1x fa-inverse"></i>
							</span>
						
						</a>
						</li>
					</ul>
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