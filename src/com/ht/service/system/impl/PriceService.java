package com.ht.service.system.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ht.dao.DaoSupport;
import com.ht.entity.Page;
import com.ht.service.system.PriceManager;
import com.ht.util.PageData;


/** 单表
 */
@Service("priceService")
public class PriceService implements PriceManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	/**单表列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listPrices(Page page)throws Exception{
		return (List<PageData>) dao.findForList("PriceMapper.mlistPage", page);
	}
	
	
	/**通过id获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PriceMapper.findById", pd);
	}
	/**通过id获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData moneytoo(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PriceMapper.moneytoo", pd);
	}
	/**通过id获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData moneytoos(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PriceMapper.moneytoos", pd);
	}
	
	/**保存单表
	 * @param pd
	 * @throws Exception
	 */
	public void saveU(PageData pd)throws Exception{
		dao.save("PriceMapper.saveU", pd);
	}
	 
	/**修改单表
	 * @param pd
	 * @throws Exception
	 */
	public void editU(PageData pd)throws Exception{
		dao.update("PriceMapper.editU", pd);
	}
	
	/**删除单表
	 * @param pd
	 * @throws Exception
	 */
	public void deleteU(PageData pd)throws Exception{
		dao.delete("PriceMapper.deleteU", pd);
	}
	/**批量删除
	 * @param USER_IDS
	 * @throws Exception
	 */
	public void deleteAllU(String[] PRICE_IDS)throws Exception{
		dao.delete("PriceMapper.deleteAllU", PRICE_IDS);
	}
}
