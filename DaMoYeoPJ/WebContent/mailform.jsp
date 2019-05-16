<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>    

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>이메일 인증</title>
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
</head>

<script type="text/javascript">

	
	window.onload = function(){
		document.getElementById("usermail").value = window.opener.document.getElementById("mail").value;
			
	}
	
	function mailchk() {
		
	 	var mailcode = '<%=(String)session.getAttribute("mailcode")%>'; 
		var inputcode = document.getElementById("mailchk").value;
		if(mailcode==inputcode){
			alert("인증 완료");
			window.opener.document.getElementById("mailcode").value = mailcode;
			self.close();
		}else{
			alert("인증코드가 올바르지 않습니다")
		}
	
	}

</script>

<body>
    <div>
        <form action="sendmail.jsp" method="post">
            <table class="table">
                <tr><th colspan="2">이메일로 본인 인증하기</th></tr>
                <tr><td>이메일을 입력하세요</td><td><input type="text" id="usermail" name="to" placeholder="메일을 입력해주세요"/></td></tr>
                <tr><td colspan="2" style="text-align:right;"><input type="submit" class="button" value="메일 전송"/></td></tr>
            </table>
        </form>
    </div>
    <div>
    	<table class="table">
    		<tr><td>확인코드를 입력하세요</td><td><input type="text" id="mailchk" name="mailcode" /></td></tr>
    		<tr><td colspan="2" style="text-align:right;"><input type="button" class="button" value="인증하기" onclick="mailchk();"/> </td></tr>
    	</table>
    </div>
</body>
</html>

