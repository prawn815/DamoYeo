//현재 위치 추적 시작
function geoLocation(){
	if(navigator.geolocation){
		navigator.geolocation.getCurrentPosition(showPosition, showError);
	}else{
		alert("Geolocation is nat supported by this browser.");
	}
}
	var nLat;
	var nLng;
	//위치 추적 성공
	function showPosition(position){
		nLat = position.coords.latitude;
		nLng = position.coords.longitude;
		console.log("nLat : "+nLat);
		console.log("nLng : "+nLng);
		
		//drawingmap.js
		map_initialize(nLat, nLng);
	}
	//위치 추적 실패
	function showError(error){
		switch(error.code){
		case error.PERMISSION_DENIED:
		alert("User denied the request for Geolocation");
		break;
		case error.POSITION_UNAVAILABLE:
		alert("Location information is unavailable");
		break;
		case error.TIMEOUT:
		alert("The request to get user location timed out");
		break;
		case error.UNKNOWN_ERROR:
		alert("An unknown error occurred");
		break;
		}
	}