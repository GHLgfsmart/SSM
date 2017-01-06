package com.ht.controller.system;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ht.controller.base.BaseController;
import com.ht.entity.Page;
import com.ht.service.system.impl.MsgService;
import com.ht.util.AppUtil;
import com.ht.util.DateUtil;
import com.ht.util.Jurisdiction;
import com.ht.util.PageData;

/** 
 * 类名称：MsgController
 */
@Controller
@RequestMapping(value="/msg")
public class MsgController extends BaseController{
	String menuUrl = "msg/list.do"; //菜单地址(权限用)
	@Resource(name="msgService")
	private MsgService msgService;
	/**显示用户列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView listUsers(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData>	listMsgs = msgService.listMsgs(page);	//列出用户列表
		mv.setViewName("system/affiche/Msg_list");
		mv.addObject("listMsgs", listMsgs);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	/**去修改页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditU")//
	public ModelAndView goEditU() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("MSGID", pd.getString("MSGID"));
		pd = msgService.findById(pd);
		mv.setViewName("system/affiche/Msg_edit"); 
		mv.addObject("msg", "editU");
		mv.addObject("pd", pd);
		return mv;
	}
	/**
	 * 修改公告栏
	 */
	@RequestMapping(value="/editU")
	public ModelAndView editU() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ser");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限判断当前操作者有无用户管理修改权限
		msgService.editU(pd);	//执行修改
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	/**去新增公告栏
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goAddU")////goAddU
	public ModelAndView goAddU()throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/affiche/Msg_edit");
		mv.addObject("msg", "saveU");
		mv.addObject("pd", pd);
		return mv;
	}
	/**保存公告栏
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveU")
	public ModelAndView saveU() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"新增Msg");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		
		pd = this.getPageData();
		pd.put("MSGID", this.get32UUID());	
		pd.put("MSGSTATUS", 0);	
		pd.put("USER_ID", Jurisdiction.getUsername());	
		pd.put("MSGTIME", DateUtil.getTime().toString());
		msgService.saveU(pd); 
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除公告栏
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/deleteU")
	public void deleteU(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除msg");
		PageData pd = new PageData();
		pd = this.getPageData();
		msgService.deleteU(pd);
		out.write("success");
		out.close();
	}
	/**
	 * 批量删除
	 * @throws Exception 
	 */
	@RequestMapping(value="/deleteAllU")
	@ResponseBody
	public Object deleteAllU() throws Exception {
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"批量删除msg");
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String MSGIDS = pd.getString("MSGID");
		if(null != MSGIDS && !"".equals(MSGIDS)){
			String ArrayMsg_IDS[] = MSGIDS.split(",");
			msgService.deleteAllU(ArrayMsg_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
}
