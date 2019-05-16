<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%@ page import="com.product.dto.ReviewDto"%>

<%@ page import="com.login.dto.LoginDto"%>
<%@ page import="com.login.dao.LoginDao " %>

<%
   LoginDto dto_login = (LoginDto)session.getAttribute("dto");

   String myid = null;
   if(dto_login != null){
      myid = dto_login.getMyid();
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
   
   table{width: 100%; margin: auto;}
   tr input{text-align: right;}
   #detail{width: 800px;}
   .detail_tab {width:800px; background-color: #b4d8b7;border-top: 2px solid #444444; margin-top: 10px;margin-bottom: 10px;}
   .detail_tab_inner th {text-align: center;}
    
   .detailReview{
      border: 1px solid black;
      background: white;
      position : relative;
      margin-left : -20%;
      top: 50%;
      left: 50%;
      display: none;
      width: 850px;
   }
   #review{width:800px;}
   #paging{text-align: center;margin-top: 15px;}
   
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
<%
      String move = (String)request.getAttribute("move");
      ArrayList<ReviewDto> reviewSelect = (ArrayList<ReviewDto>)request.getAttribute("reviewSelect");      
      int pageNum = (Integer)request.getAttribute("pageNum");
%>
<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
   var sell_price = ${prodto.pprice};
   var amount;   
   function init(){
      sell_price = document.form.sell_price.value;
      document.form.sum.value = sum;
      amount = document.form.amount.value;
      document.form.sum.value = sell_price;
      change()            
   }
   function add(){
      hm = document.form.amount;
      sum = document.form.sum;
      hm.value ++;
      
      sum.value = parseInt(hm.value) * sell_price;
   }   
   function change(){
      hm = document.form.amount;
      sum =document.form.sum;
      
      if(hm.value<0){
         ham.value = 0;
      }
      sum.value = parseInt(hm.value) * sell_price
   }   
   function del(){
      hm = document.form.amount;
      sum = document.form.sum;
      
      if(hm.value>1){
         hm.value --;
      }
      sum.value = parseInt(hm.value) * sell_price;   
   }   
   function getParameterValues(){//SESSION에서 아이디를 받아와 JSON으로 형식으로 보내줌
      var my_id ="my_id=<%=dto_login.getMyid()%>";
      var pname = "pname="+encodeURIComponent($("[name=pname]").val());
      var pid = "pid="+$("[name=pid]").val();
      var price = "price="+$("[name=sum]").val();
      var amount = "amount="+$("[name=amount]").val();
      
      return my_id+"&"+pname+"&"+pid+"&"+price+"&"+amount;   
   }
   $(function(){
      $("#basket").click(function(){// productDetail.jsp에서 장바구니 버튼을 눌렀을 때
         $.ajax({
            url:"controller.do?command=basket&"+getParameterValues(),//요청할 URL
            dataType:"json",
            success:function(msg){// 성공 할 경우 할 행위
               location.href="controller.do?command=basket_res";            
            },
            error:function(){
               alert("실패");
            }         
         })
      })
   })   

   // 상품 후기 이미지 팝업창 기능
   function imgResize(img) {
      img1 = new Image();
      img1.src = (img);
      imgControll(img);
   }
   function imgControll(img) {
      if ((img1.width != 0) && (img1.height != 0)) {
         viewImage(img);
      } else {
         controller = "imgControll('" + img + "')";
         intervalID = setTimeout(controller, 20);
      }
   }
   function viewImage(img) {
      W = img1.width;
      H = img1.height;
      O = "width=" + W + ",height=" + H;
      imgWin = window.open("", "", O);
      imgWin.document.write("<html><head><title>이미지 미리보기</title></head>");
      imgWin.document.write("<body topmargin=0 leftmargin=0>");
      imgWin.document.write("<img src=" + img
            + " onclick='self.close()' style=cursor:hand>");
      imgWin.document.close();
   }// 상품 후기 이미지 팝업창 기능

   function MM_openBrWindow(theURL, winName, features) { //v2.0 
      window.open(theURL, winName, features);
   }

   function move(seq) { // 상세탭 스크롤 이동 기능
      var offset = $("#detail_tab" + seq).offset();
      $('html, body').animate({
         scrollTop : offset.top
      }, 400);
   }
   // 리뷰 상세보기
   function reviewDetail(tmp){
      
      document.getElementsByClassName("detailReview")[tmp].style.display = "block";
      document.body.style.backgroud = "white";

       $('html, body').animate({
         scrollTop : $("#detail_tab3").offset().top
      }, 400); 
       
 
   }
   
   function closeReview(tmp){
      document.getElementsByClassName("detailReview")[tmp].style.display="none";
   }
   <%=move%>            //리뷰 페이징
   function go(page_no) {  //리뷰 페이징         
         document.paging.action = "${pageContext.request.contextPath }/controller.do?command=detail&pid="+${prodto.pid}+"&nowPageNo="+page_no;
         document.paging.submit();
          
         $('html, body').animate({
            scrollTop : $("#detail_tab3").offset().top
         }, 400); 
      }
   
   function payOne(){
      var pid = $("[name=pid]").val();
      var price = $("[name=sum]").val();
      var amount = $("[name=amount]").val();
      
      window.location.href='controller.do?command=payone&pid='+pid+'&price='+price+'&amount='+amount;
   }
   
</script>
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
                        <li class="nav-item"><a class="nav-link" href="controller.do?command=adminpage">관리페이지</a></li>
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
        <div class="col-lg-8 col-md-10 mx-auto">
          
   <a href="controller.do?command=main"><b>SHOP > </b></a><a href="#"><b>Detail</b></a>
   <div id="detail">
   <table border="1" class="table">
      <tr>
         <td>
            <img src="img/product/do${prodto.pid}.jpg" width="400px" height="400px">
            <input type="hidden" name="pid" value="${prodto.pid}">
         </td>
         <td>   
         <form name="form" method="post">
            <table width="400px" height="400px" class="table">   
               <tr>
                  <td>상품명</td>
                  <td><input type="hidden" name="pname" value="${prodto.pname}">${prodto.pname}</td>
               </tr>
               <tr>
                  <td>가격</td>
                  <td>${prodto.pprice }</td>
               </tr>
               <tr> 
                  <td>제품소개</td>
                  <td>${prodto.description }</td>
               </tr>
               <tr>
                  <td>회사</td>
                  <td>${prodto.pcompany }</td>
               </tr>
               <tr>
                  <td>
                        수량 : <br>
                        금액 : 
                  </td>
                  <td>
                     <input type="hidden" name="sell_price" class="button" value="${prodto.pprice}">
                     <input type="text" name="amount" value="1" size="3" class="button" onchange="chahge();"><br>
                     <input type="button" class="button" value="+" onclick="add();"><input type="button" class="button" value="-" onclick="del()"><br>
                     <input type="text" name="sum" value="${prodto.pprice }" size="11" readonly>원
                  </td>
               </tr>
               <tr>
                  <td colspan="2" style="text-align:center;">
                     <input type="button" class="button" value="장바구니" id="basket"/>
                     <input type="button" class="button" value="바로구매" onclick="payOne();"/>
                  </td>
               </tr>
            </table>
            </form>   
         </td>
      </tr>
   </table>
   </div>

   <!-- 제품정보 tab -->
   <div id="detail_tab1" class="detail_tab">
      <div class="detail_tab_inner">
         <table class="table">
            <tr>
               <th style="background-color:white;"><a style="cursor: pointer;" onclick="move('1')">상세설명</a></th>
               <th><a style="cursor: pointer;" onclick="move('2')">구매정보</a></th>
               <th><a style="cursor: pointer;" onclick="move('3')">상품후기<span class="review_num"><!-- 상품후기 갯수 --></span></a></th>
            </tr>
         </table>
      </div>
   </div>
   <!-- 제품 상세설명 -->
   <div class="detail">
      <div class="pdt_txt">
         <p><img src="img/product/2019.jpg">&nbsp;&nbsp;</p>
         <p><img src="img/product/detail/${prodto.pid}-1.jpg">&nbsp;</p>
      </div>                  
   </div>
   
   
   <!-- 제품정보 tab -->
   <div id="detail_tab2" class="detail_tab">
      <div class="detail_tab_inner">
         <table class="table">
            <tr>
               <th><a style="cursor: pointer;" onclick="move('1')">상세설명</a></th>
               <th style="background-color:white;"><a style="cursor: pointer;" onclick="move('2')">구매정보</a></th>
               <th><a style="cursor: pointer;" onclick="move('3')">상품후기<span class="review_num"><!-- 상품후기 갯수 --></span></a></th>
            </tr>
         </table>
      </div>
   </div>
   <!-- 제품 배송안내-->
   <div class="detail" >
      <p class="pdt_policy_tit_n">
         구매전 <em>배송정책</em>을 꼭 확인해주세요!
      </p>

      <div class="list_wrap_n">
         <!--주문/배송정보-->
         <p class="pdt_p_tit_n">
            <img src="./img/icon/delivery.png" height="25" width="25">주문/배송 안내
         </p>
         <div class="pdt_p_box_n">
            <div class="pdt_p_txt_n">
               <p class="answer">
                  - 배송방법 : 산지 직접 배송<br>- 택배사 : CJ 대한통운<br>- 배송비용 : 3,000원
                  (3만원 이상 배송시 무료배송)<br>- 배송지역 : 전국 (제주도 및 도서산간지역 추가운임발생)<br>-
                  출고시간 : 평일 오후 1시 이전 결제시 당일 출고<br>
                  <font color="red"><b>* 토요일 배송을 원치 않으실 경우, 배송지시사항에 꼭
                        기재해주세요.</b></font><br>
               </p>
               <p>&nbsp;</p>
               <p></p>
            </div>
         </div>
         <!--//주문/배송정보-->

         <!--교환/반품 정보-->
         <p class="pdt_p_tit_n">
            <img src="./img/icon/coins.png" height="25" width="25">교환/반품 안내
         </p>
         <div class="pdt_p_box_n">
            <div class="pdt_p_txt_n">
               <p class="answer">
                  - 냉동식품으로 단순변심 반품 불가<br>- 수령자 부재, 잘못된 주소, 전화번호 결번으로 반송이 되는 경우
                  교환, 반품 불가<br>
                  <font color="red"><strong
                     style="font-family: NanumGothic, '나눔고딕', ng, 'Malgun Gothic', '맑은 고딕', '돋움', Dotum, 'Apple SD Gothic Neo', sans-serif">※
                        배송지가 회사 주소인 경우, 토요일 수령 가능 여부를 꼭! 확인후 주문해주세요.<br>&nbsp;
                        &nbsp; 수령 불가로 인해 제품 반송시 환불 및 재발송 불가합니다.
                  </strong></font><br>- 제품에 문제가 있는 경우, 상품 수령 후 7일 이내 1:1 문의게시판 및 고객센터를 통해
                  접수해주세요.<br>- 증빙 사진을 꼭 첨부해주셔야 접수 가능합니다. (택배박스, 송장, 제품사진 포함 3장
                  이상)<br>
               </p>
               <p>&nbsp;</p>
               <p></p>
            </div>
         </div>
         <!--//교환/반품 정보-->

         <!--환불정보-->
         <p class="pdt_p_tit_n">
            <img src="./img/icon/card.png" height="25" width="25">환불 안내
         </p>
         <div class="pdt_p_box_n">
            <div class="pdt_p_txt_n">
               <p class="answer">
                  - 교환/반품은 배송완료후 7일 이내에만 요청이 가능합니다.<br>- 결제하신 금액의 환불은 반품할 상품이
                  입고된 후에 7영업일 이내에 처리됩니다. <br>- 쿠폰이나 적립금을 사용하여 결제하신 경우에는, 주문취소
                  또는 반품 요청시 할인받으신 금액을 제외하고 환불처리됩니다.<br>- 무통장입금(가상계좌)으로 결제하셨거나,
                  계좌로 환불처리되는 경우에는 주문자 본인의 계좌로만 환불처리됩니다.<br>- 신용카드, 휴대폰,
                  실시간계좌이체를 통해 결제하신 경우는 승인을 취소하여 결제 대금이 청구되지 않게 합니다.<br>(단,
                  신용카드나 휴대폰 결제일자에 따라 대금이 청구될 수 있으며, 이 경우 익월 신용카드 대금 청구시 카드사에서 환급처리
                  됩니다.)
               </p>
            </div>
         </div>
         <!--//환불정보-->
      </div>
   </div>

   <!-- 제품정보 tab -->
   <div id="detail_tab3" class="detail_tab">
      <div class="detail_tab_inner">
         <table class="table">
            <tr>
               <th><a style="cursor: pointer;" onclick="move('1')">상세설명</a></th>
               <th><a style="cursor: pointer;" onclick="move('2')">구매정보</a></th>
               <th style="background-color:white;"><a style="cursor: pointer;" onclick="move('3')">상품후기<span class="review_num"><!-- 상품후기 갯수 --></span></a></th>
            </tr>
         </table>
      </div>
   </div>
   <!-- 제품 후기 게시판 -->
   <div class="detail">
      <table border="1" id="review" class="table">
      <col width="200">
      <col width="200">
      <col width="500">
      

         <tr>
         <th>
            <c:forEach var="s" begin="0" end="4" step="1">
                     <img src="img/icon/star.png" height="20" width="20"/>
               </c:forEach>
            </th>
            <th>작성자</th>
            <th align="center">Review</th>
         </tr>
      <%
         int tmp = 0;
         for(ReviewDto redto : reviewSelect){ 
      %>
         <tr id="<%=redto.getR_no()%>">
         <td>
            <c:set var="star" value="<%=redto.getR_star() %>" />
                  <c:forEach var="i" begin="1" end="${star }" step="1"> <img src="img/icon/star.png" height="20" width="20"> </c:forEach>
                  <c:forEach var="j" begin="1" end="${5-star }" step="1"> <img src="img/icon/starx.png" height="20" width="20"> </c:forEach> 
         </td>
            <td><%=redto.getR_writer() %></td>
            <td><a href="#" onclick="reviewDetail(<%=tmp%>);"><%=redto.getR_title() %></a></td>
         </tr>
      <%
         tmp ++;
         } 
      %>         
      </table>
   </div>         
   <div id="paging">
   <form action="" id="paging" name="paging" method="post">
      <%
      for(int i=1; i <= pageNum; i++){
      %>
      <input type="button" class="button" value="<%=i%>" id="page_no" onclick="go(<%=i%>);">
      <% 
      }
      %>
   </form>
   </div>
        </div>
      </div>
    </div>

   
       <%   
          int ttmp = 0;
         for(ReviewDto redto : reviewSelect){
//          System.out.println(dto+"=dto");
      %>
        <div class="detailReview">
       <!-- <form action="" method> -->
       <table class="table">
            <caption>Review</caption>
               <tr>
                  <td>작성자</td>
                  <td align="center"><%=redto.getR_writer() %></td>
               </tr>
               <tr>
                  <td>별점</td>
                  <td>
                      <c:set var="star" value="<%=redto.getR_star()%>" /> 
                        <c:forEach var="i" begin="1" end="${star }" step="1"> <img src="img/icon/star.png" height="20" width="20"/> </c:forEach> 
                        <c:forEach var="j" begin="1" end="${5-star }" step="1"> <img alt="" src="img/icon/starx.png" height="20" width="20"/> </c:forEach>
                  </td>
               </tr>
               <tr>
                  <td>제목</td>
                  <td><%=redto.getR_title()%></td>
               </tr>
               <tr>
                  <td>내용</td>
                  <td><textarea rows="10" cols="50" name="content" readonly="readonly"><%=redto.getR_content() %></textarea></td>
               </tr>
               <tr>
                  <td>작성일</td>
                  <td><%=redto.getR_date() %></td>
               </tr>
               <tr>
                  <td colspan="2">
                     <input type="button" class="button" value="닫기" onclick="closeReview(<%=ttmp%>)"/>
                  </td>
               </tr>
               </table> 
                  <!--     </form> -->
    </div>
      <%
         ttmp++;
         } 
      %>   
 


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