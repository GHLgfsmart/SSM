package com.ht.service.system.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ht.dao.DaoSupport;
import com.ht.entity.Page;
import com.ht.entity.User;
import com.ht.service.system.MoneyManager;
import com.ht.service.system.MsgManager;
import com.ht.service.system.UserManager;
import com.ht.util.PageData;


/** 费用
 */
@Service("moneyService")
public class MoneyService implements MoneyManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	/**列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listMoneys(Page page)throws Exception{
		return (List<PageData>) dao.findForList("MoneyMapper.mlistPage", page);
	}
	/**通过id获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("MoneyMapper.findById", pd);
	}
	
	/**保存
	 * @param pd
	 * @throws Exception
	 */
	public void saveU(PageData pd)throws Exception{
		dao.save("MoneyMapper.saveU", pd);
	}
	 
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void editU(PageData pd)throws Exception{
		dao.update("MoneyMapper.editU", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void deleteU(PageData pd)throws Exception{
		dao.delete("MoneyMapper.deleteU", pd);
	}
	
	/**批量删除
	 * @param USER_IDS
	 * @throws Exception
	 */
	public void deleteAllU(String[] MSGID)throws Exception{
		dao.delete("MoneyMapper.deleteAllU", MSGID);
	}
}
