package com.post.dao;

import com.post.dto.choiceDto;

public interface choiceDao {
	
	public int goodCnt(int boardseq);
	public int notgoodCnt(int boardseq);
	public String getCInfo(choiceDto choicedto);
	public int choice(choiceDto choicedto);
	public int deleteChoice(int boardseq);
	public int deleteChoiceId(String myid);
	
	public String checkChoice(int boardseq, String myid);

}
