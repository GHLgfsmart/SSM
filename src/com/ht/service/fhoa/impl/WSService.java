package com.ht.service.fhoa.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ht.dao.DaoSupport;
import com.ht.entity.Page;
import com.ht.entity.Warehouse;
import com.ht.service.fhoa.WSManager;
import com.ht.service.fhoa.WarehouseManager;
import com.ht.util.PageData;

/**
 * 仓库管理Service实现类
 */
@Service("/wSService")
public class WSService implements WSManager{
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void saveWare(PageData pd)throws Exception{
		dao.save("WSMapper.saveWare", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void deleteWare(PageData pd)throws Exception{
		dao.delete("WSMapper.deleteWare", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void editWare(PageData pd)throws Exception{
		dao.update("WSMapper.editWare", pd);
	}
	/**
	 * 修改状态
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void editSTATE(PageData pd) throws Exception {
		dao.update("WSMapper.editSTATE", pd);
	}
	/**用户列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listWarehouse(Page page) throws Exception {
		return (List<PageData>) dao.findForList("WSMapper.datalistPage", page);
	}

	@SuppressWarnings("unchecked")
	public List<PageData> findByName(PageData pd) throws Exception {
		return (List<PageData>)dao.findForObject("WSMapper.findByName", pd);
		
	}

	@SuppressWarnings("unchecked")
	public List<PageData> listAllWare(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("WSMapper.listWare", pd);
	}
	/**
	 * 通过Id获取数据
	 * @param pd
	 */
	@Override
	public PageData findById(PageData pd) throws Exception {
		return (PageData)dao.findForObject("WSMapper.findById", pd);
	}

	/**获取总数
	 * @param pd
	 * @throws Exception
	 */
	public int getCount(PageData pd)throws Exception{
		return (int)dao.findForObject("WSMapper.getCount", pd);
	}
}
