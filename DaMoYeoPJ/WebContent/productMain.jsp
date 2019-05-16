<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="com.login.dto.LoginDto"%>
<%@ page import="com.login.dao.LoginDao " %>

<%
	LoginDto dto_login = (LoginDto)session.getAttribute("dto");

	String myid = null;
	if(dto_login != null){
		myid = dto_login.getMyid();
	}
	else{
		response.sendRedirect("controller.do?command=whatlog");
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
	    }  
	    .table th {
	      color: #168;
	      background: #f0f6f9;
	      text-align: center;
	      font-size: 10px;
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
			border-right: none;
			border-left: none;
			border-top: none;
			border-bottom: none;
			margin-left: auto;
			margin-right: auto;
			
		}
		
		.doimg{
		 	vertical-align: middle;
		 	-webkit-transform : scale(1);
		 	transition: all 0.4s ease-in-out;
		}
		.doimg:hover {
		 	-webkit-transform : scale(1.2);
		}
	</style>
	
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
            </div>
          </div>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <div class="container" style="font-family: 맑은 고딕;">
      <div class="row">
        <div class="col-lg-8 col-md-10 mx-inherit">

   <h1>>Shop</h1>
   	

   <form action="controller.do" method="post" id="shop">
      <input type="hidden" name="command" value="muldel">
      <table class="table">
         <c:choose>
            <c:when test="${empty list }">
               <tr>
                  <td>--게시된 상품이 없습니다.--</td>
               </tr>
            </c:when>
            <c:otherwise>
            <tr>
               <c:forEach items="${list }" var="list">
               	<c:if test="${list.pid%4 == '0'}">
                	<tr></tr>
              	</c:if>
                <td>   
                     <table border="1" width="200px" height="300px" >
                           <tr><td ><a href="controller.do?command=detail&pid=${list.pid }"><img src="img/product/do${list.pid}.jpg" width="200px" height="200px" class="doimg"/></a></td></tr>
                           <tr><td>${list.pcompany }</td></tr>
                           <tr><td><a href="controller.do?command=detail&pid=${list.pid }">${list.pname }</a></td></tr>
                           <tr><td>${list.pprice }</td></tr>             
                     </table>
               	</td>
                   
               </c:forEach>
            </tr>
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
