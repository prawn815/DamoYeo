<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>   

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아이디 중복확인</title>
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
	      font-size: 20px;
	    }  
	    .table th {
	      color: #168;
	      background: #f0f6f9;
	      text-align: center;
	      font-size: 20px;
	</style>
	<script type="text/javascript">
	
		function idcheck() {
		
			if(document.getElementById('idcon').value == ""){
				alert("아이디를 입력해주세요!");
				return false;
			}
			return true;
		}
	</script>
</head>
<body>
	<div align="center" style="font-family: 맑은 고딕;"><h1>아이디 중복확인</h1></div>
	<div align="center" style="font-family: 맑은 고딕;">
	<form action="controller.do" name="idwriter" method="post" onsubmit="return idcheck()">
		<table class="table">
			<tr>
				<td>
					<input type="hidden" name="command" value="idchk"/>
					<input type="text" name="idchk" placeholder="아이디를 입력해주세요" id="idcon"/>
					<input type="submit" class="button" value="중복체크"/>
				</td>
			</tr>
		</table>	
	</form>
	</div>
</body>
</html>