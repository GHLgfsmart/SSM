package com.ht.service.fhdb.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ht.dao.DaoSupport;
import com.ht.entity.Materials_information;
import com.ht.entity.Page;
import com.ht.service.fhdb.InventoryManager;
import com.ht.util.PageData;

/**
 * 仓库盘点Service实现类
 * @author Bruse
 *
 */
@Service("inventoryService")
public class InventoryService implements InventoryManager{
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 保存数据
	 */
	@Override
	public void saveU(PageData pd) throws Exception {
		dao.save("InventoryMapper.saveU", pd);
	}

	/**
	 * 查询
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> listInventory(Page page) throws Exception {
		return (List<PageData>) dao.findForList("InventoryMapper.datalistPage", page);
	}

	/**
	 * 删除数据
	 */
	@Override
	public void deleteU(PageData pd) throws Exception {
		dao.delete("InventoryMapper.deleteU", pd);
	}

	/**
	 * 修改数据
	 */
	@Override
	public void editU(PageData pd) throws Exception {
		dao.update("InventoryMapper.editU", pd);
	}

	/**
	 * 根据ID查询数据
	 */
	@Override
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("InventoryMapper.findById", pd);
	}

	/**
	 * 获取总记录数
	 */
	@Override
	public PageData getUserCount(String value) throws Exception {
		return (PageData) dao.findForObject("InventoryMapper.getCount", value);
	}

	@Override
	public void deleteAllU(String[] IDS) throws Exception {
		dao.delete("InventoryMapper.deleteAllU", IDS);
	}

	@Override
	public PageData findByUN(PageData pd) throws Exception {
		return (PageData) dao.findForObject("InventoryMapper.findByUN", pd);
	}

	@Override
	public void yes(PageData pd) throws Exception {
		dao.update("InventoryMapper.editState", pd);
	}

	@Override
	public void no(PageData pd) throws Exception {
		dao.update("InventoryMapper.editState", pd);
	}

	@Override
	public void quShen(PageData pd) throws Exception {
		dao.update("InventoryMapper.editState", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Materials_information> findBymaterialAll(Page page) throws Exception {
		return (List<Materials_information>)dao.findForList("MaterialMapper.datalistPage", page);
	}

}
