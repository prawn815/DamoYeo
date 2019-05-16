	var map = document.getElementById("map");
	
	function map_initialize(myLat, myLng){
		
		console.log("map_initialize2");
		
		DrawLocationMarker(myLat, myLng);
		
		DrawCircle(myLat, myLng, 1000);
	};
	
	function DrawLocationMarker(lat, lng){
		console.log("DrawLocationMarker");
		var imageSrc = 'img/pin.png',
			imageSize = new daum.maps.Size(32,37),
			imageOption = {offset: new daum.maps.Point(16,37)};
		
		var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption),
			markerPosition = new daum.maps.LatLng(lat, lng);
		
		var poiDaumMarker = new daum.maps.Marker({
			position: markerPosition,
			image: markerImage
		});
		poiDaumMarker.setMap(map);
	}
		var circle;
		var circleList=[];
		
		function DrawCircle(lat, lng, radius){
			console.log("DrawCircle");
			
			circle = new daum.maps.Circle({
				center : new daum.maps.LatLng(lat,lng),
				radius : radius,
				strokeWeight : 5,
				strokeColor : '#75B8FA',
				strokeOpacity : 1,
				strokeStyle : 'dashed',
				fillColor: '#CFE7FF',
				fillOpacity: 0.3
			});
			circle.setMap(map);
		}