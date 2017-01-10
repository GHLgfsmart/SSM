package com.ht.service.fhoa.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.ht.dao.DaoSupport;
import com.ht.entity.Customer_categories;
import com.ht.entity.Page;
import com.ht.service.fhoa.CategoriesManager;
import com.ht.util.PageData;

@Service("categoriesService")
public class CategoriesService implements CategoriesManager{
	
	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	@Override
	public void save(PageData pd) throws Exception {
		dao.save("CategoriesMapper.save", pd);
	}

	@Override
	public void delete(PageData pd) throws Exception {
		dao.delete("CategoriesMapper.delete",pd);
	}

	@Override
	public void edit(PageData pd) throws Exception {
		dao.update("CategoriesMapper.edit",pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Customer_categories> findBy(PageData pd) throws Exception {
		return (List<Customer_categories>)dao.findForList("CategoriesMapper.findBy",pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findAll(Page page) throws Exception {
		return (List<PageData>)dao.findForList("CategoriesMapper.datalistPage", page);
	}

	@Override
	public PageData findById(String id) throws Exception {
		return (PageData)dao.findForObject("CategoriesMapper.findByID",id);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Customer_categories> findSublevel(String uid)throws Exception {
		return (List<Customer_categories>) dao.findForList("CategoriesMapper.findSublevel",uid);
	}
	
	public List<Customer_categories> paddingSublevel(String ID) throws Exception {
		List<Customer_categories> list = (List<Customer_categories>)this.findSublevel(ID);
		for(Customer_categories depar : list){
			depar.setTreeurl("categories/list.do?ID="+depar.getID());
			depar.setCclist(this.paddingSublevel(depar.getID()));
			depar.setTarget("treeFrame");
		}
		return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Customer_categories> findAllName() throws Exception {
		return (List<Customer_categories>)dao.findForList("CategoriesMapper.findAllName",null);
	}

	@Override
	public int checkName(PageData pd) throws Exception {
		return (Integer)dao.findForObject("CategoriesMapper.findByName",pd);
	}
}
