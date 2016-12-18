package com.ht.entity;

/**
 * 
 * @author仓库表
 *
 */
public class Warehouse {
	private String ID;//主键编号(加密)
	private Page page;
	private String NAME;// 仓库名称
	private String USER_ID;//仓库管理员（关联 ERP 加密）
	private String SIZE;// 仓库大小（单位m2）
	private int UPPER_LIMIT;// 仓库上限
	private int LOWER_LIMIT;// 仓库下限
	private int PRACTICAl;// 仓库实际库存
	private String ADDRESS;// 仓库地址
	private String ENTRY_TIME;// 录入时间
	private String UPDATE_TIME;// 最好登录时间
	private String NOTE;// 备注
	private int STATE;// 状态

	public Warehouse() {

	}

	public Warehouse(String iD, Page page, String nAME, String uSER_ID, String sIZE, int uPPER_LIMIT, int lOWER_LIMIT,
			int pRACTICAl, String aDDRESS, String eNTRY_TIME, String uPDATE_TIME, String nOTE, int sTATE) {
		ID = iD;
		this.page = page;
		NAME = nAME;
		USER_ID = uSER_ID;
		SIZE = sIZE;
		UPPER_LIMIT = uPPER_LIMIT;
		LOWER_LIMIT = lOWER_LIMIT;
		PRACTICAl = pRACTICAl;
		ADDRESS = aDDRESS;
		ENTRY_TIME = eNTRY_TIME;
		UPDATE_TIME = uPDATE_TIME;
		NOTE = nOTE;
		STATE = sTATE;
	}

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public String getNAME() {
		return NAME;
	}

	public void setNAME(String nAME) {
		NAME = nAME;
	}

	public String getUSER_ID() {
		return USER_ID;
	}

	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}

	public String getSIZE() {
		return SIZE;
	}

	public void setSIZE(String sIZE) {
		SIZE = sIZE;
	}

	public int getUPPER_LIMIT() {
		return UPPER_LIMIT;
	}

	public void setUPPER_LIMIT(int uPPER_LIMIT) {
		UPPER_LIMIT = uPPER_LIMIT;
	}

	public int getLOWER_LIMIT() {
		return LOWER_LIMIT;
	}

	public void setLOWER_LIMIT(int lOWER_LIMIT) {
		LOWER_LIMIT = lOWER_LIMIT;
	}

	public int getPRACTICAl() {
		return PRACTICAl;
	}

	public void setPRACTICAl(int pRACTICAl) {
		PRACTICAl = pRACTICAl;
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
		return "Warehouse [ID=" + ID + ", page=" + page + ", NAME=" + NAME + ", USER_ID=" + USER_ID + ", SIZE=" + SIZE
				+ ", UPPER_LIMIT=" + UPPER_LIMIT + ", LOWER_LIMIT=" + LOWER_LIMIT + ", PRACTICAl=" + PRACTICAl
				+ ", ADDRESS=" + ADDRESS + ", ENTRY_TIME=" + ENTRY_TIME + ", UPDATE_TIME=" + UPDATE_TIME + ", NOTE="
				+ NOTE + ", STATE=" + STATE + "]";
	}
	
	
}
