package com.ht.service.fhdb.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ht.dao.DaoSupport;
import com.ht.entity.Car;
import com.ht.entity.Driver;
import com.ht.entity.Page;
import com.ht.entity.Picking;
import com.ht.service.fhdb.GoodsManager;
import com.ht.util.PageData;

/**
 * 装箱操作Service实现类
 * @author Bruse
 *
 */
@Service("goodsService")
public class GoodsService implements GoodsManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	@Override
	public void checkGoods() throws Exception {
		System.out.println("执行定时任务====Goods");
		dao.delete("GoodsMapper.deleteLossGoods", "");
	}
	/**
	 * 保存数据
	 */
	@Override
	public void saveU(PageData pd) throws Exception {
		dao.save("GoodsMapper.saveU", pd);
	}

	/**
	 * 列表
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> listGoods(Page page) throws Exception {
		return (List<PageData>) dao.findForList("GoodsMapper.datalistPage", page);
	}

	/**
	 * 删除数据
	 */
	@Override
	public void deleteU(PageData pd) throws Exception {
		dao.delete("GoodsMapper.deleteU", pd);
	}

	/**
	 * 修改数据
	 */
	@Override
	public void editU(PageData pd) throws Exception {
		dao.update("GoodsMapper.editU", pd);
	}

	/**
	 * 根据ID查询数据
	 */
	@Override
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("GoodsMapper.findById", pd);
	}

	/**
	 * 获取总记录数
	 */
	@Override
	public PageData getUserCount(String value) throws Exception {
		return (PageData) dao.findForObject("GoodsMapper.getCount", value);
	}

	/**
	 * 删除多条数据
	 */
	@Override
	public void deleteAllU(String[] IDS) throws Exception {
		dao.delete("GoodsMapper.deleteAllU", IDS);
	}

	/**
	 * 获取物资
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Picking> findByMaterialAll(Page page) throws Exception {
		return (List<Picking>)dao.findForList("PickingMapper.datalistPage", page);
	}

	/**
	 * 获取车辆
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Car> findByCarAll(Page page) throws Exception {
		return (List<Car>)dao.findForList("CarMapper.findCar", page);
	}

	/**
	 * 修改状态为1   派送中
	 */
	@Override
	public void ps(PageData pd) throws Exception {
		dao.update("GoodsMapper.editState1", pd);
	}

	/**
	 * 修改状态为2   已派送
	 */
	@Override
	public void ok(PageData pd) throws Exception {
		dao.update("GoodsMapper.editState2", pd);
	}

	/**
	 * 获取司机的信息
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Driver> findByDriverAll(Page page) throws Exception {
		return (List<Driver>)dao.findForList("DriverMapper.findSJ", page);
	}

	@Override
	public void edit2(PageData pd) throws Exception {
		dao.update("GoodsMapper.edit2", pd);
	}

	@Override
	public void edit3(String[] PIDS) throws Exception {
		dao.update("GoodsMapper.edit3", PIDS);
	}
	
}
