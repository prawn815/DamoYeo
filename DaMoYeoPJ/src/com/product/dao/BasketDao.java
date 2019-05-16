package com.product.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.product.dto.BasketDto;

public class BasketDao extends SqlMapConfig{

	private String namespace="com.product.db.mapper.";
	
	public List<BasketDto> BasketAll(String myid){		
		SqlSession session = null;
		List<BasketDto> list = null;
		
		session = getSqlSessionFactory().openSession(true);
		
		list = session.selectList(namespace+ "BasketAll", myid);
		
		session.close();
		
		return list;
	}
	
	public BasketDto selectBas(String myid) {
		
		SqlSession session = null;
		BasketDto dto = null;
		
		session = getSqlSessionFactory().openSession(true);
		dto = session.selectOne(namespace+"selectBas", myid);
		
		session.close();
		
		return dto;
	}
	
	public int insertBas(BasketDto dto) {	
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		res = session.insert(namespace+"insertBas", dto);
		
		session.close();
		
		return res;
	}
	
	public int muldelBas(String[] basket_seq) {		
		SqlSession session = null;
		int res = 0;
				
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("basket_seq", basket_seq);
		
		session = getSqlSessionFactory().openSession(false);
		
		res = session.delete(namespace+"muldelBas",map);
		
		if(res == basket_seq.length) {
			session.commit();
		}
		session.close();
		
		return res;
	}
	
	public List<BasketDto> BasketSelect(String[] basket_seq) {
		SqlSession session = null;
		List<BasketDto> list = null;
				
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("basket_seq", basket_seq);
		
		session = getSqlSessionFactory().openSession(false);
		list = session.selectList(namespace+"BasketSelect",map);
		
		session.close();
		
		return list;
	}
	
	public int sumBas0(BasketDto dto) {
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		res = session.selectOne(namespace+"sumBas0",dto);
		
		session.close();
		
		return res;
	}
	
	public int sumBas(String[] basket_seq) {
		SqlSession session = null;
		int res = 0;
		
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("basket_seq", basket_seq);
		
		session = getSqlSessionFactory().openSession(true);
		res = session.selectOne(namespace+"sumBas",map);
		
		session.close();
		
		return res;
	}
}
