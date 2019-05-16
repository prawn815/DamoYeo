package com.cal.dto;

public class InbodyDto {

	private String myid;
	private double weight;
	private double height;
	private double bmi;
	private double metabolism;
	public InbodyDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public InbodyDto(String myid, double weight, double height, double bmi, double metabolism) {
		super();
		this.myid = myid;
		this.weight = weight;
		this.height = height;
		this.bmi = bmi;
		this.metabolism = metabolism;
	}

	public String getMyid() {
		return myid;
	}
	public void setMyid(String myid) {
		this.myid = myid;
	}
	public double getWeight() {
		return weight;
	}
	public void setWeight(double weight) {
		this.weight = weight;
	}
	public double getHeight() {
		return height;
	}
	public void setHeight(double height) {
		this.height = height;
	}
	public double getBmi() {
		return bmi;
	}
	public void setBmi(double bmi) {
		this.bmi = bmi;
	}
	public double getMetabolism() {
		return metabolism;
	}
	public void setMetabolism(double metabolism) {
		this.metabolism = metabolism;
	}
	
	
	
}
