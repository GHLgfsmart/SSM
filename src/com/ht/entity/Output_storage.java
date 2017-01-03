package com.ht.entity;

import java.math.BigDecimal;
/**
 * 
 * @author 出入库表
 *
 */
public class Output_storage {
	private String ID;//主键编号(加密)
	private String BIANHAO;//编号（如：CK00001）
	private String MATERIALS_ID;//物资（关联Materials_information（物资信息表））
	private String WAREHOUSE_ID;//仓库（关联warehouse（仓库表））
	private String OUTPUT_TYPE_ID;//出入库类型（关联out_put_type（出入库类型表））
	private int STATE;//审核状态（未审核 0 IQC审核通过 1 不通过2）
	private BigDecimal MONEY;//单据金额
	private int NUMBER_OF;//单据数量
	private String USER_ID;//操作员(关联EMP 加密)
	private String AUDITOR;//审核人
	private String ENTRY_TIME;//录入时间
	private String UPDATE_TIME;//最后修改时间
	private String RAW_NUMBER;//原始单号
	private String NOTE;//备注
	private String TYPE; //1为入库  2为出库
	
	private Materials_information materials;
	private Warehouse warehouse;
	private Output_type output_put;
	private User user;
	
	public Output_storage(){}
	
	public Output_storage(String iD, String bIANHAO, String mATERIALS_ID, String wAREHOUSE_ID, String oUTPUT_TYPE_ID,
			int sTATE, BigDecimal mONEY, int nUMBER_OF, String uSER_ID, String aUDITOR, String eNTRY_TIME,
			String uPDATE_TIME, String rAW_NUMBER, String nOTE) {
		ID = iD;
		BIANHAO = bIANHAO;
		MATERIALS_ID = mATERIALS_ID;
		WAREHOUSE_ID = wAREHOUSE_ID;
		OUTPUT_TYPE_ID = oUTPUT_TYPE_ID;
		STATE = sTATE;
		MONEY = mONEY;
		NUMBER_OF = nUMBER_OF;
		USER_ID = uSER_ID;
		AUDITOR = aUDITOR;
		ENTRY_TIME = eNTRY_TIME;
		UPDATE_TIME = uPDATE_TIME;
		RAW_NUMBER = rAW_NUMBER;
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


	public String getOUTPUT_TYPE_ID() {
		return OUTPUT_TYPE_ID;
	}


	public void setOUTPUT_TYPE_ID(String oUTPUT_TYPE_ID) {
		OUTPUT_TYPE_ID = oUTPUT_TYPE_ID;
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


	public String getUSER_ID() {
		return USER_ID;
	}


	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
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


	public String getRAW_NUMBER() {
		return RAW_NUMBER;
	}


	public void setRAW_NUMBER(String rAW_NUMBER) {
		RAW_NUMBER = rAW_NUMBER;
	}


	public String getNOTE() {
		return NOTE;
	}


	public void setNOTE(String nOTE) {
		NOTE = nOTE;
	}


	public Materials_information getMaterials() {
		return materials;
	}


	public void setMaterials(Materials_information materials) {
		this.materials = materials;
	}


	public Warehouse getWarehouse() {
		return warehouse;
	}


	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
	}


	public Output_type getOutput_put() {
		return output_put;
	}


	public void setOutput_put(Output_type output_put) {
		this.output_put = output_put;
	}


	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}


	public String getTYPE() {
		return TYPE;
	}

	public void setTYPE(String tYPE) {
		TYPE = tYPE;
	}

	@Override
	public String toString() {
		return "Output_storage [ID=" + ID + ", BIANHAO=" + BIANHAO + ", MATERIALS_ID=" + MATERIALS_ID
				+ ", WAREHOUSE_ID=" + WAREHOUSE_ID + ", OUTPUT_TYPE_ID=" + OUTPUT_TYPE_ID + ", STATE=" + STATE
				+ ", MONEY=" + MONEY + ", NUMBER_OF=" + NUMBER_OF + ", USER_ID=" + USER_ID + ", AUDITOR=" + AUDITOR
				+ ", ENTRY_TIME=" + ENTRY_TIME + ", UPDATE_TIME=" + UPDATE_TIME + ", RAW_NUMBER=" + RAW_NUMBER
				+ ", NOTE=" + NOTE + "]";
	}

	
	
	
}
