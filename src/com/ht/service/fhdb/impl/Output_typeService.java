package com.ht.service.fhdb.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ht.dao.DaoSupport;
import com.ht.entity.Page;
import com.ht.service.fhdb.Output_typeManager;
import com.ht.util.PageData;

@Service("output_typeService")
public class Output_typeService implements Output_typeManager{
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;


	@Override
	public void saveU(PageData pd) throws Exception {
		dao.save("Output_typeMapper.saveU", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> listOutput(Page page) throws Exception {
		return (List<PageData>) dao.findForList("Output_typeMapper.datalistPage", page);
	}

	@Override
	public void deleteU(PageData pd) throws Exception {
		dao.delete("Output_typeMapper.deleteU", pd);
	}

	@Override
	public void editU(PageData pd) throws Exception {
		dao.update("Output_typeMapper.editU", pd);
	}

	@Override
	public PageData getUserCount(String value) throws Exception {
		return (PageData) dao.findForObject("Output_typeMapper.getCount", value);
	}

	@Override
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("Output_typeMapper.findById", pd);
	}

	@Override
	public PageData findByUN(PageData pd) throws Exception {
		return (PageData) dao.findForObject("Output_typeMapper.findByUN", pd);
	}

}
