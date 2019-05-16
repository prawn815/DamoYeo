package com.product.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.product.dto.ReviewDto;

public class ReviewDao extends SqlMapConfig{

	private String namespace="com.product.db.mapper.";
	
	// paging 처리 개체
		private static final int page_size = 5;
		
		public List<ReviewDto> reviewSelect(int pageNo, int pid) {
			
			SqlSession session = null;
			List<ReviewDto> list = null;
			
			session = getSqlSessionFactory().openSession(true);
			
			int pageCount = 0;
			int total = session.selectOne(namespace+"selContSQL", pid);
			if (total != 0) {
				pageCount = total / page_size + (total % page_size != 0 ? 1 : 0);
			}
			if (pageNo > pageCount) {
				pageNo = pageCount;
			}
			
			int one = (pageNo - 1) * page_size + 1;
			int two = pageNo * page_size;
			
		    Map<String, Object> parameters = new HashMap<String, Object>();
		    parameters.put("one", one);
		    parameters.put("two", two);
		    parameters.put("pid", pid);
			
			list = session.selectList(namespace+"selectSQL", parameters);		

			session.close();
			
			return list;
		}
		
		public int pageNum(int pid) {//페이지 갯수
			SqlSession session = null;
			
			session = getSqlSessionFactory().openSession(true);
			
			int pageCount = 0;											//REVIEW의 페이지 갯수
			int total = session.selectOne(namespace+"selContSQL", pid); //REVIEW의 게시물 갯수
			
			if (total != 0) {
				pageCount = total / page_size + (total % page_size != 0 ? 1 : 0);
			}
			
			return pageCount;
		}
		
		public int insertReview(ReviewDto rdto) {
			SqlSession session = null;
			int res = 0;
			
			session = getSqlSessionFactory().openSession(true);
			res = session.insert(namespace+"insertReview",rdto);
			
			session.close();
			
			return res;
		}
	
	public ReviewDto detailReview(int r_no) {
		SqlSession session = null;
		ReviewDto rdto = null;
		
		session = getSqlSessionFactory().openSession(true);
		rdto = session.selectOne(namespace+"detailReview",r_no);
		
		session.close();
		return rdto;
	}
}
