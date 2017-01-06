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
import com.ht.entity.Materials_information;
import com.ht.entity.Output_storage;
import com.ht.entity.Page;
import com.ht.service.fhdb.WarehousingManager;
import com.ht.service.fhoa.SupplierAndCustomerManager;
import com.ht.service.fhoa.impl.CategoriesService;
import com.ht.service.system.MoneyManager;
import com.ht.service.system.PriceManager;
import com.ht.util.DateUtil;
import com.ht.util.Jurisdiction;
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
		moneyService.saveU(pd1);
		//--------
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
	 * 弹出物资选择供应商界面
	 * @throws Exception 
	 * */
	@RequestMapping(value="/testPage")
	public ModelAndView testPage(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<Materials_information> list = warehousingService.findBymaterialAll(page);
		mv.setViewName("fhdb/materials/elect_supplier");
		mv.addObject("varList", list);
		mv.addObject("pd", pd);
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
		int result = warehousingService.materialUpdate(pd);
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
		int result = warehousingService.materialDelete(pd);
		if(result>0) {
			out.write("success");
		}else {
			out.write("fail");
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
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0; i<ArrayDATA_IDS.length; i++) {
				pd.put("ID", ArrayDATA_IDS[i]);
				warehousingService.materialDelete(pd);
			}
			out.write("success");
		}else {
			out.write("fail");
		}
		out.close();
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
		//pd.put("STATE", "0");
		page.setPd(pd);
		List<Materials_information> list = warehousingService.findBymaterialAll(page);
		mv.setViewName("fhdb/output_storage/elect_materials");
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
		if(!Jurisdiction.buttonJurisdiction(menuUrls, "add")){return null;} //校验权限
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
		if(!Jurisdiction.buttonJurisdiction(returnmenuUrl, "add")){return null;} //校验权限
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
		mv.addObject("msg", "checkoutEdit");
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
	public ModelAndView distribute_warehousePage()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = warehousingService.findByOutput_storageId(pd);
		mv.setViewName("fhdb/output_storage/distribute_warehouse");
		mv.addObject("msg", "distribute_warehouse");
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
			/**仓库库存增加
			 * 物资状态改为已入库
			 * 待加
			 * 
			 * */
			// TODO Auto-generated method stub
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
		if(!Jurisdiction.buttonJurisdiction(returnmenuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ID", this.get32UUID());	//主键
		int result = warehousingService.salesreturnSave(pd);
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
		int result = warehousingService.salesreturnUpdate(pd);
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
	 * 退货单删除操作
	 * @throws Exception 
	 * */
	@RequestMapping(value="/sales_returnDel")
	public void sales_returnDel(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"退货单删除");
		if(!Jurisdiction.buttonJurisdiction(returnmenuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		int result = warehousingService.salesreturnDelete(pd);
		if(result>0) {
			out.write("success");
		}else {
			out.write("fail");
		}
		out.close();
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
		if(!Jurisdiction.buttonJurisdiction(returnmenuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		int result = warehousingService.salesreturnUpdate(pd);
		if(result>0) {
			/**
			 * 审核成功后仓库库存需要增加
			 * 
			 * */
			// TODO Auto-generated method stub
			out.write("success");
		}else {
			out.write("fail");
		}
		out.close();
	}
}
