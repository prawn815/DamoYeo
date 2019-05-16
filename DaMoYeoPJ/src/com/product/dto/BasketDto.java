package com.product.dto;

public class BasketDto {
	private int basket_seq;
	private String myid;
	private String pname;
	private int pid;
	private int price;
	private int amount;
	public BasketDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BasketDto(int basket_seq, String myid, String pname, int pid, int price, int amount) {
		super();
		this.basket_seq = basket_seq;
		this.myid = myid;
		this.pname = pname;
		this.pid = pid;
		this.price = price;
		this.amount = amount;
	}
	public int getBasket_seq() {
		return basket_seq;
	}
	public void setBasket_seq(int basket_seq) {
		this.basket_seq = basket_seq;
	}
	public String getMyid() {
		return myid;
	}
	public void setMyid(String myid) {
		this.myid = myid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	
	
}
