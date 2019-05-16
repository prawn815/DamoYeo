package com.cal.dao;

import java.util.List;

public class calMain {
	
	public static void main(String[] args) {
		// 음식 칼로리 엑셀파일(csv) -> db 입력 실행
		// DB를 먼저 만들어주세요. 그 다음  foodList / exerciseList를 순차적으로 주석을 풀어서 자바를 실행, DB에 데이터를 넣어주세요.
		// ExceltoDBDao는 두 list를 번갈아가면서 풀더라도 필요합니다.
		
		ExceltoDBDao ex = new ExceltoDBDao();
		/*List<String[]> foodList = ex.locationList("WebContent\\csv\\Fooddb.csv");
		ex.insertFood(foodList);*/
		
		
		List<String[]> exerciseList = ex.locationList("WebContent\\csv\\Exerdb.csv");
		ex.insertEX(exerciseList);
	}
}
