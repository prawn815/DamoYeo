package com.post.dao;

import java.util.List;

import com.post.dto.ansDto;

public interface ansDao {
	
	public List<ansDto> ansList(int boardseq, int pagecnt);
	public int insertAns(ansDto ansdto);
	public int getAnsCnt(int boardseq);
	public int deleteAnsAll(int boardseq);
	public int deleteAns(int ansno);
	public int deleteAnsId(String myid);
	
	public int getWriterAnsCnt(String myid);

}
