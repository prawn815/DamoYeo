package com.login.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.login.dto.LoginDto;

public class LoginDao extends SqlMapConfig {
	
	private String namespace = "com.login.mapper.";
	
	public List<LoginDto> selectAll(){
		SqlSession session = null;
		List<LoginDto> list = null;
		
		session = getSqlSessionFactory().openSession(true);
		list = session.selectList(namespace+"selectAll");
		
		return list;
	}
	

	public int insert(LoginDto dto) {
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(false);
		res = session.insert(namespace+"insert",dto);
		session.commit();
		session.close();
		return res;
	}
	
	public int kakaoinsert(LoginDto dto) {
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(false);
		res = session.insert(namespace+"kakaoinsert",dto);
		session.commit();
		session.close();
		return res;
	}
	
	public LoginDto login(String myid, String mypw) {
		SqlSession session = null;
		
		LoginDto dto = new LoginDto(myid, mypw);
		LoginDto res = dto;
		session = getSqlSessionFactory().openSession(false);
		res = session.selectOne(namespace+"login", dto);
		session.close();
		
		return res;
	}
	
	public LoginDto idchk(String myid) {
		SqlSession session = null;
		LoginDto res = new LoginDto(myid);
		session = getSqlSessionFactory().openSession(false);
		res = session.selectOne(namespace+"idchk", myid);
		session.close();
		
		return res;

	}
	
	public LoginDto idfind(String myname, int mybirthday, String myphone) {
		SqlSession session = null;
		LoginDto dto = new LoginDto(myname, mybirthday, myphone);
		LoginDto res = dto;
		session = getSqlSessionFactory().openSession(false);
		res = session.selectOne(namespace+"idpassfind", dto);
		session.close();
		
		return res;
	}
	
	public int userupdate(LoginDto dto) {
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(false);
		res = session.insert(namespace+"userupdate",dto);
		session.commit();
		session.close();
		
		return res;
		
	}
	
	public int userdelete(String myid) {
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		res = session.update(namespace+"userdelete", myid);
		session.commit();
		session.close();
		
		return res;
	}
	
	public int updateGenBirth(LoginDto dto) {
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		res = session.update(namespace + "updateGenBirth", dto);
		session.commit();
		session.close();
		
		return res;
	}
}
