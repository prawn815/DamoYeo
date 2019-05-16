package com.product.dto;

public class ProductDto {
	
	private int pid;
	private String pname;
	private int pprice;
	private String description;
	private String pcompany;
	public ProductDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ProductDto(int pid, String pname, int pprice, String description, String pcompany) {
		super();
		this.pid = pid;
		this.pname = pname;
		this.pprice = pprice;
		this.description = description;
		this.pcompany = pcompany;
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
	public int getPprice() {
		return pprice;
	}
	public void setPprice(int pprice) {
		this.pprice = pprice;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getPcompany() {
		return pcompany;
	}
	public void setPcompany(String pcompany) {
		this.pcompany = pcompany;
	}
	
	

}
