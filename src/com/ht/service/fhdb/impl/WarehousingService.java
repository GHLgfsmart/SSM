package com.ht.service.fhdb.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ht.dao.DaoSupport;
import com.ht.entity.Materials_information;
import com.ht.entity.Page;
import com.ht.service.fhdb.WarehousingManager;
import com.ht.util.PageData;

/**
 * 入库管理实现类
 * */
@Service("warehousingService")
public class WarehousingService implements WarehousingManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	@Override
	public int materialSave(PageData pd) throws Exception {
		return (Integer)dao.save("MaterialMapper.materialInsert", pd);
	}

	@Override
	public int materialUpdate(PageData pd) throws Exception {
		return (Integer)dao.delete("MaterialMapper.materialUpdate", pd);
	}

	@Override
	public int materialDelete(PageData pd) throws Exception {
		return (Integer)dao.delete("MaterialMapper.materialdel", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Materials_information> findBymaterialAll(Page page) throws Exception {
		return (List<Materials_information>)dao.findForList("MaterialMapper.datalistPage", page);
	}
	
}
