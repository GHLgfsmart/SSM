package com.ht.entity;
/**
 * 
 * @author 供应商和客户的分类表
 *
 */
public class Customer_categories {
	private String ID;//主键编号(加密)
	private String NAME;//名称(注意 后面一定要加供应商或者客户)
	private String MYID;//主编号
	private String UID;//上级编号
	private String NOTE;//备注
	
	
	
	public Customer_categories() {
	
	}



	public Customer_categories(String iD, String nAME, String mYID, String uID, String nOTE) {
		ID = iD;
		NAME = nAME;
		MYID = mYID;
		UID = uID;
		NOTE = nOTE;
	}



	public String getID() {
		return ID;
	}



	public void setID(String iD) {
		ID = iD;
	}



	public String getNAME() {
		return NAME;
	}



	public void setNAME(String nAME) {
		NAME = nAME;
	}



	public String getMYID() {
		return MYID;
	}



	public void setMYID(String mYID) {
		MYID = mYID;
	}



	public String getUID() {
		return UID;
	}



	public void setUID(String uID) {
		UID = uID;
	}



	public String getNOTE() {
		return NOTE;
	}



	public void setNOTE(String nOTE) {
		NOTE = nOTE;
	}



	@Override
	public String toString() {
		return "Sacc [ID=" + ID + ", NAME=" + NAME + ", MYID=" + MYID + ", UID=" + UID + ", NOTE=" + NOTE + "]";
	}
	
	
}
