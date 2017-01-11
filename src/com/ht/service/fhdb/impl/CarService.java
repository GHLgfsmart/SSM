package com.ht.service.fhdb.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ht.dao.DaoSupport;
import com.ht.entity.Page;
import com.ht.service.fhdb.CarManager;
import com.ht.util.PageData;


/**
 * 货车Service实现类
 * @author Bruse
 *
 */
@Service("carService")
public class CarService implements CarManager{
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 列表
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> listCar(Page page) throws Exception {
		return (List<PageData>) dao.findForList("CarMapper.datalistPage", page);
	}
	
	/**
	 * 保存数据
	 */
	@Override
	public void saveU(PageData pd) throws Exception {
		dao.save("CarMapper.saveU", pd);
	}

	/**
	 * 删除数据
	 */
	@Override
	public void deleteU(PageData pd) throws Exception {
		dao.delete("CarMapper.deleteU", pd);
	}

	/**
	 * 修改数据
	 */
	@Override
	public void editU(PageData pd) throws Exception {
		dao.update("CarMapper.editU", pd);
	}

	/**
	 * 根据ID查询数据
	 */
	@Override
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("CarMapper.findById", pd);
	}

	/**
	 * 获取总记录数
	 */
	@Override
	public PageData getUserCount(String value) throws Exception {
		return (PageData) dao.findForObject("CarMapper.getCount", value);
	}

	/**
	 * 删除多条数据
	 */
	@Override
	public void deleteAllU(String[] IDS) throws Exception {
		dao.delete("CarMapper.deleteAllU", IDS);
	}

	/**
	 * 判断车牌号是否存在
	 */
	@Override
	public PageData findByUN(PageData pd) throws Exception {
		return (PageData) dao.findForObject("CarMapper.findByUN", pd);
	}

}
