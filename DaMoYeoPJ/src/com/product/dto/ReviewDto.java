package com.product.dto;

public class ReviewDto {
	private int r_no;
	private int pid;
	private int r_star;
	private String r_writer;
	private String r_title;
	private String r_content;
	private String r_img;
	private String r_date;
	public ReviewDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReviewDto(int r_no, int pid, int r_star, String r_writer, String r_title, String r_content, String r_img,
			String r_date) {
		super();
		this.r_no = r_no;
		this.pid = pid;
		this.r_star = r_star;
		this.r_writer = r_writer;
		this.r_title = r_title;
		this.r_content = r_content;
		this.r_img = r_img;
		this.r_date = r_date;
	}
	public int getR_no() {
		return r_no;
	}
	public void setR_no(int r_no) {
		this.r_no = r_no;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getR_star() {
		return r_star;
	}
	public void setR_star(int r_star) {
		this.r_star = r_star;
	}
	public String getR_writer() {
		return r_writer;
	}
	public void setR_writer(String r_writer) {
		this.r_writer = r_writer;
	}
	public String getR_title() {
		return r_title;
	}
	public void setR_title(String r_title) {
		this.r_title = r_title;
	}
	public String getR_content() {
		return r_content;
	}
	public void setR_content(String r_content) {
		this.r_content = r_content;
	}
	public String getR_img() {
		return r_img;
	}
	public void setR_img(String r_img) {
		this.r_img = r_img;
	}
	public String getR_date() {
		return r_date;
	}
	public void setR_date(String r_date) {
		this.r_date = r_date;
	}
	
}
