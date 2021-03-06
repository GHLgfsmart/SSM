package com.ht.controller.fhdb;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ht.controller.base.BaseController;
import com.ht.entity.Output_storage;
import com.ht.entity.Page;
import com.ht.entity.User;
import com.ht.service.fhdb.WarehousingManager;
import com.ht.service.fhoa.WSManager;
import com.ht.service.system.MoneyManager;
import com.ht.service.system.PriceManager;
import com.ht.util.Const;
import com.ht.util.Jurisdiction;
import com.ht.util.ObjectExcelView;
import com.ht.util.PageData;
/**
 * 出库控制
 * */
@Controller
@RequestMapping(value="/outstorage")
public class OutstorageController extends BaseController{
	
	String menuUrl = "outstorage/outstorageList.do"; //菜单地址(权限用)
	String pickingmenuUrl = "outstorage/pickingList.do"; //菜单地址(权限用)
	String picking_exceedmenuUrl = "outstorage/exceedList.do"; //菜单地址(权限用)
	@Resource(name="warehousingService")
	private WarehousingManager warehousingService;
	@Resource
	private WSManager wSService;
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
	 * 主管审核操作
	 * @throws Exception 
	 * */
	@RequestMapping(value="/outstorageAuditing")
	public void outstorageAuditing(HttpServletRequest request,PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"主管审核操作");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "email")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		if(pd.get("STATE").equals("3")) {
			HttpSession session = request.getSession();
			User u = (User)session.getAttribute(Const.SESSION_USER);
			pd.put("AUDITOR", u.getUSERNAME());
		}else {
			pd.put("AUDITOR", "暂无");
		}
		int result = warehousingService.output_storageUpdate(pd);
		if(result>0) {
			pd.put("ID", pd.get("WAREHOUSE_ID"));
			wSService.editWarehouseCountreduce(pd);	//仓库库存减少
			out.write("success");
		}else {
			out.write("fail");
		}
		out.close();
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
	 * 导出出库信息到EXCEL
	 * @return
	 */
	@RequestMapping(value="/output_storageExcel")
	public ModelAndView output_storageExcel(Page page){
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
				titles.add("审核人");		//12
				titles.add("备注");			//13
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
					}else if(state.equals("2")){
						state = "不合格";
					}else {
						state = "审核成功";
					}
					vpd.put("var8", state);		//7
					vpd.put("var9", userList.get(i).getUser().getUSERNAME());//8
					vpd.put("var10", userList.get(i).getENTRY_TIME());	//9
					vpd.put("var11", userList.get(i).getUPDATE_TIME());	//10
					vpd.put("var12", userList.get(i).getRAW_NUMBER());	//11
					vpd.put("var13", userList.get(i).getAUDITOR());		//12
					vpd.put("var14", userList.get(i).getNOTE());		//13
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
		mv.setViewName("fhdb/picking/picking_exceedManage");
		mv.addObject("varList", list);
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
		if(pd.get("YK").toString().equals("1")) {
			mv.setViewName("fhdb/picking/pickingEdit");
			mv.addObject("msg", "pickingAdd");
		}else {
			//洪青青修改
			PageData pd1=Moneytoo();
			mv.addObject("pd1", pd1);
			//--------
			mv.setViewName("fhdb/picking/picking_exceedEdit");
			mv.addObject("msg", "pickingexceedAdd");
		}
		String str = "";
		List<PageData> list = warehousingService.findoutstorageByPType(pd);
		for(PageData p : list) {
			if(str=="" && str.equals("")) {
				str+=p.getString("OID");
			}else {
				str += ";"+p.getString("OID");
			}
		}
		pd.put("oid", str);
		mv.addObject("dj", dj);
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 拣货新增操作 整进整出
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/pickingAdd")
	public ModelAndView pickingAdd()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"拣货新增");
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
	 * 拣货新增操作  越货
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/pickingexceedAdd")
	public ModelAndView pickingexceedAdd()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"拣货新增");
		if(!Jurisdiction.buttonJurisdiction(picking_exceedmenuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//洪青青修改
		try{
			PageData pd1 = new PageData();
			pd1 = this.getPageData();
			//-----
			pd.put("ID", this.get32UUID());	//主键    拣货单id
			String pid = pd.getString("ID");
			int result = warehousingService.pickingSave(pd);
			String OUTID = pd.getString("OUTID"); //获取选择入库单的ID
			int result1=0;
			if(null != OUTID && !"".equals(OUTID)){
				OUTID = OUTID.replaceAll("；", ";");
				OUTID = OUTID.replaceAll(" ", "");
				String[] arrOUTID = OUTID.split(";");
				//洪青青修改
				String[] STORAGE = (""+pd1.get("STORAGE")).split(";");
				for(int i=0; i<arrOUTID.length; i++) {
					pd.put("ID", this.get32UUID());
					pd.put("OID", arrOUTID[i]);
					pd.put("PID", pid);
					warehousingService.outstorage_pickingSave(pd);
					pd1.put("ID", pd.getString("OID"));
					pd1=moneyService.outmoney(pd1);//查询money
					pd1.put("ID", pd.getString("OID"));
					Object money= pd1.get("MONEY");
					pd1.put("PRODUCT_ID", pd1.getString("PRODUCT_ID"));
					double moneys=Double.valueOf(""+money)-Double.valueOf(STORAGE[i]);
					pd1.put("MONEY", moneys);
					moneyService.maeditU(pd1);//修改物质状态
					moneyService.OuteditU(pd1);				//修改出货单的money
					result1=moneyService.moneyeditU(pd1);//修改money
				}
			}
			if(result>0 || result1>0) {
				mv.addObject("msg","success");
			}else {
				mv.addObject("msg","fail");
			}
		}catch(Exception e){
			e.fillInStackTrace();
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
			pd.put("STATE", "1");
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
	 * 拣货删除操作 整进整出
	 * @throws Exception 
	 * */
	@RequestMapping(value="/pickingDel")
	public void pickingDel(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"拣货删除");
		if(!Jurisdiction.buttonJurisdiction(pickingmenuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		int result = warehousingService.outstorage_pickingDelete(pd);
		if(result>0) {
			warehousingService.pickingDelete(pd);
			out.write("success");
		}else {
			out.write("fail");
		}
		out.close();
	}
	
	/**
	 * @author Mr.Lin
	 * 拣货删除操作 越库
	 * @throws Exception 
	 * */
	@RequestMapping(value="/picking_exceedDel")
	public void picking_exceedDel(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"拣货删除");
		if(!Jurisdiction.buttonJurisdiction(picking_exceedmenuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		int result = warehousingService.outstorage_pickingDelete(pd);
		if(result>0) {
			warehousingService.pickingDelete(pd);
			out.write("success");
		}else {
			out.write("fail");
		}
		out.close();
	}
	
	/**
	 * @author Mr.Lin
	 * 导出拣货信息到EXCEL 整进整出
	 * @return
	 */
	@RequestMapping(value="/pickingExcel")
	public ModelAndView pickingExcel(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			if(Jurisdiction.buttonJurisdiction(pickingmenuUrl, "cha")){
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
				titles.add("拣取数量");  	//2
				titles.add("出库单数");		//3
				titles.add("拣取时间");		//4
				titles.add("装车状态");		//5
				titles.add("操作员");		//6
				titles.add("越库");			//7
				titles.add("备注");			//8
				dataMap.put("titles", titles);
				List<PageData> userList = warehousingService.findBypickingAll(page);
				List<PageData> varList = new ArrayList<PageData>();
				String state = "";
				String type = "";
				for(int i=0;i<userList.size();i++){
					PageData vpd = new PageData();
					vpd.put("var1", i+1+"");
					vpd.put("var2", userList.get(i).getString("BIANHAO"));		//1
					vpd.put("var3", userList.get(i).get("COUNT").toString());		//2
					vpd.put("var4", userList.get(i).get("MATCOUNT").toString());	//3
					vpd.put("var5", userList.get(i).getString("TIME"));	//4
					state = userList.get(i).get("STATE")+"";
					if(state.equals("1")) {
						state = "未装车";
					}else {
						state = "已装车";
					}
					vpd.put("var6", state);		//5
					vpd.put("var7", userList.get(i).getString("INSPECTOR"));//6
					type = userList.get(i).get("TYPE")+"";
					if(type.equals("1")) {
						type = "整进整出";
					}else {
						type = "一般越库";
					}
					vpd.put("var8", type);	//7
					vpd.put("var9", userList.get(i).getString("NOTE"));		//8
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
	 * 导出拣货信息到EXCEL 越库
	 * @return
	 */
	@RequestMapping(value="/picking_exceedExcel")
	public ModelAndView picking_exceedExcel(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			if(Jurisdiction.buttonJurisdiction(picking_exceedmenuUrl, "cha")){
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
				titles.add("拣取数量");  	//2
				titles.add("出库单数");		//3
				titles.add("拣取时间");		//4
				titles.add("装车状态");		//5
				titles.add("操作员");		//6
				titles.add("越库");			//7
				titles.add("备注");			//8
				dataMap.put("titles", titles);
				List<PageData> userList = warehousingService.findBypickingAll(page);
				List<PageData> varList = new ArrayList<PageData>();
				String state = "";
				String type = "";
				for(int i=0;i<userList.size();i++){
					PageData vpd = new PageData();
					vpd.put("var1", i+1+"");
					vpd.put("var2", userList.get(i).getString("BIANHAO"));		//1
					vpd.put("var3", userList.get(i).get("COUNT").toString());		//2
					vpd.put("var4", userList.get(i).get("MATCOUNT").toString());	//3
					vpd.put("var5", userList.get(i).getString("TIME"));	//4
					state = userList.get(i).get("STATE")+"";
					if(state.equals("1")) {
						state = "未装车";
					}else {
						state = "已装车";
					}
					vpd.put("var6", state);		//5
					vpd.put("var7", userList.get(i).getString("INSPECTOR"));//6
					type = userList.get(i).get("TYPE")+"";
					if(type.equals("1")) {
						type = "整进整出";
					}else {
						type = "一般越库";
					}
					vpd.put("var8", type);	//7
					vpd.put("var9", userList.get(i).getString("NOTE"));		//8
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
