package com.post.dao;

import java.util.List;

import com.post.dto.boardDto;

public interface boardDao {
	
	public List<boardDto> BoardList(int page);
	public List<boardDto> temaBoardList(int page, int boardno);
	
	public List<boardDto> writerBoardList(int page, String searchtext);
	public List<boardDto> titleBoardList(int page, String searchtext);
	public List<boardDto> writerTemaBoardList(int page, String searchtext, int boardno);
	public List<boardDto> titleTemaBoardList(int page, String searchtext, int boardno);
	public List<boardDto> ansBoardList(int page, String myid);
	
	public boardDto BoardOne(int boardseq);
	public int updateVisit(int boardseq);
	public int updateVisits(int boardseq);
	public int insertBoard(boardDto dto);
	public int deleteBoard(int boardseq);
	public int updateBoard(boardDto dto);
	
	public int deleteBoardId(String myid);
	
	public int getCnt();
	public int getTemaCnt(int boardno);
	public int getTitleCnt(String searchtext);
	public int getTemaTitleCnt(String searchtext, int boardno);
	public int getWriterCnt(String searchtext);
	public int getTemaWriterCnt(String searchtext, int boardno);
	
}
