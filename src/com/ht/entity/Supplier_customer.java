package com.ht.entity;
/**
 * 
 * @author 供应商和客户的信息表
 *
 */
public class Supplier_customer {
	private String ID;//主键编号(加密)
	private String BIANHAO;//编号（如：CK00001）
	private String PINYIN;//拼音简码
	private String NAME;//名称
	private String CATEGORIES_ID;//类别(关联supplier_and_customer_categories 加密)
	private String CONTACT;//联系人
	private String USER_ID;//操作员
	private String PHONE;//联系电话
	private String ADDRESS;//地址
	private String ENTRY_TIME;//录入时间
	private String UPDATE_TIME;//最后修改时间
	private String FAX_PHONE;//传真号码
	private String MAIL;//电子邮件
	private String OPEN_ACCOUNT;//开户行
	private String SITE_ADDRESS;//网站地址
	private String BANK;//银行账号
	private String EIN;//企业税号
	private String NOTE;//备注
	private int STATE;//状态(默认0)
	
	
	
	
	public Supplier_customer() {
		
	}




	public Supplier_customer(String iD, String bIANHAO, String pINYIN, String nAME, String cATEGORIES_ID,
			String cONTACT, String uSER_ID, String pHONE, String aDDRESS, String eNTRY_TIME, String uPDATE_TIME,
			String fAX_PHONE, String mAIL, String oPEN_ACCOUNT, String sITE_ADDRESS, String bANK, String eIN,
			String nOTE, int sTATE) {
		ID = iD;
		BIANHAO = bIANHAO;
		PINYIN = pINYIN;
		NAME = nAME;
		CATEGORIES_ID = cATEGORIES_ID;
		CONTACT = cONTACT;
		USER_ID = uSER_ID;
		PHONE = pHONE;
		ADDRESS = aDDRESS;
		ENTRY_TIME = eNTRY_TIME;
		UPDATE_TIME = uPDATE_TIME;
		FAX_PHONE = fAX_PHONE;
		MAIL = mAIL;
		OPEN_ACCOUNT = oPEN_ACCOUNT;
		SITE_ADDRESS = sITE_ADDRESS;
		BANK = bANK;
		EIN = eIN;
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




	public String getNAME() {
		return NAME;
	}




	public void setNAME(String nAME) {
		NAME = nAME;
	}




	public String getCATEGORIES_ID() {
		return CATEGORIES_ID;
	}




	public void setCATEGORIES_ID(String cATEGORIES_ID) {
		CATEGORIES_ID = cATEGORIES_ID;
	}




	public String getCONTACT() {
		return CONTACT;
	}




	public void setCONTACT(String cONTACT) {
		CONTACT = cONTACT;
	}




	public String getUSER_ID() {
		return USER_ID;
	}




	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}




	public String getPHONE() {
		return PHONE;
	}




	public void setPHONE(String pHONE) {
		PHONE = pHONE;
	}




	public String getADDRESS() {
		return ADDRESS;
	}




	public void setADDRESS(String aDDRESS) {
		ADDRESS = aDDRESS;
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




	public String getFAX_PHONE() {
		return FAX_PHONE;
	}




	public void setFAX_PHONE(String fAX_PHONE) {
		FAX_PHONE = fAX_PHONE;
	}




	public String getMAIL() {
		return MAIL;
	}




	public void setMAIL(String mAIL) {
		MAIL = mAIL;
	}




	public String getOPEN_ACCOUNT() {
		return OPEN_ACCOUNT;
	}




	public void setOPEN_ACCOUNT(String oPEN_ACCOUNT) {
		OPEN_ACCOUNT = oPEN_ACCOUNT;
	}




	public String getSITE_ADDRESS() {
		return SITE_ADDRESS;
	}




	public void setSITE_ADDRESS(String sITE_ADDRESS) {
		SITE_ADDRESS = sITE_ADDRESS;
	}




	public String getBANK() {
		return BANK;
	}




	public void setBANK(String bANK) {
		BANK = bANK;
	}




	public String getEIN() {
		return EIN;
	}




	public void setEIN(String eIN) {
		EIN = eIN;
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
		return "Supplier_customer [ID=" + ID + ", BIANHAO=" + BIANHAO + ", PINYIN=" + PINYIN + ", NAME=" + NAME
				+ ", CATEGORIES_ID=" + CATEGORIES_ID + ", CONTACT=" + CONTACT + ", USER_ID=" + USER_ID + ", PHONE="
				+ PHONE + ", ADDRESS=" + ADDRESS + ", ENTRY_TIME=" + ENTRY_TIME + ", UPDATE_TIME=" + UPDATE_TIME
				+ ", FAX_PHONE=" + FAX_PHONE + ", MAIL=" + MAIL + ", OPEN_ACCOUNT=" + OPEN_ACCOUNT + ", SITE_ADDRESS="
				+ SITE_ADDRESS + ", BANK=" + BANK + ", EIN=" + EIN + ", NOTE=" + NOTE + ", STATE=" + STATE + "]";
	}
	
	
	
	
}
