package com.ht.service.fhoa.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ht.dao.DaoSupport;
import com.ht.entity.Warehouse;
import com.ht.service.fhoa.WarehouseManager;

/**
 * 仓库管理Service实现类
 */
@Service("/warehouseService")
public class WarehouseService implements WarehouseManager{
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<Warehouse> barChar() throws Exception {
		return (List<Warehouse>) dao.findForList("WarehouseMapper.barChar","");
	}

}
