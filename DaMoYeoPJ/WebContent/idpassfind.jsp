<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %> 
   
<!DOCTYPE html>
<html>

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>아이디 찾기</title>
    
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>

    <!-- Custom styles for this template -->
    <link href="css/clean-blog.min.css" rel="stylesheet">

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
              			<a class="nav-link" href="controller.do?command=loginpage">로그인</a>
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
      <div class="row">
        <div class="col-lg-8 col-md-10 mx-auto">
         <form action="controller.do" method="post" id="contactForm" novalidate>
         <input type="hidden" name="command" value="idfind">
         <div class="control-group">
              <div class="form-group floating-label-form-group controls">
                <label>이름</label>
                <input type="text" class="form-control" placeholder="이름" id="idnamefind" name="idnamefind" required data-validation-required-message="Please enter your name.">
                <p class="help-block text-danger"></p>
              </div>
            </div>
        	<div class="control-group">
              <div class="form-group floating-label-form-group controls">
                <label>전화번호</label>
                <input type="text" class="form-control" placeholder="전화번호" id="idphonefind" name="idphonefind" required data-validation-required-message="Please enter your name.">
                <p class="help-block text-danger"></p>
                <span>Ex) ' - '를 제외하고 입력하여 주세요</span>
              </div>
            </div>
            <div class="control-group">
              <div class="form-group floating-label-form-group controls">
                <label>생년월일</label>
                <input type="text" class="form-control" placeholder="생년월일" id="idbirthdayfind" name="idbirthdayfind" required data-validation-required-message="Please enter your name.">
                <p class="help-block text-danger"></p>
                <span>Ex) 901212</span>
              </div>
            </div>
            <br>
            <div id="success"></div>
            <div class="form-group" align="center">
              <button type="submit" class="btn btn-primary" id="sendMessageButton">아이디 / 비밀번호 찾기</button>
            </div>
             
          </form>
          	
				  
            
            </div>
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