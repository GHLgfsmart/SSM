package com.ht.service.system.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ht.dao.DaoSupport;
import com.ht.entity.Page;
import com.ht.entity.User;
import com.ht.service.system.MsgManager;
import com.ht.service.system.UserManager;
import com.ht.util.PageData;


/** 公告栏
 */
@Service("msgService")
public class MsgService implements MsgManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	/**公告栏列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listMsgs(Page page)throws Exception{
		return (List<PageData>) dao.findForList("MsgMapper.mlistPage", page);
	}
	
	
	/**通过id获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("MsgMapper.findById", pd);
	}
	/**最新数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData descname(PageData pd)throws Exception{
		return (PageData)dao.findForObject("MsgMapper.descname", pd);
	}
	
	/**保存公告栏
	 * @param pd
	 * @throws Exception
	 */
	public void saveU(PageData pd)throws Exception{
		dao.save("MsgMapper.saveU", pd);
	}
	 
	/**修改公告栏
	 * @param pd
	 * @throws Exception
	 */
	public void editU(PageData pd)throws Exception{
		dao.update("MsgMapper.editU", pd);
	}
	
	/**删除公告栏
	 * @param pd
	 * @throws Exception
	 */
	public void deleteU(PageData pd)throws Exception{
		dao.delete("MsgMapper.deleteU", pd);
	}
	
	/**批量删除公告栏
	 * @param USER_IDS
	 * @throws Exception
	 */
	public void deleteAllU(String[] MSGID)throws Exception{
		dao.delete("MsgMapper.deleteAllU", MSGID);
	}
}
