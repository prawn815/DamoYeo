package com.post.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.post.dto.choiceDto;

public class choiceDaoImpl extends SqlMapConfig implements choiceDao {
	
	private String namespace="com.post.comm_mapper.";

	@Override
	public int goodCnt(int boardseq) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.selectOne(namespace+"getGoodCnt", boardseq);
		
		session.close();
		
		return res;
		
	}

	@Override
	public int notgoodCnt(int boardseq) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.selectOne(namespace+"getNotGoodCnt", boardseq);
		
		session.close();
		
		return res;
	}

	@Override
	public String getCInfo(choiceDto choicedto) {
		
		SqlSession session = null;
		String res = "";
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.selectOne(namespace+"checkChoice", choicedto);
		
		session.close();
		
		return res;
		
	}

	@Override
	public int choice(choiceDto choicedto) {
		
		SqlSession session = null;
		String res_chk = "";
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res_chk = session.selectOne(namespace+"checkChoice", choicedto);
		
		if(res_chk != null) {
			if(res_chk.equals(choicedto.getChoice())) {
				res = session.delete(namespace+"deleteChoice", choicedto);
				System.out.println("삭제해따!!");
			}
			else {
				res = session.update(namespace+"nextChoice", choicedto);
				System.out.println("수정해따!!");
			}
		}
		else {
			res = session.insert(namespace+"firstChoice", choicedto);
			System.out.println("삽입해따!!");
		}
		
		session.close();
		
		return res;
		
	}

	@Override
	public int deleteChoice(int boardseq) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.delete(namespace+"deleteChoiceAll", boardseq);
		
		session.close();
		
		return res;
		
	}

	@Override
	public String checkChoice(int boardseq, String myid) {
		
		SqlSession session = null;
		String res = "";
		
		session = getSqlSessionFactory().openSession(true);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("boardseq", Integer.toString(boardseq));
		map.put("myid", myid);
		
		res = session.selectOne(namespace+"checkChoices", map);
		
		session.close();
		
		return res;
	}

	@Override
	public int deleteChoiceId(String myid) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.delete(namespace+"deleteChoiceId", myid);
		
		session.close();
		
		return res;
	}

}
