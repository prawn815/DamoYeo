package com.cal.dto;

import java.util.Date;

public class DiaryDto {

	private String mdate;
	private String myid;
	private double totalcal;
	private double totalmeta;
	private Date regdate;
	
	public DiaryDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public DiaryDto(String mdate, String myid, double totalcal, double totalmeta, Date regdate) {
		super();
		this.mdate = mdate;
		this.myid = myid;
		this.totalcal = totalcal;
		this.totalmeta = totalmeta;
		this.regdate = regdate;
	}

	public String getMdate() {
		return mdate;
	}

	public void setMdate(String mdate) {
		this.mdate = mdate;
	}

	public String getMyid() {
		return myid;
	}

	public void setMyid(String myid) {
		this.myid = myid;
	}

	public double getTotalcal() {
		return totalcal;
	}

	public void setTotalcal(double totalcal) {
		this.totalcal = totalcal;
	}

	public double getTotalmeta() {
		return totalmeta;
	}

	public void setTotalmeta(double totalmeta) {
		this.totalmeta = totalmeta;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	
	
}
