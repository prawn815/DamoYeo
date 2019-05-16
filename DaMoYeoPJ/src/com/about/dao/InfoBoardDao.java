package com.about.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.about.dto.BikeDto;
import com.about.dto.InfoBoardDto;


public class InfoBoardDao extends SqlMapConfig {
			
	private String namespace="com.about.mapper.";
	
	public int insertBike(List<BikeDto> list1){
		
		SqlSession session = null;
		int tmp = 0;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		for(int i = 0; i < list1.size(); i++) {
			tmp = session.insert(namespace+"insertbike", list1.get(i));
			
			if(tmp > 0) {
				res++;
			}
		}
				
		session.close();
		
		return res;
	}
	
	public List<InfoBoardDto> selectINFOBOARD(int page, int boardno){
		
		SqlSession session = null;
		List<InfoBoardDto> list = null;
		
		session = getSqlSessionFactory().openSession(true);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("boardno", Integer.toString(boardno));
		map.put("page", Integer.toString(page));
		
		list = session.selectList(namespace+"selectINFOBOARD",map);
		
		session.close();
		
		return list;
		
	}
	
public List<BikeDto> selectBikeBOARD(int page){
		
		SqlSession session = null;
		List<BikeDto> list = null;
		
		session = getSqlSessionFactory().openSession(true);
		
		list = session.selectList(namespace+"selectBikeBOARD",page);
		
		session.close();
		
		return list;
		
	}
	
	public List<InfoBoardDto> selectBoardno(int boardno){
		SqlSession session = null;
		List<InfoBoardDto> list = null;
		
		session = getSqlSessionFactory().openSession(true);
		list = session.selectList(namespace+"selectBoard", boardno);
		
		return list;
	}


	public InfoBoardDto selectOne(int myno) {
		SqlSession session = null;
		InfoBoardDto res = null;
		
		session = getSqlSessionFactory().openSession(true);
		res = session.selectOne(namespace+"selectOne",myno);
		
		return res;
	}
	
	public int insert(InfoBoardDto dto) {	
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		res = session.insert(namespace+"insert",dto);
		
		session.close();
		
		return res;
	}	
	
	public int delete(int myno) {
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		res = session.delete(namespace+"delete",myno);
		
		session.close();
		
		return res;
	}
	
	public int update(InfoBoardDto dto) {	
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		res = session.update(namespace+"update",dto);
		
		session.close();
		
		return res;
	}
}
	