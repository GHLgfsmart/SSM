package com.ht.bean;

import java.math.BigDecimal;
/**
 * 
 * @author 出入库表
 *
 */
public class Output_storage {
	private String ID;//主键编号(加密)
	private String BIANHAO;//编号（如：CK00001）
	private String BUSINESS_TIME;//业务日期
	private String PRODUCT_ID;//产品（关联product（产品信息表））
	private String WAREHOUSE_ID;//仓库（关联warehouse（仓库表））
	private String OUT_PUT_TYPE_ID;//出入库类型（关联out_put_type（出入库类型表））
	private int STATE;//审核状态（未审核 0 IQC审核通过 1 不通过2 分配3 主管审核4 默认未审核 0）
	private BigDecimal MONEY;//单据金额
	private int NUMBER_OF;//单据数量
	private String OPERATOR_EMP_ID;//操作员(关联EMP 加密)
	private String SHENHE_EMP_ID;//审核人（关联EMP 加密）
	private String ENTRY_TIME;//录入时间
	private String UPDATE_TIME;//最后修改时间
	private String DANHAO;//原始单号
	private String NOTE;//备注
	
	
	
	public Output_storage() {
		
	}



	public Output_storage(String iD, String bIANHAO, String bUSINESS_TIME, String pRODUCT_ID, String wAREHOUSE_ID,
			String oUT_PUT_TYPE_ID, int sTATE, BigDecimal mONEY, int nUMBER_OF, String oPERATOR_EMP_ID,
			String sHENHE_EMP_ID, String eNTRY_TIME, String uPDATE_TIME, String dANHAO, String nOTE) {
		ID = iD;
		BIANHAO = bIANHAO;
		BUSINESS_TIME = bUSINESS_TIME;
		PRODUCT_ID = pRODUCT_ID;
		WAREHOUSE_ID = wAREHOUSE_ID;
		OUT_PUT_TYPE_ID = oUT_PUT_TYPE_ID;
		STATE = sTATE;
		MONEY = mONEY;
		NUMBER_OF = nUMBER_OF;
		OPERATOR_EMP_ID = oPERATOR_EMP_ID;
		SHENHE_EMP_ID = sHENHE_EMP_ID;
		ENTRY_TIME = eNTRY_TIME;
		UPDATE_TIME = uPDATE_TIME;
		DANHAO = dANHAO;
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



	public String getBUSINESS_TIME() {
		return BUSINESS_TIME;
	}



	public void setBUSINESS_TIME(String bUSINESS_TIME) {
		BUSINESS_TIME = bUSINESS_TIME;
	}



	public String getPRODUCT_ID() {
		return PRODUCT_ID;
	}



	public void setPRODUCT_ID(String pRODUCT_ID) {
		PRODUCT_ID = pRODUCT_ID;
	}



	public String getWAREHOUSE_ID() {
		return WAREHOUSE_ID;
	}



	public void setWAREHOUSE_ID(String wAREHOUSE_ID) {
		WAREHOUSE_ID = wAREHOUSE_ID;
	}



	public String getOUT_PUT_TYPE_ID() {
		return OUT_PUT_TYPE_ID;
	}



	public void setOUT_PUT_TYPE_ID(String oUT_PUT_TYPE_ID) {
		OUT_PUT_TYPE_ID = oUT_PUT_TYPE_ID;
	}



	public int getSTATE() {
		return STATE;
	}



	public void setSTATE(int sTATE) {
		STATE = sTATE;
	}



	public BigDecimal getMONEY() {
		return MONEY;
	}



	public void setMONEY(BigDecimal mONEY) {
		MONEY = mONEY;
	}



	public int getNUMBER_OF() {
		return NUMBER_OF;
	}



	public void setNUMBER_OF(int nUMBER_OF) {
		NUMBER_OF = nUMBER_OF;
	}



	public String getOPERATOR_EMP_ID() {
		return OPERATOR_EMP_ID;
	}



	public void setOPERATOR_EMP_ID(String oPERATOR_EMP_ID) {
		OPERATOR_EMP_ID = oPERATOR_EMP_ID;
	}



	public String getSHENHE_EMP_ID() {
		return SHENHE_EMP_ID;
	}



	public void setSHENHE_EMP_ID(String sHENHE_EMP_ID) {
		SHENHE_EMP_ID = sHENHE_EMP_ID;
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



	public String getDANHAO() {
		return DANHAO;
	}



	public void setDANHAO(String dANHAO) {
		DANHAO = dANHAO;
	}



	public String getNOTE() {
		return NOTE;
	}



	public void setNOTE(String nOTE) {
		NOTE = nOTE;
	}



	@Override
	public String toString() {
		return "Output_storage [ID=" + ID + ", BIANHAO=" + BIANHAO + ", BUSINESS_TIME=" + BUSINESS_TIME
				+ ", PRODUCT_ID=" + PRODUCT_ID + ", WAREHOUSE_ID=" + WAREHOUSE_ID + ", OUT_PUT_TYPE_ID="
				+ OUT_PUT_TYPE_ID + ", STATE=" + STATE + ", MONEY=" + MONEY + ", NUMBER_OF=" + NUMBER_OF
				+ ", OPERATOR_EMP_ID=" + OPERATOR_EMP_ID + ", SHENHE_EMP_ID=" + SHENHE_EMP_ID + ", ENTRY_TIME="
				+ ENTRY_TIME + ", UPDATE_TIME=" + UPDATE_TIME + ", DANHAO=" + DANHAO + ", NOTE=" + NOTE + "]";
	}
	
	
}
