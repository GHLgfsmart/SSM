package com.ht.service.fhdb.impl;

import java.util.List;


import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.ht.dao.DaoSupport;
import com.ht.entity.Page;
import com.ht.service.fhdb.DrawingService;
import com.ht.util.PageData;
@Service("drawingServiceImpl")
public class DrawingServiceImpl implements DrawingService{
	@Resource(name = "daoSupport")
	private DaoSupport ds;
	/**
	 * 
	 * 查询经手人
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> ListWAndU(Page page) throws Exception {
		return	(List<PageData>) ds.findForList("DrawingMapper.drawinglist", "");
	}
	/**
	 * 查询仓库名
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> ListWA(Page page) throws Exception {
		return	(List<PageData>) ds.findForList("DrawingMapper.warlist", "");
	}
	
	/**
	 * 查询产品
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> ListProduct(Page page) throws Exception {
		return (List<PageData>) ds.findForList("ProductMapper.matlistPage", page);
	}
	/**
	 * 保存调拨的数据
	 */
	@Override
	public int DrawingSave(PageData pd) throws Exception {
		return (Integer)ds.save("DrawingMapper.DrwingSave", pd);
	}
	/**
	 * 查询调拨单
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> drwingList(Page page) throws Exception {
		
		return (List<PageData>) ds.findForList("DrawingMapper.datalistPage", page);
	}
	
	/**
	 * 审核
	 * @throws Exception 
	 */
	@Override
	public void Audit(PageData pd) throws Exception {
		
		ds.update("DrawingMapper.Audit", pd);
	}
	
	/**
	 * 去审
	 */
	@Override
	public void Abolish(PageData pd) {
		
		try {
			ds.update("DrawingMapper.Abolish", pd);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 批量删除
	 * @throws Exception 
	 */
	@Override
	public int delDraeing(PageData pd) throws Exception {
			
		return (Integer)ds.delete("DrawingMapper.delDraeing", pd);
	
		/**
		 * 修改	 
		 * */
	}
	@Override
	public int updateDraeing(PageData pd) throws Exception {
		
		return (Integer)ds.update("DrawingMapper.updateDraeing", pd);
	}
	
	/**
	 * 根据id获取数据
	 * @throws Exception 
	 */
	@Override
	public PageData DraeingById(String ID) throws Exception{
	
			return (PageData) ds.findForObject("DrawingMapper.DraeingById", ID);
		
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> notSuppliesList(PageData pd) throws Exception {
		return (List<PageData>) ds.findForList("ProductMapper.notSuppliesList", pd);
	}
	
	@Override
	public PageData DraeingBywname(String MATERIALS_ID) throws Exception {
		return (PageData) ds.findForObject("DrawingMapper.DraeingBywname", MATERIALS_ID);
	}
	
	public PageData byIDPage(Page page)throws Exception{
		return (PageData)ds.findForObject("DrawingMapper.idlistPage", page);
		
	}
	@Override
	public void reduce(PageData pd) throws Exception {
		ds.update("DrawingMapper.reduce", pd);
	};
}
