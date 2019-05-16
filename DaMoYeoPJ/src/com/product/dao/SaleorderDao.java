package com.product.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.product.dto.SaleorderDto;

public class SaleorderDao extends SqlMapConfig{

	private String namespace="com.product.db.mapper.";
	
	public List<SaleorderDto> selectAll(){
		
		SqlSession session = null;
		List<SaleorderDto> list = null;
		
		session = getSqlSessionFactory().openSession(true);
		
		list = session.selectList(namespace+"OrderAll");
		
		session.close();
		
		return list;
	}
	
	public List<SaleorderDto> selectAdmin(){
			
			SqlSession session = null;
			List<SaleorderDto> list = null;
			
			session = getSqlSessionFactory().openSession(true);
			
			list = session.selectList(namespace+"AdminAll");
			
			session.close();
			
			return list;
		}
	
	public List<SaleorderDto> selectOrder(String myid) {
		
		SqlSession session = null;
		List<SaleorderDto> slist = null;
		
		session = getSqlSessionFactory().openSession(true);
		
		slist = session.selectList(namespace+"selectOrder",myid);
		
		session.close();
		
		return slist;
	}
	
	public int insertOrder(SaleorderDto sdto) {
	
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.insert(namespace+"insertOrder",sdto);
		
		session.close();
		
		return res;
	}
	
	public SaleorderDto selOneOrder(int order_id) {
		
		SqlSession session = null;
		SaleorderDto sdto = null;
		
		session = getSqlSessionFactory().openSession(true);
		
		sdto = session.selectOne(namespace+"selOneOrder",order_id);
		
		session.close();
	
		return sdto;
	}
}
