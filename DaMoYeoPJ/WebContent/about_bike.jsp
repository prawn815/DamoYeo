<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%@ page import="com.login.dto.LoginDto"%>
<%@ page import="com.login.dao.LoginDao " %>
<%@ page import="java.util.*" %>
<%@ page import="com.about.dto.*" %>
<%@ page import="com.about.dao.*" %>

<%
   request.setCharacterEncoding("UTF-8");
   response.setContentType("text/html; charset=UTF-8");
%>

<%
   LoginDto dto = (LoginDto)session.getAttribute("dto");

   String myid = null;
   if(dto != null){
      myid = dto.getMyid();
   }
   else{
      response.sendRedirect("controller.do?command=whatlog");
   }
%>

<%
   List<BikeDto> list = (List<BikeDto>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>

   


<style>
.map_wrap, .map_wrap * {
   margin: 0;
   padding: 0;
   font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
   font-size: 12px;
}

.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
   color: #000;
   text-decoration: none;
}

.map_wrap {
   position: relative;
   width: 100%;
   height: 500px;
}

#menu_wrap {
   position: absolute;
   top: 0;
   left: 0;
   bottom: 0;
   width: 250px;
   margin: 50px 0 30px 10px;
   padding: 5px;
   overflow-y: auto;
   background: rgba(255, 255, 255, 0.7);
   z-index: 1;
   font-size: 12px;
   border-radius: 10px;
}

.bg_white {
   background: #fff;
}

#menu_wrap hr {
   display: block;
   height: 1px;
   border: 0;
   border-top: 2px solid #5F5F5F;
   margin: 3px 0;
}

#menu_wrap .option {
   text-align: center;
}

#menu_wrap .option p {
   margin: 10px 0;
}

#menu_wrap .option button {
   margin-left: 5px;
}

#placesList li {
   list-style: none;
}

#placesList .item {
   position: relative;
   border-bottom: 1px solid #888;
   overflow: hidden;
   cursor: pointer;
   min-height: 65px;
}

#placesList .item span {
   display: block;
   margin-top: 4px;
}

#placesList .item h5, #placesList .item .info {
   text-overflow: ellipsis;
   overflow: hidden;
   white-space: nowrap;
}

#placesList .item .info {
   padding: 10px 0 10px 55px;
}

#placesList .info .gray {
   color: #8a8a8a;
}

#placesList .info .jibun {
   padding-left: 26px;
   background:
      url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
      no-repeat;
}

#placesList .info .tel {
   color: #009900;
}

#placesList .item .markerbg {
   float: left;
   position: absolute;
   width: 36px;
   height: 37px;
   margin: 10px 0 0 10px;
   background:
      url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png)
      no-repeat;
}

#placesList .item .marker_1 {
   background-position: 0 -10px;
}

#placesList .item .marker_2 {
   background-position: 0 -56px;
}

#placesList .item .marker_3 {
   background-position: 0 -102px
}

#placesList .item .marker_4 {
   background-position: 0 -148px;
}

#placesList .item .marker_5 {
   background-position: 0 -194px;
}

#placesList .item .marker_6 {
   background-position: 0 -240px;
}

#placesList .item .marker_7 {
   background-position: 0 -286px;
}

#placesList .item .marker_8 {
   background-position: 0 -332px;
}

#placesList .item .marker_9 {
   background-position: 0 -378px;
}

#placesList .item .marker_10 {
   background-position: 0 -423px;
}

#placesList .item .marker_11 {
   background-position: 0 -470px;
}

#placesList .item .marker_12 {
   background-position: 0 -516px;
}

#placesList .item .marker_13 {
   background-position: 0 -562px;
}

#placesList .item .marker_14 {
   background-position: 0 -608px;
}

#placesList .item .marker_15 {
   background-position: 0 -654px;
}

#pagination {
   margin: 10px auto;
   text-align: center;
}

#pagination a {
   display: inline-block;
   margin-right: 10px;
}

#pagination .on {
   font-weight: bold;
   cursor: default;
   color: #777;
}
</style>
<style type="text/css">
a {
   text-decoration: none;
}

.button {
      
          width:125px;
      
          background-color: #B2CCFF;
      
          border: 1px;
      
          color:black;
      
          padding: 15px 0;
      
          text-align: center;
      
          text-decoration: none;
      
          display: inline-block;
      
          font-size: 15px;
      
          margin: 4px;
      
          cursor: pointer;
          
          border-radius:10px 10px 10px 10px;
          
          border: solid 3px #4374D9;
      
      }
      
      .button:hover{
         background-color: yellow;
      }
         
      .table {
         border-collapse: collapse;
         border-top: 3px solid #4374D9;
         font-size: 20px;
       }  
       .table th {
         color: #168;
         background: #B2CCFF;
         text-align: center;
         font-size: 20px;
         
       }
       .table th, .table td {
         padding: 10px;
         border: 1px solid #ddd;
         text-align: center;
       }
       
       .table td{
       background: #F8FFFF;
       
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

      .button1 {
      
          width:50px;
      
          background-color: #B2CCFF;
      
          border: 1px;
      
          color:black;
      
          padding: 15px 0;
      
          text-align: center;
      
          text-decoration: none;
      
          display: inline-block;
      
          font-size: 10px;
      
          margin: 4px;
      
          cursor: pointer;
          
          border-radius:30px 30px 30px 30px;
          
          border: solid 3px #4374D9;
      
      }
      
      .button1:hover{
         background-color: yellow;
      }
      
      .button2 {
      
          width:50px;
      
          background-color: #B2CCFF;
      
          border: 1px;
      
          color:black;
      
          padding: 15px 0;
      
          text-align: center;
      
          text-decoration: none;
      
          display: inline-block;
      
          font-size: 15px;
      
          margin: 4px;
      
          cursor: pointer;
          
          border-radius:30px 30px 30px 30px;
          
          border: solid 3px #4374D9;
      
      }
      
      .button2:hover{
         background-color: yellow;
      }


</style>
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
   
   <script type="text/javascript">
      function tttt() {
         window.open('chating.jsp','ex','width=400,height=530');
      };
   </script>


<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5c9494263c5fa28fb51d3f17f6bf032d&libraries=services"></script>
<script type="text/javascript" src="js/drawingmap.js"></script>
<script type="text/javascript" src="js/geolocation.js"></script>
<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>

<script>
   function init() {
      geoLocation();
   }
   window.onload = init();
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
                     if(dto.getMyrole().equals("ADMIN")){
                        
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
   <header class="masthead" style="">
      <div class="overlay">
         <img alt="1" src="img/5.jpg" style="width: 100%; height: 100%" />
      </div>
      <div class="container">
         <div class="row">
            <div class="col-lg-8 col-md-10 mx-auto">
               <div class="page-heading">
                  <h1>정보 게시판</h1>
                  <span class="subheading"></span>
               </div>
            </div>
         </div>
      </div>
   </header>

   <!-- Main Content -->
<div class="container" style="font-family: 맑은 고딕;">
   <div class="map_wrap">
      <div id="map"
         style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

      <div id="menu_wrap" class="bg_white">
         <div class="option">
            <div>
               <form onsubmit="searchPlaces(); return false;">
                  키워드 : <input type="text" value="따릉이" id="keyword" size="15">
                  <button type="submit" class="button1">검색하기</button>


               </form>
            </div>
         </div>
         <hr>
         <ul id="placesList"></ul>
         <div id="pagination"></div>
      </div>
   </div>
   <br />
   
   <div align="center">
      <input type="button" value="따릉이" class="button"  onclick="location.href='controller.do?command=selectINFOBOARD&page=1&boardno=1'" />
      <input type="button" value="헬스장" class="button" onclick="location.href='controller.do?command=selectINFOBOARD&page=1&boardno=2'" />
      <input type="button" value="자전거 도로" class="button" onclick="location.href='controller.do?command=selectINFOBOARD&page=1&boardno=3'" />
   </div>
   
   <br />
   <table border="1" class="table">
      <col width="50px">
      <col width="100px">
      <col width="200px">
      <col width="300px">
      <tr>
         <th>번호</th>
         <th>이름</th>
         <th>주소</th>
         <th>상세정보</th>
      </tr>
      

      <%
         for (int i = 0; i < list.size(); i++) {
      %>
      <tr>
         <td><%=list.get(i).getContent_id()%></td>
         <td><%=list.get(i).getContent_nm()%></td>
         <td><%=list.get(i).getNew_addr()%></td>
         <td><a><%=list.get(i).getAddr_gu()%></a></td>
      </tr>

      <%
         }
      %>
   </table>
   
   
   <div align="center">
      <input type="button" class="button2" value="1" onclick="location.href='controller.do?command=selectINFOBOARD&page=1&boardno=1'"/>
      <input type="button" class="button2" value="2" onclick="location.href='controller.do?command=selectINFOBOARD&page=2&boardno=1'"/>
      <input type="button" class="button2" value="3" onclick="location.href='controller.do?command=selectINFOBOARD&page=3&boardno=1'"/>
      <input type="button" class="button2" value="4" onclick="location.href='controller.do?command=selectINFOBOARD&page=4&boardno=1'"/>
   
   </div>


   <script>
      // 마커를 담을 배열입니다
      var markers = [];

      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
      mapOption = {
         center : new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
         level : 4
      // 지도의 확대 레벨
      };

      // 지도를 생성합니다    
      var map = new daum.maps.Map(mapContainer, mapOption);

      /*    지도 컨트롤러 */
      // 지도 타입 변경 컨트롤을 생성한다
      var mapTypeControl = new daum.maps.MapTypeControl();

      // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
      map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

      // 지도에 확대 축소 컨트롤을 생성한다
      var zoomControl = new daum.maps.ZoomControl();

      // 지도의 우측에 확대 축소 컨트롤을 추가한다
      map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

      // 장소 검색 객체를 생성합니다
      var ps = new daum.maps.services.Places(map);

      // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
      var infowindow = new daum.maps.InfoWindow({
         zIndex : 1
      });

      // 키워드로 장소를 검색합니다
      searchPlaces();

      // 키워드 검색을 요청하는 함수입니다
      function searchPlaces() {

         var keyword = document.getElementById('keyword').value;

         if (!keyword.replace(/^\s+|\s+$/g, '')) {
            alert('키워드를 입력해주세요!');
            return false;
         }

         // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
         ps.keywordSearch(keyword, placesSearchCB);
      }

      // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
      function placesSearchCB(data, status, pagination) {
         if (status === daum.maps.services.Status.OK) {

            // 정상적으로 검색이 완료됐으면
            // 검색 목록과 마커를 표출합니다
            displayPlaces(data);
            // 페이지 번호를 표출합니다
            displayPagination(pagination);

         } else if (status === daum.maps.services.Status.ZERO_RESULT) {

            alert('검색 결과가 존재하지 않습니다.');
            return;

         } else if (status === daum.maps.services.Status.ERROR) {

            alert('검색 결과 중 오류가 발생했습니다.');
            return;

         }
      }

      // 검색 결과 목록과 마커를 표출하는 함수입니다
      function displayPlaces(places) {

         var listEl = document.getElementById('placesList'), menuEl = document
               .getElementById('menu_wrap'), fragment = document
               .createDocumentFragment(), bounds = new daum.maps.LatLngBounds(), listStr = '';

         // 검색 결과 목록에 추가된 항목들을 제거합니다
         removeAllChildNods(listEl);

         // 지도에 표시되고 있는 마커를 제거합니다
         removeMarker();

         for (var i = 0; i < places.length; i++) {

            // 마커를 생성하고 지도에 표시합니다
            var placePosition = new daum.maps.LatLng(places[i].y,
                  places[i].x), marker = addMarker(placePosition, i), itemEl = getListItem(
                  i, places[i]); // 검색 결과 항목 Element를 생성합니다

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            bounds.extend(placePosition);

            // 마커와 검색결과 항목에 mouseover 했을때
            // 해당 장소에 인포윈도우에 장소명을 표시합니다
            // mouseout 했을 때는 인포윈도우를 닫습니다
            (function(marker, title) {
               daum.maps.event.addListener(marker, 'mouseover',
                     function() {
                        displayInfowindow(marker, title);
                     });

               daum.maps.event.addListener(marker, 'mouseout', function() {
                  infowindow.close();
               });

               itemEl.onmouseover = function() {
                  displayInfowindow(marker, title);
               };

               itemEl.onmouseout = function() {
                  infowindow.close();
               };
            })(marker, places[i].place_name);

            fragment.appendChild(itemEl);
         }

         // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
         listEl.appendChild(fragment);
         menuEl.scrollTop = 0;

         // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
         map.setBounds(bounds);
      }

      // 검색결과 항목을 Element로 반환하는 함수입니다
      function getListItem(index, places) {

         var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
               + (index + 1)
               + '"></span>'
               + '<div class="info">'
               + '   <h5>' + places.place_name + '</h5>';

         if (places.road_address_name) {
            itemStr += '    <span>' + places.road_address_name + '</span>'
                  + '   <span class="jibun gray">' + places.address_name
                  + '</span>';
         } else {
            itemStr += '    <span>' + places.address_name + '</span>';
         }

         itemStr += '  <span class="tel">' + places.phone + '</span>'
               + '</div>';

         el.innerHTML = itemStr;
         el.className = 'item';

         return el;
      }

      // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
      function addMarker(position, idx, title) {
         var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
         imageSize = new daum.maps.Size(36, 37), // 마커 이미지의 크기
         imgOptions = {
            spriteSize : new daum.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new daum.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset : new daum.maps.Point(13, 37)
         // 마커 좌표에 일치시킬 이미지 내에서의 좌표
         }, markerImage = new daum.maps.MarkerImage(imageSrc, imageSize,
               imgOptions), marker = new daum.maps.Marker({
            position : position, // 마커의 위치
            image : markerImage
         });

         marker.setMap(map); // 지도 위에 마커를 표출합니다
         markers.push(marker); // 배열에 생성된 마커를 추가합니다

         return marker;
      }

      // 지도 위에 표시되고 있는 마커를 모두 제거합니다
      function removeMarker() {
         for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
         }
         markers = [];
      }

      // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
      function displayPagination(pagination) {
         var paginationEl = document.getElementById('pagination'), fragment = document
               .createDocumentFragment(), i;

         // 기존에 추가된 페이지번호를 삭제합니다
         while (paginationEl.hasChildNodes()) {
            paginationEl.removeChild(paginationEl.lastChild);
         }

         for (i = 1; i <= pagination.last; i++) {
            var el = document.createElement('a');
            el.href = "#";
            el.innerHTML = i;

            if (i === pagination.current) {
               el.className = 'on';
            } else {
               el.onclick = (function(i) {
                  return function() {
                     pagination.gotoPage(i);
                  }
               })(i);
            }

            fragment.appendChild(el);
         }
         paginationEl.appendChild(fragment);
      }

      // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
      // 인포윈도우에 장소명을 표시합니다
      function displayInfowindow(marker, title) {
         var content = '<div style="padding:5px;z-index:1;">' + title
               + '</div>';

         infowindow.setContent(content);
         infowindow.open(map, marker);
      }

      // 검색결과 목록의 자식 Element를 제거하는 함수입니다
      function removeAllChildNods(el) {
         while (el.hasChildNodes()) {
            el.removeChild(el.lastChild);
         }
      }

      var places = new daum.maps.services.Places();
      var callback = function(status, result, pagination) {
         if (status === daum.maps.services.Status.OK) {
            alert("검색된 음식점의 갯수는 " + result.places.length + "개 입니다.");
         }
      };

      places.categorySearch('PO3', callback, {
         // Map 객체를 지정하지 않았으므로 좌표객체를 생성하여 넘겨준다.
         location : new daum.maps.LatLng(37.564968, 126.939909)
      });

      //지도에 마커를 표시합니다 
      var marker = new daum.maps.Marker({
         map : map,
         position : new daum.maps.LatLng(33.450701, 126.570667)
      });

      // 커스텀 오버레이에 표시할 컨텐츠 입니다
      // 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
      // 별도의 이벤트 메소드를 제공하지 않습니다 
      var content = '<div class="wrap">'
            + '    <div class="info">'
            + '        <div class="title">'
            + '            카카오 스페이스닷원'
            + '            <div class="close" onclick="closeOverlay()" title="닫기"></div>'
            + '        </div>'
            + '        <div class="body">'
            + '            <div class="img">'
            + '                <img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">'
            + '           </div>'
            + '            <div class="desc">'
            + '                <div class="ellipsis">제주특별자치도 제주시 첨단로 242</div>'
            + '                <div class="jibun ellipsis">(우) 63309 (지번) 영평동 2181</div>'
            + '                <div><a href="http://www.kakaocorp.com/main" target="_blank" class="link">홈페이지</a></div>'
            + '            </div>' + '        </div>' + '    </div>'
            + '</div>';
   </script>
   <hr>
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

   <!-- Custom scripts for this template -->
   <script src="js/clean-blog.min.js"></script>

</body>
</html>