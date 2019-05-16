package com.post.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.post.dto.boardDto;

public class boardDaoImpl extends SqlMapConfig implements boardDao {
	
	private String namespace="com.post.comm_mapper.";

	@Override
	public List<boardDto> BoardList(int page) {
		
		SqlSession session = null;
		List<boardDto> list = null;
		
		session = getSqlSessionFactory().openSession(true);
		
		list = session.selectList(namespace+"selectList",page);
		
		session.close();
		
		return list;
		
	}

	@Override
	public boardDto BoardOne(int boardseq) {
		
		SqlSession session = null;
		boardDto res = null;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.selectOne(namespace+"selectOne",boardseq);
		
		session.close();
		
		return res;
		
	}

	@Override
	public int updateVisit(int boardseq) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.insert(namespace+"updateVisit", boardseq);
		
		session.close();
		
		return res;
		
	}

	@Override
	public int insertBoard(boardDto dto) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.insert(namespace+"insertBoard", dto);
		
		session.close();
		
		return res;
		
	}

	@Override
	public int deleteBoard(int boardseq) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.delete(namespace+"deleteBoard", boardseq);
		
		session.close();
		
		return res;
		
	}

	@Override
	public int getCnt() {

		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.selectOne(namespace+"getCnt");
		
		session.close();
		
		return res;
		
	}

	@Override
	public List<boardDto> writerBoardList(int page, String searchtext) {
		
		SqlSession session = null;
		List<boardDto> list = null;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("searchtext", searchtext);
		map.put("page", Integer.toString(page));
		
		session = getSqlSessionFactory().openSession(true);
		
		list = session.selectList(namespace+"selectWriterList",map);
		
		session.close();
		
		return list;
	}

	@Override
	public List<boardDto> titleBoardList(int page, String searchtext) {
		
		SqlSession session = null;
		List<boardDto> list = null;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("searchtext", searchtext);
		map.put("page", Integer.toString(page));
		
		session = getSqlSessionFactory().openSession(true);
		
		list = session.selectList(namespace+"selectTitleList",map);
		
		session.close();
		
		return list;
	}

	@Override
	public int getTitleCnt(String searchtext) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.selectOne(namespace+"getTitleCnt",searchtext);
		
		session.close();
		
		return res;
	}

	@Override
	public int getWriterCnt(String searchtext) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.selectOne(namespace+"getWriterCnt",searchtext);
		
		session.close();
		
		return res;
	}

	@Override
	public List<boardDto> temaBoardList(int page, int boardno) {

		SqlSession session = null;
		List<boardDto> list = null;
		
		session = getSqlSessionFactory().openSession(true);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("page",page);
		map.put("boardno", boardno);
		
		list = session.selectList(namespace+"selectTemaList",map);
		
		session.close();
		
		return list;
	}

	@Override
	public int getTemaCnt(int boardno) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.selectOne(namespace+"getTemaCnt", boardno);
		
		session.close();
		
		return res;
	}

	@Override
	public int updateBoard(boardDto dto) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.insert(namespace+"updateBoard", dto);
		
		session.close();
		
		return res;
	}

	@Override
	public List<boardDto> writerTemaBoardList(int page, String searchtext, int boardno) {
		
		SqlSession session = null;
		List<boardDto> list = null;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("searchtext", searchtext);
		map.put("page", Integer.toString(page));
		map.put("boardno", Integer.toString(boardno));
		
		session = getSqlSessionFactory().openSession(true);
		
		list = session.selectList(namespace+"selectTemaTitleList",map);
		
		session.close();
		
		return list;
	}

	@Override
	public List<boardDto> titleTemaBoardList(int page, String searchtext, int boardno) {
		SqlSession session = null;
		List<boardDto> list = null;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("searchtext", searchtext);
		map.put("page", Integer.toString(page));
		map.put("boardno", Integer.toString(boardno));
		
		session = getSqlSessionFactory().openSession(true);
		
		list = session.selectList(namespace+"selectTemaTitleList",map);
		
		session.close();
		
		return list;
	}

	@Override
	public int getTemaTitleCnt(String searchtext, int boardno) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("boardno",Integer.toString(boardno));
		map.put("searchtext", searchtext);
		
		res = session.selectOne(namespace+"getTemaWriterCnt",map);
		
		session.close();
		
		return res;
	}

	@Override
	public int getTemaWriterCnt(String searchtext, int boardno) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("boardno",Integer.toString(boardno));
		map.put("searchtext", searchtext);
		
		res = session.selectOne(namespace+"getTemaWriterCnt",map);
		
		session.close();
		
		return res;
	}

	@Override
	public List<boardDto> ansBoardList(int page, String myid) {
		SqlSession session = null;
		List<boardDto> list = null;
		
		session = getSqlSessionFactory().openSession(true);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("page",Integer.toString(page));
		map.put("myid", myid);
		
		list = session.selectList(namespace+"selectAnsList",map);
		
		session.close();
		
		return list;
	}

	@Override
	public int deleteBoardId(String myid) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.delete(namespace+"deleteBoardId", myid);
		
		session.close();
		
		return res;
	}

	@Override
	public int updateVisits(int boardseq) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		
		res = session.insert(namespace+"updateVisits", boardseq);
		
		session.close();
		
		return res;
	}
}
