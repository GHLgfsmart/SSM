package com.ht.service.fhdb.impl;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.ht.dao.DaoSupport;
import com.ht.entity.Page;
import com.ht.service.fhdb.WarningService;
import com.ht.util.PageData;

@Service("warningServiceImpl")
public class WarningServiceImpl implements WarningService{
	@Resource(name = "daoSupport")
	private DaoSupport ds;
	
	
	/**
	 * 列出所有警报的仓库
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> listWarning(Page page) throws Exception {
		
		return	(List<PageData>) ds.findForList("WarningMapper.datalistPage", page);
	}

}
