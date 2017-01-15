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

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> ListWAndU(Page page) throws Exception {
		return	(List<PageData>) ds.findForList("DrawingMapper.drawinglist", "");
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> ListWA(Page page) throws Exception {
		return	(List<PageData>) ds.findForList("DrawingMapper.warlist", "");
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> ListProduct(Page page) throws Exception {
		return (List<PageData>) ds.findForList("ProductMapper.matlistPage", page);
	}
	
	@Override
	public int DrawingSave(PageData pd) throws Exception {
		return (Integer)ds.save("DrawingMapper.DrwingSave", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> drwingList(Page page) throws Exception {
		
		return (List<PageData>) ds.findForList("DrawingMapper.datalistPage", page);
	}
	
	@Override
	public void Audit(PageData pd) throws Exception {
		
		ds.update("DrawingMapper.Audit", pd);
	}
	
	@Override
	public void Abolish(PageData pd) {
		
		try {
			ds.update("DrawingMapper.Abolish", pd);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public int delDraeing(PageData pd) throws Exception {
			
		return (Integer)ds.delete("DrawingMapper.delDraeing", pd);
	
	}
	@Override
	public int updateDraeing(PageData pd) throws Exception {
		
		return (Integer)ds.update("DrawingMapper.updateDraeing", pd);
	}
	
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
		return (PageData)ds.findForObject("DrawingMapper.wzidlistPage", page);
		
	}
	

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> listWarning(Page page) throws Exception {
		
		return	(List<PageData>) ds.findForList("ProductMapper.datalistPage", page);
	}

	@Override
	public void allot(PageData pd) throws Exception {
		
		ds.save("DrawingMapper.allot", pd);
	}

	@Override
	public PageData allweID(PageData pd){
	
		try {
			return(PageData)ds.findForObject("DrawingMapper.allweID", pd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pd;
		
	}
}
