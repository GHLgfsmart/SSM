package com.ht.service.fhdb;

import java.util.List;
import com.ht.entity.Page;
import com.ht.util.PageData;

public interface DrawingService {

	public List<PageData> ListWAndU(Page page)throws Exception;

	public List<PageData> ListWA(Page page)throws Exception; 
	
	public List<PageData> ListProduct(Page page)throws Exception;
	
	public int DrawingSave(PageData pd)throws Exception;

	public List<PageData> drwingList(Page page)throws Exception;
	
	public void Audit(PageData pd) throws Exception;
	
	public void Abolish(PageData pd);
	
	public int delDraeing(PageData pd) throws Exception;
	
	public PageData DraeingById(String ID) throws Exception;
	
	public PageData DraeingBywname(String MATERIALS_ID) throws Exception;

	public PageData byIDPage(Page page)throws Exception;

	public int updateDraeing(PageData pd) throws Exception;
	
	public List<PageData> notSuppliesList(PageData pd) throws Exception;	
	
	public List<PageData> listWarning(Page page)throws Exception;
	
	public void allot(PageData pd)throws Exception;
	
	public PageData allweID(PageData pd);
}
