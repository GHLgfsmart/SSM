package com.ht.entity;
/**
 * 
 * @author 出入库类型表
 *
 */
public class Output_type {
	private String ID;//主键编号(加密)
	private String OPTNAME;//名称
	private String NOTE;//备注
	
	public Output_type() {
		
	}


	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}


	public String getOPTNAME() {
		return OPTNAME;
	}


	public void setOPTNAME(String oPTNAME) {
		OPTNAME = oPTNAME;
	}


	public String getNOTE() {
		return NOTE;
	}

	public void setNOTE(String nOTE) {
		NOTE = nOTE;
	}

	@Override
	public String toString() {
		return "Out_put_type [ID=" + ID + ", NAME=" + OPTNAME + ", NOTE=" + NOTE + "]";
	}
	
	
	
	
}
