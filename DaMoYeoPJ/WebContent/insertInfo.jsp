<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style type="text/css">
			.button, .submit {
		
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
		
		.button:hover, .submit:hover{
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
		
	
		tr.space {
 			 border-bottom: 10px solid #fff;
 			 height: 20px;
		}
	</style>
	<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		var myid = $("#myid", opener.document).val();
		$("#myid").val(myid);
	})
		
		function nullcheck() {
			if(document.getElementById("birthday").value == ""){
				alert("생년월일을 입력해주세요");
				return false;
			}
			
			if(document.getElementById("birthday").value.length > 6){
				alert("올바르지 않은 형식의 생년월일입니다.");
				return false;
			}
		}
	</script>
</head>
<body>

	<form action="controller.do" method="post" novalidate onsubmit="return nullcheck();" style="text-align: center;">
		<input type="hidden" name="command" value="updateGenBirth">
		<input type="hidden" id="myid" name="myid">
		<table style="width: 100%; height: 100%">
			<tr class="space"></tr>
			<tr>
				<td>
					<a style="font-size: 10px;">기초대사량 산출을 위해 성별, 생년월일이 필요합니다.</a>
				</td>
			</tr>
			<tr class="space"></tr>
			<tr>
				<td>
					<a>성별  </a>
					<select id="gender" name="gender">
						<option value="M">남</option>
						<option value="W">여</option>
					</select>
				</td>
			</tr>
			<tr class="space"></tr>
			<tr>
				<td>
					<a>생년월일</a>
					<input type="number" placeholder="생년월일" id="birthday" name="birthday">
				</td>
			</tr>
			<tr>
			<td><a style="font-size: 10px; color: gray;">ex) 900101 (6자리)</a></td>
			</tr>
			<tr class="space"></tr>
			<tr>
				<td>
					<input type="submit" value="입력">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>