package com.product.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.product.dto.ProductDto;

public class ProductDao extends SqlMapConfig{
	
	private String namespace="com.product.db.mapper.";

	public List<ProductDto> selectAll(){
		
		SqlSession session = null;
		List<ProductDto> list = null;
		
		session = getSqlSessionFactory().openSession(true);
		
		list = session.selectList(namespace+"selectAll");
		
		session.close();
		
		return list;
	}
	
	public ProductDto selectOne(int pid) {
		
		SqlSession session = null;
		ProductDto dto = null;
		
		session = getSqlSessionFactory().openSession(true);
		dto = session.selectOne(namespace+"selectOne",pid);
		
		session.close();
		
		return dto;
	}

}
