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
	
	    <title>회원가입</title>
	    <script type="text/javascript" src="js/jquery-3.3.1.js"></script>
	    <script type="text/javascript">
	    
	    // 새로고침, 백스페이스 버튼 누를시 세션 삭제
	    window.onkeydown = function() {
	    	var kcode = event.keyCode;
	    	if(kcode == 116){
	    		location.href="controller.do?command=refresh";
	    	}
	    }
	    
	    //아이디 중복체크 팝업
	    function idchk() {
	    	window.open("idchk.jsp", "아이디 중복체크", "width=500,height=300");
	
		}
	    
	    //이메일 인증 팝업
	    function mailform() {		
	    	if(document.getElementById("mail").value==""){
	    		alert("이메일 주소를 적어주세요");
	    	}else{
	    	  	window.name = "mailparent";
	    		window.open("mailform.jsp", "이메일 인증", "width=500,height=300");
	    	}
	  
		}
	    
	    //메일 주소
	    function mailchk(){
	 		
	    	var mail = document.getElementById("mail").value;
	    	var mailoption = document.getElementById("mailoption").value;
	    	var mailplus = document.getElementById("@").innerHTML;
	    	
	    	if(document.getElementById('mail').value!='' && document.getElementById('mail').value!=null){
	    		if(document.getElementById("mailoption").value!='notSelected' && document.getElementById("mailoption").value!='self'){
	    			
	      			document.getElementById('mail').value = mail + mailplus + mailoption;
	        	
	    		}
	    	}
	    } 
	    
	    //바말번호 일치 확인
	    function pwchk(){
			
			var pw = document.getElementsByName('userpw').value;
	    	var pwcon = document.getElementsByName('user_pw').value;
			if(document.getElementById('pw').value.length >= 6 && document.getElementById('pwcon').value.length <= 12){
				//document.getElementById('pw').value=document.getElementById('pwcon').value='';
				document.getElementById('same01').innerHTML='사용가능한 비밀번호 입니다.';
				document.getElementById("same01").style.color="blue";
	    		
	    	} 
			else {
	    		document.getElementById('same01').innerHTML='비밀번호는 6글자 이상 12글자 이하로 설정해주세요';
	    		document.getElementById("same01").style.color="red";
	    	}
	    	
	    	if(document.getElementById('pw')!='' && document.getElementById('pwcon').value!=''){
	    		if(document.getElementById('pw').value==document.getElementById('pwcon').value){
	    			document.getElementById('same02').innerHTML='비밀번호가 일치 합니다.';
	    			document.getElementById('same02').style.color='blue';
	    		}
	    		else{
	    			document.getElementById('same02').innerHTML='비밀번호가 일치하지않습니다.';
	    			document.getElementById('same02').style.color='red';
	    		}
	    	}
	    }
	    
	 // 공백 체크 및 기능 체크
	    function nullchk() {
			
			if(document.getElementById("id").value == ""){
				alert("아이디를 입력해주세요");
				return false;
			}
			
			if(document.getElementById("id").value == null){
				alert("아이디를 입력해주세요");
				return false;
			}
			
			if(document.getElementById("pw").value == ""){
				alert("비밀번호를 입력해주세요");
				return false;
			}
			

			
			if(document.getElementById("pw").value != document.getElementById("pwcon").value){
				alert("비밀번호 확인을해주세요");
				return false;
			}
			
			if(document.getElementById("name").value == ""){
				alert("이름을 입력해주세요");
				return false;
			}
			
			if(document.getElementById("birthday").value == ""){
				alert("생년월일을 입력해주세요");
				return false;
			}
			
			if(document.getElementById("birthday").value.length > 6){
				alert("올바르지 않은 형식의 생년월일입니다.");
				return false;
			}
			
			
			if(document.getElementById("address").value == ""){
				alert("주소를 입력해주세요");
				return false;
			}
			
			if(document.getElementById("phone").value == ""){
				alert("전화번호를 입력해주세요");
				return false;
			}
			
			if(document.getElementById("phone").value.length > 11){
				alert("올바르지 않은 전화번호입니다.");
				return false;
			}
			
			if(document.getElementById("mail").value == ""){
				alert("메일을 입력해주세요");
				return false;
			}
			
			if(document.getElementById("mailcode").value=="" || document.getElementById("mailcode").value== "null"){
				alert("메일인증을 해주세요");
				return false;
			}

	    	return true;
		}
	 
		 function numkeyCheck(event) { var keyValue = event.keyCode; if( ((keyValue >= 48) && (keyValue <= 57)) ) return true; else return false; }

	    
	    
	    </script>
	    
	    <%
    	String idchk = (String)session.getAttribute("idchk");
    	
    %>
	    
	    
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
						<a class="nav-link" href="controller.do?command=login">로그인</a>
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
						<span class="subheading">회원가입</span>
					</div>
				</div>
			</div>
		</div>
	</header>
	
	<div align="center">
		<h3 align="center">정보를 모두 입력해주세요!</h3>
	</div>

	<!-- Main Content -->
	<div id="regist">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-md-10 mx-auto">
					<form action="controller.do" method="post" id="contactForm" novalidate onsubmit="return nullchk();" >
						<input type="hidden" name="command" value="userinfor">
						<div class="control-group">
							<div class="form-group floating-label-form-group controls">
								<label>아이디</label>
                				<input type="text" class="form-control" value="<%=((String)session.getAttribute("idchk")==null)?"아이디":(String)session.getAttribute("idchk") %>" placeholder="아이디" id="id" name="userid" style="background-color:white" required="required" autofocus="autofocus" onclick="idchk();" readonly="readonly" required data-validation-required-message="Please enter your id.">
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div class="form-group floating-label-form-group controls">
								<label>비밀번호</label>
								<input type="password" class="form-control" placeholder="비밀번호" id="pw" name="userpw" onchange="pwchk();" required="required" required data-validation-required-message="Please enter your password.">
                				<br/>
                				<span id="same01"></span>
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div class="form-group floating-label-form-group controls">
								<label>비밀번호 확인</label>
								<input type="password" class="form-control" placeholder="비밀번호 확인" id="pwcon" name="user_pw" onchange="pwchk();" required="required" required data-validation-required-message="Please enter your password.">
								<br/>
								<span id="same02"></span>
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div class="form-group floating-label-form-group controls">
								<label>이름</label>
								<input type="text" class="form-control" placeholder="이름" id="name" name="username"  required="required" required data-validation-required-message="Please enter your name.">
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div class="form-group floating-label-form-group controls">
								<label>성별</label>
								<input type="text" readonly="readonly" class="form-control" placeholder="성별" id="gender" style="background-color:white" required="required" required data-validation-required-message="Please enter your gender.">
								<select id="gender" name="usergender" >
									<option value="M">남</option>
									<option value="W">여</option>
								</select>
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div class="form-group floating-label-form-group controls">
								<label>생년월일</label>
								<input type="number" class="form-control" placeholder="생년월일" id="birthday" name="userbirthday" required="required" required data-validation-required-message="Please enter your birthday.">
								<span>Ex) 123456</span>
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div class="form-group floating-label-form-group controls">
								<label>주소</label>
								<input type="text" class="form-control" placeholder="주소" id="address" name="useraddr" required="required" required data-validation-required-message="Please enter your address.">
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div class="form-group floating-label-form-group controls">
								<label>전화번호</label>
								<input type="text" class="form-control" placeholder="전화번호" id="phone" name="userphone" required="required" onKeyPress="return numkeyCheck(event)" required data-validation-required-message="Please enter your phonenumber.">
								<span>Ex) '-'를 제외하여 입력해주세요</span>
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div class="form-group floating-label-form-group controls">
								<label>이메일</label>
								<input type="email" class="form-control" placeholder="이메일" id="mail" name="useremail" style="background-color:white" required="required" required data-validation-required-message="Please enter your email.">
								<input type="hidden" class="form-control" placeholder="인증코드" id="mailcode" name="useremailcode" required="required" onclick="mailform();" readonly="readonly" style="background-color:white;" required data-validation-required-message="Please enter your email.">
								<span id="@">@</span>
								<select id="mailoption" name="usermailoption" onchange="mailchk();">
									<option value="notSelected" >::선택하세요::</option>
								    <option value="self">직접입력</option>
								    <option value="naver.com">naver.com</option>
								    <option value="nate.com">nate.com</option>
								    <option value="empal.com">empal.com</option>
								    <option value="hotmail.com">hotmail.com</option>
								    <option value="lycos.co.kr">lycos.co.kr</option>
								    <option value="msn.com">msn.com</option>
								    <option value="hanmail.net">hanmail.net</option>
								    <option value="yahoo.com">yahoo.com</option>
								    <option value="korea.com">korea.com</option>
								    <option value="kornet.net">kornet.net</option>
								    <option value="yahoo.co.kr">yahoo.co.kr</option>
								    <option value="kebi.com">kebi.com</option>
								    <option value="orgio.net">orgio.net</option>
								    <option value="paran.com">paran.com</option>    
								    <option value="gmail.com">gmail.com</option>
								</select>
								<input type="button"  class="btn btn-primary" id="sendMessageButton" value="인증하기" onclick="mailform();"/>
                				<p class="help-block text-danger"></p>
              				</div>
            			</div>
            			<br/>
            			<br/>
            			<div id="success"></div>
            			<div class="form-group" align="center">
              				<button type="submit" class="btn btn-primary" id="click">회원가입</button>
              				<button type="button" class="btn btn-primary" id="sendMessageButton" onclick="location.href='controller.do?command=logout'">돌아가기</button>
            			</div>
          			</form>
            	</div>
        	</div>   
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