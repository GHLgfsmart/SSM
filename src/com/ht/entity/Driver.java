package com.ht.entity;

/**
 * 司机实体表
 * @author Bruse
 *
 */
public class Driver {
	
	private String ID;	//编号
	private String NAME;		//司机姓名
	private Integer AGE;	//司机年龄
	private String PHONE;	//电话
	private String EMAIL;	//电子邮件
	
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
	public Integer getAGE() {
		return AGE;
	}
	public void setAGE(Integer aGE) {
		AGE = aGE;
	}
	public String getPHONE() {
		return PHONE;
	}
	public void setPHONE(String pHONE) {
		PHONE = pHONE;
	}
	public String getEMAIL() {
		return EMAIL;
	}
	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}

}
