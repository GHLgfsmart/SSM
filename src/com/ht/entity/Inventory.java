package com.ht.entity;
/**
 * 
 * @author 盘点表
 *
 */
public class Inventory {
	private String ID;//主键编号(加密)
	private String BIANHAO;//编号(如:CK00001)
	private String BUSINESS_TIME;//业务日期
	private String JINGSHUO_EMP_ID;//经手人(关联EMP 加密)
	private String MATERIALS_ID;//产品（关联product（产品信息表））
	private String WAREHOUSE_ID;//仓库（关联warehouse（仓库表））
	private int STATE;//审核状态（未审核 0 通过 1 不通过2 默认未审核 0）
	private String INSPECTOR;//操作员
	private String ADUDITOR;//审核人
	private String ENTRY_TIME;//录入时间
	private String UPDATE_TIME;//最后修改时间
	private String PANDIAN_INST;//盘点说明
	private String ZHAIYAO_INST;//摘要说明(目的、方法、结果(应给出主要数据)及结论四部分,各部分冠以相应的标题)
	private int PRACTICAL;//实际库存
	private int DECREASE_COUNT;//损益合计
	private String NOTE;//备注
	
	public Inventory() {
		
	}

	public Inventory(String iD, String bIANHAO, String bUSINESS_TIME, String jINGSHUO_EMP_ID, String mATERIALS_ID,
			String wAREHOUSE_ID, int sTATE, String iNSPECTOR, String aDUDITOR, String eNTRY_TIME, String uPDATE_TIME,
			String pANDIAN_INST, String zHAIYAO_INST, int pRACTICAL, int dECREASE_COUNT, String nOTE) {
		ID = iD;
		BIANHAO = bIANHAO;
		BUSINESS_TIME = bUSINESS_TIME;
		JINGSHUO_EMP_ID = jINGSHUO_EMP_ID;
		MATERIALS_ID = mATERIALS_ID;
		WAREHOUSE_ID = wAREHOUSE_ID;
		STATE = sTATE;
		INSPECTOR = iNSPECTOR;
		ADUDITOR = aDUDITOR;
		ENTRY_TIME = eNTRY_TIME;
		UPDATE_TIME = uPDATE_TIME;
		PANDIAN_INST = pANDIAN_INST;
		ZHAIYAO_INST = zHAIYAO_INST;
		PRACTICAL = pRACTICAL;
		DECREASE_COUNT = dECREASE_COUNT;
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

	public String getJINGSHUO_EMP_ID() {
		return JINGSHUO_EMP_ID;
	}

	public void setJINGSHUO_EMP_ID(String jINGSHUO_EMP_ID) {
		JINGSHUO_EMP_ID = jINGSHUO_EMP_ID;
	}

	public String getMATERIALS_ID() {
		return MATERIALS_ID;
	}

	public void setMATERIALS_ID(String mATERIALS_ID) {
		MATERIALS_ID = mATERIALS_ID;
	}

	public String getWAREHOUSE_ID() {
		return WAREHOUSE_ID;
	}

	public void setWAREHOUSE_ID(String wAREHOUSE_ID) {
		WAREHOUSE_ID = wAREHOUSE_ID;
	}

	public int getSTATE() {
		return STATE;
	}

	public void setSTATE(int sTATE) {
		STATE = sTATE;
	}

	public String getINSPECTOR() {
		return INSPECTOR;
	}

	public void setINSPECTOR(String iNSPECTOR) {
		INSPECTOR = iNSPECTOR;
	}

	public String getADUDITOR() {
		return ADUDITOR;
	}

	public void setADUDITOR(String aDUDITOR) {
		ADUDITOR = aDUDITOR;
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

	public String getPANDIAN_INST() {
		return PANDIAN_INST;
	}

	public void setPANDIAN_INST(String pANDIAN_INST) {
		PANDIAN_INST = pANDIAN_INST;
	}

	public String getZHAIYAO_INST() {
		return ZHAIYAO_INST;
	}

	public void setZHAIYAO_INST(String zHAIYAO_INST) {
		ZHAIYAO_INST = zHAIYAO_INST;
	}

	public int getPRACTICAL() {
		return PRACTICAL;
	}

	public void setPRACTICAL(int pRACTICAL) {
		PRACTICAL = pRACTICAL;
	}

	public int getDECREASE_COUNT() {
		return DECREASE_COUNT;
	}

	public void setDECREASE_COUNT(int dECREASE_COUNT) {
		DECREASE_COUNT = dECREASE_COUNT;
	}

	public String getNOTE() {
		return NOTE;
	}

	public void setNOTE(String nOTE) {
		NOTE = nOTE;
	}

	@Override
	public String toString() {
		return "Inventory [ID=" + ID + ", BIANHAO=" + BIANHAO + ", BUSINESS_TIME=" + BUSINESS_TIME
				+ ", JINGSHUO_EMP_ID=" + JINGSHUO_EMP_ID + ", MATERIALS_ID=" + MATERIALS_ID + ", WAREHOUSE_ID="
				+ WAREHOUSE_ID + ", STATE=" + STATE + ", INSPECTOR=" + INSPECTOR + ", ADUDITOR=" + ADUDITOR
				+ ", ENTRY_TIME=" + ENTRY_TIME + ", UPDATE_TIME=" + UPDATE_TIME + ", PANDIAN_INST=" + PANDIAN_INST
				+ ", ZHAIYAO_INST=" + ZHAIYAO_INST + ", PRACTICAL=" + PRACTICAL + ", DECREASE_COUNT=" + DECREASE_COUNT
				+ ", NOTE=" + NOTE + "]";
	}

	
}
