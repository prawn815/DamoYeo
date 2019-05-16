package com.post.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.post.dto.ansDto;

public class ansDaoImpl extends SqlMapConfig implements ansDao {
	
	private String namespace="com.post.comm_mapper.";

	@Override
	public List<ansDto> ansList(int boardseq, int pagecnt) {

		SqlSession session = null;
		List<ansDto> list = null;
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("boardseq", boardseq);
		map.put("pagecnt", pagecnt);
		
		session = getSqlSessionFactory().openSession(true);
		
		list = session.selectList(namespace+"ansList", map);
		
		session.close();
		
		return list;
		
	}

	@Override
	public int insertAns(ansDto ansdto) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.insert(namespace+"ansinsert", ansdto);
		
		session.close();
		
		return res;
		
	}

	@Override
	public int getAnsCnt(int boardseq) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.selectOne(namespace+"getAnsCnt", boardseq);
		
		session.close();
		
		return res;
		
	}

	@Override
	public int deleteAnsAll(int boardseq) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.delete(namespace+"deleteAnsAll", boardseq);
		
		session.close();
		
		return res;
		
	}

	@Override
	public int deleteAns(int ansno) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.delete(namespace+"deleteAns", ansno);
		
		session.close();
		
		return res;
		
	}

	@Override
	public int getWriterAnsCnt(String myid) {

		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.selectOne(namespace+"getWriterAnsCnt", myid);
		
		session.close();
		
		return res;
	}

	@Override
	public int deleteAnsId(String myid) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.delete(namespace+"deleteAnsId", myid);
		
		session.close();
		
		return res;
	}

}
