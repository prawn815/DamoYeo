package com.cal.dao;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import com.cal.dto.DiaryDto;;

public class Util {
	
	private String toDates;
	
	public String getToDates() {
		return toDates;
	}
	public void setToDates(String mDate) {
		//yyyyMMddhhmm
		//yyyy-MM-dd hh:mm:00
		String m = mDate.substring(0, 4) + "-"
				+ mDate.substring(4,6)+"-"
				+ mDate.substring(6, 8)+" "
				+ mDate.substring(8, 10)+":"
				+ mDate.substring(10) + ":00";
		
		// 로케일에 따라 날짜를 형식화하고 구문 분석하는 데 필요한 구체적인 클래스입니다. 서식 지정 (날짜 → 텍스트), 구문 분석 (텍스트 → 날짜) 및 정규화가 가능합니다.
		// date 형식의 객체를 원하는 방식으로 출력
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");
		
		// date클래스에 nanosecond를 더한 클래스
		Timestamp tm = Timestamp.valueOf(m);
		toDates = sdf.format(tm);
	}
	
	
	// 한자리 수를 두자리 수로 변환
	public static String isTwo(String msg) {
		return (msg.length()<2)?"0"+msg:msg;
	}
	
	// 요일 색깔 font color
	public static String fontColor(int date, int dayOfWeek) {
		String color = "";
		//만일 토요일 이라면  : blue
		//혹은 일요일 이라면 : red
		//모두 아니라면 : black
		
		if((dayOfWeek-1+date)%7 == 0) {
			color = "blue";
		}else if((dayOfWeek-1+date)%7 == 1) {
			color = "red";
		}else {
			color = "black";
		}
		
		return color;
	}
	
	public static String getCalView(int i, List<DiaryDto> dlist, int month) {
		String d = isTwo(i+"");
		String res = "";
		String mon = isTwo(Integer.toString(month));
		for(DiaryDto dto : dlist) {
			if(dto.getMdate().substring(4, 6).equals(mon)) {
				if(dto.getMdate().substring(6, 8).equals(d)) {
					if(dto.getTotalcal() == 0.0 && dto.getTotalmeta() == 0.0) {
						
					}else {
						res = "<p style='background-color: pink'>"+ Double.toString(dto.getTotalcal())+"(kcal)" +"</p>";
						res += "<p style='background-color: skyblue'>"+ Double.toString(dto.getTotalmeta())+"(kcal)" +"</p>";
						if(decimal(dto.getTotalcal()-dto.getTotalmeta()) < 0) {
							res += "<p style='background-color: skyblue'>"+ Double.toString(decimal(dto.getTotalcal()-dto.getTotalmeta())) +"(kcal)" + "</p>";
						}else {
							res += "<p style='background-color: pink'>"+ Double.toString(decimal(dto.getTotalcal()-dto.getTotalmeta())) +"(kcal)" + "</p>";
						}
					}
				}
			}
			
		}
		
		return res;
	}
	
	//String을 날짜로 변환
	public static String[] updateDay(String mDate) {
		String year = mDate.substring(0, 4);
		String month = mDate.substring(4, 6);
		String day = mDate.substring(6,8);
		
		String[] res = {year, month, day};
		return res;
	}
	
	//소수점 1자리 표현하는 코드
    public static double decimal(double num) {
        int n = 1;
        double n2 = Math.pow(10.0, n);
        
        return Math.round(num*n2)/n2;
    }
	
}
