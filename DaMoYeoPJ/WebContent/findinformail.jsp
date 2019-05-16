<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.Address"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="mail.SMTPAuthenticatior"%>
<%@ page import="javax.mail.Authenticator"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.util.Random" %>

<%@ page import="com.login.dto.LoginDto"%>
<%@ page import="com.login.dao.LoginDao " %>

<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html; charset=UTF-8");
	
	LoginDto dto = (LoginDto)session.getAttribute("dto");

	String myid = null;
	if(dto != null){
		myid = dto.getMyid();
	}
		
	String usermail = (String)request.getAttribute("idfindmail");
	String userid = (String)request.getAttribute("idfindid");
	String userpassword =(String)request.getAttribute("idfindpw");
		
		
	String from = "chldjs@naver.com";
	String to = usermail;
	String subject = "다모여 아이디 / 비밀번호 찾기 메일입니다.";
	String content = "회원님의 아이디 :  "+ userid + " / " +"회원님의 비밀번호 :  " + userpassword;
		
	out.print(content);
		
	// 입력값 받음
		
	Properties p = new Properties(); // 정보를 담을 객체
		 
	p.put("mail.smtp.host","smtp.naver.com"); // 네이버 SMTP
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	// SMTP 서버에 접속하기 위한 정보들
		 
	try{
		Authenticator auth = new SMTPAuthenticatior();
		Session ses = Session.getInstance(p, auth);
		     
		ses.setDebug(true);
		     
		MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
		msg.setSubject(subject); // 제목
		     
		Address fromAddr = new InternetAddress(from);
		msg.setFrom(fromAddr); // 보내는 사람
		     
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
		     
		msg.setContent(content, "text/html;charset=UTF-8"); // 내용과 인코딩
		     
		Transport.send(msg); // 전송
		    
	} catch(Exception e){
		e.printStackTrace();
		out.println("<script>alert('유효하지 않은 메일입니다.');history.back();</script>");
		// 오류 발생시 뒤로 돌아가도록
		return;
	}
		 
		
	out.println("<script>alert('회원님의 이메일로 아이디와 비밀번호가 전송되었습니다.');location.href='login.jsp';</script>");
		
	// 성공 시
%>
