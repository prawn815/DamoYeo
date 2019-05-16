package com.cal.dto;

public class CalorieDto {

	private int foodno;
	private String foodgroup;
	private String foodname;
	private int servingsize;
	private double foodcalorie;
	
	private int exno;
	private String exname;
	private int common;
	private double consumed_calorie;
	
	public CalorieDto() {
		
	}

	public CalorieDto(int foodno, String foodgroup, String foodname, int servingsize, double foodcalorie) {
		super();
		this.foodno = foodno;
		this.foodgroup = foodgroup;
		this.foodname = foodname;
		this.servingsize = servingsize;
		this.foodcalorie = foodcalorie;
	}
	
	

	public int getExno() {
		return exno;
	}

	public void setExno(int exno) {
		this.exno = exno;
	}

	public String getExname() {
		return exname;
	}

	public void setExname(String exname) {
		this.exname = exname;
	}

	public int getCommon() {
		return common;
	}

	public void setCommon(int common) {
		this.common = common;
	}

	public double getconsumed_calorie() {
		return consumed_calorie;
	}

	public void setconsumed_calorie(double consumed_calorie) {
		this.consumed_calorie = consumed_calorie;
	}

	public CalorieDto(int exno, String exname, int common, double consumed_calorie) {
		super();
		this.exno = exno;
		this.exname = exname;
		this.common = common;
		this.consumed_calorie = consumed_calorie;
	}

	public int getFoodno() {
		return foodno;
	}

	public void setFoodno(int foodno) {
		this.foodno = foodno;
	}

	public String getFoodgroup() {
		return foodgroup;
	}

	public void setFoodgroup(String foodgroup) {
		this.foodgroup = foodgroup;
	}

	public String getFoodname() {
		return foodname;
	}

	public void setFoodname(String foodname) {
		this.foodname = foodname;
	}

	public int getServingsize() {
		return servingsize;
	}

	public void setServingsize(int servingsize) {
		this.servingsize = servingsize;
	}

	public double getFoodcalorie() {
		return foodcalorie;
	}

	public void setFoodcalorie(double foodcalorie) {
		this.foodcalorie = foodcalorie;
	}
	
	
	
	
}
