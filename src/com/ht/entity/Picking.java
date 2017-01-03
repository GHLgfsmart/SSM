package com.ht.entity;

/**
 * 拣货表
 * */
public class Picking {
	private String ID; //主键编号
	private String BIANHAO; //单据编号
	private String INSPECTOR; //操作员
	private String STATE; //装车状态  1未装车  2已装车
	private int COUNT; //拣取数量
	private int MATCOUNT; //出库单数
	private String TIME; //拣取时间
	private String NOTE; //备注
	
	public Picking() {}

	public Picking(String iD, String bIANHAO, String iNSPECTOR, String sTATE, int cOUNT, int mATCOUNT, String tIME,
			String nOTE) {
		ID = iD;
		BIANHAO = bIANHAO;
		INSPECTOR = iNSPECTOR;
		STATE = sTATE;
		COUNT = cOUNT;
		MATCOUNT = mATCOUNT;
		TIME = tIME;
		NOTE = nOTE;
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

	public String getINSPECTOR() {
		return INSPECTOR;
	}

	public void setINSPECTOR(String iNSPECTOR) {
		INSPECTOR = iNSPECTOR;
	}

	public String getSTATE() {
		return STATE;
	}

	public void setSTATE(String sTATE) {
		STATE = sTATE;
	}

	public int getCOUNT() {
		return COUNT;
	}

	public void setCOUNT(int cOUNT) {
		COUNT = cOUNT;
	}

	public int getMATCOUNT() {
		return MATCOUNT;
	}

	public void setMATCOUNT(int mATCOUNT) {
		MATCOUNT = mATCOUNT;
	}

	public String getTIME() {
		return TIME;
	}

	public void setTIME(String tIME) {
		TIME = tIME;
	}

	public String getNOTE() {
		return NOTE;
	}

	public void setNOTE(String nOTE) {
		NOTE = nOTE;
	}

	@Override
	public String toString() {
		return "Picking [ID=" + ID + ", BIANHAO=" + BIANHAO + ", INSPECTOR=" + INSPECTOR + ", STATE=" + STATE
				+ ", COUNT=" + COUNT + ", MATCOUNT=" + MATCOUNT + ", TIME=" + TIME + ", NOTE=" + NOTE + "]";
	}
	
	
}
