package test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.cnipr.cniprgz.db.DBPoolAccessor;

public class Test1 {

	private static boolean testIPC(String IPC) throws Exception{
//		System.out.println(IPC);		
		boolean isIPC = false;
		IPC = IPC.toUpperCase();
		Pattern p = Pattern.compile("^[A-Z]{1}[0-9]{2}[A-Z]{1}[0-9]{1,4}/[0-9]{1,6}$");
		try {
			Matcher m = p.matcher(IPC); // 获取 matcher 对象
			isIPC = m.find();
		} catch (Exception ex) {
			isIPC = false;
			throw ex;
		}
		
		return isIPC;
	}
	
	public static void main1(String[] args) throws Exception {
		Map<String, String> hm = new HashMap<String, String>();
		String an = "CN201610112692.8";
		String indexName = "patent";
		String type = "fmzl_ft";
		String IPC = "G02F1/1335(2006.01)I;G02F1/1343(2006.01)I";
		
//		 System.out.println(IPC);
//		long begin_gmjj = System.currentTimeMillis();
		

		IPC = IPC.replace("（", "(");
		IPC = IPC.replace("；", ";");
		
		String _IPC = "";
		// String _IPCB = "";
		// String _IPCD = "";
		// String _IPCX = "";
		// String _IPCZ = "";
//		String[] arrIPC = IPC.split(";");
		String[] arrIPC = IPC.replace("(IPC1-7):", "").split(";");

		Set<String> _set_b = new HashSet<String>();
		Set<String> _set_dl = new HashSet<String>();
		Set<String> _set_xl = new HashSet<String>();
		Set<String> _set_dz = new HashSet<String>();

		for (String _ipc : arrIPC) {
//			 System.out.println(_ipc);
//			if(_ipc.indexOf("//")>-1) {
//				continue;
//			}
			if (!type.equals("wgzl_ab")) {
				System.out.println(an+"---------"+_ipc);
				
				if(_ipc.equals("")||_ipc.trim().equals("(")) {
					continue;
				}
				
				String[] arr = _ipc.split("\\(");
				if(arr!=null&&arr.length>0) {
					if(!testIPC(_ipc.split("\\(")[0])) {
						continue;
					}
					
					if (!_IPC.equals("")) {
						_IPC += ";";
					}
					_IPC += _ipc.split("\\(")[0];

					_set_b.add(_ipc.substring(0, 1));
					_set_dl.add(_ipc.substring(0, 3));
					_set_xl.add(_ipc.substring(0, 4));
					if (_ipc.indexOf("/") != -1) {
						_set_dz.add(_ipc.substring(0, _ipc.indexOf("/")));
					} else {
						_set_dz.add(_ipc);
					}
				}								
				
			}else {
//			外观专利	wgzl
				if(_ipc!=null&&_ipc.length()>=5) {									
					_ipc = _ipc.substring(0, 5);
					Pattern p = Pattern.compile("^[0-9]{2}-[0-9]{2}$");
					Matcher m = p.matcher(_ipc); // 获取 matcher 对象
					if(m.find()) {
						if (!_IPC.equals("")) {
							_IPC += ";";
						}
						_IPC += _ipc.split("\\(")[0];
					}else {
						continue;
					}
				}
				

			}
		}

		String _str = "";
		Iterator<String> iterator = _set_b.iterator();
		while (iterator.hasNext()) {
			_str += iterator.next() + " ";
		}
		_str = _str.trim();
		// System.out.println(_str);
		// hm.put("IPC部", _str);
		if (type.equals("wgzl_ab")) {
			hm.put("IPC部", "");
		} else {
			hm.put("IPC部", _str);
		}

		_str = "";
		iterator = _set_dl.iterator();
		while (iterator.hasNext()) {
			_str += iterator.next() + " ";
		}
		_str = _str.trim();
		// hm.put("IPC大类", _str);
		if (type.equals("wgzl_ab")) {
			hm.put("IPC大类", "");
		} else {
			hm.put("IPC大类", _str);
		}

		_str = "";
		iterator = _set_xl.iterator();
		while (iterator.hasNext()) {
			_str += iterator.next() + " ";
		}
		_str = _str.trim();
		// hm.put("IPC小类", _str);
		if (type.equals("wgzl_ab")) {
			hm.put("IPC小类", "");
		} else {
			hm.put("IPC小类", _str);
		}

		_str = "";
		iterator = _set_dz.iterator();
		while (iterator.hasNext()) {
			_str += iterator.next() + " ";
		}
		_str = _str.trim();
		// hm.put("IPC大组", _str);
		if (type.equals("wgzl_ab")) {
			hm.put("IPC大组", "");
		} else {
			hm.put("IPC大组", _str);
		}

		/*
		 * hm.put("IPC部", _IPCB+=_ipc.substring(0,1)+" "); hm.put("IPC大类",
		 * _IPCD+=_ipc.substring(0,3)+" "); hm.put("IPC小类",
		 * _IPCX+=_ipc.substring(0,4)+" "); hm.put("IPC大组",
		 * _IPCZ+=_ipc.substring(0,_ipc.indexOf("/"))+" ");
		 */
		// _IPC = _IPC.replace(";", " ");
		// hm.put(cols[j].getFullName(), _IPC);

		_IPC = _IPC.replace(";", " ");
		
//		F21S6/00;//F21W131:205,F21V19/02
		IPC = IPC.replace("；", ";");
		IPC = IPC.replace(";", " ");

		System.out.println(IPC);
		
		if(indexName.equals("patent")||indexName.equals("cn_patent")){
			if (type.equals("fmzl_ft") || type.equals("syxx_ft") || type.equals("fmsq_ft")) {
				hm.put("IPC分类号", _IPC);
				hm.put("外观分类号", "");
				// System.out.println(_IPC);
			} else {
				hm.put("IPC分类号", "");
				hm.put("外观分类号", _IPC);
			}
		}else{
			hm.put("IPC分类号", _IPC);
		}

	}

	public static void main2(String[] args) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			String sql =  "select a.id,a.parent_id,a.name,a.notes,b.expr_zh,b.expr_en from t_ptl_subs a,t_ptl_leaves b where a.id=b.id";
			
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			while (rs.next()) {


			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		
	}

	public static void main(String[] args) throws Exception {
		String str=",公开（公告）号,申请号,专利号,主分类号,优先权,同族专利项,分案原申请号,摘要附图存储路径,欧洲主分类号,欧洲分类号,本国主分类号,本国分类号,发布路径,页数,申请国代码,专利类型,申请来源,范畴分类,权利要求书页数,说明书页数,说明书附图页数,专利代理机构分析,代理人分析,第一申请人,第一发明人,申请年,公开年,公开月,国省,申请区域,最新法律状态,PATTYPE,省级行政,市级行政,县区行政,地址ID,授权公告号,申请号,审定公告号,受理区域,受理区域代码,第一申请人_keyword,地址_keyword,邮编_keyword,申请年_keyword,国省代码_keyword,省级行政_keyword,市级行政_keyword,县区行政_keyword,处理方式_keyword,检索时长毫秒,检索年,检索月,检索日,检索时,关键词个数,平台名称,IP地址,平台名称,平台MAC地址,申请号,优先权,PATTYPE,省级行政,市级行政,县区行政,独立申请号,法律状态申请号,专利代理机构分析,代理人分析,第一申请人,第一发明人,申请年,公开年,公开月,IPC部,IPC大类,IPC小类,IPC大组,IPC分类号,主IPC部,主IPC大类,主IPC小类,主IPC大组,主IPC分类号,外观分类号,国省,专利有效年,申请人,发明人,权利要求数,申请区域,最新法律状态,国民经济代码,国民经济部,国民经济大类,国民经济中类,国民经济小类,专利类型,受理区域,国省代码,";
		String str1=",公开（公告）号,申请号,专利号,主分类号,优先权,同族专利项,分案原申请号,摘要附图存储路径,欧洲主分类号,欧洲分类号,本国主分类号,本国分类号,发布路径,页数,申请国代码,专利类型,申请来源,范畴分类,权利要求书页数,说明书页数,说明书附图页数,专利代理机构分析,代理人分析,第一申请人,第一发明人,申请年,公开年,公开月,国省,申请区域,最新法律状态,PATTYPE,省级行政,市级行政,县区行政,地址ID,授权公告号,审定公告号,受理区域,受理区域代码,第一申请人_keyword,地址_keyword,邮编_keyword,申请年_keyword,国省代码_keyword,省级行政_keyword,市级行政_keyword,县区行政_keyword,处理方式_keyword,检索时长毫秒,检索年,检索月,检索日,检索时,关键词个数,平台名称,IP地址,平台MAC地址,独立申请号,法律状态申请号,IPC部,IPC大类,IPC小类,IPC大组,IPC分类号,主IPC部,主IPC大类,主IPC小类,主IPC大组,主IPC分类号,外观分类号,专利有效年,申请人,发明人,权利要求数,国民经济代码,国民经济部,国民经济大类,国民经济中类,国民经济小类,国省代码";
		
		String[] arr = str.split(",");
		
//		HashSet hs = new HashSet<String>();		
		for(int i=0;i<arr.length;i++)
		{
//			hs.add(arr[i]);
			if(str1.indexOf(","+arr[i]+",")==-1) {
				str1+=arr[i]+",";
			}
		}
		
		System.out.println(str1);
		
/*		Iterator<String> iter = hs.iterator();
		while(iter.hasNext())
		{
//			iter.next();
			System.out.print(iter.next()+",");
		}*/
		String ss= "美国（US）\r\n" + 
				"日本（JP）\r\n" + 
				"英国（GB）\r\n" + 
				"德国（DE）\r\n" + 
				"法国（FR）\r\n" + 
				"欧洲（EP）\r\n" + 
				"WIPO（WO）\r\n" + 
				"瑞士（CH）\r\n" + 
				"韩国（KR）\r\n" + 
				"俄罗斯（RU）\r\n" + 
				"澳大利亚（AU）\r\n" + 
				"加拿大（CA）\r\n" + 
				"阿拉伯（AE）\r\n" + 
				"亚美尼亚（AM）\r\n" + 
				"非洲地区知识产权组织（AP）\r\n" + 
				"阿根廷（AR）\r\n" + 
				"奥地利（AT）\r\n" + 
				"波斯尼亚和黑塞哥维那（BA）\r\n" + 
				"比利时（BE）\r\n" + 
				"保加利亚（BG）\r\n" + 
				"巴西（BR）\r\n" + 
				"白俄罗斯（BY）\r\n" + 
				"智利（CL）\r\n" + 
				"哥伦比亚（CO）\r\n" + 
				"哥斯达黎加（CR）\r\n" + 
				"捷克斯洛伐克（CS）\r\n" + 
				"古巴（CU）\r\n" + 
				"塞浦路斯(CY)\r\n" + 
				"捷克（CZ）\r\n" + 
				"丹麦（DK）\r\n" + 
				"多米尼加共和国（DO）\r\n" + 
				"阿尔及利亚（DZ）\r\n" + 
				"欧亚专利局（EA）\r\n" + 
				"厄瓜多尔（EC）\r\n" + 
				"爱沙尼亚（EE）\r\n" + 
				"埃及（EG）\r\n" + 
				"西班牙（ES）\r\n" + 
				"芬兰（FI）\r\n" + 
				"海湾地区阿拉伯国家合作委员会专利局（GC）\r\n" + 
				"格鲁吉亚（GE）\r\n" + 
				"希腊（GR）\r\n" + 
				"危地马拉（GT）\r\n" + 
				"洪都拉斯（HN）\r\n" + 
				"克罗地亚（HR）\r\n" + 
				"匈牙利（HU）\r\n" + 
				"印度尼西亚（ID）\r\n" + 
				"爱尔兰（IE）\r\n" + 
				"以色列（IL）\r\n" + 
				"印度（IN）\r\n" + 
				"冰岛（IS）\r\n" + 
				"意大利（IT）\r\n" + 
				"约旦（JO）\r\n" + 
				"肯尼亚（KE）\r\n" + 
				"吉尔吉斯斯坦（KG）\r\n" + 
				"哈萨克斯坦（KZ）\r\n" + 
				"立陶宛（LT）\r\n" + 
				"卢森堡（LU）\r\n" + 
				"拉脱维亚（LV）\r\n" + 
				"摩洛哥（MA）\r\n" + 
				"摩纳哥（MC）\r\n" + 
				"摩尔多瓦（MD）\r\n" + 
				"黑山（ME）\r\n" + 
				"蒙古（MN）\r\n" + 
				"马耳他（MT）\r\n" + 
				"马拉维（MW）\r\n" + 
				"墨西哥（MX）\r\n" + 
				"马来西亚（MY）\r\n" + 
				"尼加拉瓜（NI）\r\n" + 
				"荷兰（NL）\r\n" + 
				"挪威（NO）\r\n" + 
				"新西兰（NZ）\r\n" + 
				"非洲知识产权组织（OA）\r\n" + 
				"巴拿马（PA）\r\n" + 
				"秘鲁（PE）\r\n" + 
				"菲律宾（PH）\r\n" + 
				"波兰（PL）\r\n" + 
				"葡萄牙（PT）\r\n" + 
				"罗马尼亚（RO）\r\n" + 
				"塞尔维亚（RS）\r\n" + 
				"瑞典（SE）\r\n" + 
				"新加坡（SG）\r\n" + 
				"斯洛文尼亚（SI）\r\n" + 
				"斯洛伐克（SK）\r\n" + 
				"圣马力诺（SM）\r\n" + 
				"前苏联（SU）\r\n" + 
				"萨尔瓦多（SV）\r\n" + 
				"泰国（TH）\r\n" + 
				"塔吉克斯坦（TJ）\r\n" + 
				"突尼斯（TN）\r\n" + 
				"土耳其（TR）\r\n" + 
				"特立尼达和多巴哥（TT）\r\n" + 
				"乌克兰（UA）\r\n" + 
				"乌拉圭（UY）\r\n" + 
				"乌兹别克斯坦（UZ）\r\n" + 
				"越南（VN）\r\n" + 
				"南斯拉夫（YU）\r\n" + 
				"南非（ZA）\r\n" + 
				"赞比亚（ZM）\r\n" + 
				"津巴布韦（ZW）\r\n" + 
				"";
		
		
	}
}
