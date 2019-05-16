package com.post.dto;

import java.util.Date;

public class ansDto {
	private int boardseq;
	private String myid;
	private int ansno;
	private int grouno;
	private int groupsq;
	private int ttab;
	private String anscontent;
	private Date ansregdate;
	
	public ansDto() {
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

	public int getAnsno() {
		return ansno;
	}
	public void setAnsno(int ansno) {
		this.ansno = ansno;
	}
	
	public int getGrouno() {
		return grouno;
	}
	public void setGrouno(int grouno) {
		this.grouno = grouno;
	}

	public int getGroupsq() {
		return groupsq;
	}
	public void setGroupsq(int groupsq) {
		this.groupsq = groupsq;
	}

	public int getTtab() {
		return ttab;
	}
	public void setTtab(int ttab) {
		this.ttab = ttab;
	}

	public String getAnscontent() {
		return anscontent;
	}
	public void setAnscontent(String anscontent) {
		this.anscontent = anscontent;
	}

	public Date getAnsregdate() {
		return ansregdate;
	}
	public void setAnsregdate(Date ansregdate) {
		this.ansregdate = ansregdate;
	}
}
