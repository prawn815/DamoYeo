<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import="java.util.List" %> 
<%@ page import="com.login.dto.LoginDto"%>
<%@ page import="com.login.dao.LoginDao " %>
<%@ page import="com.post.dao.*" %>
<%@ page import="com.post.dto.*" %>

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
	LoginDto dto = (LoginDto)session.getAttribute("dto");

	String username = null;
	int boardcnt = 0;
	int anscnt = 0;
	if(dto != null){
		username = dto.getMyid();
		
		boardDao boarddao = new boardDaoImpl();
		boardcnt = boarddao.getWriterCnt(username);
		
		ansDao ansdao = new ansDaoImpl();
		anscnt = ansdao.getWriterAnsCnt(username);
	}
	else{
		pageContext.forward("login.jsp");
	}
%>

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>My 페이지</title>
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
		<h1 align="center">My 페이지</h1>
		
		<div style="font-family: 맑은 고딕;"><p align="center"><%=dto.getMyid() %>님 환영합니다!</p></div>
		
		<h3 align="center">My Information</h3>
	<div align="center" style="font-family: 맑은 고딕;">	
		<table border="2" align="center" class="table">
		<col width="100">
		<col width="100">
		<col width="100">
		<col width="100">
		<col width="100">
		<col width="100">
		<col width="100">
		<col width="100">
		
		<tr>
			<th>아이디</th>
			<td><%=dto.getMyid() %></td>
		</tr>
		<tr>				
			<th>이름</th>
			<td><%=dto.getMyname() %></td>
		</tr>		
		<tr>
			<th>성별</th>
			<td><%=dto.getMygender() %></td>
		</tr>	
		<tr>	
			<th>생년월일</th>
			<td><%=dto.getMybirthday() %></td>
		</tr>		
		<tr>	
			<th>주소</th>
			<td><%=dto.getMyaddr() %></td>
		</tr>	
		<tr>	
			<th>전화번호</th>
			<td><%=dto.getMyphone() %></td>
		</tr>	
		<tr>	
			<th>이메일</th>
			<td><%=dto.getMyemail() %></td>
		</tr>
		<tr>
			<th>작성한 글</th>
			<td><a href="controller.do?command=searchResult&sort=2&searchtext=<%=username %>&page=1"><%=boardcnt %></a></td>
		</tr>
		<tr>
			<th>내가 댓글을 단 글</th>
			<td><a href="controller.do?command=searchResult&sort=3&searchtext=<%=username %>&page=1"><%=anscnt %></a></td>
		</tr>
		<tr>
			<td align="center" colspan="2">
				<input type="button" value="정보 수정" class="button" onclick="location.href='controller.do?command=userinforupdate'"/>
			</td>
		</tr>		
		</table>
	</div>
	
	<div align="center" style="font-family: 맑은 고딕;">
		<input type="button" class="button" value="장바구니" onclick="location.href='controller.do?command=basket_res'">
		<input type="button" class="button" value="주문/배송조회" onclick="location.href='controller.do?command=payLook&my_id=<%=dto.getMyid()%>'">
	</div>
	</div>
    <hr>

    <!-- Footer -->
    <footer>
    	
    <br>
    
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
