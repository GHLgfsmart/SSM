package com.ht.controller.fhdb;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ht.controller.base.BaseController;
import com.ht.entity.Output_storage;
import com.ht.entity.Page;
import com.ht.service.fhdb.WarehousingManager;
import com.ht.service.system.MoneyManager;
import com.ht.service.system.PriceManager;
import com.ht.util.Jurisdiction;
import com.ht.util.PageData;
/**
 * 出库控制
 * */
@Controller
@RequestMapping(value="/outstorage")
public class OutstorageController extends BaseController{
	
	String menuUrl = "outstorage/outstorageList.do"; //菜单地址(权限用)
	String pickingmenuUrl = "outstorage/pickingList.do"; //菜单地址(权限用)
	@Resource(name="warehousingService")
	private WarehousingManager warehousingService;
	//洪青青修改
	@Resource(name="priceService")
	private PriceManager priceService;
	@Resource(name="moneyService")
	private MoneyManager moneyService;
	/**
	 * @author Mr.Lin
	 * 查询所有出库信息
	 * @param page
	 * @return
	 * @throws Exception 
	 * */
	@RequestMapping(value="/outstorageList")
	private ModelAndView findoutput_storageListAll(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername()+"列表output_storageList");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();	
		String keywords = pd.getString("keywords");			//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		pd.put("TYPE", "2");
		page.setPd(pd);
		List<Output_storage> list = warehousingService.findByOutput_storageAll(page);
		mv.setViewName("fhdb/outstorage/outstorageManage");
		mv.addObject("varList", list);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	/**
	 * @author 洪青青
	 * 费用规则查询
	 * @throws Exception
	 * @return
	 */
	public PageData Moneytoo()throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("toos", "toos");
		pd = priceService.findById(pd);
		return pd;
	}
	/**
	 * @author 洪青青
	 * 费用查询
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/moneys")
	public void moneys(PrintWriter out) throws Exception{
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd=moneyService.moneys(pd);
			out.write(""+pd.get("MONEY")+";"+pd.get("COUNT"));
		} catch (Exception e) {
			e.fillInStackTrace();
			out.write("fall");
		}
		out.close();
	}
	/**
	 * @author Mr.Lin
	 * 出库弹出新增界面
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/outstorageAddPage")
	public ModelAndView outstorageAddPage()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String dj = "CK"+sdf.format(new Date());
		//洪青青修改
		PageData pd1=Moneytoo();
		mv.addObject("pd1", pd1);
		//--------
		mv.setViewName("fhdb/outstorage/outstorageEdit");
		mv.addObject("dj", dj);
		mv.addObject("msg", "outstorageAdd");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 出库新增操作
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/outstorageAdd")
	public ModelAndView outstorageAdd()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"出库新增");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ID", this.get32UUID());	//主键
		int result = warehousingService.output_storageSave(pd);
		//洪青青修改
		pd.put("PRODUCT_ID", pd.getString("ID"));
		int result1=moneyService.moneyeditU(pd);
		//----------
		if(result>0 || result1>0) {
			mv.addObject("msg","success");
		}else {
			mv.addObject("msg","fail");
		}
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 弹出入库选择物资界面
	 * @throws Exception 
	 * */
	@RequestMapping(value="/electMaterialsPage")
	public ModelAndView electMaterialsPage(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("TYPE", "1");  //入库信息
		pd.put("matState", "1");	//物资已入库信息
		page.setPd(pd);
		List<PageData> list = warehousingService.findByPutstorageMat(page);
		for(PageData os : list) {
			System.out.println(os+"********");
		}
		mv.setViewName("fhdb/outstorage/elect_materials");
		mv.addObject("varList", list);
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 弹出出库修改界面
	 * @throws Exception 
	 * @return
	 * */
	@RequestMapping(value="/outstorageEditPage")
	public ModelAndView outstorageEditPage()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = warehousingService.findByOutput_storageId(pd);
		//洪青青修改
		PageData pd1=Moneytoo();
		mv.addObject("pd1", pd1);
		//--------
		mv.setViewName("fhdb/outstorage/outstorageEdit");
		mv.addObject("msg", "outstorageEdit");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 出库修改操作
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/outstorageEdit")
	public ModelAndView outstorageEdit()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"出库修改");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		int result = warehousingService.output_storageUpdate(pd);
		//洪青青修改
		pd.put("PRODUCT_ID", pd.getString("ID"));
		int result1=moneyService.moneyeditU(pd);
		if(result>0 ||result1>0) {
			mv.addObject("msg","success");
		}else {
			mv.addObject("msg","fail");
		}
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 出库删除操作
	 * @throws Exception 
	 * */
	@RequestMapping(value="/outstorageDel")
	public void outstorageDel(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"出库删除");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		int result = warehousingService.output_storageDelete(pd);
		if(result>0) {
			out.write("success");
		}else {
			out.write("fail");
		}
		out.close();
	}
	
	/**
	 * @author Mr.Lin
	 * 出库批量删除操作
	 * @throws Exception 
	 * */
	@RequestMapping(value="/outstorageBatchDel")
	public void outstorageBatchDel(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"出库批量删除");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0; i<ArrayDATA_IDS.length; i++) {
				pd.put("ID", ArrayDATA_IDS[i]);
				warehousingService.output_storageDelete(pd);
			}
			out.write("success");
		}else {
			out.write("fail");
		}
		out.close();
	}
	
	/**
	 * @author Mr.Lin
	 * 出库检验弹出新增界面
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/checkoutAddPage")
	public ModelAndView checkoutAddPage()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = warehousingService.findByOutput_storageId(pd);
		mv.setViewName("fhdb/checkout/incoming_test");
		mv.addObject("msg", "outstorage/checkoutAdd");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 出库检验新增操作
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/checkoutAdd")
	public ModelAndView checkoutAdd()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"出库检验新增");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "sms")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String yuanid = pd.getString("ID");
		pd.put("ID", this.get32UUID());	//主键
		int result = warehousingService.checkoutSave(pd);
		if(result>0) {
			pd.put("ID", yuanid);
			warehousingService.output_storageUpdate(pd);
			mv.addObject("msg","success");
		}else {
			mv.addObject("msg","fail");
		}
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 查询所有拣货  整进整出信息
	 * @param page
	 * @return
	 * @throws Exception 
	 * */
	@RequestMapping(value="/pickingList")
	private ModelAndView findpickingListAll(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername()+"列表pickingList");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();	
		String keywords = pd.getString("keywords");			//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		pd.put("TYPE", "1");  //整进整出数据
		page.setPd(pd);
		List<PageData> list = warehousingService.findBypickingAll(page);
		mv.setViewName("fhdb/picking/pickingManage");
		mv.addObject("varList", list);
		mv.addObject("YK", "1");
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 查询所有拣货  越库信息
	 * @param page
	 * @return
	 * @throws Exception 
	 * */
	@RequestMapping(value="/exceedList")
	private ModelAndView findexceedListAll(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername()+"列表pickingList");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();	
		String keywords = pd.getString("keywords");			//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		pd.put("TYPE", "2");  //一般越库数据
		page.setPd(pd);
		List<PageData> list = warehousingService.findBypickingAll(page);
		mv.setViewName("fhdb/picking/pickingManage");
		mv.addObject("varList", list);
		mv.addObject("YK", "2");
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 拣货弹出新增界面
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/pickingAddPage")
	public ModelAndView pickingAddPage()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String dj = "JH"+sdf.format(new Date());
		System.out.println(pd.get("YK"));
		if(pd.get("YK").toString().equals("1")) {
			mv.setViewName("fhdb/picking/pickingEdit");
		}else {
			mv.setViewName("fhdb/picking/picking_exceedEdit");
		}
		mv.addObject("dj", dj);
		mv.addObject("msg", "pickingAdd");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 拣货新增操作
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/pickingAdd")
	public ModelAndView pickingAdd()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"出库新增");
		if(!Jurisdiction.buttonJurisdiction(pickingmenuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ID", this.get32UUID());	//主键    拣货单id
		String pid = pd.getString("ID");
		int result = warehousingService.pickingSave(pd);
		String OUTID = pd.getString("OUTID"); //获取选择入库单的ID
		if(null != OUTID && !"".equals(OUTID)){
			OUTID = OUTID.replaceAll("；", ";");
			OUTID = OUTID.replaceAll(" ", "");
			String[] arrOUTID = OUTID.split(";");
			for(int i=0; i<arrOUTID.length; i++) {
				pd.put("ID", this.get32UUID());
				pd.put("OID", arrOUTID[i]);
				pd.put("PID", pid);
				warehousingService.outstorage_pickingSave(pd);
			}
		}
		if(result>0) {
			mv.addObject("msg","success");
		}else {
			mv.addObject("msg","fail");
		}
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 选择出库计划页面
	 * @param page
	 * @return
	 * @throws Exception 
	 * */
	@RequestMapping(value="/electOutstoragePage")
	private ModelAndView electOutstoragePage(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername()+"列表output_storageList");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();	
		String keywords = pd.getString("keywords");			//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		if(pd.get("YK").toString().equals("1")) {
			pd.put("TYPE", "2");
			pd.put("STATE", "3");
		}else {
			pd.put("TYPE", "1");
			pd.put("matState", "0");
		}
		page.setPd(pd);
		List<Output_storage> list = warehousingService.findByOutput_storageAll(page);
		mv.setViewName("fhdb/picking/elect_outstorage");
		mv.addObject("varList", list);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 查看拣货单详细信息
	 * @throws Exception 
	 * @return
	 * */
	@RequestMapping(value="/picking_detailedPage")
	public ModelAndView picking_detailedPage(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername()+"列表picking_detailedPage");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		PageData picking = warehousingService.findBypickingId(pd);
		List<PageData> list = warehousingService.findBypickingDetailed(page);
		int mtotal = 0;int ctotal = 0;
		for(PageData p : list) {
			mtotal+=Integer.valueOf(p.get("MONEY").toString());
			ctotal+=Integer.valueOf(p.get("COUNT").toString());
		}
		picking.put("mtotal", mtotal);
		picking.put("ctotal", ctotal);
		mv.addObject("varList", list);
		mv.addObject("picking", picking);
		mv.addObject("pd", pd);
		mv.setViewName("fhdb/picking/picking_detailed");
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 拣货删除操作
	 * @throws Exception 
	 * */
	@RequestMapping(value="/pickingDel")
	public void pickingDel(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"拣货删除");
		if(!Jurisdiction.buttonJurisdiction(pickingmenuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		int result = warehousingService.pickingDelete(pd);
		if(result>0) {
			warehousingService.outstorage_pickingDelete(pd);
			out.write("success");
		}else {
			out.write("fail");
		}
		out.close();
	}
	
}
