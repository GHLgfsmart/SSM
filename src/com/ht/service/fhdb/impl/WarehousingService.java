package com.ht.service.fhdb.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ht.dao.DaoSupport;
import com.ht.entity.Materials_information;
import com.ht.entity.Output_storage;
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
		return (Integer)dao.update("MaterialMapper.materialUpdate", pd);
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

	@Override
	public PageData findBymaterialId(PageData pd) throws Exception {
		return (PageData)dao.findForObject("MaterialMapper.materialById", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Output_storage> findByOutput_storageAll(Page page) throws Exception {
		return (List<Output_storage>)dao.findForList("Output_storageMapper.datalistPage", page);
	}

	@Override
	public int output_storageSave(PageData pd) throws Exception {
		return (Integer)dao.save("Output_storageMapper.output_storageInsert", pd);
	}

	@Override
	public int output_storageUpdate(PageData pd) throws Exception {
		return (Integer)dao.update("Output_storageMapper.output_storageUpdate", pd);
	}

	@Override
	public int output_storageDelete(PageData pd) throws Exception {
		return (Integer)dao.delete("Output_storageMapper.output_storagedel", pd);
	}

	@Override
	public PageData findByOutput_storageId(PageData pd) throws Exception {
		return (PageData)dao.findForObject("Output_storageMapper.output_storageById", pd);
	}
	
	@Override
	public PageData findByOutput_storageNum(PageData pd) throws Exception {
		return (PageData)dao.findForObject("Output_storageMapper.output_storageByNum", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findByCheckoutAll(Page page) throws Exception {
		return (List<PageData>)dao.findForList("CheckoutMapper.datalistPage", page);
	}

	@Override
	public int checkoutUpdate(PageData pd) throws Exception {
		return (Integer)dao.update("CheckoutMapper.checkoutUpdate", pd);
	}

	@Override
	public int checkoutDelete(PageData pd) throws Exception {
		return (Integer)dao.delete("CheckoutMapper.checkoutdel", pd);
	}

	@Override
	public int checkoutSave(PageData pd) throws Exception {
		return (Integer)dao.save("CheckoutMapper.checkoutInsert", pd);
	}

	@Override
	public PageData findBycheckoutId(PageData pd) throws Exception {
		return (PageData)dao.findForObject("CheckoutMapper.checkoutById", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findBysalesreturnAll(Page page) throws Exception {
		return (List<PageData>)dao.findForList("SalesreturnMapper.datalistPage", page);
	}

	@Override
	public int salesreturnUpdate(PageData pd) throws Exception {
		return (Integer)dao.update("SalesreturnMapper.salesreturnUpdate", pd);
	}

	@Override
	public int salesreturnDelete(PageData pd) throws Exception {
		return (Integer)dao.delete("SalesreturnMapper.salesreturndel", pd);
	}

	@Override
	public int salesreturnSave(PageData pd) throws Exception {
		return (Integer)dao.save("SalesreturnMapper.salesreturnInsert", pd);
	}

	@Override
	public PageData findBysalesreturnId(PageData pd) throws Exception {
		return (PageData)dao.findForObject("SalesreturnMapper.salesreturnById", pd);
	}

	@Override
	public PageData findBysalesreturnState(PageData pd) throws Exception {
		return (PageData)dao.findForObject("SalesreturnMapper.findBysalesreturnByState", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findBypickingAll(Page page) throws Exception {
		return (List<PageData>)dao.findForList("PickingMapper.datalistPage", page);
	}

	@Override
	public int pickingUpdate(PageData pd) throws Exception {
		return (Integer)dao.update("PickingMapper.pickingUpdate", pd);
	}

	@Override
	public int pickingDelete(PageData pd) throws Exception {
		return (Integer)dao.delete("PickingMapper.pickingdel", pd);
	}

	@Override
	public int pickingSave(PageData pd) throws Exception {
		return (Integer)dao.save("PickingMapper.pickingInsert", pd);
	}

	@Override
	public PageData findBypickingId(PageData pd) throws Exception {
		return (PageData)dao.findForObject("PickingMapper.pickingById", pd);
	}
	
}
