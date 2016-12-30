package com.ht.controller.fhoa;

import java.awt.Color;
import java.awt.Font;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.labels.ItemLabelAnchor;
import org.jfree.chart.labels.ItemLabelPosition;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer3D;
import org.jfree.chart.servlet.ServletUtilities;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.general.DatasetUtilities;
import org.jfree.ui.TextAnchor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ht.controller.base.BaseController;
import com.ht.entity.Warehouse;
import com.ht.service.fhoa.WarehouseManager;

/**
 * 仓库管理Controller层
 * @author Bruse
 *
 */
@Controller
@RequestMapping("/warehouse")
public class WarehouseController extends BaseController{
	
	String menuUrl = "warehouse/barChar.do"; //菜单地址(权限用)
	
	@Resource
	private WarehouseManager warehouseService;
	
	
	@RequestMapping("/barChar")
	public ModelAndView barChar(HttpSession session) throws Exception {
		ModelAndView mv = this.getModelAndView();
		
		List<Warehouse>	list =warehouseService.barChar();//列出仓库列表
		if (list.size()==0) {
			mv.setViewName("404");
			return mv;
		}else{
			Iterator<Warehouse> iterator = list.iterator();
			double [][] data= new double[list.size()][4];
			double [][] data1= new double[list.size()][4];
			String []address = new String[list.size()];
			for (int i = 0, j = list.size(); i < j; i++ ) {
				Warehouse wh = (Warehouse) iterator.next();
				data[i][0] = wh.getUPPER_LIMIT();//仓库上限
				data[i][1] = wh.getLOWER_LIMIT();//仓库下限
				data[i][2] = wh.getPRACTICAl();//实际库存
				data[i][3] = wh.getUPPER_LIMIT() - wh.getPRACTICAl();//还能存多少
				address[i] = wh.getADDRESS() +"("+wh.getSIZE()+" /平方米)";
			} 
			for(int i=0;i<4;i++){
				for(int j=0;j<4;j++){
						data1[i][j]=data[j][i];
				}
			}
			
			String []keyWords={"仓库上限","仓库下限","实际库存","还能存放"};
			
			/*String [] columnKeys = {"仓库A(300/平方米)","仓库B(400/平方米)","仓库C(500/平方米)","仓库D(300/平方米)"};*/
			CategoryDataset dataset=DatasetUtilities.createCategoryDataset(keyWords,address ,data1);
			JFreeChart chart=ChartFactory.createBarChart3D("库存统计图", "仓库", "库存 (/件)", dataset,
					PlotOrientation.VERTICAL, true, true, true);
			
			CategoryPlot plot=chart.getCategoryPlot();
			// 设置网格背景颜色
			plot.setBackgroundPaint(Color.white);
			// 设置网格竖线颜色
			plot.setDomainGridlinePaint(Color.pink);
			// 设置网格横线颜色
			plot.setRangeGridlinePaint(Color.pink);
			
			// 显示每个柱的数值，并修改该数值的字体属性
			BarRenderer3D renderer=new BarRenderer3D();
			renderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
			renderer.setBaseItemLabelsVisible(true);
			renderer.setWallPaint(Color.gray); 
			renderer.setBasePositiveItemLabelPosition(new ItemLabelPosition(ItemLabelAnchor.OUTSIDE12, TextAnchor.BASELINE_LEFT));
			renderer.setItemLabelAnchorOffset(10D);  
			
			//设置标题字体
			TextTitle textTitle = chart.getTitle();
			textTitle.setFont(new Font("黑体", Font.PLAIN, 20)); 
	        textTitle.setBackgroundPaint(Color.LIGHT_GRAY);//标题背景色 
	        textTitle.setPaint(Color.BLACK);//标题字体颜色 
	        textTitle.setText("库存统计图");//标题内容  
			
			//对X轴做操作
			CategoryAxis domainAxis = plot.getDomainAxis(); 
			domainAxis.setTickLabelPaint(Color.red);//X轴的标题文字颜色 
		    domainAxis.setTickLabelsVisible(true);//X轴的标题文字是否显示 
		    domainAxis.setAxisLinePaint(Color.red);//X轴横线颜色 
		    domainAxis.setTickMarksVisible(true);//标记线是否显示 
		    domainAxis.setTickMarkOutsideLength(3);//标记线向外长度 
		    domainAxis.setTickMarkInsideLength(3);//标记线向内长度 
		    domainAxis.setTickMarkPaint(Color.red);//标记线颜色 
			
			//对Y轴做操作
			ValueAxis rAxis = plot.getRangeAxis(); 
			rAxis.setLabelFont(new Font("黑体", Font.PLAIN, 12)); 
			rAxis.setLabel("库存 (/件)");
			rAxis.setLabelPaint(Color.red);
			
			// 设置平行柱的之间距离
			renderer.setItemMargin(0.3);
			
			plot.setRenderer(renderer);
			
			String fileName=ServletUtilities.saveChartAsPNG(chart, 700, 430, null,session);
			
			mv.setViewName("system/warehouse/Msg_edit");
			mv.addObject("fileName",fileName);
			System.out.println(fileName);
			/*mv.addObject("list", list);*/
			return mv;
		}
	}

}
