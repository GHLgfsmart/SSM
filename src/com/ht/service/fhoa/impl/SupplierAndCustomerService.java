package com.ht.service.fhoa.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.ht.dao.DaoSupport;
import com.ht.entity.Page;
import com.ht.service.fhoa.SupplierAndCustomerManager;
import com.ht.util.PageData;

import oracle.net.aso.p;

@Service("supplierAndCustomerService")
public class SupplierAndCustomerService implements SupplierAndCustomerManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	@Override
	public void save(PageData pd) throws Exception {
		System.out.println("SERVICE.PD:"+pd.toString());
		dao.save("SupplierAndCustomerMapper.save", pd);
	}

	@Override
	public void delete(PageData pd) throws Exception {
		dao.delete("SupplierAndCustomerMapper.delete", pd);
	}

	@Override
	public void edit(PageData pd) throws Exception {
		dao.update("SupplierAndCustomerMapper.edit", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>)dao.findForList("SupplierAndCustomerMapper.datalistPage", page);
	}

	@Override
	public PageData findById(PageData pd) throws Exception {
		return (PageData)dao.findForObject("SupplierAndCustomerMapper.findByID", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findBy(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("SupplierAndCustomerMapper.findBy", pd);
	}

	@Override
	public void deleteAll(String[] IDS) throws Exception {
		dao.delete("SupplierAndCustomerMapper.deleteAll", IDS);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> checkID(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("SupplierAndCustomerMapper.checkID", pd);
	}

	@Override
	public int findByName(PageData pd) throws Exception {
		return (Integer)dao.findForObject("SupplierAndCustomerMapper.findByName", pd);
	}
	
	

}
