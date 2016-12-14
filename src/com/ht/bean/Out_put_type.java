package com.ht.bean;
/**
 * 
 * @author 出入库类型表
 *
 */
public class Out_put_type {
	private String ID;//主键编号(加密)
	private String NAME;//名称
	private String NOTE;//备注
	
	public Out_put_type() {
		
	}

	public Out_put_type(String iD, String nAME, String nOTE) {
		
		ID = iD;
		NAME = nAME;
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

	public String getNOTE() {
		return NOTE;
	}

	public void setNOTE(String nOTE) {
		NOTE = nOTE;
	}

	@Override
	public String toString() {
		return "Out_put_type [ID=" + ID + ", NAME=" + NAME + ", NOTE=" + NOTE + "]";
	}
	
	
	
	
}
