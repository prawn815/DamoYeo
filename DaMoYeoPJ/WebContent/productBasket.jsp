<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="com.product.dao.BasketDao" %>
<%@page import="com.product.dto.BasketDto" %>

<%@page import="java.util.List" %>

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
		List<BasketDto> list = (List<BasketDto>)request.getAttribute("list");
	%>
<style type="text/css">

	.button {
		
		    width:125px;
		
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
/* 	tr,td{
		border-bottom: solid 1px;
		padding: 5px;
	}
	 */
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript">

	$(function() {
		$("input[name=all]").click(function() {
			if ($("input[name=all]").prop("checked")) {
				$("input[name=chk]").prop("checked", true);
			} else {
				$("input[name=chk]").prop("checked", false);
			}
		});
	});
	
	function result(){
		var result = confirm("결제하시겠습니까?");		
		if(result){
			location.href="controller.do?command=payment"
		}else{
			
		}
	}

	function checkProduct(index) {
		if(index ==1){
			document.myForm.action="controller.do?command=multidel";
		}
		if(index ==2){
			document.myForm.action="controller.do?command=multiPay";
		}
		document.myForm.submit();
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
    <header class="masthead" style="background-image: url('img/contact-bg.jpg')">
      <div class="overlay">
      <img alt="1" src="img/6.jpg" style="width:100%; height: 100%" />
      </div>
      <div class="container">
        <div class="row">
          <div class="col-lg-8 col-md-10 mx-auto">
            <div class="page-heading">
              <h1>SHOP</h1>
              <span class="subheading">필요하시면쓰세요</span>
            </div>
          </div>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <div class="container" style="font-family: 맑은 고딕;">
      <div class="row">
        <div class="col-lg-8 col-md-10 mx-auto">
          

	<h1>장바구니</h1>
	<form name="myForm" method="post">
	
	<table border="1" class="table">
	<colgroup>
				<col width="50">
				<col width="100">
				<col width="400">
				<col width="300">
				<col width="300">
				<col width="300">	
			</colgroup>
		<c:choose>
			<c:when test="">
				<tr>
					<td>---담겨있는 상품이 없습니다.---</td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr align="center">
					<th><input type="checkbox" name="all"></th>
					<th>-</th>
					<th>상품명</th>	
					<th>수량</th>
					<th>가격</th>	
					<th>유저</th>
				</tr>
				<%
					int sum = 0;
					for(BasketDto dto : list){
				%>
				<tr>
					<td align="center"><input type="checkbox" name="chk" value="<%=dto.getBasket_seq()%>"></td>
					<td><img src="img/product/do<%=dto.getPid() %>.jpg" width="100" height="100"></td>
					<td align="center"><a href="controller.do?command=detail&pid=<%=dto.getPid()%>"><%=dto.getPname() %></a></td>
					<td align="center"><%=dto.getAmount() %></td>
					<td align="center"><%=dto.getPrice() %></td>
					<td align="center"><%=dto.getMyid() %></td>		
				</tr>
				<%
					sum = sum + dto.getPrice();
					}
				%>
				<tr>
					<th colspan="5" style="background-color: white;">총금액</th>
					<td align="center"><%= sum %></td>
				</tr>

					<td colspan="6" align="right">
						<input type="button" class="button" value="메인" onclick="location.href='controller.do?command=main'">
						<input type="submit" class="button" value="선택상품삭제" onclick="checkProduct(1)"/>
						<input type="submit" class="button" value="선택상품결제" onClick="checkProduct(2)"/>
						<input type="button" class="button" value="모든상품결제" onclick="result()"/>
					</td>
			</c:otherwise>
		</c:choose>

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
