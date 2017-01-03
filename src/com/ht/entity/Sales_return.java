package com.ht.entity;
/**
 * 
 * 退货入库表
 *
 */
public class Sales_return {
	private String ID;//主键编号(加密)
	private String RETREAT_CODE;//退货单号
	private String OUT_CODE;//出库单号
	private String INSPECTOR;//操作员
	private String WAREHOUSE_OUT_ID;//出库仓库（关联warehouse（仓库表））
	private String WAREHOUSE_PUT_ID;//入库仓库（关联warehouse（仓库表））
	private String OUTPUT_TYPE_ID;
	private String MAKETIME;//制单时间
	private int COUNT;//数量
	private String NOTE;//备注
	private int STATE;//状态（0待检验，1已检验，2不合格，3审核成功）
	
	public Sales_return() {
		
	}

	public Sales_return(String iD, String rETREAT_CODE, String oUT_CODE, String iNSPECTOR, String wAREHOUSE_OUT_ID,
			String wAREHOUSE_PUT_ID, String mAKETIME, int cOUNT, String nOTE, int sTATE) {

		ID = iD;
		RETREAT_CODE = rETREAT_CODE;
		OUT_CODE = oUT_CODE;
		INSPECTOR = iNSPECTOR;
		WAREHOUSE_OUT_ID = wAREHOUSE_OUT_ID;
		WAREHOUSE_PUT_ID = wAREHOUSE_PUT_ID;
		MAKETIME = mAKETIME;
		COUNT = cOUNT;
		NOTE = nOTE;
		STATE = sTATE;
	}

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getRETREAT_CODE() {
		return RETREAT_CODE;
	}

	public void setRETREAT_CODE(String rETREAT_CODE) {
		RETREAT_CODE = rETREAT_CODE;
	}

	public String getOUT_CODE() {
		return OUT_CODE;
	}

	public void setOUT_CODE(String oUT_CODE) {
		OUT_CODE = oUT_CODE;
	}

	public String getINSPECTOR() {
		return INSPECTOR;
	}

	public void setINSPECTOR(String iNSPECTOR) {
		INSPECTOR = iNSPECTOR;
	}

	public String getWAREHOUSE_OUT_ID() {
		return WAREHOUSE_OUT_ID;
	}

	public void setWAREHOUSE_OUT_ID(String wAREHOUSE_OUT_ID) {
		WAREHOUSE_OUT_ID = wAREHOUSE_OUT_ID;
	}

	public String getWAREHOUSE_PUT_ID() {
		return WAREHOUSE_PUT_ID;
	}

	public void setWAREHOUSE_PUT_ID(String wAREHOUSE_PUT_ID) {
		WAREHOUSE_PUT_ID = wAREHOUSE_PUT_ID;
	}

	public String getMAKETIME() {
		return MAKETIME;
	}

	public void setMAKETIME(String mAKETIME) {
		MAKETIME = mAKETIME;
	}

	public int getCOUNT() {
		return COUNT;
	}

	public void setCOUNT(int cOUNT) {
		COUNT = cOUNT;
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

	public String getOUTPUT_TYPE_ID() {
		return OUTPUT_TYPE_ID;
	}

	public void setOUTPUT_TYPE_ID(String oUTPUT_TYPE_ID) {
		OUTPUT_TYPE_ID = oUTPUT_TYPE_ID;
	}

	@Override
	public String toString() {
		return "Sales_return [ID=" + ID + ", RETREAT_CODE=" + RETREAT_CODE + ", OUT_CODE=" + OUT_CODE + ", INSPECTOR="
				+ INSPECTOR + ", WAREHOUSE_OUT_ID=" + WAREHOUSE_OUT_ID + ", WAREHOUSE_PUT_ID=" + WAREHOUSE_PUT_ID
				+ ", MAKETIME=" + MAKETIME + ", COUNT=" + COUNT + ", NOTE=" + NOTE + ", STATE=" + STATE + "]";
	}
	
	
}
