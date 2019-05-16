<%@page import="com.product.dto.SaleorderDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import="com.login.dto.LoginDto"%>
<%@ page import="com.login.dao.LoginDao " %>
<%@ page import="java.util.List" %> 

<%
	response.setHeader("Pragma", "no-chche");
	response.setHeader("Cache-control", "no-store");
	response.setHeader("Expries", "0");
	/* 데이터가 변경되었을 떄, 이전 내용을 화면에 보여주는 이유 -> 서버의 값이  아닌 캐시에 저장된 내용을 가져오기 때문
	
	브라우저가 캐시에 응답결과를 저장하지 않도록 설
	response.setHeader("Pragma", "no-chche");			// http 1.0
	response.setHeader("Cache-control", "no-store");	// http 1.1
	response.setHeader("Expries", "0");					// proxy server	
	 */ 
%>

<!DOCTYPE html>
<html>

<%

	List<LoginDto> list = (List<LoginDto>)request.getAttribute("userlist");
	List<SaleorderDto> userorder = (List<SaleorderDto>)request.getAttribute("userorder");
	
	LoginDto admin = (LoginDto)session.getAttribute("dto");
	
	if(admin == null){
		pageContext.forward("login.jsp");
	}
%>


<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>관리자 페이지</title>
    <style>
    .table {
      border-collapse: collapse;
      border-top: 3px solid #168;
    }  
    .table th {
      color: #168;
      background: #f0f6f9;
      text-align: center;
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
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

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
            		<li class="nav-item">
              			<a class="nav-link" href="controller.do?command=logout">로그아웃</a>
            		</li>
            		<li class="nav-item">
              			<a class="nav-link" onclick="tttt();">채팅방</a>
            		</li>
            		
          		</ul>
        	</div>
      	</div>
	</nav>
    

	<!-- Page Header -->
    <header class="masthead" style="">
		<div class="overlay">
      		<img alt="1" src="img/2.jpg" style="width:100%; height: 100%">
      	</div>
      	<div class="container">
        	<div class="row">
          		<div class="col-lg-8 col-md-10 mx-auto">
            		<div class="page-heading">
              			<h1></h1>
              			<span class="subheading"></span>
            		</div>
          		</div>
        	</div>
      	</div>
    </header>

    <!-- Main Content -->
    <div class="container">
	<div align="center" style="font-family: 맑은 고딕;">
		<h1>관리자 페이지</h1>
		<br/>
		<br/>
		<br/>
		<b><span><%=admin.getMyid() %>님 환영합니다.</span></b>
	</div>
	
	<br/>
	<br/>
	
	<p align="center" style="font-family: 맑은 고딕;">회원 리스트</p>
	
	<br/>
	<div align="center" style="font-family: 맑은 고딕;">
		<table border="2" class="table">
			<col width="300">
			<col width="100">
			<col width="100">
			<col width="200">
			<col width="250">
			<col width="300">
			<col width="100">
		
			<tr>
				<th>아이디</th>	
				<th>이름</th>
				<th>성별</th>
				<th>생년월일</th>
				<th>주소</th>
				<th>전화번호</th>
				<th>이메일</th>	
				<th>등급</th>
			</tr>
<%
			for(LoginDto dto : list){
%>		
				<tr>
					<td><%=dto.getMyid() %></td>
					<td><%=dto.getMyname() %></td>
					<td><%=dto.getMygender() %></td>
					<td><%=dto.getMybirthday() %></td>
					<td><%=dto.getMyaddr() %></td>
					<td><%=dto.getMyphone() %></td>
					<td><%=dto.getMyemail() %></td>
					<td><%=dto.getMyrole() %></td>
				</tr>
	
<%
			}	
%>		
    	</table>
    </div>
    <br>
	<p align="center" style="font-family: 맑은 고딕;">주문 내역</p>
	<br>
	<div align="center" style="font-family: 맑은 고딕;">
			<table border="2" class="table">
				<col width="300">
				<col width="100">
				<col width="100">
				<col width="200">
				<col width="250">
				<col width="300">
				<col width="100">
			
				<tr>
					<th>아이디</th>	
					<th>이름</th>
					<th>주소</th>
					<th>주문 양</th>
					<th>가격</th>
					<th>주문 날짜</th>
					<th>배송 상태</th>	
				</tr>
	 <%
				for(SaleorderDto sedto : userorder){
					
					if(sedto.getMyid() != null){
	%>		
					<tr>
						<td><%=sedto.getMyid() %></td>
						<td><%=sedto.getPname() %></td>
						<td><%=sedto.getAddr() %></td>
						<td><%=sedto.getAmount() %></td>
						<td><%=sedto.getPrice() %></td>
						<td><%=sedto.getOrder_date() %></td>
						<td>
						<%
							if(sedto.getOrder_state() == 1){
								%>
								상품 준비중
								<%
							}
							else if(sedto.getOrder_state() == 2){
								%>
								택배사 운송중
								<%
							}
							else if(sedto.getOrder_state() == 3){
							%>
								상품 배달중
								<%
							}
							else if(sedto.getOrder_state() == 4){
							%>
								상품수령완료
							<%
								
							}
							else{
							%>
								망망망
								<%
							}
						%>
						
						</td>

					</tr>
					
	<%
					}
					else{
	%>
					<tr><td>-----주문내역이 없습니다-----</td></tr>
	<%
					}
	%>
		
	<%
				}	
	%>	 	
	    	</table>
	    </div>
	</div>	

	
    <hr/>

    <!-- Footer -->
    <footer>
    	
    <br/>
    
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