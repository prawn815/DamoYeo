package com.post.dto;

import java.util.Date;

public class boardDto {
	private int boardseq;
	private String myid;
	private int boardno;
	private String title;
	private String content;
	private Date regdate;
	private int visitcnt;
	private int goodcnt;
	private int notgoodcnt;
	private String addr;
	
	public boardDto() {
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

	public int getBoardno() {
		return boardno;
	}
	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public int getVisitcnt() {
		return visitcnt;
	}
	public void setVisitcnt(int visitcnt) {
		this.visitcnt = visitcnt;
	}

	public int getGoodcnt() {
		return goodcnt;
	}
	public void setGoodcnt(int goodcnt) {
		this.goodcnt = goodcnt;
	}

	public int getNotgoodcnt() {
		return notgoodcnt;
	}
	public void setNotgoodcnt(int notgoodcnt) {
		this.notgoodcnt = notgoodcnt;
	}

	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
}
