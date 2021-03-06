package com.ht.service.fhdb.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ht.dao.DaoSupport;
import com.ht.entity.Checkout;
import com.ht.entity.Materials_information;
import com.ht.entity.Output_storage;
import com.ht.entity.Page;
import com.ht.entity.Picking;
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

	@Override
	public int outstorage_pickingSave(PageData pd) throws Exception {
		return (Integer)dao.save("PickingMapper.pic_outInsert", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findBypickingDetailed(Page page) throws Exception {
		return (List<PageData>)dao.findForList("PickingMapper.pickingDetailed", page);
	}

	@Override
	public int outstorage_pickingDelete(PageData pd) throws Exception {
		return (Integer)dao.delete("PickingMapper.outid_piciddel", pd);
	}

	@Override
	public int findBymaterialCount(PageData pd) throws Exception {
		return (Integer)dao.findForObject("Output_storageMapper.materialByCount", pd);
	}

	@Override
	public int cknumber(PageData pd) throws Exception{
		return (int)dao.findForObject("CheckoutMapper.cknumber",pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Checkout> barChar1() throws Exception {
		return (List<Checkout>) dao.findForList("CheckoutMapper.barChar1","");
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Checkout> barChar2() throws Exception {
		return (List<Checkout>) dao.findForList("CheckoutMapper.barChar2","");
	}

	@Override
	public int findBypickingCount(PageData pd) throws Exception {
		return (Integer)dao.delete("PickingMapper.pickingByCount", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findByPutstorageMat(Page page) throws Exception {
		return (List<PageData>) dao.findForList("Output_storageMapper.ByPutstorageMat",page);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Picking> barChar3() throws Exception {
		return (List<Picking>) dao.findForList("PickingMapper.barChar1","");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Picking> barChar4() throws Exception {
		return (List<Picking>) dao.findForList("PickingMapper.barChar2","");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findoutstorageByPType(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("PickingMapper.outstorageByPType", pd);
	}
	@Override
	public void checkPicking() throws Exception {
		System.out.println("执行定时任务====Picking");
		dao.delete("PickingMapper.deleteLossPicking", "");
	}

	@Override
	public void checkOutput_Storage() throws Exception {
		System.out.println("执行定时任务====Output_Storage");
		dao.delete("Output_storageMapper.deleteLossOutput_Storage", "");
	}

	@Override
	public void checkMaterial() throws Exception {
		System.out.println("执行定时任务====Material");
		dao.delete("MaterialMapper.deleteLossMaterial", "");
	}
}
