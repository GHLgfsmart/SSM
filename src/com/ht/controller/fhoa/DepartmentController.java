package com.ht.controller.fhoa;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ht.controller.base.BaseController;
import com.ht.entity.Page;
import com.ht.service.fhoa.DepartmentManager;
import com.ht.service.system.UserManager;
import com.ht.util.AppUtil;
import com.ht.util.DateUtil;
import com.ht.util.Jurisdiction;
import com.ht.util.PageData;

/** 
 * 说明：部门
 */
@Controller
@RequestMapping(value="/department")
public class DepartmentController extends BaseController {
	
	String menuUrl = "department/list.do"; //菜单地址(权限用)
	@Resource(name="departmentService")
	private DepartmentManager departmentService;
	@Resource(name="userService")
	private UserManager userService;
	/**
	 * 弹出负责人界面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/testPage")
	public ModelAndView testPage(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();//hqq
		page.setPd(pd);
		List<PageData> list = userService.listUsers(page);//----
		mv.setViewName("fhoa/department/user_list");
		mv.addObject("userList", list);
		mv.addObject("pd", pd);
		return mv;
		
	}
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增department");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("DEPARTMENT_ID", this.get32UUID());	//主键
		String numberMax=departmentService.numberMax();
		numberMax=numberMax.substring(2, numberMax.length());
		
		int num=Integer.valueOf(numberMax)+1;
		int num1=num;
		int a = 0;
		while(num1!=0){
			num1 /=10;//获取位数
		    a++;
		}
		String nums=pd.getString("JM");
		if(a==1){
			nums+="0000"+num;
		}else if(a==2){
			nums+="000"+num;
		}else if(a==3){
			nums+="00"+num;
		}else if(a==4){
			nums+="0"+num;
		}else if(a==5){
			nums+=""+num;
		}
		pd.put("BIANMA", nums);
		pd.put("ENTRY_TIME", DateUtil.getTime().toString());
		departmentService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除
	 * @param DEPARTMENT_ID
	 * @param
	 * @throws Exception 
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public Object delete(@RequestParam String DEPARTMENT_ID) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除department");
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd.put("DEPARTMENT_ID", DEPARTMENT_ID);
		String errInfo = "success";
		if(departmentService.listSubDepartmentByParentId(DEPARTMENT_ID).size() > 0){//判断是否有子级，是：不允许删除
			errInfo = "false";
		}else{
			departmentService.delete(pd);	//执行删除
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改department");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		departmentService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表department");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");					//检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String DEPARTMENT_ID = null == pd.get("DEPARTMENT_ID")?"":pd.get("DEPARTMENT_ID").toString();
		if(null != pd.get("id") && !"".equals(pd.get("id").toString())){
			DEPARTMENT_ID = pd.get("id").toString();
		}
		pd.put("DEPARTMENT_ID", DEPARTMENT_ID);					//上级ID
		page.setPd(pd);
		List<PageData>	varList = departmentService.list(page);	//列出Dictionaries列表
		mv.addObject("pd", departmentService.findById(pd));		//传入上级所有信息
		mv.addObject("DEPARTMENT_ID", DEPARTMENT_ID);			//上级ID
		mv.setViewName("fhoa/department/department_list");
		mv.addObject("varList", varList);
		mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
		return mv;
	}
	
	/**
	 * 显示列表ztree
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/listAllDepartment")
	public ModelAndView listAllDepartment(Model model,String DEPARTMENT_ID)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			JSONArray arr = JSONArray.fromObject(departmentService.listAllDepartment("0"));
			String json = arr.toString();
			json = json.replaceAll("DEPARTMENT_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("NAME", "name").replaceAll("subDepartment", "nodes").replaceAll("hasDepartment", "checked").replaceAll("treeurl", "url");
			model.addAttribute("zTreeNodes", json);
			mv.addObject("DEPARTMENT_ID",DEPARTMENT_ID);
			mv.addObject("pd", pd);	
			mv.setViewName("fhoa/department/department_ztree");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String DEPARTMENT_ID = null == pd.get("DEPARTMENT_ID")?"":pd.get("DEPARTMENT_ID").toString();
		pd.put("DEPARTMENT_ID", DEPARTMENT_ID);					//上级ID
		mv.addObject("pds",departmentService.findById(pd));		//传入上级所有信息
		mv.addObject("DEPARTMENT_ID", DEPARTMENT_ID);			//传入ID，作为子级ID用
		mv.setViewName("fhoa/department/department_edit");
		mv.addObject("msg", "save");
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String DEPARTMENT_ID = pd.getString("DEPARTMENT_ID");
		pd = departmentService.findById(pd);	//根据ID读取
		mv.addObject("pd", pd);					//放入视图容器
		pd.put("DEPARTMENT_ID",pd.get("PARENT_ID").toString());			//用作上级信息
		mv.addObject("pds",departmentService.findById(pd));				//传入上级所有信息
		mv.addObject("DEPARTMENT_ID", pd.get("PARENT_ID").toString());	//传入上级ID，作为子ID用
		pd.put("DEPARTMENT_ID",DEPARTMENT_ID);							//复原本ID
		mv.setViewName("fhoa/department/department_edit");
		mv.addObject("msg", "edit");
		return mv;
	}	

	/**判断编码是否存在
	 * @return
	 */
	@RequestMapping(value="/hasBianma")
	@ResponseBody
	public Object hasBianma(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(departmentService.findByBianma(pd) != null){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
