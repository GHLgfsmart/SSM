package com.ht.controller.fhoa;

import java.io.PrintWriter;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.ht.controller.base.BaseController;
import com.ht.entity.Page;
import com.ht.service.fhoa.impl.CategoriesService;
import com.ht.util.Jurisdiction;
import com.ht.util.PageData;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("/categories")
public class CategoriesController extends BaseController{
	String menuUrl = "categories/list.do";
	@Resource(name="categoriesService")
	private CategoriesService categoriesService;

	@RequestMapping(value="del")
	public void delete(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除department");
		PageData pd = new PageData();
		pd = this.getPageData();
		if(categoriesService.findSublevel(pd.getString("ID")).size() > 0){
			out.write("false");
		}else{
			categoriesService.delete(pd);	//执行删除
			out.write("success");
		}
		out.close();
		
	}
	
	/**
	 * 入修改界面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="goEdit")
	public ModelAndView goEdit() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String ID = pd.getString("ID");
		pd = categoriesService.findById(ID);	//根据ID读取
		String UID=pd.get("UID").toString();
		mv.addObject("pd", pd);		//放入视图容器
		mv.addObject("pds",categoriesService.findById(UID));	//传入上级所有信息
		mv.addObject("ID",ID );	
		mv.addObject("UID",UID);
		mv.setViewName("fhoa/supplier_type/save_edit");
		mv.addObject("msg", "edit");
		return mv;
	}
	
	@RequestMapping(value="edit")
	public ModelAndView update() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改供应商客户分类");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		categoriesService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	@RequestMapping(value="goAdd")
	public ModelAndView goAdd() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		System.out.println("pd.data:"+pd.toString());
		String ID = null == pd.get("UID") ? "0" : pd.get("UID").toString();
		//pd.put("UID", ID);//上级ID
		mv.addObject("pds",categoriesService.findById(ID));		//传入上级所有信息
		mv.addObject("UID", ID);	//传入ID，作为子级ID用
		mv.setViewName("fhoa/supplier_type/save_edit");
		mv.addObject("msg", "save");
		return mv;
	}
	
	@RequestMapping(value="save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增供应商类型");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		System.out.println("添加pd.lei:"+pd.toString());
		pd.put("ID", this.get32UUID());	//主键
		categoriesService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 树型列表
	 * @param model
	 * @param ID
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/listtree")
	public ModelAndView listAllDepartment(Model model,String ID,HttpServletResponse response)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			JSONArray arr = JSONArray.fromObject(categoriesService.paddingSublevel("0"));
			String json = arr.toString();
			json = json.replaceAll("ID", "id").replaceAll("UID", "uid").replaceAll("NAME", "name").replaceAll("cclist", "nodes").replaceAll("hasCategories", "checked").replaceAll("treeurl", "url");
			model.addAttribute("zTreeNodes", json);
			mv.addObject("ID",ID);
			mv.addObject("pd", pd);	
			mv.setViewName("fhoa/supplier_type/type_ztree");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 信息列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"供应商信息列表");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");					//检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String ID = null == pd.get("ID")?"":pd.get("ID").toString();
		if(null != pd.get("id") && !"".equals(pd.get("id").toString())){
			ID = pd.get("id").toString();
		}
		pd.put("ID", ID);					//上级ID
		page.setPd(pd);
		List<PageData> varList = categoriesService.findAll(page);	//列出Dictionaries列表
		mv.addObject("pd",categoriesService.findById(ID));		//传入上级所有信息
		mv.addObject("ID",ID);			//上级ID
		mv.setViewName("fhoa/supplier_type/type_list");
		mv.addObject("varList", varList);
		mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
		return mv;
	}
}
