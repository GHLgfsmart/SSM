package com.ht.entity;

public class Msg {
	private String MSGID;//主键
	private String MSGTITLE;//标题
	private String MSGCON;//内容
	private int MSGSTATUS;//状态
	private String USER_ID;//关联USER表
	private String MSGTIME;//发布时间
	private Page page;			//分页对象
	private User user; //用户对象
	public String getMSGID() {
		return MSGID;
	}
	public void setMSGID(String mSGID) {
		MSGID = mSGID;
	}
	public String getMSGTITLE() {
		return MSGTITLE;
	}
	public void setMSGTITLE(String mSGTITLE) {
		MSGTITLE = mSGTITLE;
	}
	public String getMSGCON() {
		return MSGCON;
	}
	public void setMSGCON(String mSGCON) {
		MSGCON = mSGCON;
	}
	public int getMSGSTATUS() {
		return MSGSTATUS;
	}
	public void setMSGSTATUS(int mSGSTATUS) {
		MSGSTATUS = mSGSTATUS;
	}
	public String getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}
	public String getMSGTIME() {
		return MSGTIME;
	}
	public void setMSGTIME(String mSGTIME) {
		MSGTIME = mSGTIME;
	}
	public Page getPage() {
		if(page==null)
			page = new Page();
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
}
