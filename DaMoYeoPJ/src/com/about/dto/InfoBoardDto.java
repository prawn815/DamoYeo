package com.about.dto;

public class InfoBoardDto {
	
	private int myno;
	private int boardno;
	private String myname;
	private String mytitle;
	private String mycontent;
	private String addr;
	
	public InfoBoardDto() {
		
	}

	public InfoBoardDto(int boardno, String myname, String mytitle, String mycontent) {
		super();
		this.boardno = boardno;
		this.myname = myname;
		this.mytitle = mytitle;
		this.mycontent = mycontent;
	}
	


	public InfoBoardDto(int myno, String mytitle, String mycontent) {
		super();
		this.myno = myno;
		this.mytitle = mytitle;
		this.mycontent = mycontent;
	}

	public int getMyno() {
		return myno;
	}

	public void setMyno(int myno) {
		this.myno = myno;
	}

	public int getBoardno() {
		return boardno;
	}

	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}

	public String getMyname() {
		return myname;
	}

	public void setMyname(String myname) {
		this.myname = myname;
	}

	public String getMytitle() {
		return mytitle;
	}

	public void setMytitle(String mytitle) {
		this.mytitle = mytitle;
	}

	public String getMycontent() {
		return mycontent;
	}

	public void setMycontent(String mycontent) {
		this.mycontent = mycontent;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	
}
