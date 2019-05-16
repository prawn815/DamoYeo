package com.cal.dao;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import static common.JDBCTemplate.*;

public class ExceltoDBDao {
 
	//private static String locationFilePath = "C:\\Users\\prawn\\Desktop\\OPENDATA_Total.csv";
	
	//private static List<String[]> locationList = new ArrayList<String[]>();

	public List<String[]> locationList(String locationFilePath) {
		List<String[]> locationList = new ArrayList<String[]>();
		String line = null;

		File locationFile = new File(locationFilePath);

		try {

			BufferedReader in = new BufferedReader(new FileReader(locationFile));

			while( (line = in.readLine()) != null) {
				String[] arr = line.split(",");

				locationList.add(arr);
				
			}
			
			
		}catch (Exception e) {

			e.printStackTrace();

		}
		
		return locationList;

	}
	
	public int insertFood(List<String[]> locationList) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		int cnt[] = null;
		
		String sql = " INSERT INTO FOODCALORIE " + " VALUES(FOODSEQ.NEXTVAL,?,?,?,?) ";
		
		try {
				pstm = con.prepareStatement(sql);
				for(int i = 0; i < locationList.size(); i++) {
					String[] arr = locationList.get(i);
					pstm.setString(1, arr[0]);
					pstm.setString(2, arr[1]);
					pstm.setInt(3, Integer.parseInt(arr[2].trim()));
					pstm.setDouble(4, Double.parseDouble(arr[3]));
					pstm.addBatch();
				}
				System.out.println("03.query 준비");
				
				cnt = pstm.executeBatch();
				System.out.println("04.query 실행");
				for(int i = 0; i < cnt.length; i++) {
					if(cnt[i] == -2) {
						res++;//성공한 쿼리의 갯수
					}
				}
				
				if(res == locationList.size()) {
					commit(con);
				}
	
		} catch (SQLException e) {
			System.out.println("3/4단계 에러");
			e.printStackTrace();
		}finally {
			close(pstm);
			close(con);
			System.out.println("05.db 종료");
		}
		
		return res;
	}
	
	public int insertEX(List<String[]> locationList) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		int cnt[] = null;
		
		String sql = " INSERT INTO EXCALORIE " + " VALUES(EXSEQ.NEXTVAL,?,?,?) ";
		
		try {
			pstm = con.prepareStatement(sql);
			for(int i = 0; i < locationList.size(); i++) {
				String[] arr = locationList.get(i);
				pstm.setString(1, arr[0]);
				pstm.setInt(2, Integer.parseInt(arr[1].trim()));
				pstm.setDouble(3, Double.parseDouble(arr[2].trim()));
				pstm.addBatch();
			}
			System.out.println("03.query 준비");
			
			cnt = pstm.executeBatch();
			System.out.println("04.query 실행");
			for(int i = 0; i < cnt.length; i++) {
				if(cnt[i] == -2) {
					res++;//성공한 쿼리의 갯수
				}
			}
			
			if(res == locationList.size()) {
				commit(con);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4단계 에러");
			e.printStackTrace();
		}finally {
			close(pstm);
			close(con);
			System.out.println("05.db 종료");
		}
		
		return res;
	}

}
