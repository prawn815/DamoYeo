package com.login.dto;

public class LoginDto {
	
	private String myid;
	private String mypw;
	private String myname;
	private String mygender;
	private int mybirthday;
	private String myaddr;
	private String myphone;
	private String myemail;
	private String myenabled;
	private String myrole;
	
	public LoginDto() {
		
		
	}
	
	

	public LoginDto(String myid) {
		super();
		this.myid = myid;
	}


	public LoginDto(String myid, String mypw, String myname, String mygender, int mybirthday, String myaddr,
			String myphone, String myemail, String myenabled, String myrole) {
		super();
		this.myid = myid;
		this.mypw = mypw;
		this.myname = myname;
		this.mygender = mygender;
		this.mybirthday = mybirthday;
		this.myaddr = myaddr;
		this.myphone = myphone;
		this.myemail = myemail;
		this.myenabled = myenabled;
		this.myrole = myrole;
	}


	public LoginDto(String myid, String mypw, String myname, String mygender,int mybirthday,String myaddr, String myphone, String myemail) {
		super();
		this.myid = myid;
		this.mypw = mypw;
		this.myname = myname;
		this.mygender = mygender;
		this.mybirthday = mybirthday;
		this.myaddr = myaddr;
		this.myphone = myphone;
		this.myemail = myemail;
	}
	
	
	
	public LoginDto(String myname, int mybirthday, String myphone) {
		super();
		this.myname = myname;
		this.mybirthday = mybirthday;
		this.myphone = myphone;
	}
	
	

	
	

	public LoginDto(String mypw, String myaddr, String myphone, String myemail, String myid) {
		super();
		this.mypw = mypw;
		this.myaddr = myaddr;
		this.myphone = myphone;
		this.myemail = myemail;
		this.myid = myid;
	}



	public LoginDto(String myid, String mypw) {
		super();
		this.myid = myid;
		this.mypw = mypw;
	}


	public String getMyid() {
		return myid;
	}

	public void setMyid(String myid) {
		this.myid = myid;
	}

	public String getMypw() {
		return mypw;
	}

	public void setMypw(String mypw) {
		this.mypw = mypw;
	}

	public String getMyname() {
		return myname;
	}

	public void setMyname(String myname) {
		this.myname = myname;
	}
	
	

	public String getMygender() {
		return mygender;
	}



	public void setMygender(String mygender) {
		this.mygender = mygender;
	}

	

	public int getMybirthday() {
		return mybirthday;
	}



	public void setMybirthday(int mybirthday) {
		this.mybirthday = mybirthday;
	}



	public String getMyaddr() {
		return myaddr;
	}

	public void setMyaddr(String myaddr) {
		this.myaddr = myaddr;
	}

	public String getMyphone() {
		return myphone;
	}

	public void setMyphone(String myphone) {
		this.myphone = myphone;
	}

	public String getMyemail() {
		return myemail;
	}

	public void setMyemail(String myemail) {
		this.myemail = myemail;
	}

	public String getEnabled() {
		return myenabled;
	}

	public void setEnabled(String enabled) {
		this.myenabled = enabled;
	}

	public String getMyrole() {
		return myrole;
	}

	public void setMyrole(String myrole) {
		this.myrole = myrole;
	}
	
	

}
