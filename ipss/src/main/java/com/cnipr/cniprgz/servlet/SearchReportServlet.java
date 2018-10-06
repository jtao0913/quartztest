package com.cnipr.cniprgz.servlet;

import java.io.IOException;
import java.lang.reflect.Array;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import com.alibaba.fastjson.JSON;
import com.cnipr.cniprgz.dao.NodeDAO;
import com.unboundid.util.json.JSONObject;

/**
 * Servlet implementation class SearchReportServlet
 */
public class SearchReportServlet extends HttpServlet {

	private List<Object> menus(String datt,String menu){
		Map<String,Object> parseObject=new HashMap<>();
		parseObject = (Map<String,Object>)JSON.parseObject(datt);
		List<Object> menus=new ArrayList<>();
		menus.add("编号");menus.add(menu);
		Set<String> keySet = new TreeSet<>();
		for (String string : parseObject.keySet()) {
			keySet.add(string);
		}
		for (String string : keySet) {
			menus.add(string);
		}
		return menus;
	}
	
	private List<List<Object>> jsontolist(String datt,String menu) {
		Map<String,Object> parseObject=new HashMap<>();
		parseObject = (Map<String,Object>)JSON.parseObject(datt);
		List<List<Object>> table=new ArrayList<List<Object>>();
		Set<String> keySet = new TreeSet<>();
		for (String string : parseObject.keySet()) {
			keySet.add(string);
		}
		for (Object key : keySet) {
			if(parseObject.get(key.toString()).toString().indexOf("{")<0) {
				List<Object> tem=new ArrayList<>();
				tem.add(1);
				tem.add("广东省");
				for (Object key2 : keySet) {
					tem.add(parseObject.get(key.toString()));
				}
				table.add(tem);
				break;
			}
			
			Map<String, Object> temp=(Map<String, Object>)parseObject.get(key.toString());
			int a=1;
			for (String key1 : temp.keySet()){
				List<Object> tem=new ArrayList<>();
				tem.add(a);
				String tt=key1.replace("&nbsp;", "");
				if(!tt.equals("广东省")) {
					tem.add(tt);
					for (Object key2 : keySet) {
						Map<String, Object> temp1=(Map<String, Object>)parseObject.get(key2.toString());
						if(temp1.get(key1)!=null) {
							String lin=temp1.get(key1).toString();
							lin=lin.replace("{", "");lin=lin.replace("}", "");
							lin=lin.replace("\"", "");lin=lin.replace(",", "<w:br/>");
							lin=lin.replace("&nbsp;", "");lin=lin.replace("广东省", "中国-广东省");
							lin=lin.replace("&", "");
							tem.add(lin);
						}else {
							tem.add(0);
						}
					}
					table.add(tem);
					a++;
				}
			}
			List<Object> tem=new ArrayList<>();
			tem.add(a);
			if(temp.get("广东省")!=null) {
				tem.add("广东省");
				for (Object key2 : keySet) {
					Map<String, Object> temp1=(Map<String, Object>)parseObject.get(key2.toString());
					if(temp1.get("广东省")!=null) {
						String lin=temp1.get("广东省").toString();
						lin=lin.replace("{", "");lin=lin.replace("}", "");
						lin=lin.replace("\"", "");lin=lin.replace(",", "<w:br/>");
						lin=lin.replace("&nbsp;", "");lin=lin.replace("广东省", "中国-广东省");
						lin=lin.replace("&", "");
						tem.add(lin);
					}else {
						tem.add(0);
					}
				}
				table.add(tem);
			}
			break;
		}
		return table;
	}
	
	@SuppressWarnings("unlikely-arg-type")
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> report = new HashMap<String, Object>();
		for(int i=0;i<28;i++) {
			String ecl=req.getParameter("ecl"+i);
			String menu=req.getParameter("menu"+i);
			String dec=req.getParameter("dec"+i);
			List<List<Object>> list = new ArrayList<>();
			List<Object> menus = new ArrayList<>();
			if(ecl!=null&&(!ecl.equals("kong"))) {
				list = jsontolist(ecl, menu);
				menus = menus(ecl, menu);
			}else {
				List<Object> list2=new ArrayList<>();
				list2.add("暂无数据");
				list.add(list2);
				menus.add(" ");
			}
			report.put("menus"+i, menus);
			report.put("table"+i,list );
			report.put("dec"+i, dec);
		}
		//添加日期
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
        String date = df.format(new Date());
        report.put("date", date);
        //添加行业
        String trade = req.getSession().getAttribute("chrGDHyName").toString();
        report.put("trade", trade);
        
		Map<String, String> imageDate = NodeDAO.getImageDate();
		for (String key : imageDate.keySet()) {
			if(imageDate.get(key).length()>1000) {
				String dd=imageDate.get(key).substring(22);
				ArrayList<Byte> list = new ArrayList<Byte>();  
		        byte[] bytes = dd.getBytes("UTF-8");  
		        for(int i=0;bytes!=null&&i<bytes.length;i++){  
		            if(0!=bytes[i]){  
		                list.add(bytes[i]);  
		            }
		        }  
		        byte[] newbytes = new byte[list.size()];  
		        for(int i = 0 ; i<list.size();i++){
		            newbytes[i]=(Byte) list.get(i);   
		        }
		        String str = new String(newbytes,"UTF-8");
				report.put(key, str);
			}
		}
		try {
			WordUtils.exportMillCertificateWord(req, resp, report, trade, "ggg.ftl");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//获取当前日期
		/*SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
        String date = df.format(new Date());
        req.getSession().setAttribute("date", date);
        for(int a=0;a<28;a++) {
        	String htm = req.getParameter("ecl"+a);
            htm=htm.replace("{", "<");
            htm=htm.replace("}", ">");
            map.put("htm"+a, htm);
        }
        req.getSession().setAttribute("map", map);
        //1.1专利总量分析表格数据
        String htm0 = req.getParameter("ecl0");
        htm0=htm0.replace("{", "<");
        htm0=htm0.replace("}", ">");
        req.getSession().setAttribute("htm0", htm0);
        //1.2.1区域构成分析表格数据
        Map<String, Object> map2 = new HashMap<String, Object>();
        for(int i=9;i<36;i++) {
        	String temp = req.getParameter("ecl"+i);
        	map2.put("ecl"+i, temp);
        }
        req.getSession().setAttribute("map2", map2);
        //1.2.2区域技术分析
        String htm37 = req.getParameter("ecl37");
        htm37=htm37.replace("{", "<");
        htm37=htm37.replace("}", ">");
        req.getSession().setAttribute("htm37", htm37);
        //1.2.3区域申请人分析
        String htm64 = req.getParameter("ecl64");
        htm64=htm64.replace("{", "<");
        htm64=htm64.replace("}", ">");
        req.getSession().setAttribute("htm64", htm64);
        //1.3.1技术构成分析
        String htm1 = req.getParameter("ecl93");
        htm1=htm1.replace("{", "<");
        htm1=htm1.replace("}", ">");
        req.getSession().setAttribute("htm1", htm1);
        //1.3.2技术区域分析
        String htm2 = req.getParameter("ecl94");
        htm2=htm2.replace("{", "<");
        htm2=htm2.replace("}", ">");
        req.getSession().setAttribute("htm2", htm2);
        //1.3.3技术申请人分析
        String htm3 = req.getParameter("ecl98");
        htm3=htm3.replace("{", "<");
        htm3=htm3.replace("}", ">");
        req.getSession().setAttribute("htm3", htm3);
        //1.4.1申请人构成分析
        String htm4 = req.getParameter("ecl102");
        htm4=htm4.replace("{", "<");
        htm4=htm4.replace("}", ">");
        req.getSession().setAttribute("htm4", htm4);
        //2.1专利总量分析表格数据
        Map<String, Object> map5 = new HashMap<String, Object>();
        for(int i=110;i<116;i++) {
        	String temp = req.getParameter("ecl"+i);
        	map5.put("ecl"+i, temp);
        }
        req.getSession().setAttribute("map5", map5);
        //2.2专利类型分析
        Map<String, Object> map6 = new HashMap<String, Object>();
        for(int i=120;i<129;i++) {
        	String temp = req.getParameter("ecl"+i);
        	map6.put("ecl"+i, temp);
        }
        req.getSession().setAttribute("map6", map6);
        //2.3.1省市分布分析
        String htm5 = req.getParameter("ecl129");
        htm5=htm5.replace("{", "<");
        htm5=htm5.replace("}", ">");
        req.getSession().setAttribute("htm5", htm5);
        //2.4.1省市分布分析
        String htm6 = req.getParameter("ecl133");
        htm6=htm6.replace("{", "<");
        htm6=htm6.replace("}", ">");
        req.getSession().setAttribute("htm6", htm6);
        //2.4.2技术区域分析
        String htm7 = req.getParameter("ecl137");
        htm7=htm7.replace("{", "<");
        htm7=htm7.replace("}", ">");
        req.getSession().setAttribute("htm7", htm7);
        //2.4.3技术申请人分析
        String htm8 = req.getParameter("ecl141");
        htm8=htm8.replace("{", "<");
        htm8=htm8.replace("}", ">");
        req.getSession().setAttribute("htm8", htm8);
        //2.5.1技术申请人分析
        String htm9 = req.getParameter("ecl145");
        htm9=htm9.replace("{", "<");
        htm9=htm9.replace("}", ">");
        req.getSession().setAttribute("htm9", htm9);
        //2.6.1发明人构成分析
        String htm10 = req.getParameter("ecl149");
        htm10=htm10.replace("{", "<");
        htm10=htm10.replace("}", ">");
        req.getSession().setAttribute("htm10", htm10);
        //2.7.1法律状态总体构成分析
        String htm11 = req.getParameter("ecl153");
        htm11=htm11.replace("{", "<");
        htm11=htm11.replace("}", ">");
        req.getSession().setAttribute("htm11", htm11);
        //2.7.2法律状态区域构成分析
        String htm12 = req.getParameter("ecl169");
        htm12=htm12.replace("{", "<");
        htm12=htm12.replace("}", ">");
        req.getSession().setAttribute("htm12", htm12);
        //3.1专利总量分析表格数据
        Map<String, Object> map7 = new HashMap<String, Object>();
        for(int i=174;i<177;i++) {
        	String temp = req.getParameter("ecl"+i);
        	map7.put("ecl"+i, temp);
        }
        req.getSession().setAttribute("map7", map7);
        //3.2专利类型分析
        Map<String, Object> map8 = new HashMap<String, Object>();
        for(int i=181;i<190;i++) {
        	String temp = req.getParameter("ecl"+i);
        	map8.put("ecl"+i, temp);
        }
        req.getSession().setAttribute("map8", map8);
        //3.3地区分析
        String htm13 = req.getParameter("ecl190");
        htm13=htm13.replace("{", "<");
        htm13=htm13.replace("}", ">");
        req.getSession().setAttribute("htm13", htm13);
        //3.4.1技术构成分析
        String htm14 = req.getParameter("ecl194");
        htm14=htm14.replace("{", "<");
        htm14=htm14.replace("}", ">");
        req.getSession().setAttribute("htm14", htm14);
        //3.4.2技术区域分析
        String htm15 = req.getParameter("ecl198");
        htm15=htm15.replace("{", "<");
        htm15=htm15.replace("}", ">");
        req.getSession().setAttribute("htm15", htm15);
        //3.4.3技术申请人分析
        String htm16 = req.getParameter("ecl202");
        htm16=htm16.replace("{", "<");
        htm16=htm16.replace("}", ">");
        req.getSession().setAttribute("htm16", htm16);
        //3.5.1申请人构成分析
        String htm17 = req.getParameter("ecl206");
        htm17=htm17.replace("{", "<");
        htm17=htm17.replace("}", ">");
        req.getSession().setAttribute("htm17", htm17);
        //3.6.1发明人构成分析
        String htm18 = req.getParameter("ecl210");
        htm18=htm18.replace("{", "<");
        htm18=htm18.replace("}", ">");
        req.getSession().setAttribute("htm18", htm18);
        //3.7.1法律状态总体构成分析
        String htm19 = req.getParameter("ecl214");
        htm19=htm19.replace("{", "<");
        htm19=htm19.replace("}", ">");
        req.getSession().setAttribute("htm19", htm19);
        //3.7.2法律状态区域构成分析
        String htm20 = req.getParameter("ecl230");
        htm20=htm20.replace("{", "<");
        htm20=htm20.replace("}", ">");
        req.getSession().setAttribute("htm20", htm20);
		//接收三张图片
		String pic1 = req.getParameter("onepic");
		req.getSession().setAttribute("pic1", pic1);
		String pic2 = req.getParameter("twopic");
		req.getSession().setAttribute("pic2", pic2);
		String pic3 = req.getParameter("threepic");
		req.getSession().setAttribute("pic3", pic3);
		//接收描述数据
		for(int b=0;b<30;b++) {
			String dec="dec" + Integer.toString(b);
			String temp=req.getParameter(dec);
			if (temp == null) {
				temp = "暂无描述";
			}
			req.getSession().setAttribute(dec, temp);
			map.put(dec, temp);
		}
		String pic4="data:image/png;base64,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";
		req.getSession().setAttribute("pic4", pic4);
		resp.sendRedirect("jsp/zljs/report2.jsp");*/
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SearchReportServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
