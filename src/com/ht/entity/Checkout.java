package com.ht.entity;

/**
 * 
 * @author IQC检验表
 *
 */
public class Checkout {
	private String ID;// 主键编号(加密)
	private String SOURCECODE;// 单号
	private String TIME;// 检测时间
	private String OUTPUT_TYPE_ID;// 检测单类型（关联out_put_type（出入库类型表））
	private int QUANTITY;// 出入库总数量
	private int DAMAGEDQTY;// 坏货数量
	private String DAMAGEDREASON;// 坏货原因
	private int SHORTQTY;// 缺货数量
	private String SHORTREASON;// 缺货原因
	private String INSPECTOR;// 检测员
	private int STATE; //状态  1检验合格   2不合格

	public Checkout() {

	}
	public Checkout(String iD, String sOURCECODE, String tIME, String oUT_PUT_TYPE, int qUANTITY, int dAMAGEDQTY,
			String dAMAGEDREASON, int sHORTQTY, String sHORTREASON, String iNSPECTOR, int sTATE) {
		ID = iD;
		SOURCECODE = sOURCECODE;
		TIME = tIME;
		OUTPUT_TYPE_ID = oUT_PUT_TYPE;
		QUANTITY = qUANTITY;
		DAMAGEDQTY = dAMAGEDQTY;
		DAMAGEDREASON = dAMAGEDREASON;
		SHORTQTY = sHORTQTY;
		SHORTREASON = sHORTREASON;
		INSPECTOR = iNSPECTOR;
		STATE = sTATE;
	}

	

	public String getID() {
		return ID;
	}



	public void setID(String iD) {
		ID = iD;
	}



	public String getSOURCECODE() {
		return SOURCECODE;
	}



	public void setSOURCECODE(String sOURCECODE) {
		SOURCECODE = sOURCECODE;
	}



	public String getTIME() {
		return TIME;
	}



	public void setTIME(String tIME) {
		TIME = tIME;
	}
	
	public String getOUTPUT_TYPE_ID() {
		return OUTPUT_TYPE_ID;
	}



	public void setOUTPUT_TYPE_ID(String oUTPUT_TYPE_ID) {
		OUTPUT_TYPE_ID = oUTPUT_TYPE_ID;
	}



	public int getQUANTITY() {
		return QUANTITY;
	}



	public void setQUANTITY(int qUANTITY) {
		QUANTITY = qUANTITY;
	}



	public int getDAMAGEDQTY() {
		return DAMAGEDQTY;
	}



	public void setDAMAGEDQTY(int dAMAGEDQTY) {
		DAMAGEDQTY = dAMAGEDQTY;
	}



	public String getDAMAGEDREASON() {
		return DAMAGEDREASON;
	}



	public void setDAMAGEDREASON(String dAMAGEDREASON) {
		DAMAGEDREASON = dAMAGEDREASON;
	}



	public int getSHORTQTY() {
		return SHORTQTY;
	}



	public void setSHORTQTY(int sHORTQTY) {
		SHORTQTY = sHORTQTY;
	}



	public String getSHORTREASON() {
		return SHORTREASON;
	}



	public void setSHORTREASON(String sHORTREASON) {
		SHORTREASON = sHORTREASON;
	}



	public String getINSPECTOR() {
		return INSPECTOR;
	}



	public void setINSPECTOR(String iNSPECTOR) {
		INSPECTOR = iNSPECTOR;
	}



	public int getSTATE() {
		return STATE;
	}
	public void setSTATE(int sTATE) {
		STATE = sTATE;
	}
	@Override
	public String toString() {
		return "Checkout [ID=" + ID + ", SOURCECODE=" + SOURCECODE + ", TIME=" + TIME + ", OUT_PUT_TYPE=" + OUTPUT_TYPE_ID
				+ ", QUANTITY=" + QUANTITY + ", DAMAGEDQTY=" + DAMAGEDQTY + ", DAMAGEDREASON=" + DAMAGEDREASON
				+ ", SHORTQTY=" + SHORTQTY + ", SHORTREASON=" + SHORTREASON + ", INSPECTOR=" + INSPECTOR + "]";
	}

}
