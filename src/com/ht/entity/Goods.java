package com.ht.entity;

import java.util.Date;

public class Goods {
	
	private String ID;	//编号
	private String D_NAME;	//驾驶员（司机表）
	private String C_BRAND;		//车牌号（汽车表）
	private Integer C_WEIGHT;	//载重（汽车表）
	private Integer P_COUNT; 			//拣取数量
	private Integer P_MATCOUNT; 		//出库单数
	private String START_ADDRESS;		//起点
	private Date START_TIME;			//起点时间
	private String ADDRESS;			//目的地
	private Date END_TIME;			//到货时间
	private int STATE;			//状态  0：休闲     1：派送中   2：已派送
	private String D_ID;			//司机表的ID
	private String C_ID;			//汽车表的ID
	private String P_ID;			//拣货表的ID
	
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getD_NAME() {
		return D_NAME;
	}
	public void setD_NAME(String d_NAME) {
		D_NAME = d_NAME;
	}
	public String getC_BRAND() {
		return C_BRAND;
	}
	public void setC_BRAND(String c_BRAND) {
		C_BRAND = c_BRAND;
	}
	public Integer getC_WEIGHT() {
		return C_WEIGHT;
	}
	public void setC_WEIGHT(Integer c_WEIGHT) {
		C_WEIGHT = c_WEIGHT;
	}
	public Integer getP_COUNT() {
		return P_COUNT;
	}
	public void setP_COUNT(Integer p_COUNT) {
		P_COUNT = p_COUNT;
	}
	public Integer getP_MATCOUNT() {
		return P_MATCOUNT;
	}
	public void setP_MATCOUNT(Integer p_MATCOUNT) {
		P_MATCOUNT = p_MATCOUNT;
	}
	public String getSTART_ADDRESS() {
		return START_ADDRESS;
	}
	public void setSTART_ADDRESS(String sTART_ADDRESS) {
		START_ADDRESS = sTART_ADDRESS;
	}
	public Date getSTART_TIME() {
		return START_TIME;
	}
	public void setSTART_TIME(Date sTART_TIME) {
		START_TIME = sTART_TIME;
	}
	public String getADDRESS() {
		return ADDRESS;
	}
	public void setADDRESS(String aDDRESS) {
		ADDRESS = aDDRESS;
	}
	public Date getEND_TIME() {
		return END_TIME;
	}
	public void setEND_TIME(Date eND_TIME) {
		END_TIME = eND_TIME;
	}
	public int getSTATE() {
		return STATE;
	}
	public void setSTATE(int sTATE) {
		STATE = sTATE;
	}
	public String getD_ID() {
		return D_ID;
	}
	public void setD_ID(String d_ID) {
		D_ID = d_ID;
	}
	public String getC_ID() {
		return C_ID;
	}
	public void setC_ID(String c_ID) {
		C_ID = c_ID;
	}
	public String getP_ID() {
		return P_ID;
	}
	public void setP_ID(String p_ID) {
		P_ID = p_ID;
	}
	
}
