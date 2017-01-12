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
	/**总费用
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public PageData mlistsum(PageData pd)throws Exception{
		return (PageData) dao.findForObject("MoneyMapper.mlistsum", pd);
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
	/**保存退货费用
	 * @param pd
	 * @throws Exception
	 */
	public int totalsaveU(PageData pd)throws Exception{
		return(Integer) dao.save("MoneyMapper.totalsaveU", pd);
	}
	/**修改退货费用
	 * @param pd
	 * @throws Exception
	 */
	public int totaleditU(PageData pd)throws Exception{
		return(Integer) dao.save("MoneyMapper.totaleditU", pd);
	}
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void editU(PageData pd)throws Exception{
		dao.update("MoneyMapper.editU", pd);
	}
	/**修改money
	 * @param pd
	 * @throws Exception
	 */
	public int moneyeditU(PageData pd)throws Exception{
		return (Integer)dao.update("MoneyMapper.moneyeditU", pd);
	}
	/**修改物质状态
	 * @param pd
	 * @throws Exception
	 */
	public void maeditU(PageData pd)throws Exception{
		dao.update("MoneyMapper.maeditU", pd);
	}
	/**修改出货单money
	 * @param pd
	 * @throws Exception
	 */
	public void OuteditU(PageData pd)throws Exception{
		dao.update("MoneyMapper.OuteditU", pd);
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
	/**判断退货数量不能大于实际数量
	 * @param USER_IDS
	 * @throws Exception
	 */
	@Override
	public int numbers(PageData pd) throws Exception{
		return(int)dao.findForObject("MoneyMapper.numbers",pd);
	}
	/**查询退货个数和数量
	 * @param USER_IDS
	 * @throws Exception
	 */
	@Override
	public PageData countsum(PageData pd) throws Exception{
		return (PageData)dao.findForObject("MoneyMapper.countsum",pd);
	}
	/**费用查询
	 * @param USER_IDS
	 * @throws Exception
	 */
	@Override
	public PageData moneys(PageData pd) throws Exception{
		return (PageData)dao.findForObject("MoneyMapper.moneys",pd);
	}
	/**费用查询
	 * @param USER_IDS
	 * @throws Exception
	 */
	@Override
	public PageData outmoney(PageData pd) throws Exception{
		return (PageData)dao.findForObject("MoneyMapper.outmoney",pd);
	}
}
