package com.ht.entity;

import java.math.BigDecimal;

public class Price_Money {
	private String PRICE_ID;
	private BigDecimal STORAGE;//存储费
	private BigDecimal RICHARD;//理货费
	private BigDecimal LOADING;//装车费
	private BigDecimal UNLOADING;//卸车费
	private String MONEYTIME;//发布时间
	private BigDecimal ARTIFICIAL;//人工费
	private String STATE;//状态
	public String getPRICE_ID() {
		return PRICE_ID;
	}
	public void setPRICE_ID(String pRICE_ID) {
		PRICE_ID = pRICE_ID;
	}
	public BigDecimal getSTORAGE() {
		return STORAGE;
	}
	public void setSTORAGE(BigDecimal sTORAGE) {
		STORAGE = sTORAGE;
	}
	public BigDecimal getRICHARD() {
		return RICHARD;
	}
	public void setRICHARD(BigDecimal rICHARD) {
		RICHARD = rICHARD;
	}
	public BigDecimal getLOADING() {
		return LOADING;
	}
	public void setLOADING(BigDecimal lOADING) {
		LOADING = lOADING;
	}
	public BigDecimal getUNLOADING() {
		return UNLOADING;
	}
	public void setUNLOADING(BigDecimal uNLOADING) {
		UNLOADING = uNLOADING;
	}
	public String getMONEYTIME() {
		return MONEYTIME;
	}
	public void setMONEYTIME(String mONEYTIME) {
		MONEYTIME = mONEYTIME;
	}
	public BigDecimal getARTIFICIAL() {
		return ARTIFICIAL;
	}
	public void setARTIFICIAL(BigDecimal aRTIFICIAL) {
		ARTIFICIAL = aRTIFICIAL;
	}
	public String getSTATE() {
		return STATE;
	}
	public void setSTATE(String sTATE) {
		STATE = sTATE;
	}
	
}
