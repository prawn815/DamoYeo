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

    <title>다이어트필요한사람모두여기로!</title>
    
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script type="text/javascript" src="js/jquery-3.3.1.js"></script>

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
				Menu <i class="fas fa-bars"></i>
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
						<span class="subheading">로그인</span>
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
					<input type="hidden" name="command" value="login">
					<div class="control-group">
						<div class="form-group floating-label-form-group controls">
                			<label>아이디</label>
                			<input type="text" class="form-control" placeholder="아이디" id="id" name="id" required data-validation-required-message="Please enter your name.">
                			<p class="help-block text-danger"></p>
              			</div>
           			</div>
            		<div class="control-group">
              			<div class="form-group floating-label-form-group controls">
                			<label>비밀번호</label>
                			<input type="password" class="form-control" placeholder="비밀번호" id="pw" name="pw" required data-validation-required-message="Please enter your name.">
                			<p class="help-block text-danger"></p>
              			</div>
            		</div>
            		
            		<br/>
            		<div align="center">
            			<a href="userinfor.jsp">회원가입</a>&nbsp;<span>/</span>&nbsp;
                		<a href="idpassfind.jsp">ID / PW 찾기</a>
            		</div>

					<div align="center">
					<a id="custom-login-btn" href="javascript:loginWithKakao()"><br/><img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/></a>
						<script type='text/javascript'>
							  //<![CDATA[
							    // 사용할 앱의 JavaScript 키를 설정해 주세요.
							    Kakao.init('7743c2bf6b6b8b6712a68fa25bf7500d');
							    function loginWithKakao() {
							      // 로그인 창을 띄웁니다.
							     Kakao.Auth.loginForm({
							        success: function(authObj) {
							          //alert(JSON.stringify(authObj));
							
							          Kakao.API.request({
							   
							         url: '/v2/user/me',
							         success: function(res) {
							   
							        	 $.ajax({
				            					type:"POST",
				            					url:"controller.do?command=kakaologin&kakaoid="+res.id+"&kakaoemail="+res.kakao_account.email,
				            					dataType:"text",
				            					//data:kakaoemail,
				            					success:function(data){
				            						location.href='user.jsp';
				            					},
				            					error:function(){
													alert("로그인실패");
												}
				            	
				            				})
							              
							             }
							           })
							
							        },
							        fail: function(err) {
							          alert(JSON.stringify(err));
							        }
							      });
							    };
						</script>
            		</div>
            		<br/>
            		<div id="success"></div>
            		<div class="form-group" align="center">
              			<button type="submit" class="btn btn-primary" id="sendMessageButton">로그인</button>
            		</div>
          		</form>
            </div>
        </div>	      
	</div>
	
 	<div id="result"></div>
 	
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