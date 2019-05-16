package com.post.dto;

public class choiceDto {
	private int boardseq;
	private String myid;
	private String choice;
	
	public choiceDto() {
		//super();
	}

	public int getBoardseq() {
		return boardseq;
	}
	public void setBoardseq(int boardseq) {
		this.boardseq = boardseq;
	}

	public String getMyid() {
		return myid;
	}
	public void setMyid(String myid) {
		this.myid = myid;
	}

	public String getChoice() {
		return choice;
	}
	public void setChoice(String choice) {
		this.choice = choice;
	}
	
}
