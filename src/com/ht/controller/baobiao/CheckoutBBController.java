package com.ht.controller.baobiao;

import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ht.controller.base.BaseController;
import com.ht.entity.Checkout;
import com.ht.service.fhdb.WarehousingManager;

@Controller
@RequestMapping("/checkout")
public class CheckoutBBController extends BaseController{
	
	/*String menuUrl = "checkout/barChar.do"; //菜单地址(权限用)
	
	@Resource(name="warehousingService")
	private WarehousingManager warehousingService;
	
	@RequestMapping("/barChar")
	public ModelAndView barChar(HttpSession session) throws Exception {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("system/output/checkOutBB");
		return mv;
	}
	
	@RequestMapping("/barChar")
	public ModelAndView barChar(HttpSession session) throws Exception {
		ModelAndView mv = this.getModelAndView();
		List<Checkout> list1 = warehousingService.barChar1();
		Iterator<Checkout> iterator1 = list1.iterator();
		
		List<Checkout> list2 = warehousingService.barChar2();
		Iterator<Checkout> iterator2 = list2.iterator();
		
		double [][] data1= new double[list1.size()][4];
		double [][] data2= new double[list2.size()][4];
		double [][] data3= new double[4][2];
		//String []months = {"前15天","后15天"};
		//前15天的数据
		for (int i = 0, j = list1.size(); i < j; i++ ) {
			Checkout ck = (Checkout) iterator1.next();
			data1[i][0] = ck.getQUANTITY();//总数量
			data1[i][1] = ck.getDAMAGEDQTY();//坏货数量
			data1[i][2] = ck.getSHORTQTY();//缺货数量
			data1[i][3] = ck.getQUANTITY() - (ck.getDAMAGEDQTY()+ck.getSHORTQTY());//入库多少
		}
		int c=0;
		for(double[] row : data1){
            for(double element : row){
            	data3[c][0]=element;
              c++;
            }
        }
		//后15天的数据
		for (int i = 0, j = list2.size(); i < j; i++ ) {
			Checkout ck = (Checkout) iterator2.next();
			data2[i][0] = ck.getQUANTITY();//总数量
			data2[i][1] = ck.getDAMAGEDQTY();//坏货数量
			data2[i][2] = ck.getSHORTQTY();//缺货数量
			data2[i][3] = ck.getQUANTITY() - (ck.getDAMAGEDQTY()+ck.getSHORTQTY());//还能存多少
		}
		int cc=0;
		for(double[] row : data2){
            for(double element : row){
            	data3[cc][1]=element;
                cc++;
            }
        }
		HttpServletRequest request = getRequest();
		request.setAttribute("ttt", "ttt");
		mv.addObject("ss", "ss");
		mv.setViewName("baobiao/checkOutBB");
		mv.addObject("msg","success");
		return mv;
	}*/

}
