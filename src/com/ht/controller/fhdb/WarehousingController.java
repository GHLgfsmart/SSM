package com.ht.controller.fhdb;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ht.controller.base.BaseController;
import com.ht.entity.Materials_information;
import com.ht.entity.Output_storage;
import com.ht.entity.Page;
import com.ht.service.fhdb.Output_typeManager;
import com.ht.service.fhdb.WarehousingManager;
import com.ht.service.fhoa.SupplierAndCustomerManager;
import com.ht.service.fhoa.WSManager;
import com.ht.service.fhoa.impl.CategoriesService;
import com.ht.service.system.MoneyManager;
import com.ht.service.system.PriceManager;
import com.ht.util.DateUtil;
import com.ht.util.Jurisdiction;
import com.ht.util.ObjectExcelView;
import com.ht.util.PageData;
/**
 * 入库控制
 * */
@Controller
@RequestMapping(value="/warehousing")
public class WarehousingController extends BaseController{
		
	String menuUrl = "warehousing/materialsList.do"; //菜单地址(权限用)
	String menuUrls = "warehousing/output_storageList.do"; //菜单地址(权限用)
	String checkmenuUrl = "warehousing/findcheckListAll.do"; //菜单地址(权限用)
	String returnmenuUrl = "warehousing/findsales_returnListAll.do"; //菜单地址(权限用)
	@Resource(name="warehousingService")
	private WarehousingManager warehousingService;
	@Resource
	private Output_typeManager output_typeService;
	@Resource
	private WSManager wSService;
	//洪青青修改
	@Resource(name="priceService")
	private PriceManager priceService;
	@Resource(name="moneyService")
	private MoneyManager moneyService;
	@Resource(name="categoriesService")
	private CategoriesService categoriesService;
	@Resource(name="supplierAndCustomerService")
	private SupplierAndCustomerManager service;
	
	/**
	 * @author Mr.Lin
	 * 查询所有物资信息
	 * @param page
	 * @return
	 * @throws Exception 
	 * */
	@RequestMapping(value="/materialsList")
	private ModelAndView findmaterialsAll(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername()+"列表Materials");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();	
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<Materials_information> list = warehousingService.findBymaterialAll(page);
		mv.setViewName("fhdb/materials/materialsManage");
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
	 * 供应商信息查询
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/SClist")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表supplierAndCustomer");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");					//检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = service.list(page);
		mv.addObject("varList", varList);
		mv.setViewName("fhdb/materials/elect_supplier");
		return mv;
	}
	/**
	 * @author Mr.Lin
	 * 物资弹出新增界面
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/materialsAddPage")
	public ModelAndView warehousingAddPage()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String dj = "WZ"+sdf.format(new Date());
		//洪青青修改
		PageData pd1=Moneytoo();
		mv.addObject("pd1", pd1);
		//--------
		mv.setViewName("fhdb/materials/materialsEdit");
		mv.addObject("dj", dj);
		mv.addObject("msg", "materialsAdd");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 物资新增操作
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/materialsAdd")
	public ModelAndView materialsAdd()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"物资新增");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//洪青青修改
		PageData pd1 = new PageData();
		pd1 = this.getPageData();
		String STORAGE=pd1.getString("STORAGE");
		String RICHARD=pd1.getString("RICHARD");
		String LOADING=pd1.getString("LOADING");
		String UNLOADING=pd1.getString("UNLOADING");
		double MONEY=Double.valueOf(STORAGE);
		pd1.put("ID", this.get32UUID());	//主键
		pd1.put("STORAGE_STATE", '0');
		if(RICHARD == null){
			pd1.put("RICHARD_STATE", '1');
		}else{
			MONEY +=Double.valueOf(RICHARD);
			pd1.put("RICHARD_STATE", '0');
		}
		if(LOADING == null){
			pd1.put("LOADING_STATE", '1');
		}else{
			MONEY +=Double.valueOf(LOADING);
			pd1.put("LOADING_STATE", '0');
		}
		if(UNLOADING == null){
			pd1.put("UNLOADING_STATE", '1');
		}else{
			MONEY +=Double.valueOf(UNLOADING);
			pd1.put("UNLOADING_STATE", '0');
		}
		pd1.put("MONEY", MONEY);
		pd.put("ID", this.get32UUID());	//主键
		pd1.put("PRODUCT_ID", pd.getString("ID"));
		pd1.put("MO_TIME", DateUtil.getTime().toString());
		int result = warehousingService.materialSave(pd);
		pd1.put("PRODUCT_ID", pd.getString("ID"));
		//--------
		if(result>0) {
			moneyService.saveU(pd1);
			mv.addObject("msg","success");
		}else {
			mv.addObject("msg","fail");
		}
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 弹出物资修改界面
	 * @throws Exception 
	 * @return
	 * */
	@RequestMapping(value="/materialsEditPage")
	public ModelAndView materialsEditPage()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = warehousingService.findBymaterialId(pd);
		//洪青青修改
		PageData pd1=Moneytoo();
		PageData pd2 = new PageData();
		pd2.put("PRODUCT_ID", pd.getString("ID"));
		System.out.println("--------"+pd.getString("ID"));
		pd2=moneyService.findById(pd2);
		mv.addObject("pd1", pd1);
		mv.addObject("pd2", pd2);
		//--------
		mv.setViewName("fhdb/materials/materialsEdit");
		mv.addObject("msg", "materialsEdit");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 物资修改操作
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/materialsEdit")
	public ModelAndView materialsEdit()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"物资修改");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ID", pd.getString("ID"));
		//洪青青修改
		PageData pd1 = new PageData();
		pd1 = this.getPageData();
		String STORAGE=pd1.getString("STORAGE");
		String RICHARD=pd1.getString("RICHARD");
		String LOADING=pd1.getString("LOADING");
		String UNLOADING=pd1.getString("UNLOADING");
		System.out.println("======"+STORAGE+"======="+RICHARD+"======="+LOADING+"======"+UNLOADING);
		double MONEY=Double.valueOf(STORAGE);
		pd1.put("STORAGE_STATE", '0');
		if(RICHARD == null){
			pd1.put("RICHARD_STATE", '1');
		}else{
			MONEY +=Double.valueOf(RICHARD);
			pd1.put("RICHARD_STATE", '0');
		}
		if(LOADING == null){
			pd1.put("LOADING_STATE", '1');
		}else{
			MONEY +=Double.valueOf(LOADING);
			pd1.put("LOADING_STATE", '0');
		}
		if(UNLOADING == null){
			pd1.put("UNLOADING_STATE", '1');
		}else{
			MONEY +=Double.valueOf(UNLOADING);
			pd1.put("UNLOADING_STATE", '0');
		}
		pd1.put("MONEY", MONEY);
		int result = warehousingService.materialUpdate(pd);
		pd1.put("PRODUCT_ID", pd.getString("ID"));
		moneyService.editU(pd1);
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
	 * 物资删除操作
	 * @throws Exception 
	 * */
	@RequestMapping(value="/materialsDel")
	public void materialsDel(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"物资删除");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		int result = warehousingService.findBymaterialCount(pd);
		if(result>0) {
			out.write("fail");
		}else {
			warehousingService.materialDelete(pd);
			out.write("success");
		}
		out.close();
	}
	
	/**
	 * @author Mr.Lin
	 * 物资批量删除操作
	 * @throws Exception 
	 * */
	@RequestMapping(value="/materialsBatchDel")
	public void materialsBatchDel(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"物资批量删除");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		String DATA_IDS = pd.getString("DATA_IDS");
		int result = 0;
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0; i<ArrayDATA_IDS.length; i++) {
				pd.put("ID", ArrayDATA_IDS[i]);
				result += warehousingService.findBymaterialCount(pd);
			}
			if(result>0) {
				out.write("fail");
			}else {
				for(int i=0; i<ArrayDATA_IDS.length; i++) {
					pd.put("ID", ArrayDATA_IDS[i]);
					warehousingService.materialDelete(pd);
				}
				out.write("success");
			}
		}else {
			out.write("fail");
		}
		out.close();
	}
	
	/**
	 * @author Mr.Lin
	 * 导出物资信息到EXCEL
	 * @return
	 */
	@RequestMapping(value="/materialsexcel")
	public ModelAndView materialsexcel(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			if(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){
				String keywords = pd.getString("keywords");				//关键词检索条件
				if(null != keywords && !"".equals(keywords)){
					pd.put("keywords", keywords.trim());
				}
				String lastLoginStart = pd.getString("lastLoginStart");	//开始时间
				String lastLoginEnd = pd.getString("lastLoginEnd");		//结束时间
				if(lastLoginStart != null && !"".equals(lastLoginStart)){
					pd.put("lastLoginStart", lastLoginStart+" 00:00:00");
				}
				if(lastLoginEnd != null && !"".equals(lastLoginEnd)){
					pd.put("lastLoginEnd", lastLoginEnd+" 00:00:00");
				} 
				page.setPd(pd);
				Map<String,Object> dataMap = new HashMap<String,Object>();
				List<String> titles = new ArrayList<String>();
				titles.add("单据编号"); 		//1
				titles.add("拼音简码");  	//2
				titles.add("条形码");		//3
				titles.add("物资名称");		//4
				titles.add("供应商");		//5
				titles.add("商品数量");		//6
				titles.add("单位");			//7
				titles.add("录入时间");		//8
				titles.add("最后修改时间");	//9
				titles.add("操作员");		//10
				titles.add("备注");			//11
				titles.add("状态");			//12
				dataMap.put("titles", titles);
				List<Materials_information> userList = warehousingService.findBymaterialAll(page);
				List<PageData> varList = new ArrayList<PageData>();
				String state = "";
				for(int i=0;i<userList.size();i++){
					PageData vpd = new PageData();
					vpd.put("var1", userList.get(i).getBIANHAO());		//1
					vpd.put("var2", userList.get(i).getPINYIN());		//2
					vpd.put("var3", userList.get(i).getBAR_CODE());		//3
					vpd.put("var4", userList.get(i).getNAME());			//4
					vpd.put("var5", userList.get(i).getSupplier().getSUPNAME());		//5
					String count = userList.get(i).getCOUNT()+"";
					vpd.put("var6", count);		//6
					vpd.put("var7", userList.get(i).getUNIT());			//7
					vpd.put("var8", userList.get(i).getENTRY_TIME());	//8
					vpd.put("var9", userList.get(i).getUPDATE_TIME());	//9
					vpd.put("var10", userList.get(i).getOperator());	//10
					vpd.put("var11", userList.get(i).getNOTE());		//11
					state = userList.get(i).getSTATE()+"";
					if(state.equals("0")) {
						state = "待入库";
					}else if(state.equals("1")) {
						state = "已入库";
					}else {
						state = "已出库";
					}
					vpd.put("var12", state);		//12
					varList.add(vpd);
				}
				dataMap.put("varList", varList);
				ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
				mv = new ModelAndView(erv,dataMap);
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 查询所有入库信息
	 * @param page
	 * @return
	 * @throws Exception 
	 * */
	@RequestMapping(value="/output_storageList")
	private ModelAndView findoutput_storageListAll(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername()+"列表output_storageList");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();	
		String keywords = pd.getString("keywords");			//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		pd.put("TYPE", "1");
		page.setPd(pd);
		List<Output_storage> list = warehousingService.findByOutput_storageAll(page);
		mv.setViewName("fhdb/output_storage/output_storageManage");
		mv.addObject("varList", list);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 入库弹出新增界面
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/output_storageAddPage")
	public ModelAndView output_storageAddPage()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String dj = "RK"+sdf.format(new Date());
		mv.setViewName("fhdb/output_storage/output_storageEdit");
		mv.addObject("dj", dj);
		mv.addObject("msg", "output_storageAdd");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 入库新增操作
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/output_storageAdd")
	public ModelAndView output_storageAdd()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"入库新增");
		if(!Jurisdiction.buttonJurisdiction(menuUrls, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ID", this.get32UUID());	//主键
		int result = warehousingService.output_storageSave(pd);
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
	 * 弹出入库选择物资界面
	 * @throws Exception 
	 * */
	@RequestMapping(value="/electMaterialsPage")
	public ModelAndView electMaterialsPage(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<Materials_information> list = warehousingService.findBymaterialAll(page);
		mv.setViewName("fhdb/output_storage/elect_materials");
		mv.addObject("varList", list);
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 弹出入库选择出入库类型界面
	 * @throws Exception 
	 * */
	@RequestMapping(value="/electOutPutTypePage")
	public ModelAndView electOutPutTypePage(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> list = output_typeService.listOutput(page);
		mv.setViewName("fhdb/output_storage/elect_outputType");
		mv.addObject("varList", list);
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 弹出入库修改界面
	 * @throws Exception 
	 * @return
	 * */
	@RequestMapping(value="/output_storageEditPage")
	public ModelAndView output_storageEditPage()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = warehousingService.findByOutput_storageId(pd);
		mv.setViewName("fhdb/output_storage/output_storageEdit");
		mv.addObject("msg", "output_storageEdit");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 入库修改操作
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/output_storageEdit")
	public ModelAndView output_storageEdit()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"入库修改");
		if(!Jurisdiction.buttonJurisdiction(menuUrls, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		int result = warehousingService.output_storageUpdate(pd);
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
	 * 入库删除操作
	 * @throws Exception 
	 * */
	@RequestMapping(value="/output_storageDel")
	public void output_storageDel(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"入库删除");
		if(!Jurisdiction.buttonJurisdiction(menuUrls, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		int result = warehousingService.findBypickingCount(pd); //判断拣货表是否已拣货
		if(result>0) {
			out.write("fail");
		}else {
			warehousingService.output_storageDelete(pd);
			out.write("success");
		}
		out.close();
	}
	
	/**
	 * @author Mr.Lin
	 * 入库批量删除操作
	 * @throws Exception 
	 * */
	@RequestMapping(value="/output_storageBatchDel")
	public void output_storageBatchDel(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"入库批量删除");
		if(!Jurisdiction.buttonJurisdiction(menuUrls, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		String DATA_IDS = pd.getString("DATA_IDS");
		int result = 0;
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0; i<ArrayDATA_IDS.length; i++) {
				pd.put("ID", ArrayDATA_IDS[i]);
				result += warehousingService.findBypickingCount(pd); //判断拣货表是否已拣货
			}
			if(result>0) {
				out.write("fail");
			}else {
				for(int i=0; i<ArrayDATA_IDS.length; i++) {
					pd.put("ID", ArrayDATA_IDS[i]);
					warehousingService.output_storageDelete(pd);
				}
				out.write("success");
			}
		}else {
			out.write("fail");
		}
		out.close();
	}
	
	/**
	 * @author Mr.Lin
	 * 导出入库信息到EXCEL
	 * @return
	 */
	@RequestMapping(value="/output_storageExcel")
	public ModelAndView output_storageExcel(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			if(Jurisdiction.buttonJurisdiction(menuUrls, "cha")){
				String keywords = pd.getString("keywords");				//关键词检索条件
				if(null != keywords && !"".equals(keywords)){
					pd.put("keywords", keywords.trim());
				}
				String lastLoginStart = pd.getString("lastLoginStart");	//开始时间
				String lastLoginEnd = pd.getString("lastLoginEnd");		//结束时间
				if(lastLoginStart != null && !"".equals(lastLoginStart)){
					pd.put("lastLoginStart", lastLoginStart+" 00:00:00");
				}
				if(lastLoginEnd != null && !"".equals(lastLoginEnd)){
					pd.put("lastLoginEnd", lastLoginEnd+" 00:00:00");
				} 
				page.setPd(pd);
				Map<String,Object> dataMap = new HashMap<String,Object>();
				List<String> titles = new ArrayList<String>();
				titles.add("序号");
				titles.add("单据编号"); 		//1
				titles.add("物资名称");  	//2
				titles.add("仓库名称");		//3
				titles.add("出入库类型");	//4
				titles.add("单据金额");		//5
				titles.add("单据数量");		//6
				titles.add("状态");			//7
				titles.add("操作员");		//8
				titles.add("录入时间");		//9
				titles.add("最后修改时间");	//10
				titles.add("原始单号");		//11
				titles.add("备注");			//12
				dataMap.put("titles", titles);
				List<Output_storage> userList = warehousingService.findByOutput_storageAll(page);
				List<PageData> varList = new ArrayList<PageData>();
				String state = "";
				for(int i=0;i<userList.size();i++){
					PageData vpd = new PageData();
					vpd.put("var1", i+1+"");
					vpd.put("var2", userList.get(i).getBIANHAO());		//1
					vpd.put("var3", userList.get(i).getMaterials().getNAME());		//2
					vpd.put("var4", userList.get(i).getWarehouse().getWARNAME());	//3
					vpd.put("var5", userList.get(i).getOutput_put().getOPTNAME());	//4
					String money = userList.get(i).getMONEY()+"";
					vpd.put("var6", money);		//5
					String count = userList.get(i).getNUMBER_OF()+"";
					vpd.put("var7", count);		//6
					state = userList.get(i).getSTATE()+"";
					if(state.equals("0")) {
						state = "待检验";
					}else if(state.equals("1")) {
						state = "已检验";
					}else {
						state = "不合格";
					}
					vpd.put("var8", state);		//7
					vpd.put("var9", userList.get(i).getUser().getUSERNAME());//8
					vpd.put("var10", userList.get(i).getENTRY_TIME());	//9
					vpd.put("var11", userList.get(i).getUPDATE_TIME());	//10
					vpd.put("var12", userList.get(i).getRAW_NUMBER());	//11
					vpd.put("var13", userList.get(i).getNOTE());		//12
					varList.add(vpd);
				}
				dataMap.put("varList", varList);
				ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
				mv = new ModelAndView(erv,dataMap);
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 入库检验弹出新增界面
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/outputcheckoutAddPage")
	public ModelAndView outputcheckoutAddPage()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String yanzheng = pd.getString("yan");
		if(yanzheng.equals("rk")) {
			pd = warehousingService.findByOutput_storageId(pd);
			mv.addObject("msg", "warehousing/checkoutAdd");
		}else if(yanzheng.equals("th")) {
			pd = warehousingService.findBysalesreturnId(pd);
			mv.addObject("msg", "warehousing/returncheckoutAdd");
		}
		mv.setViewName("fhdb/checkout/incoming_test");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 入库检验新增操作
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/checkoutAdd")
	public ModelAndView checkoutAdd()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"检验新增");
		if(!Jurisdiction.buttonJurisdiction(menuUrls, "sms")){return null;} //校验权限
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
	 * 退货检验新增操作
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/returncheckoutAdd")
	public ModelAndView returncheckoutAdd()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"检验新增");
		if(!Jurisdiction.buttonJurisdiction(returnmenuUrl, "sms")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String yuanid = pd.getString("ID");
		pd.put("ID", this.get32UUID());	//主键
		int result = warehousingService.checkoutSave(pd);
		if(result>0) {
			pd.put("ID", yuanid);
			warehousingService.salesreturnUpdate(pd);
			mv.addObject("msg","success");
		}else {
			mv.addObject("msg","fail");
		}
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 查询所有检验信息
	 * @param page
	 * @return
	 * @throws Exception 
	 * */
	@RequestMapping(value="/findcheckListAll")
	private ModelAndView findcheckListAll(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername()+"列表findcheckListAll");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();	
		String keywords = pd.getString("keywords");			//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> list = warehousingService.findByCheckoutAll(page);
		mv.setViewName("fhdb/checkout/checkoutManage");
		mv.addObject("varList", list);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 弹出检验修改界面
	 * @throws Exception 
	 * @return
	 * */
	@RequestMapping(value="/checkoutEditPage")
	public ModelAndView checkoutEditPage()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		PageData paged = new PageData();
		pd = this.getPageData();
		pd = warehousingService.findBycheckoutId(pd);
		String type = pd.getString("SOURCECODE").substring(0, 2);
		if(type != null) {
			if(type.equals("RK") || type.equals("CK")) {
				paged = warehousingService.findByOutput_storageNum(pd);
			}else if(type.equals("TH")) {
				paged = warehousingService.findBysalesreturnState(pd);
			}
		}
		pd.put("yan", type);
		mv.setViewName("fhdb/checkout/incoming_test");
		mv.addObject("msg", "warehousing/checkoutEdit");
		mv.addObject("pd", pd);
		mv.addObject("oppd", paged);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 检验修改操作
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/checkoutEdit")
	public ModelAndView checkoutEdit()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"检验修改");
		if(!Jurisdiction.buttonJurisdiction(checkmenuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String yanzheng = pd.getString("yan");
		String oupid = pd.getString("OPID");
		int result = warehousingService.checkoutUpdate(pd);
		if(result>0) {
			pd.put("ID", oupid);
			if(yanzheng.equals("RK") || yanzheng.equals("CK")) {
				warehousingService.output_storageUpdate(pd);
			}else if(yanzheng.equals("TH")) {
				warehousingService.salesreturnUpdate(pd);
			}
			mv.addObject("msg","success");
		}else {
			mv.addObject("msg","fail");
		}
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 检验删除操作
	 * @throws Exception 
	 * */
	@RequestMapping(value="/checkoutDel")
	public void checkoutDel(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"检验删除");
		if(!Jurisdiction.buttonJurisdiction(checkmenuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		int result = warehousingService.checkoutDelete(pd);
		if(result>0) {
			out.write("success");
		}else {
			out.write("fail");
		}
		out.close();
	}
	
	/**
	 * @author Mr.Lin
	 * 检验批量删除操作
	 * @throws Exception 
	 * */
	@RequestMapping(value="/checkoutBatchDel")
	public void checkoutBatchDel(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"检验批量删除");
		if(!Jurisdiction.buttonJurisdiction(checkmenuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0; i<ArrayDATA_IDS.length; i++) {
				pd.put("ID", ArrayDATA_IDS[i]);
				warehousingService.checkoutDelete(pd);
			}
			out.write("success");
		}else {
			out.write("fail");
		}
		out.close();
	}
	
	/**
	 * @author Mr.Lin
	 * 导出检验信息到EXCEL
	 * @return
	 */
	@RequestMapping(value="/checkoutExcel")
	public ModelAndView checkoutExcel(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			if(Jurisdiction.buttonJurisdiction(checkmenuUrl, "cha")){
				String keywords = pd.getString("keywords");				//关键词检索条件
				if(null != keywords && !"".equals(keywords)){
					pd.put("keywords", keywords.trim());
				}
				String lastLoginStart = pd.getString("lastLoginStart");	//开始时间
				String lastLoginEnd = pd.getString("lastLoginEnd");		//结束时间
				if(lastLoginStart != null && !"".equals(lastLoginStart)){
					pd.put("lastLoginStart", lastLoginStart+" 00:00:00");
				}
				if(lastLoginEnd != null && !"".equals(lastLoginEnd)){
					pd.put("lastLoginEnd", lastLoginEnd+" 00:00:00");
				} 
				page.setPd(pd);
				Map<String,Object> dataMap = new HashMap<String,Object>();
				List<String> titles = new ArrayList<String>();
				titles.add("序号");
				titles.add("单号"); 			//1
				titles.add("检测单类型");  	//2
				titles.add("总数量");		//3
				titles.add("坏货数量");		//4
				titles.add("坏货原因");		//5
				titles.add("缺货数量");		//6
				titles.add("缺货原因");		//7
				titles.add("状态");			//8
				titles.add("检测时间");		//9
				titles.add("检测员");		//10
				dataMap.put("titles", titles);
				List<PageData> userList = warehousingService.findByCheckoutAll(page);
				List<PageData> varList = new ArrayList<PageData>();
				String state = "";
				for(int i=0;i<userList.size();i++){
					PageData vpd = new PageData();
					vpd.put("var1", i+1+"");
					vpd.put("var2", userList.get(i).getString("SOURCECODE"));		//1
					vpd.put("var3", userList.get(i).getString("OPTNAME"));		//2
					String quantity = userList.get(i).get("QUANTITY")+"";
					vpd.put("var4", quantity);	//3
					String damagedqty = userList.get(i).get("DAMAGEDQTY")+"";
					vpd.put("var5", damagedqty);	//4
					vpd.put("var6", userList.get(i).getString("DAMAGEDREASON"));		//5
					String shortqty = userList.get(i).get("SHORTQTY")+"";
					vpd.put("var7", shortqty);		//6
					vpd.put("var8", userList.get(i).getString("SHORTREASON"));//7
					state = userList.get(i).get("STATE")+"";	//8
					if(state.equals("1")) {
						state = "检验成功";
					}else if(state.equals("2")) {
						state = "不合格";
					}
					vpd.put("var9", state);		//9
					vpd.put("var10", userList.get(i).getString("TIME"));	//10
					vpd.put("var11", userList.get(i).getString("INSPECTOR"));	//11
					varList.add(vpd);
				}
				dataMap.put("varList", varList);
				ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
				mv = new ModelAndView(erv,dataMap);
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 查询所有已检验入库信息
	 * @param page
	 * @return
	 * @throws Exception 
	 * */
	@RequestMapping(value="/findput_storage_checkoutListAll")
	private ModelAndView findput_storage_checkoutListAll(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername()+"列表findput_storage_checkoutListAll");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();	
		String keywords = pd.getString("keywords");			//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		pd.put("STATE", "1"); //已检验通过
		page.setPd(pd);
		List<Output_storage> list = warehousingService.findByOutput_storageAll(page);
		mv.setViewName("fhdb/output_storage/putstorage_distribute");
		mv.addObject("varList", list);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 弹出分配仓库界面
	 * @throws Exception 
	 * @return
	 * */
	@RequestMapping(value="/distribute_warehousePage")
	public ModelAndView distribute_warehousePage(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		pd = warehousingService.findByOutput_storageId(pd);
		mv.setViewName("fhdb/output_storage/distribute_warehouse");
		mv.addObject("pd", pd);
		mv.addObject("msg", "distribute_warehouse");
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 弹出选择仓库界面
	 * @throws Exception 
	 * @return
	 * */
	@RequestMapping(value="/elect_warehousePage")
	public ModelAndView elect_warehousePage(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("STATE", "0"); //查询出全部为启用的仓库
		pd.put("WNAME", "Stage区");
		page.setPd(pd);
		List<PageData> warehouseList = wSService.listWarehouse(page);
		mv.setViewName("fhdb/output_storage/elect_warehouse");
		mv.addObject("varList", warehouseList);
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 分配仓库操作
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/distribute_warehouse")
	public ModelAndView distribute_warehouse()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"分配仓库操作");
		if(!Jurisdiction.buttonJurisdiction(menuUrls, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		int result = warehousingService.output_storageUpdate(pd);
		if(result>0) {
			pd.put("ID", pd.get("WAREHOUSE_ID"));
			wSService.editWarehouseCountadd(pd);	//仓库库存增加
			System.out.println(pd.get("ID")+"**************");
			pd.put("ID", pd.get("MATERIALS_ID"));
			System.out.println(pd.get("ID")+"////////////");
			warehousingService.materialUpdate(pd);  //物资改为已入库
			mv.addObject("msg","success");
		}else {
			mv.addObject("msg","fail");
		}
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 查询所有退货入库信息
	 * @param page
	 * @return
	 * @throws Exception 
	 * */
	@RequestMapping(value="/findsales_returnListAll")
	private ModelAndView findsales_returnListAll(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername()+"列表findsales_returnListAll");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();	
		String keywords = pd.getString("keywords");			//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> list = warehousingService.findBysalesreturnAll(page);
		mv.setViewName("fhdb/sales_return/sales_returnManage");
		mv.addObject("varList", list);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**
	 * @author 洪青青
	 * 判断退货数量不能大于实际数量
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/numbers")
	public void numbers(PrintWriter out) throws Exception{
		try{
		PageData pd = new PageData();
		pd = this.getPageData();
		int numbers=moneyService.numbers(pd);
		pd=moneyService.countsum(pd);
		int number=Integer.valueOf(pd.get("ID").toString());
		if(number!=0){
			out.write(""+numbers+";"+pd.get("ID")+";"+pd.get("COUNT"));
		}else{
			out.write(""+numbers);
		}
		}catch(Exception e){
			out.write("fall");
			e.getStackTrace();
		}
		out.close();
	}
	/**
	 * @author 洪青青
	 * 查询所有出库信息
	 * @param page
	 * @return
	 * @throws Exception 
	 * */
	@RequestMapping(value="/OUTlist")
	private ModelAndView OUTlist(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername()+"列表OUTlist");
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
		mv.setViewName("fhdb/sales_return/outlist");
		mv.addObject("varList", list);
		mv.addObject("pd", pd);
		return mv;
	}
	/**
	 * @author Mr.Lin
	 * 退货单弹出新增界面
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/sales_returnAddPage")
	public ModelAndView sales_returnAddPage()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String dj = "TH"+sdf.format(new Date());
		//洪青青修改
		PageData pd1=Moneytoo();
		mv.addObject("pd1", pd1);
		//--------
		mv.setViewName("fhdb/sales_return/sales_returnEdit");
		mv.addObject("dj", dj);
		mv.addObject("msg", "sales_returnAdd");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 退货单新增操作
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/sales_returnAdd")
	public ModelAndView sales_returnAdd()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"检验新增");
		if(!Jurisdiction.buttonJurisdiction(returnmenuUrl, "sms")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ID", this.get32UUID());	//主键
		//洪青青修改
		PageData pd1 = new PageData();
		pd1 = this.getPageData();
		String STORAGE=pd1.getString("STORAGE");
		String RICHARD=pd1.getString("RICHARD");
		String LOADING=pd1.getString("LOADING");
		String UNLOADING=pd1.getString("UNLOADING");
		double MONEY=Double.valueOf(STORAGE);
		pd1.put("ID", this.get32UUID());	//主键
		pd1.put("STORAGE_STATE", '0');
		if(RICHARD == null){
			pd1.put("RICHARD_STATE", '1');
		}else{
			MONEY +=Double.valueOf(RICHARD);
			pd1.put("RICHARD_STATE", '0');
		}
		if(LOADING == null){
			pd1.put("LOADING_STATE", '1');
		}else{
			MONEY +=Double.valueOf(LOADING);
			pd1.put("LOADING_STATE", '0');
		}
		if(UNLOADING == null){
			pd1.put("UNLOADING_STATE", '1');
		}else{
			MONEY +=Double.valueOf(UNLOADING);
			pd1.put("UNLOADING_STATE", '0');
		}
		pd1.put("STATE", "0");
		pd1.put("MONEY", MONEY);
		pd1.put("MO_TIME", DateUtil.getTime().toString());
		int result = warehousingService.salesreturnSave(pd);
		pd1.put("PRODUCT_ID", pd.getString("ID"));
		int result1=moneyService.totalsaveU(pd1);
		//--------
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
	 * 退货单修改界面
	 * @throws Exception 
	 * @return
	 * */
	@RequestMapping(value="/sales_returnEditPage")
	public ModelAndView sales_returnEditPage()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = warehousingService.findBysalesreturnId(pd);
		//洪青青修改
		PageData pd1=Moneytoo();
		PageData pd2 = new PageData();
		pd2.put("PRODUCT_ID", pd.getString("ID"));
		pd2=moneyService.findById(pd2);
		mv.addObject("pd1", pd1);
		mv.addObject("pd2", pd2);
		//--------
		mv.setViewName("fhdb/sales_return/sales_returnEdit");
		mv.addObject("msg", "sales_returnEdit");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 退货单修改操作
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/sales_returnEdit")
	public ModelAndView sales_returnEdit()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"退货单修改");
		if(!Jurisdiction.buttonJurisdiction(returnmenuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//洪青青修改
		PageData pd1 = new PageData();
		pd1 = this.getPageData();
		String STORAGE=pd1.getString("STORAGE");
		String RICHARD=pd1.getString("RICHARD");
		String LOADING=pd1.getString("LOADING");
		String UNLOADING=pd1.getString("UNLOADING");
		double MONEY=Double.valueOf(STORAGE);
		pd1.put("STORAGE_STATE", '0');
		if(RICHARD == null){
			pd1.put("RICHARD_STATE", '1');
		}else{
			MONEY +=Double.valueOf(RICHARD);
			pd1.put("RICHARD_STATE", '0');
		}
		if(LOADING == null){
			pd1.put("LOADING_STATE", '1');
		}else{
			MONEY +=Double.valueOf(LOADING);
			pd1.put("LOADING_STATE", '0');
		}
		if(UNLOADING == null){
			pd1.put("UNLOADING_STATE", '1');
		}else{
			MONEY +=Double.valueOf(UNLOADING);
			pd1.put("UNLOADING_STATE", '0');
		}
		pd1.put("MONEY", MONEY);
		int result = warehousingService.salesreturnUpdate(pd);
		pd1.put("PRODUCT_ID", pd.getString("ID"));
		int result1 =  moneyService.totaleditU(pd1);
		//-------------
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
	 * 退货单批量删除操作
	 * @throws Exception 
	 * */
	@RequestMapping(value="/sales_returnBatchDel")
	public void sales_returnBatchDel(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"退货单批量删除");
		if(!Jurisdiction.buttonJurisdiction(returnmenuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0; i<ArrayDATA_IDS.length; i++) {
				pd.put("ID", ArrayDATA_IDS[i]);
				warehousingService.salesreturnDelete(pd);
			}
			out.write("success");
		}else {
			out.write("fail");
		}
		out.close();
	}
	
	/**
	 * @author Mr.Lin
	 * 主管审核操作
	 * @throws Exception 
	 * */
	@RequestMapping(value="/sales_returnAuditing")
	public void sales_returnAuditing(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"主管审核操作");
		if(!Jurisdiction.buttonJurisdiction(returnmenuUrl, "email")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		int result = warehousingService.salesreturnUpdate(pd);
		if(result>0) {
			pd.put("ID", pd.get("WAREHOUSE_ID"));
			wSService.editWarehouseCountadd(pd);	//仓库库存增加
			out.write("success");
		}else {
			out.write("fail");
		}
		out.close();
	}
	
	/**
	 * @author Mr.Lin
	 * 导出退货入库信息到EXCEL
	 * @return
	 */
	@RequestMapping(value="/sales_returnExcel")
	public ModelAndView sales_returnExcel(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			if(Jurisdiction.buttonJurisdiction(returnmenuUrl, "cha")){
				String keywords = pd.getString("keywords");				//关键词检索条件
				if(null != keywords && !"".equals(keywords)){
					pd.put("keywords", keywords.trim());
				}
				String lastLoginStart = pd.getString("lastLoginStart");	//开始时间
				String lastLoginEnd = pd.getString("lastLoginEnd");		//结束时间
				if(lastLoginStart != null && !"".equals(lastLoginStart)){
					pd.put("lastLoginStart", lastLoginStart+" 00:00:00");
				}
				if(lastLoginEnd != null && !"".equals(lastLoginEnd)){
					pd.put("lastLoginEnd", lastLoginEnd+" 00:00:00");
				} 
				page.setPd(pd);
				Map<String,Object> dataMap = new HashMap<String,Object>();
				List<String> titles = new ArrayList<String>();
				titles.add("序号");
				titles.add("退货单号"); 		//1
				titles.add("出库单号");  	//2
				titles.add("出库仓库");		//3
				titles.add("入库仓库");		//4
				titles.add("出入库类型");	//5
				titles.add("制单时间");		//6
				titles.add("退货数量");		//7
				titles.add("操作员");	//8
				titles.add("状态");		//9
				titles.add("备注");		//10
				dataMap.put("titles", titles);
				List<PageData> userList = warehousingService.findBysalesreturnAll(page);
				List<PageData> varList = new ArrayList<PageData>();
				String state = "";
				for(int i=0;i<userList.size();i++){
					PageData vpd = new PageData();
					vpd.put("var1", i+1+"");
					vpd.put("var2", userList.get(i).getString("RETREAT_CODE"));		//1
					vpd.put("var3", userList.get(i).getString("OUT_CODE"));		//2
					vpd.put("var4", userList.get(i).getString("OTNAME"));	//3
					vpd.put("var5", userList.get(i).getString("PTNAME"));	//4
					vpd.put("var6", userList.get(i).getString("OPTNAME"));	//5
					vpd.put("var7", userList.get(i).getString("MAKETIME"));	//6
					String count = userList.get(i).get("COUNT")+"";
					vpd.put("var8", count);		//7
					vpd.put("var9", userList.get(i).getString("INSPECTOR"));	//8
					state = userList.get(i).get("STATE")+"";
					if(state.equals("0")) {
						state = "待检验";
					}else if(state.equals("1")) {
						state = "已检验";
					}else if(state.equals("2")){
						state = "不合格";
					}else if(state.equals("3")){
						state = "审核成功";
					}
					vpd.put("var10", state);		//9
					vpd.put("var11", userList.get(i).getString("NOTE"));	//11
					varList.add(vpd);
				}
				dataMap.put("varList", varList);
				ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
				mv = new ModelAndView(erv,dataMap);
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
}
