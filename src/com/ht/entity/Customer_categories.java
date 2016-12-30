package com.ht.entity;

import java.util.List;

/**
 * 
 * @author 供应商和客户的分类表
 *
 */
public class Customer_categories {
	private String ID;//主键编号(加密)
	private String NAME;//名称(注意 后面一定要加供应商或者客户)
	private String UID;//上级编号
	private String NOTE;//备注
	private String treeurl;
	private Customer_categories cces;
	private List<Customer_categories> cclist;
	private String target;
	private boolean hasCategories = false;

	public Customer_categories() {
	
	}
	
	public boolean isHasCategories() {
		return hasCategories;
	}
	public void setHasCategories(boolean hasCategories) {
		this.hasCategories = hasCategories;
	}
	
	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}
	
	public void setCclist(List<Customer_categories> cclist){
		this.cclist=cclist;
	}
	public List<Customer_categories> getCclist(){
		return cclist;
	}
	public void setCces(Customer_categories cces){
		this.cces=cces;
	}
	public Customer_categories getCCes(){
		return cces;
	}
	
	public String getTreeurl() {
		return treeurl;
	}

	public void setTreeurl(String treeurl) {
		this.treeurl = treeurl;
	}

	public Customer_categories(String iD, String nAME, String uID, String nOTE) {
		ID = iD;
		NAME = nAME;
		NOTE = nOTE;
		UID=uID;
	}



	public String getID() {
		return ID;
	}



	public void setID(String iD) {
		ID = iD;
	}



	public String getNAME() {
		return NAME;
	}



	public void setNAME(String nAME) {
		NAME = nAME;
	}


	public String getUID() {
		return UID;
	}



	public void setUID(String uID) {
		UID = uID;
	}



	public String getNOTE() {
		return NOTE;
	}



	public void setNOTE(String nOTE) {
		NOTE = nOTE;
	}



	@Override
	public String toString() {
		return "Sacc [ID=" + ID + ", NAME=" + NAME +  ", UID=" + UID + ", NOTE=" + NOTE + "]";
	}
	
	
}
