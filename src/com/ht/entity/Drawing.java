package com.ht.entity;

import java.math.BigDecimal;

/**
 * 
 * @author 调拨表
 *
 */
public class Drawing {
	private String ID;//主键编号(加密)
	private String BIANHAO;//编号（如：CK00001）	
	private String JINGSHUO_ID;//经手人(关联EMP 加密)		
	private String DRAWING_INST;//调拔说明		
	private int STATE;//审核状态（未审核 0 通过 1 不通过2 默认未审核 0）		
	private String MATERIALS_ID;//产品（关联product（产品信息表））		
	private String WAREHOUSE_OUT_ID;//出仓库（关联warehouse（仓库表））		
	private String WAREHOUSE_PUT_ID;//入仓库（关联warehouse（仓库表））		
	private String INSPECTOR;//操作员	
	private String AUDITOR;//审核人		
	private String ENTRY_TIME;//录入时间		
	private String UPDATE_TIME;//最后修改时间		
	private BigDecimal MONEY;//单据金额		
	private int NUMBER_OF;//单据数量		
	private String ZHAIYAO_INST;//摘要说明(目的、方法、结果(应给出主要数据)及结论四部分,各部分冠以相应的标题)
	private String BusinessDate;
	private String WzNAME;
	private User user;
	private Materials_information materials_information;
	private Warehouse warehouse;
	
	public Drawing() {
	
	}

	public Drawing(String iD, String bIANHAO, String jINGSHUO_ID, String dRAWING_INST, int sTATE, String mATERIALS_ID,
			String wAREHOUSE_OUT_ID, String wAREHOUSE_PUT_ID, String iNSPECTOR, String aUDITOR, String eNTRY_TIME,
			String uPDATE_TIME, BigDecimal mONEY, int nUMBER_OF, String zHAIYAO_INST, String businessDate,
			String wzNAME, User user, Materials_information materials_information, Warehouse warehouse) {
		ID = iD;
		BIANHAO = bIANHAO;
		JINGSHUO_ID = jINGSHUO_ID;
		DRAWING_INST = dRAWING_INST;
		STATE = sTATE;
		MATERIALS_ID = mATERIALS_ID;
		WAREHOUSE_OUT_ID = wAREHOUSE_OUT_ID;
		WAREHOUSE_PUT_ID = wAREHOUSE_PUT_ID;
		INSPECTOR = iNSPECTOR;
		AUDITOR = aUDITOR;
		ENTRY_TIME = eNTRY_TIME;
		UPDATE_TIME = uPDATE_TIME;
		MONEY = mONEY;
		NUMBER_OF = nUMBER_OF;
		ZHAIYAO_INST = zHAIYAO_INST;
		BusinessDate = businessDate;
		WzNAME = wzNAME;
		this.user = user;
		this.materials_information = materials_information;
		this.warehouse = warehouse;
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

	public String getJINGSHUO_ID() {
		return JINGSHUO_ID;
	}

	public void setJINGSHUO_ID(String jINGSHUO_ID) {
		JINGSHUO_ID = jINGSHUO_ID;
	}

	public String getDRAWING_INST() {
		return DRAWING_INST;
	}

	public void setDRAWING_INST(String dRAWING_INST) {
		DRAWING_INST = dRAWING_INST;
	}

	public int getSTATE() {
		return STATE;
	}

	public void setSTATE(int sTATE) {
		STATE = sTATE;
	}

	public String getMATERIALS_ID() {
		return MATERIALS_ID;
	}

	public void setMATERIALS_ID(String mATERIALS_ID) {
		MATERIALS_ID = mATERIALS_ID;
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

	public String getINSPECTOR() {
		return INSPECTOR;
	}

	public void setINSPECTOR(String iNSPECTOR) {
		INSPECTOR = iNSPECTOR;
	}

	public String getAUDITOR() {
		return AUDITOR;
	}

	public void setAUDITOR(String aUDITOR) {
		AUDITOR = aUDITOR;
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

	public String getBusinessDate() {
		return BusinessDate;
	}

	public void setBusinessDate(String businessDate) {
		BusinessDate = businessDate;
	}

	public String getWzNAME() {
		return WzNAME;
	}

	public void setWzNAME(String wzNAME) {
		WzNAME = wzNAME;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Materials_information getMaterials_information() {
		return materials_information;
	}

	public void setMaterials_information(Materials_information materials_information) {
		this.materials_information = materials_information;
	}

	public Warehouse getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
	}

	@Override
	public String toString() {
		return "Drawing [ID=" + ID + ", BIANHAO=" + BIANHAO + ", JINGSHUO_ID=" + JINGSHUO_ID + ", DRAWING_INST="
				+ DRAWING_INST + ", STATE=" + STATE + ", MATERIALS_ID=" + MATERIALS_ID + ", WAREHOUSE_OUT_ID="
				+ WAREHOUSE_OUT_ID + ", WAREHOUSE_PUT_ID=" + WAREHOUSE_PUT_ID + ", INSPECTOR=" + INSPECTOR
				+ ", AUDITOR=" + AUDITOR + ", ENTRY_TIME=" + ENTRY_TIME + ", UPDATE_TIME=" + UPDATE_TIME + ", MONEY="
				+ MONEY + ", NUMBER_OF=" + NUMBER_OF + ", ZHAIYAO_INST=" + ZHAIYAO_INST + ", BusinessDate="
				+ BusinessDate + ", WzNAME=" + WzNAME + ", user=" + user + ", materials_information="
				+ materials_information + ", warehouse=" + warehouse + "]";
	}
	
	
	
}
