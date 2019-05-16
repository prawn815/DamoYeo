$(function() {
	parseJson();
})

function parseJson() {
	$.getJSON("json/bike.json",function(data){
		$.ajax({
			url:"controller.do?command=test",
			method:"post",	
			data:{"obj":JSON.stringify(data)}, //json 객체를 string 객체로 변환시켜줌
			success:function(msg){	// 통신에 성공하면 function 기능 수행
				if(msg == 1460){
					// bike01.js 에서와 같이 bike02.jsp에 bike.json의 데이터를 table에 표현하자.
					$("table").attr("border","1");
					$.each(data, function(key, val) {
						if(key == "DESCRIPTION"){
							$("thead").append(
									"<tr>"+
										"<td>"+val.ADDR_GU+"</td>"+
										"<td>"+val.CONTENT_ID+"</td>"+
										"<td>"+val.CONTENT_NM+"</td>"+
										"<td>"+val.NEW_ADDR+"</td>"+
										"<td>"+val.CRADLE_COUNT+"</td>"+
										"<td>"+val.LONGITUDE+"</td>"+
										"<td>"+val.LATITUDE+"</td>"+
									"<tr>"
							);
						}else if(key=="DATA"){
							var list = val;
							for(var i = 0; i < list.length; i++){
								var str = list[i];
								$("tbody").append(
									"<tr>"+
										"<td>"+str.addr_gu+"</td>"+
										"<td>"+str.content_id+"</td>"+
										"<td>"+str.content_nm+"</td>"+
										"<td>"+str.new_addr+"</td>"+
										"<td>"+str.cradle_count+"</td>"+
										"<td>"+str.longitude+"</td>"+
										"<td>"+str.latitude+"</td>"+
									"</tr>"
								);
							}
						}
					} )
				}else{
					alert("실패");
				}
			},
			error: function() {
				alert("실패");
			}
		})
	})
}