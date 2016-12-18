package com.ht.entity;
/**
 * 
 * @author 物资信息表
 *
 */
public class Materials_information {
	private String ID;//主键编号(加密)
	private String BIANHAO;//编号（如：CK00001）
	private String PINYIN;//拼音简码
	private String BAR_CODE;//条形码
	private String NAME;//产品名称
	private String CUS_ID;//关联supplier_and_customer（供应商和客户的信息表）
	private int COUNT;//商品数量
	private String UNIT;//单位(件)
	private String ENTRY_TIME;//录用时间
	private String UPDATE_TIME;//最后修改时间
	private String operator;//操作员
	private String NOTE;//备注
	private int STATE;//状态（默认0）0未入库，1已入库,2已出库
	
	
	
	public Materials_information() {
		
	}



	public Materials_information(String iD, String bIANHAO, String pINYIN, String bAR_CODE, String nAME, String cUS_ID,
			int cOUNT, String uNIT, String eNTRY_TIME, String uPDATE_TIME, String operator, String nOTE, int sTATE) {
		ID = iD;
		BIANHAO = bIANHAO;
		PINYIN = pINYIN;
		BAR_CODE = bAR_CODE;
		NAME = nAME;
		CUS_ID = cUS_ID;
		COUNT = cOUNT;
		UNIT = uNIT;
		ENTRY_TIME = eNTRY_TIME;
		UPDATE_TIME = uPDATE_TIME;
		this.operator = operator;
		NOTE = nOTE;
		STATE = sTATE;
	}



	public String getID() {
		return ID;
	}



	public void setID(String iD) {
		ID = iD;
	}



	public String getBIANHAO() {
		return BIANHAO;
	}



	public void setBIANHAO(String bIANHAO) {
		BIANHAO = bIANHAO;
	}



	public String getPINYIN() {
		return PINYIN;
	}



	public void setPINYIN(String pINYIN) {
		PINYIN = pINYIN;
	}



	public String getBAR_CODE() {
		return BAR_CODE;
	}



	public void setBAR_CODE(String bAR_CODE) {
		BAR_CODE = bAR_CODE;
	}



	public String getNAME() {
		return NAME;
	}



	public void setNAME(String nAME) {
		NAME = nAME;
	}



	public String getCUS_ID() {
		return CUS_ID;
	}



	public void setCUS_ID(String cUS_ID) {
		CUS_ID = cUS_ID;
	}



	public int getCOUNT() {
		return COUNT;
	}



	public void setCOUNT(int cOUNT) {
		COUNT = cOUNT;
	}



	public String getUNIT() {
		return UNIT;
	}



	public void setUNIT(String uNIT) {
		UNIT = uNIT;
	}



	public String getENTRY_TIME() {
		return ENTRY_TIME;
	}



	public void setENTRY_TIME(String eNTRY_TIME) {
		ENTRY_TIME = eNTRY_TIME;
	}



	public String getUPDATE_TIME() {
		return UPDATE_TIME;
	}



	public void setUPDATE_TIME(String uPDATE_TIME) {
		UPDATE_TIME = uPDATE_TIME;
	}



	public String getOperator() {
		return operator;
	}



	public void setOperator(String operator) {
		this.operator = operator;
	}



	public String getNOTE() {
		return NOTE;
	}



	public void setNOTE(String nOTE) {
		NOTE = nOTE;
	}



	public int getSTATE() {
		return STATE;
	}



	public void setSTATE(int sTATE) {
		STATE = sTATE;
	}



	@Override
	public String toString() {
		return "Materials_information [ID=" + ID + ", BIANHAO=" + BIANHAO + ", PINYIN=" + PINYIN + ", BAR_CODE="
				+ BAR_CODE + ", NAME=" + NAME + ", CUS_ID=" + CUS_ID + ", COUNT=" + COUNT + ", UNIT=" + UNIT
				+ ", ENTRY_TIME=" + ENTRY_TIME + ", UPDATE_TIME=" + UPDATE_TIME + ", operator=" + operator + ", NOTE="
				+ NOTE + ", STATE=" + STATE + "]";
	}

	
	
	
}