<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="com.product.dao.BasketDao" %>
<%@page import="com.product.dto.BasketDto" %>
<%@page import="java.util.List" %>

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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
<title>다이어트필요한사람모두여기로!</title>
    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>

    <!-- Custom styles for this template -->
    <link href="css/clean-blog.min.css" rel="stylesheet">
   <style type="text/css">
   
   div {text-align: left; width: 70%; margin: auto;}
   table{width: 100%;}
   
   .order_option_cnt{float:right;}
   order_option_input b, em .b{clear:left; text-align: right;}
   /* + = 위치 */
   .order_calculate_area {position: relative;overflow:hidden;border-bottom: 1px solid #eee; border-top: 2px solid #333;width: 70%;}
   .order_calculate_area {clear: both; display: block;}
   .order_deal_price .order_h_area, .order_h_area, .order_deal_delivery .order_h_area, .order_deal_payment .order_h_area
   {
   background-color: #f6f6f6;border-bottom: 1px solid #dddddd;font-size:14px;text-align:center; 
   padding: 13px 0 10px 0px;font-weight:800; letter-spacing: -1px;
   margin: 0; width: 100%; margin-right: 0;
   } 
   .order_h_area_s{
   background-color: #f6f6f6;border-bottom: 1px solid #dddddd;font-size:14px;text-align:center; 
   padding: 13px 0 10px 0px;font-weight:800; letter-spacing: -1px;
   margin: 0; width: 100%; margin-right: 0;
   }
   .order_deal_price {float:left;overflow:hidden;width: 270px;border-right: 1px solid #dddddd; }
   .order_deal_delivery {float:left;overflow:hidden;width: 220px;border-right: 1px solid #dddddd; }
   
   .order_deal_payment .order_result_area_s em span{color: #fe4f4f;}
   .order_result_area_s { padding: 20px 3px 20px 0px; text-align: right;font-family: tahoma; width:110%; }
   .order_result_area { padding: 20px 3px 20px 0px; text-align: right;font-family: tahoma}
   .order_result_area em, .order_result_area_s em{color: #333; display: inline-block;font-size: 24px; font-weight: bold; line-height: 23px; vertical-align: middle;}
   .order_result_area .won,.order_result_area_s .won { color: #555; display: inline-block; font-size: 14px; font-weight: bold; margin-left: 1px;  position: relative;   top: 3px;}
   .order_result_area .view,.order_result_area_s .view { color: #000; display: inline-block; font-size: 14px; font-weight: bold; margin-left: 4px;  position: relative; top: 3px; text-decoration:underline }
   .order_result_area em span,.order_result_area_s em span {color: #7e8bd5;}

   .order_plus, .order_equal {display: inline-block;text-align:center; width:24px;height:24px;line-height:21px;overflow: hidden;color:#fff;font-size:20px;font-weight: bold;font-family: tahoma; }
   .order_plus {background:#565656; position:absolute;left:258px;top:62px;}
   .order_equal {background:#fe4f4f;position:absolute;left:478px;top:62px;}
   .divAll{
      margin-left: 300px;
      margin-right: 300px;
   
   }
   /*checkbox*/
   .selected{font-style: italic;}
   
    .button {
      
          width:125px;
      
          background-color: #FAECC5;
      
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
         text-align: left;
       }
       .table th:first-child, .table td:first-child {
         border-left: 0;
       }
       .table th:last-child, .table td:last-child {
         border-right: 0;
       }
       .table tr td:first-child{
         text-align: left;
       }
       .table caption{caption-side: bottom; display: none;}
   
</style>
   <%
      List<BasketDto> list = (List<BasketDto>)request.getAttribute("list");
      int sum = (Integer)request.getAttribute("sum");
      
   %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">

   $(document).ready(function() {
      $("#pay").on("click", function() {//input:checkbox 
         if ($(this).prop("checked")) {
            $("#agree").addClass("selected");
         } else {
            $("#agree").removeClass("selected");
         }
      });

      $("#namecheck").change(function() {
         if ($("#namecheck").is(":checked")) { // 체크시 구매자 배송지 동일
            $("#name1").val($("#sdname").val());
            $("#tel11").val($("#sdtel1").val());
            $("#tel12").val($("#sdtel2").val());
            $("#tel13").val($("#sdtel3").val());
         } else {
            $("#name1").val("");
            $("#tel11").val("");
            $("#tel12").val("");
            $("#tel13").val("");
         }
      });
   });

    function btnClick() {
       
      if($("[name='sdname']").val() == "" || $("[name='stel2']").val() == "" || $("[name='stel3']").val() == "" ||
             $("[name='name1']").val() == "" || $("[name='tel12']").val() == "" || $("[name='tel13']").val() == ""){
            alert("빈 칸을 모두 입력해주세요.");
            return ;
         } 
             
       if($("[name='postaddr2']").val() == ""){
             alert("주소를 모두 입력해주세요.");
             return;
             }
       var agree = $("#pay").prop("checked");
        if(agree == false){
           alert("동의를 해주세요");
           return;
        }
       var IMP = window.IMP;
      var sum = $("#tprc").text();
      var my_id = $("[name='my_id']").val();
      var addr = $("[name='postnum']").val()+"/"+$("[name='postaddr1']").val()+"/"+
            $("[name='postaddr2']").val();
      var basseq = "";
      
      <% 
         for(BasketDto dto : list){
      %>      
         basseq += <%= dto.getBasket_seq()%> +",";
      <%
         }
      %>

      IMP.init("imp66952866");
      IMP.request_pay({
         pg : 'html5_inicis',
         pay_method : 'card',
         merchant_uid : 'merchant_' + new Date().getTime(),
         name : '주문명:다모여샵',
         amount : sum,
         buyer_email : 'ohp12@naver.com',
         buyer_name : '김경선',
         buyer_tel : '010-7712-3139',
         buyer_addr : '서울특별시 강남구 역삼동',
         buyer_postcode : '123-456',
         m_redirect_url : 'https://www.yourdomain.com/payments/complete'
      }, function(rsp) {
         if (rsp.success) {
            var msg = '결제가 완료되었습니다.';
            msg += '고유ID : ' + rsp.imp_uid;
            msg += '상점 거래 ID : ' + rsp.merchant_uid;
            msg += '결제 금액 : ' + rsp.paid_amount;
            msg += '카드 승인번호 : ' + rsp.apply_num;
            alert(msg);
            location.href = "controller.do?command=sale&my_id="+my_id+"&addr="+addr+"&basseq="+basseq;
         } else {
            var msg = '결제에 실패하였습니다.';
            msg += '에러내용 : ' + rsp.error_msg;
         }

         alert(msg);
      }) 
   } 
</script>

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
            <div class="page-heading" style="padding-left: 240px">
              <h1>SHOP</h1>
            </div>
          </div>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <div class ="divAll">
      <div style="font-family: 맑은 고딕;">
          <h3>주문 정보</h3>
      <table class="table" border="1" summary="주문 리스트">
         <colgroup>
            <col width="120">
            <col width="auto">
            <col width="65">
            <col width="185">
         </colgroup>
         <thead>
            <tr>
               <th class="" colspan="2" scope="col">주문 상품 정보</th>
               <th class="" scope="col">수량</th>
               <th class="" scope="col">주문 금액</th>
            </tr>
         </thead>
         
         <tbody>
            <%
               for(BasketDto dto : list){
            %>
            <input type="hidden" name="my_id" value="<%=dto.getMyid()%>"/>
            <tr id="<%=dto.getPid() %>" >
               <td class="order_thmb"><a><img alt="<%=dto.getPname() %>" src="img/product/do<%=dto.getPid()%>.jpg"width="100" height="100"></a>
               </td>
               <td colspan="3"><a class="order_deal" title=""> </a>
                  <p class="p_info"><%=dto.getPname() %></p> 
                     <span class="order_option_cnt"> 
                        <span class="order_option_cnt_input"><%=dto.getAmount() %></span>&nbsp; &nbsp; 
                        <span class="order_option_price"><em class="b"><%=dto.getPrice() %></em>원 </span>
                     </span>       
               </td>
            </tr>
            <%
               }
            %>
         </tbody>
      </table>
   </div>
   <!-- 주문/ 결제 영역 -->

   <div>
      <!-- 구매자 정보 -->
      <h3 class="order_detail_tit">구매자 정보</h3>
      <table class="table" border="1" summary="정보">
         <colgroup>
            <col width="160">
            <col width="*">
         </colgroup>
         <tbody>
            <tr>
               <th>보내는분</th>
               <td>
               <input type="text" name="name" id="sdname" class="order_txt order_dimmed placeholder" placeholder="보내는분 입력" style="width: 150px">
               </td>
            </tr>
            <tr class="last">
               <th>연락처</th>
               <td>
                  <div class="order_select_box" style="margin-left: inherit">
                     <select class="order_select" style="width: 100px" name="tel"
                        id="sdtel1" >
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                        <option value="017">017</option>
                        <option value="018">018</option>
                        <option value="019">019</option>
                        <option value="02">02</option>
                        <option value="031">031</option>
                        <option value="032">032</option>
                        <option value="033">033</option>
                        <option value="041">041</option>
                        <option value="042">042</option>
                        <option value="043">043</option>
                        <option value="044">044</option>
                        <option value="051">051</option>
                        <option value="052">052</option>
                        <option value="053">053</option>
                        <option value="054">054</option>
                        <option value="055">055</option>
                        <option value="061">061</option>
                        <option value="062">062</option>
                        <option value="063">063</option>
                        <option value="064">064</option>
                        <option value="070">070</option>
                     </select> <span class="order_select_arr"></span>
                  &nbsp;-&nbsp; 
                  <input class="order_txt order_dimmed" type="tel" style="width: 110px" name="tel" id="sdtel2" maxlength="4">&nbsp;-&nbsp; 
                  <input class="order_txt order_dimmed" type="tel" style="width: 110px" name="tel" id="sdtel3" maxlength="4">
                  </div>
               </td>
            </tr>
         </tbody>
      </table>
   </div>
   <div class="order_detail mt80" style="font-family: 맑은 고딕;">
      <h3 class="order_detail_tit">배송지 정보</h3>
      <table class="table" border="1" summary="정보">
         <colgroup>
            <col width="160">
            <col width="*">
         </colgroup>
         <tbody>
            <tr>
               <th>받으실분</th>
               <td>
                 <input class="order_txt order_dimmed placeholder" type="text" style="width: 150px" name="name1" id="name1" value=""
                maxlength="20" placeholder="받으실 분 입력" data-oval="">
               &nbsp;&nbsp;
                <input type="checkbox" name="namecheck" id="namecheck"> 구매자 정보와 동일하게 입력
               </td>
            </tr>
            <tr>
               <th>주소</th>
               <td><!-- style="width: 130px" -->
                  <!-- 주소와 우편번호를 입력할 <input>들을 생성하고 적당한 name과 class를 부여한다 -->
                  <input type="text" name="postnum" class="postcodify postcode mini" id="sample6_postcode" placeholder="우편번호" disabled="disabled"/><input type="button" class="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
                  <input type="text" name="postaddr1" class="postcodify address" id="sample6_address" placeholder="주소" disabled="disabled"/><br />
                  <input type="text" name="postaddr2" class="postcodify details" id="sample6_detailAddress" placeholder="상세주소"/>
                  <input type="text" name="postaddr3" class="postcodify more" id="sample6_extraAddress" placeholder="참고항목" disabled="disabled"/>
               </td>
            </tr>


            <tr>
               <th><span>연락처</span></th>
               <td>
                  <div class="order_select_box" style="margin-left: inherit">
                     <select class="order_select" style="width: 100px" name="tel11"
                        id="tel11" data-oval="" >
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                        <option value="017">017</option>
                        <option value="018">018</option>
                        <option value="019">019</option>
                        <option value="02">02</option>
                        <option value="031">031</option>
                        <option value="032">032</option>
                        <option value="033">033</option>
                        <option value="041">041</option>
                        <option value="042">042</option>
                        <option value="043">043</option>
                        <option value="044">044</option>
                        <option value="051">051</option>
                        <option value="052">052</option>
                        <option value="053">053</option>
                        <option value="054">054</option>
                        <option value="055">055</option>
                        <option value="061">061</option>
                        <option value="062">062</option>
                        <option value="063">063</option>
                        <option value="064">064</option>
                        <option value="070">070</option>
                     </select><span class="order_select_arr"></span>
                     &nbsp;-&nbsp; 
                  <input class="order_txt order_dimmed" style="width: 110px" type="tel" name="tel" id="tel12" maxlength="4" data-oval="">
                  &nbsp;-&nbsp; 
                  <input class="order_txt order_dimmed" style="width: 110px" type="tel" name="tel" id="tel13" maxlength="4" data-oval="">                  
                  </div>
               </td>
            </tr>
         </tbody>
      </table>
   </div>

   <div class="order_detail mt80">
      <h3 class="order_detail_tit">결제 정보</h3>
   </div>

   <div class="order_calculate_area mt10">
      <div class="order_deal_price">
         <div class="order_h_area"><strong>총 주문금액</strong></div>
         <div class="order_result_area">
            <em><span id="oprc"><%=sum %></span></em> 
            <span class="won">원</span>
         </div>
      </div>

      <span class="order_plus">+</span>

      <div class="order_deal_delivery">
         <div class="order_h_area"><strong>배송비</strong></div>
         <div class="order_result_area">
            <em>
               <span id="totaldeliveryfee"> 
                  <span data-totaldeliveryfee="3000">3000</span>
               </span>
            </em> 
            <span class="won">원</span>
         </div>
      </div>

      <span class="order_equal">=</span>

      <div class="order_deal_payment">
         <div class="order_h_area_s" style="width: 121%"><strong><span>총 결제 금액</span></strong></div>
         <div class="order_result_area_s">
            <em><span id="tprc" data-tprc="12900">여기임 </span></em> 
            <span class="won"><span>원</span></span>
         </div>
      </div>
   </div>
   <script type="text/javascript"> // 여기임에 총 결제금액 넣기
      $("#tprc").text(<%=sum%>+Number($("#totaldeliveryfee").text()));
   </script>
   <div class="order_detail mt80">
      <!-- 주문 정보 -->
      <h3 class="order_detail_tit">주문동의</h3>
      <p class="order_agree">
      <label class="order_chk_type"> 
      <input type="checkbox" name="aggchk" id="pay"> 
      </label>
      <span id="agree">주문할 상품의 상품, 가격, 배송정보 등을 최종 확인하였으며, 이에 동의합니다.</span>      
         </p>
         <div style=" width:100%; text-align:right;">
         <input type="button" class="button" value="결제" id="ok" onclick="btnClick()"/>
      <input type="button" class="button" value="취소" onclick="location.href='controller.do?command=main'"/>    
      </div>
   </div>
   </div>

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