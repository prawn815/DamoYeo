package com.cal.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.cal.dto.CalorieDto;
import com.cal.dto.DiaryDto;
import com.cal.dto.InbodyDto;
import com.cal.dto.LoginBoardDto;

public class CalorieDao extends SqlMapConfig{

	private String namespace = "com.cal.mapper.";
	
	public CalorieDao() {
		
	}
	
	public List<CalorieDto> selectFoodCalorie(String finditem){
		SqlSession session = null;
		List<CalorieDto> list = null;
		
		session = getSqlSessionFactory().openSession(true);
		list = session.selectList(namespace+"selectFoodCalorie", finditem);
		return list;
	}
	
	public List<CalorieDto> selectExCalorie(String finditem){
		SqlSession session = null;
		List<CalorieDto> list = null;
		
		session = getSqlSessionFactory().openSession(true);
		list = session.selectList(namespace+"selectExCalorie" , finditem);
		return list;
	}

	public List<DiaryDto> getCalList(String id, String yyyyMMdd){
		SqlSession session = null;
		List<DiaryDto> list = null;
		session = getSqlSessionFactory().openSession(true);
		//////////////////////
		return list;
	}
	
	public List<InbodyDto> selectInbodyAll(){
		SqlSession session = null;
		List<InbodyDto> list = null;
		
		session = getSqlSessionFactory().openSession(true);
		list = session.selectList(namespace+"selectInbodyAll");
		
		session.close();
		return list;
	}
	
	public InbodyDto selectInbodyMyid(String myid){
		SqlSession session = null;
		InbodyDto dto = null;
		
		session = getSqlSessionFactory().openSession(true);
		dto = session.selectOne(namespace + "selectInbodyMyid", myid);
		
		session.close();
		return dto;
	}
	
	public int insertInbody(InbodyDto dto) {
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		res = session.insert(namespace+"insertInbody",dto);
		
		session.close();
		
		return res;
	}
	
	public int updateInbody(InbodyDto dto) {
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		res = session.update(namespace+"updateInbody", dto);
		
		session.close();
		
		return res;
	}
	
	public int insertDiary(DiaryDto dto) {
		SqlSession session = null;
		int res = 0;
		session = getSqlSessionFactory().openSession(true);
		res = session.insert(namespace+"insertDiary", dto);
		
		session.close();
		
		return res;
	}
	
	public int updateDiary(DiaryDto dto) {
		SqlSession session = null;
		int res = 0;
		session = getSqlSessionFactory().openSession(true);
		res = session.update(namespace + "updateDiary",dto);
		
		session.close();
		
		return res;
	}
	
	public List<DiaryDto> selectDiaryAll(String myid){
		SqlSession session = null;
		List<DiaryDto> list = null;
		
		session = getSqlSessionFactory().openSession(true);
		list = session.selectList(namespace+"selectDiaryAll", myid);
		
		session.close();
		return list;
	}
	
	public DiaryDto selectDiaryOne(DiaryDto dto) {
		SqlSession session = null;
		DiaryDto res = null;
		session = getSqlSessionFactory().openSession(true);
		res = session.selectOne(namespace+"selectDiaryOne", dto);
		
		session.close();
		
		return res;
	}
	
	public int deleteDiary(DiaryDto dto) {
		SqlSession session = null;
		int res = 0;
		session = getSqlSessionFactory().openSession(true);
		res = session.delete(namespace+"deleteDiary", dto);
		
		session.close();
		
		return res;
	}
	
	public LoginBoardDto selectMyid(String myid) {
		SqlSession session = null;
		LoginBoardDto dto = null;
		session = getSqlSessionFactory().openSession(true);
		dto = session.selectOne(namespace+"selectMyid",myid);
		
		session.close();
		
		return dto;
	}
	
	public int deleteInbody(String myid) {
		SqlSession session = null;
		int res = 0;
		session = getSqlSessionFactory().openSession(true);
		res = session.delete(namespace + "deleteInbody", myid);
		
		session.close();
		
		return res;
	}
	
	public int deleteDiaryMyid(String myid) {
		SqlSession session = null;
		int res = 0;
		session = getSqlSessionFactory().openSession(true);
		res = session.delete(namespace + "deleteDiaryMyid", myid);
		
		session.close();
		
		return res;
	}
}
