<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List" %>
<%@page import = "com.product.dto.SaleorderDto" %>

<%@ page import="com.login.dto.LoginDto"%>
<%@ page import="com.login.dao.LoginDao " %>

<%
	LoginDto dto_login = (LoginDto)session.getAttribute("dto");

	String myid = null;
	if(dto_login != null){
		myid = dto_login.getMyid();
	}
%>

<!DOCTYPE html>
<html>
  <head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

<title>다이어트필요한사람모두여기로!</title>
<%
	List<SaleorderDto> slist = (List<SaleorderDto>) request.getAttribute("slist");
%>
<style type="text/css">
	 tr,td{
		border-bottom: solid 1px;
		padding: 5px;
	}
	table{
		width : 100%;
		margin: auto;
		margin-top: 50px;		
		background: white;		
		border-top: solid 1px;
		border-bottom : solid 1px;		
		text-align: center;
		border-spacing: 3px;
		border-collapse: collapse;
	}
	 
	h1{
		font-family : fantasy;
		margin: auto;
		text-align: center;
	}
	
	.review{
		border: 1px solid black;
		background: white;
		position: absolute;
		top: 200px;
		left: 500px;
	 	display: none; 	/* 클릭 시 에만 나타나게 설정  */
	}
	
	.button {
		
		    width:120px;
		
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

<script type="text/javascript">

	function reviewForm(tmp){
		document.getElementsByClassName("review")[tmp].style.display = "block";
		document.body.style.backgroud = "white";
		
		var btns = document.getElementsByName("btn");
		for ( var i in btns) { 
			
			btns[i].disabled = "disabled";
		}
		
	}
	
	function closeReview(){
		
		
		var btns = document.getElementsByName("btn");
		for ( var i in btns) { 
			document.getElementsByClassName("review")[i].style.display="none";
			btns[i].disabled = "";
		}
	}
	
	   function maxLengthCheck(object){
	         if (object.value.length > object.maxLength){
	          object.value = object.value.slice(0, object.maxLength);
	          }   
	         }
	   
	// 공백 체크 및 기능 체크
	    function nullchk() {

			
			if(document.getElementById("title").value == ""){
				alert("제목을 입력해주세요");
				return false;
			}
			
			if(document.getElementById("title").value == null){
				alert("제목을 입력해주세요");
				return false;
			}
			
			if(document.getElementById("content").value == ""){
				alert("내용을 입력해주세요");
				return false;
			}
			
			if(document.getElementById("content").value == null){
				alert("내용을 입력해주세요");
				return false;
			}

	    	return true;
		}
</script>
    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>

    <!-- Custom styles for this template -->
    <link href="css/clean-blog.min.css" rel="stylesheet">
    
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
							if(dto_login.getMyrole().equals("ADMIN")){
								
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
    <header class="masthead" style="background-image: url('img/contact-bg.jpg')">
      <div class="overlay">
      <img alt="1" src="img/6.jpg" style="width:100%; height: 100%" />
      </div>
      <div class="container">
        <div class="row">
          <div class="col-lg-8 col-md-10 mx-auto">
            <div class="page-heading">
              <h1>SHOP</h1>
            </div>
          </div>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <div class="container" style="font-family: 맑은 고딕;">
      <div class="row">
        <div class="col-lg-20 col-md-15 mx-auto">
		<!-- 여기에 넣으시면 됩니다. -->
	<h1>주문/배송 조회</h1>

	<table class="table">
		<col width="300">
		<col width="300">
		<col width="800">
		<col width="200">
		<col width="200">
		<col width="300">
		<col width="400">
		<col width="200">
		<tr>
			<th>주문 번호</th>
			<th>주문일</th>
			<th>상품정보</th>
			<th>수량</th>
			<th>주문금액</th>
			<th>주소</th>
			<th>진행 상태</th>
			<th>Review</th>
		</tr>
		<c:choose>
			<c:when test="">
				<tr>
					<td colspan="5" align="center">주문한 상품이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
			<%
				SimpleDateFormat formatType = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
				
				int tmp = 0;
				for(SaleorderDto sdto : slist){	
					
			%>
				<tr>
					<td><%=sdto.getOrder_id() %></td>
					<td><%= formatType.format(sdto.getOrder_date())%></td>
					<td>
						<a href="controller.do?command=detail&pid=<%=sdto.getPid()%>">
						<img src="img/product/do<%=sdto.getPid() %>.jpg" width="100" height="100">
						<%=sdto.getPname() %>
						</a>
					</td>
					<td><%=sdto.getAmount() %></td>
					<td><%=sdto.getPrice() %></td>
					<td><%=sdto.getAddr() %></td>
					<td>
                 	 <c:set var="state" value="<%=sdto.getOrder_state() %>"/>
                 	 <c:if test="${state eq 1 }">상품 준비중</c:if>
                 	 <c:if test="${state eq 2 }">택배사 운송중</c:if>
                	 <c:if test="${state eq 3 }">상품 배달중</c:if>
                	 <c:if test="${state eq 4 }">상품 수령완료</c:if>
              		</td>
					<td>
						<c:set var="state" value="<%=sdto.getOrder_state() %>"/>
						<c:if test="${state eq 4 }">
							<input type="button" class="button" value="Review작성" name="btn" onclick="reviewForm(<%=tmp %>)"/>
						</c:if>	
					</td>
				</tr>
			
			<%
				tmp++;
				}
			%>

			
			</c:otherwise>
		</c:choose>
		
	</table>
	
	
		<!-- 여기에 넣으시면 됩니다. -->	
        </div>
      </div>
    </div>
	<% 
	 int tmp = 0;
	for(SaleorderDto sdto : slist){		
	%>
	<div class = "review">
		<form action="controller.do?command=writeReview" method="post" novalidate onsubmit="return nullchk();">
			<input type="hidden" name="pid" value="<%=sdto.getPid() %>" />
			<input type="hidden" name="my_id" value="<%=sdto.getMyid() %>" />
			<table class="table">
				<caption>Review</caption>
					<tr>
						<td>작성자</td>
						<td><%=sdto.getMyid() %></td>
					</tr>
					<tr>
                  <td>별점</td>
                  <td>
                     <select name='star' id='star'>
                        <option value="0" selected>☆☆☆☆☆</option>
                        <option value="1">★☆☆☆☆ </option>
                        <option value="2">★★☆☆☆</option>
                        <option value="3">★★★☆☆</option>
                        <option value="4">★★★★☆</option>
                        <option value="5">★★★★★</option>
                     </select>
                  </td>
               </tr>

					<tr>
						<td>제목</td>
						<td><textarea id="title" cols="50" name="title"></textarea></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea id="content" rows="10" cols="50" name="content"></textarea></td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="button" class="button" value="취소" onclick="closeReview(<%=tmp %>)"/>
							<input type="submit" class="button" value="작성"/>
						</td>
					</tr>
		
		
			</table>
		</form>
	</div>
	<%
	tmp++;
	}
	%>
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

    <!-- Contact Form JavaScript -->
    <script src="js/jqBootstrapValidation.js"></script>
    <script src="js/contact_me.js"></script>

    <!-- Custom scripts for this template -->
    <script src="js/clean-blog.min.js"></script>

  </body>

</html>
