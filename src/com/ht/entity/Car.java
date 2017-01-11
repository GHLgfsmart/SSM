package com.ht.entity;

/**
 * 汽车表
 * @author Bruse
 *
 */
public class Car {
	
	private String ID;	//编号
	private String BRAND;	//车牌号	
	private String TIMES;									//购买时间
	private Integer WEIGHT;										//	载重
	
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getBRAND() {
		return BRAND;
	}
	public void setBRAND(String bRAND) {
		BRAND = bRAND;
	}
	public String getTIMES() {
		return TIMES;
	}
	public void setTIMES(String tIMES) {
		TIMES = tIMES;
	}
	public Integer getWEIGHT() {
		return WEIGHT;
	}
	public void setWEIGHT(Integer wEIGHT) {
		WEIGHT = wEIGHT;
	}
									
}
