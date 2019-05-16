package com.about.dto;

public class BikeDto {
	
	private int content_id;
	private String addr_gu;
	private String new_addr;
	private String content_nm;
	
	public BikeDto() {
		super();
	}

	public BikeDto(int content_id, String addr_gu, String new_addr, String content_nm) {
		super();
		this.content_id = content_id;
		this.addr_gu = addr_gu;
		this.new_addr = new_addr;
		this.content_nm = content_nm;
	}

	public int getContent_id() {
		return content_id;
	}

	public void setContent_id(int content_id) {
		this.content_id = content_id;
	}

	public String getAddr_gu() {
		return addr_gu;
	}

	public void setAddr_gu(String addr_gu) {
		this.addr_gu = addr_gu;
	}

	public String getNew_addr() {
		return new_addr;
	}

	public void setNew_addr(String new_addr) {
		this.new_addr = new_addr;
	}

	public String getContent_nm() {
		return content_nm;
	}

	public void setContent_nm(String content_nm) {
		this.content_nm = content_nm;
	}
	
	
}
