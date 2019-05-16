package com.product.dto;

import java.util.Date;

public class SaleorderDto {
	
	private int order_id;
	private int pid;
	private String pname;
	private String myid;
	private String addr;
	private int amount;
	private int price;
	private Date order_date;
	private int order_state;
	public SaleorderDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public SaleorderDto(int order_id, int pid, String pname, String myid, String addr, int amount, int price, Date order_date, int order_state) {
		super();
		this.order_id = order_id;
		this.pid = pid;
		this.pname = pname;
		this.myid = myid;
		this.addr = addr;
		this.amount = amount;
		this.price = price;
		this.order_date = order_date;
		this.order_state = order_state;
	}
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getMyid() {
		return myid;
	}
	public void setMyid(String myid) {
		this.myid = myid;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public int getOrder_state() {
		return order_state;
	}
	public void setOrder_state(int order_state) {
		this.order_state = order_state;
	}
	
	
	
	

}
