<%@page import="javax.websocket.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%   session.getAttribute("username"); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>채팅방!!</title>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">

window.onload = function(){
	
	var username = document.getElementById("username").value;
	
	document.getElementById("messageText").value=username;
	
	document.getElementById("test").click();
}

</script>

</head>
<body>

	<div align="center">
    <!-- 메시지 표시 영역 -->
    <textarea id="messageTextArea" readonly="readonly" rows="32" cols="50"></textarea><br />
    <!-- 송신 메시지 텍스트박스 -->
    <input type="text" id="messageText" size="40" onkeyup="enterkey()"/>
    <!-- 송신 버튼 -->
    <input type="button" value="Send" onclick="sendMessage()" id="test" />
    <input type="hidden" value="<%=session.getAttribute("username") %>" id="username"/>
    <script type="text/javascript" src="js/chat.js"></script>
    
    
    </div>
    
   
</body>
</html>