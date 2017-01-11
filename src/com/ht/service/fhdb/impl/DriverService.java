package com.ht.service.fhdb.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ht.dao.DaoSupport;
import com.ht.entity.Page;
import com.ht.service.fhdb.DriverManager;
import com.ht.util.PageData;

/**
 * 司机Service实现类
 * @author Bruse
 *
 */
@Service("driverService")
public class DriverService implements DriverManager{
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 保存数据
	 */
	@Override
	public void saveU(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("DriverMapper.saveU", pd);
	}

	/**
	 * 列表
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> listDriver(Page page) throws Exception {
		return (List<PageData>) dao.findForList("DriverMapper.datalistPage", page);
	}

	/**
	 * 删除数据
	 */
	@Override
	public void deleteU(PageData pd) throws Exception {
		dao.delete("DriverMapper.deleteU", pd);
	}

	/**
	 * 修改数据
	 */
	@Override
	public void editU(PageData pd) throws Exception {
		dao.update("DriverMapper.editU", pd);
	}

	/**
	 * 根据ID查询数据
	 */
	@Override
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("DriverMapper.findById", pd);
	}

	/**
	 * 获取总记录数
	 */
	@Override
	public PageData getUserCount(String value) throws Exception {
		return (PageData) dao.findForObject("DriverMapper.getCount", value);
	}

	/**
	 * 删除多条数据
	 */
	@Override
	public void deleteAllU(String[] IDS) throws Exception {
		dao.delete("DriverMapper.deleteAllU", IDS);
	}

	/**通过邮箱获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByUE(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DriverMapper.findByUE", pd);
	}
	
	/**
	 * 判断手机号码是否存在
	 */
	@Override
	public PageData findByUN(PageData pd) throws Exception {
		return (PageData) dao.findForObject("DriverMapper.findByUN", pd);
	}

}
