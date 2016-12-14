package com.ht.bean;

import java.math.BigDecimal;

/**
 * 
 * @author 调拨表
 *
 */
public class Drawing {
	private String ID;//主键编号(加密)
	private String BIANHAO;//编号（如：CK00001）
	private String BUSINESS_TIME;//业务日期		
	private String NGSHUO_EMP_ID;//经手人(关联EMP 加密)		
	private String AWING_INST;//调拔说明		
	private int STATE;//审核状态（未审核 0 通过 1 不通过2 默认未审核 0）		
	private String PRODUCT_ID;//产品（关联product（产品信息表））		
	private String CHU_WAREHOUSE_ID;//出仓库（关联warehouse（仓库表））		
	private String RU_WAREHOUSE_ID;//入仓库（关联warehouse（仓库表））		
	private String OPERATOR_EMP_ID;//操作员(关联EMP 加密)		
	private String SHENHE_EMP_ID;//审核人（关联EMP 加密）		
	private String ENTRY_TIME;//录入时间		
	private String UPDATE_TIME;//最后修改时间		
	private BigDecimal MONEY;//单据金额		
	private int NUMBER_OF;//单据数量		
	private String ZHAIYAO_INST;//摘要说明(目的、方法、结果(应给出主要数据)及结论四部分,各部分冠以相应的标题)
	
	public Drawing() {
	
	}

	public Drawing(String iD, String bIANHAO, String bUSINESS_TIME, String nGSHUO_EMP_ID, String aWING_INST, int sTATE,
			String pRODUCT_ID, String cHU_WAREHOUSE_ID, String rU_WAREHOUSE_ID, String oPERATOR_EMP_ID,
			String sHENHE_EMP_ID, String eNTRY_TIME, String uPDATE_TIME, BigDecimal mONEY, int nUMBER_OF,
			String zHAIYAO_INST) {
		ID = iD;
		BIANHAO = bIANHAO;
		BUSINESS_TIME = bUSINESS_TIME;
		NGSHUO_EMP_ID = nGSHUO_EMP_ID;
		AWING_INST = aWING_INST;
		STATE = sTATE;
		PRODUCT_ID = pRODUCT_ID;
		CHU_WAREHOUSE_ID = cHU_WAREHOUSE_ID;
		RU_WAREHOUSE_ID = rU_WAREHOUSE_ID;
		OPERATOR_EMP_ID = oPERATOR_EMP_ID;
		SHENHE_EMP_ID = sHENHE_EMP_ID;
		ENTRY_TIME = eNTRY_TIME;
		UPDATE_TIME = uPDATE_TIME;
		MONEY = mONEY;
		NUMBER_OF = nUMBER_OF;
		ZHAIYAO_INST = zHAIYAO_INST;
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

	public String getNGSHUO_EMP_ID() {
		return NGSHUO_EMP_ID;
	}

	public void setNGSHUO_EMP_ID(String nGSHUO_EMP_ID) {
		NGSHUO_EMP_ID = nGSHUO_EMP_ID;
	}

	public String getAWING_INST() {
		return AWING_INST;
	}

	public void setAWING_INST(String aWING_INST) {
		AWING_INST = aWING_INST;
	}

	public int getSTATE() {
		return STATE;
	}

	public void setSTATE(int sTATE) {
		STATE = sTATE;
	}

	public String getPRODUCT_ID() {
		return PRODUCT_ID;
	}

	public void setPRODUCT_ID(String pRODUCT_ID) {
		PRODUCT_ID = pRODUCT_ID;
	}

	public String getCHU_WAREHOUSE_ID() {
		return CHU_WAREHOUSE_ID;
	}

	public void setCHU_WAREHOUSE_ID(String cHU_WAREHOUSE_ID) {
		CHU_WAREHOUSE_ID = cHU_WAREHOUSE_ID;
	}

	public String getRU_WAREHOUSE_ID() {
		return RU_WAREHOUSE_ID;
	}

	public void setRU_WAREHOUSE_ID(String rU_WAREHOUSE_ID) {
		RU_WAREHOUSE_ID = rU_WAREHOUSE_ID;
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

	public String getZHAIYAO_INST() {
		return ZHAIYAO_INST;
	}

	public void setZHAIYAO_INST(String zHAIYAO_INST) {
		ZHAIYAO_INST = zHAIYAO_INST;
	}

	@Override
	public String toString() {
		return "Drawing [ID=" + ID + ", BIANHAO=" + BIANHAO + ", BUSINESS_TIME=" + BUSINESS_TIME + ", NGSHUO_EMP_ID="
				+ NGSHUO_EMP_ID + ", AWING_INST=" + AWING_INST + ", STATE=" + STATE + ", PRODUCT_ID=" + PRODUCT_ID
				+ ", CHU_WAREHOUSE_ID=" + CHU_WAREHOUSE_ID + ", RU_WAREHOUSE_ID=" + RU_WAREHOUSE_ID
				+ ", OPERATOR_EMP_ID=" + OPERATOR_EMP_ID + ", SHENHE_EMP_ID=" + SHENHE_EMP_ID + ", ENTRY_TIME="
				+ ENTRY_TIME + ", UPDATE_TIME=" + UPDATE_TIME + ", MONEY=" + MONEY + ", NUMBER_OF=" + NUMBER_OF
				+ ", ZHAIYAO_INST=" + ZHAIYAO_INST + "]";
	}
	
	
	

}
