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
	private String OUT_PUT_TYPE;// 检测单类型（关联out_put_type（出入库类型表））
	private int QUANTITY;// 出入库总数量
	private int DAMAGEDQTY;// 坏货数量
	private String DAMAGEDREASON;// 坏货原因
	private int SHORTQTY;// 缺货数量
	private int SHORTREASON;// 缺货原因
	private String INSPECTOR;// 检测员

	public Checkout() {

	}

	

	public Checkout(String iD, String sOURCECODE, String tIME, String oUT_PUT_TYPE, int qUANTITY, int dAMAGEDQTY,
			String dAMAGEDREASON, int sHORTQTY, int sHORTREASON, String iNSPECTOR) {
		ID = iD;
		SOURCECODE = sOURCECODE;
		TIME = tIME;
		OUT_PUT_TYPE = oUT_PUT_TYPE;
		QUANTITY = qUANTITY;
		DAMAGEDQTY = dAMAGEDQTY;
		DAMAGEDREASON = dAMAGEDREASON;
		SHORTQTY = sHORTQTY;
		SHORTREASON = sHORTREASON;
		INSPECTOR = iNSPECTOR;
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



	public String getOUT_PUT_TYPE() {
		return OUT_PUT_TYPE;
	}



	public void setOUT_PUT_TYPE(String oUT_PUT_TYPE) {
		OUT_PUT_TYPE = oUT_PUT_TYPE;
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



	public int getSHORTREASON() {
		return SHORTREASON;
	}



	public void setSHORTREASON(int sHORTREASON) {
		SHORTREASON = sHORTREASON;
	}



	public String getINSPECTOR() {
		return INSPECTOR;
	}



	public void setINSPECTOR(String iNSPECTOR) {
		INSPECTOR = iNSPECTOR;
	}



	@Override
	public String toString() {
		return "Checkout [ID=" + ID + ", SOURCECODE=" + SOURCECODE + ", TIME=" + TIME + ", OUT_PUT_TYPE=" + OUT_PUT_TYPE
				+ ", QUANTITY=" + QUANTITY + ", DAMAGEDQTY=" + DAMAGEDQTY + ", DAMAGEDREASON=" + DAMAGEDREASON
				+ ", SHORTQTY=" + SHORTQTY + ", SHORTREASON=" + SHORTREASON + ", INSPECTOR=" + INSPECTOR + "]";
	}

}
