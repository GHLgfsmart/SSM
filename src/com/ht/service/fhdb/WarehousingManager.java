package com.ht.service.fhdb;

import java.util.List;

import com.ht.entity.Checkout;
import com.ht.entity.Materials_information;
import com.ht.entity.Output_storage;
import com.ht.entity.Page;
import com.ht.entity.Picking;
import com.ht.util.PageData;

/**
 * 入库管理接口类
 * */
public interface WarehousingManager {
	
	/**
	 * @author Mr.Lin
	 * 物资保存
	 * @param pd
	 * @throws Exception
	 * */
	public int materialSave(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 物资修改
	 * @param pd
	 * @throws Exception
	 * */
	public int materialUpdate(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 物资删除
	 * @param pd
	 * @throws Exception
	 * */
	public int materialDelete(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 查询物资全部信息
	 * @param page
	 * @throws Exception
	 * */
	public List<Materials_information> findBymaterialAll(Page page)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 根据id查询物资信息
	 * @param pd
	 * @throws Exception
	 * */
	public PageData findBymaterialId(PageData pd) throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 查询出入库全部信息
	 * @param page
	 * @throws Exception
	 * */
	public List<Output_storage> findByOutput_storageAll(Page page)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 出入库保存
	 * @param pd
	 * @throws Exception
	 * */
	public int output_storageSave(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 出入库修改
	 * @param pd
	 * @throws Exception
	 * */
	public int output_storageUpdate(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 出入库删除
	 * @param pd
	 * @throws Exception
	 * */
	public int output_storageDelete(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 根据物资id查询出入库表的数量
	 * @param pd
	 * @throws Exception
	 * */
	public int findBymaterialCount(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 根据id查询出入库信息
	 * @param pd
	 * @throws Exception
	 * */
	public PageData findByOutput_storageId(PageData pd) throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 根据单据编号查询出入库信息
	 * @param pd
	 * @throws Exception
	 * */
	public PageData findByOutput_storageNum(PageData pd) throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 查询IQC检验全部信息
	 * @param page
	 * @throws Exception
	 * */
	public List<PageData> findByCheckoutAll(Page page)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * IQC检验修改
	 * @param pd
	 * @throws Exception
	 * */
	public int checkoutUpdate(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * IQC检验删除
	 * @param pd
	 * @throws Exception
	 * */
	public int checkoutDelete(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * IQC检验保存
	 * @param pd
	 * @throws Exception
	 * */
	public int checkoutSave(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 根据id查询IQC检验信息
	 * @param pd
	 * @throws Exception
	 * */
	public PageData findBycheckoutId(PageData pd) throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 查询退货单全部信息
	 * @param page
	 * @throws Exception
	 * */
	public List<PageData> findBysalesreturnAll(Page page)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 退货单修改
	 * @param pd
	 * @throws Exception
	 * */
	public int salesreturnUpdate(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 退货单删除
	 * @param pd
	 * @throws Exception
	 * */
	public int salesreturnDelete(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 退货单保存
	 * @param pd
	 * @throws Exception
	 * */
	public int salesreturnSave(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 根据id查询退货单信息
	 * @param pd
	 * @throws Exception
	 * */
	public PageData findBysalesreturnId(PageData pd) throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 根据单号查询状态
	 * @param pd
	 * @throws Exception
	 * */
	public PageData findBysalesreturnState(PageData pd) throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 查询拣货单全部信息
	 * @param page
	 * @throws Exception
	 * */
	public List<PageData> findBypickingAll(Page page)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 拣货单修改
	 * @param pd
	 * @throws Exception
	 * */
	public int pickingUpdate(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 拣货单删除
	 * @param pd
	 * @throws Exception
	 * */
	public int pickingDelete(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 拣货单保存
	 * @param pd
	 * @throws Exception
	 * */
	public int pickingSave(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 拣货单和出库计划单保存
	 * @param pd
	 * @throws Exception
	 * */
	public int outstorage_pickingSave(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 根据id查询拣货单信息
	 * @param pd
	 * @throws Exception
	 * */
	public PageData findBypickingId(PageData pd) throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 查询拣货单详细信息
	 * @param page
	 * @throws Exception
	 * */
	public List<PageData> findBypickingDetailed(Page page)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 拣货单和出库计划单id删除
	 * @param pd
	 * @throws Exception
	 * */
	public int outstorage_pickingDelete(PageData pd)throws Exception;
	
	/**
	 * @author Su
	 * IQC查询出入库数量
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public int cknumber(PageData pd) throws Exception;
	
	/**统计当前时间前15天的数据
	 * @return
	 * @throws Exception
	 */
	public List<Checkout> barChar1()throws Exception;
	
	/**统计当前时间后15天的数据
	 * @return
	 * @throws Exception
	 */
	public List<Checkout> barChar2()throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 根据id查询拣货单数量
	 * @param pd
	 * @throws Exception
	 * */
	public int findBypickingCount(PageData pd)throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 根据出入库表条件查询物资信息
	 * */
	public List<PageData> findByPutstorageMat(Page page)throws Exception;
	
	/**统计出库当前时间前15天的数据
	 * @return
	 * @throws Exception
	 */
	public List<Picking> barChar3()throws Exception;
	
	/**统计出库当前时间后15天的数据
	 * @return
	 * @throws Exception
	 */
	public List<Picking> barChar4()throws Exception;
	
	/**
	 * @author Mr.Lin
	 * 根据拣货单类型查询所有的拣货数据
	 * @param pd
	 * @throws Exception
	 * */
	public List<PageData> findoutstorageByPType(PageData pd) throws Exception;
	
	public void checkPicking() throws Exception;
	
	public void checkOutput_Storage() throws Exception;
	
	public void checkMaterial() throws Exception;
	
}
