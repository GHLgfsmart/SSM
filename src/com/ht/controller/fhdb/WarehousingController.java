package com.ht.controller.fhdb;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ht.controller.base.BaseController;
import com.ht.entity.Materials_information;
import com.ht.entity.Page;
import com.ht.service.fhdb.WarehousingManager;
import com.ht.util.Jurisdiction;
import com.ht.util.PageData;

/**
 * 入库控制
 * */
@Controller
@RequestMapping(value="/warehousing")
public class WarehousingController extends BaseController{
		
	String menuUrl = "warehousing/list.do"; //菜单地址(权限用)
	@Resource(name="warehousingService")
	private WarehousingManager warehousingService;
	
	/**
	 * Mr.Lin
	 * 查询所有物资信息
	 * @param page
	 * @return
	 * @throws Exception 
	 * */
	@RequestMapping(value="/list")
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
	 * Mr.Lin
	 * 物资弹出新增界面
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/warehousingAddPage")
	public ModelAndView warehousingAddPage()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String dj = "WZ"+sdf.format(new Date());
		mv.setViewName("fhdb/materials/materialsEdit");
		mv.addObject("dj", dj);
		mv.addObject("msg", "warehousingAdd");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * Mr.Lin
	 * 物资新增操作
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/warehousingAdd")
	public ModelAndView warehousingAdd()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"物资新增");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ID", this.get32UUID());	//主键
		warehousingService.materialSave(pd);
		mv.addObject("msg","success");
		mv.setViewName("fhdb/materials/materialsManage");
		return mv;
	}
	
	/**
	 * Mr.Lin
	 * 弹出物资选择供应商界面
	 * @throws Exception 
	 * */
	@RequestMapping(value="/testPage")
	public ModelAndView testPage(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Materials");
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
	 * Mr.Lin
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
	
}
