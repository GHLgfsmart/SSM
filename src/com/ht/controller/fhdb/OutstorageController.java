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
import com.ht.util.Jurisdiction;
import com.ht.util.PageData;
/**
 * 出库控制
 * */
@Controller
@RequestMapping(value="/outstorage")
public class OutstorageController extends BaseController{
	
	String menuUrl = "outstorage/outstorageList.do"; //菜单地址(权限用)
	@Resource(name="warehousingService")
	private WarehousingManager warehousingService;
	
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
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
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
	
}
