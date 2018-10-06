package com.cnipr.cniprgz.func.xml;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.cnipr.cniprgz.client.CoreBizClient;
import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.commons.SetupAccess;
import com.cnipr.cniprgz.commons.SetupConstant;
import com.cnipr.cniprgz.func.download.HttpGet;
import com.cnipr.corebiz.search.ws.response.DetailSearchResponse;
import com.cnipr.corebiz.search.ws.service.ICoreBizFacade;

/**
 * 处理代码化数据 需要进行二次改造
 * 
 * @author lq
 * 
 */
public class XMLContentProcess {
	int ft_type = 1;

	String strPrefix = "";

	String strPostfix = "";

	String strGif_Tif = "GIF|gif|tif|TIF";

	String patent_type = "";

	String chrFigureVirtualPath = DataAccess.getProperty("XMLServerURL");// 说明书附图的网络地址

	private HttpGet httpGetInstance = new HttpGet();
	
	public XMLContentProcess(String channelName) {
		this.patent_type = getPatentType(channelName);
	}

	public XMLContentProcess(String channelName, int ft_type) {
		this.patent_type = getPatentType(channelName);
		this.ft_type = ft_type;
	}
	
	public void setPrePostfix(String prefis, String postfis) {
		/*
		 * System.out.println("---------------------------------------------");
		 * System.out.println(action_type);
		 * System.out.println("---------------------------------------------");
		 */
		strPrefix = "<?xml version=\"1.0\"?>"
				+ "<!DOCTYPE cn-patent-document SYSTEM \"dtd/cn-patent-document-06-10-27.dtd\">";
		
		if(SetupAccess.getProperty(SetupConstant.XMLFUTUTYPE )!=null && SetupAccess.getProperty(SetupConstant.XMLFUTUTYPE).equals("tif") ) 
			strPrefix += "<?xml-stylesheet type=\"text/xsl\" href=\"xsl/XSL0117new_tif.xsl\"?>";
		else
			strPrefix += "<?xml-stylesheet type=\"text/xsl\" href=\"xsl/XSL0117new.xsl\"?>";
		// System.out.println("s_CopyXML="+s_CopyXML);
		// if (action_type == 1) {
		// /*
		// * if(s_CopyXML.equals("0")){ strPrefix+="<?xml-stylesheet
		// * type=\"text/xsl\" href=\"xsl/XSL0117new.xsl\"?>"; }else{
		// * strPrefix+="<?xml-stylesheet type=\"text/xsl\"
		// * href=\"xsl/XSL-Online_Guest.xsl\"?>"; }
		// */
		// strPrefix += "<?xml-stylesheet type=\"text/xsl\"
		// href=\"xsl/XSL0117new.xsl\"?>";
		// } else if (action_type == 3) {
		// strPrefix += "<?xml-stylesheet type=\"text/xsl\"
		// href=\"xsl/XSL0117newPrint.xsl\"?>";
		// } else if (action_type == 2) {
		// strPrefix += "<?xml-stylesheet type=\"text/xsl\"
		// href=\"xsl/XSL0117new.xsl\"?>";
		// }

		strPrefix += "<?trs-parser SegmentMark=\"paragraph\" NewLineMark=\"br\" HitShowMark=\"TRSHL\" FilterCData=\"yes\"?>"
				+ "<cn-patent-document lang=\"ZH\" country=\"CN\">"
				+ "<application-body lang=\"CN\" country=\"CN\">" + prefis;

		strPostfix = postfis + "</application-body></cn-patent-document>";
	}

	public String setPrePostfix(String xmlStr, String prefis, String postfis) {
		/*
		 * System.out.println("---------------------------------------------");
		 * System.out.println(action_type);
		 * System.out.println("---------------------------------------------");
		 */
		strPrefix = "<?xml version=\"1.0\"?>"
				+ "<!DOCTYPE cn-patent-document SYSTEM \"dtd/cn-patent-document-06-10-27.dtd\">";
		
		if(SetupAccess.getProperty(SetupConstant.XMLFUTUTYPE)!=null && SetupAccess.getProperty(SetupConstant.XMLFUTUTYPE).equals("tif") ) 
			strPrefix += "<?xml-stylesheet type=\"text/xsl\" href=\"xsl/XSL0117new_tif.xsl\"?>";
		else
			strPrefix += "<?xml-stylesheet type=\"text/xsl\" href=\"xsl/XSL0117new.xsl\"?>";
		// System.out.println("s_CopyXML="+s_CopyXML);
		// if (action_type == 1) {
		// /*
		// * if(s_CopyXML.equals("0")){ strPrefix+="<?xml-stylesheet
		// * type=\"text/xsl\" href=\"xsl/XSL0117new.xsl\"?>"; }else{
		// * strPrefix+="<?xml-stylesheet type=\"text/xsl\"
		// * href=\"xsl/XSL-Online_Guest.xsl\"?>"; }
		// */
		// strPrefix += "<?xml-stylesheet type=\"text/xsl\"
		// href=\"xsl/XSL0117new.xsl\"?>";
		// } else if (action_type == 3) {
		// strPrefix += "<?xml-stylesheet type=\"text/xsl\"
		// href=\"xsl/XSL0117newPrint.xsl\"?>";
		// } else if (action_type == 2) {
		// strPrefix += "<?xml-stylesheet type=\"text/xsl\"
		// href=\"xsl/XSL0117new.xsl\"?>";
		// }

		strPrefix += "<?trs-parser SegmentMark=\"paragraph\" NewLineMark=\"br\" HitShowMark=\"TRSHL\" FilterCData=\"yes\"?>"
				+ "<cn-patent-document lang=\"ZH\" country=\"CN\">"
				+ "<application-body lang=\"CN\" country=\"CN\">" + prefis;

		strPostfix = postfis + "</application-body></cn-patent-document>";
		
		return strPrefix + xmlStr + strPostfix;
	}

	@SuppressWarnings("unchecked")
	public String convert(String rootPath, String strAN, String strPD,
			String tmpString, int int_start) throws Exception {
		// System.out.println(strPD);
		try {
			ArrayList al = new ArrayList();
			// al.add("dis");

			Pattern pattern = Pattern.compile("</[^<^>]+>");
			pattern = Pattern.compile("</[^\u4e00-\u9fa5^<^>^/]+>");

			Matcher matcher = pattern.matcher(tmpString);

			if (int_start == 1) {
				// tmpString=tmpString.replace(strPrefix, "");
				String tmp = "";
				if (ft_type == 1) {
					tmp = "<claims>";
				} else if (ft_type == 2) {
					tmp = "<description>";
				} else if (ft_type == 3) {
					tmp = "<drawings>";
				}

				// tmp="<application-body lang=\"CN\" country=\"CN\"><claims>";
				int pos = tmpString.indexOf(tmp);
				if (pos < 0)
					pos = 0;

				tmpString = tmpString.substring(pos + tmp.length());
				tmpString = tmpString.trim();
			}

			int m = 0;

			// <![CDATA[......]]>
			// 发现这个标签
			if (tmpString.indexOf("<![CDATA[") > -1
					&& tmpString.indexOf("]]>") < 0) {
				tmpString += "]]>";
			}
			if (tmpString.indexOf("<![CDATA[") < 0
					&& tmpString.indexOf("]]>") > -1) {
				tmpString = "<![CDATA[" + tmpString;
			}

			/*
			 * <claim id="ci19" num="019">
			 * <claim-text>19.权利要求18的化合物和其异构体、立体异构体或立体异构体
			 * <br/>的混合物以及其药学上可接受的盐或前体药物形式，其中R<sup>6a</sup>独立选 <br/> <!-- SIPO
			 * <DP n="10"> -->
			 */
			// 出现上面这种情况，需要先增加</claim-text>，再增加</claim>
			// 需要把增加在前面和后面的item进行排序
			Hashtable ht_begin = new Hashtable();
			Hashtable ht_end = new Hashtable();

			boolean b_has = false;// 在ArrayList中是否已存在
			while (matcher.find() && !matcher.group().equals("</br>")) {// 取出内容
				String strItem = matcher.group();
				m++;

				Iterator it = al.iterator();
				while (it.hasNext()) {
					String item = (String) it.next();
					if (item.equals(strItem.substring(2, strItem.length() - 1))) {
						b_has = true;// 如果发现在ArrayList中是否已存在，那么就跳出循环，寻找下一个标记
						break;
					}
				}

				if (b_has == true) {
					b_has = false;
					// break;
				} else {
					boolean b_nobegin = false;
					int[] arrBegin = null;

					al.add(strItem.substring(2, strItem.length() - 1));// 此标记还未处理过，加入ArrayList中，并开始处理
					// 查找</dis>的个数及位置
					int[] arrEnd = findItem(tmpString, strItem);

					String str = "<"
							+ strItem.substring(2, strItem.length() - 1);
					// 查找<dis>的个数及位置
					if (tmpString.indexOf(str + " ") > -1) {
						str += " ";
					} else if (tmpString.indexOf(str + ">") > -1) {
						str += ">";
					} else {
						// 遇到一个情况
						// <claim-text>实时地从断面测量仪器收集数据；<br/></claim-text></claim>
						// 上面这段既没有"<claim>"也没有"<claim ",所以str为<claim,
						// 但如果findItem(tmpString,str);能找到<claim-text>,这样就违背了程序的初衷
						// 如果在截取的内容中找不到上面两种情况，就说明只有下联没有上联
						// 增加这段程序，由于某页在结尾有</p>，但没有<p 或<p>，那么就直接在开始增加<p>
						ht_begin.put(strItem.replace("</", "<"), tmpString
								.indexOf(strItem));
						b_nobegin = true;
					}

					if (!b_nobegin) {
						arrBegin = findItem(tmpString, str);
						// 如果标记成对儿
						if (arrEnd.length == arrBegin.length) {
							for (int i = 0; i < arrEnd.length; i++) {
								if (arrBegin[i] > arrEnd[i]) {
									// 一旦出现上面这种情况，就是下面这种情形
									/*
									 * </dis> <dis> </dis> <dis>
									 */
									// 前面加一个<dis>，后面加一个</dis>
									int int_pos = tmpString.indexOf(strItem);
									ht_begin.put(strItem.replace("</", "<"),
											int_pos);
									// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
									int_pos = tmpString.lastIndexOf(str);
									ht_end.put(strItem, int_pos);
									break;
								}
							}
						} else {
							// 如果标记不成对儿
							if (arrEnd.length > arrBegin.length) {
								/*
								 * </dis> <dis> </dis>
								 */
								int int_pos = tmpString.indexOf(strItem);
								ht_begin.put(strItem.replace("</", "<"),
										int_pos);
							} else if (arrBegin.length > arrEnd.length) {
								/*
								 * <dis> </dis> <dis> </dis> <dis>
								 */
								// tmpString=tmpString+strItem;
								int int_pos = tmpString.lastIndexOf(str);
								ht_end.put(strItem, int_pos);
							}
						}
					}

				}
			}

			Iterator it = null;
			m = 0;
			// 最后检查<dis>和</dis>是否成对儿
			// 只有一种可能性，tmpString有<p id="d0" num="001">，没有</p>
			// pattern = Pattern.compile("<[^/^<^>]+>");
			pattern = Pattern.compile("<[^!^/^\u4e00-\u9fa5^<^>]+>");
			matcher = pattern.matcher(tmpString);

			ArrayList al1 = new ArrayList();

			String strItem = "";
			// ArrayList altemp = new ArrayList();
			while (matcher.find()) {
				strItem = matcher.group();
				if (strItem.startsWith("<DP ")) {
					continue;
				}

				m++;

				String strSimItem = "";
				if (strItem.indexOf(" ") > -1) {
					strSimItem = strItem.substring(1, strItem.indexOf(" "));
				} else {
					strSimItem = strItem.substring(1, strItem.length() - 1);
				}

				it = al1.iterator();
				while (it.hasNext()) {
					String item = (String) it.next();
					if (item.equals(strSimItem)) {
						b_has = true;// 如果发现在ArrayList中是否已存在，那么就跳出循环，寻找下一个标记
						break;
					}
				}
				if (b_has == true) {
					b_has = false;
					// break;
				} else {
					al1.add(strSimItem);// 此标记还未处理过，加入ArrayList中，并开始处理
				}

			}
			// al存放从下联取出来的标记，这种情况已经处理过了
			// al1存放从上联取出来的标记，现在开始处理这种情况
			boolean e_has = false;// 是否存在下联

			Iterator it1 = al1.iterator();
			while (it1.hasNext()) {
				e_has = false;
				String item1 = (String) it1.next();

				it = al.iterator();
				while (it.hasNext()) {
					String item = (String) it.next();
					if (item1.equals(item)) {
						e_has = true;
						break;
					}
				}

				if (!e_has) {// 如果没有下联
					try {
						// 查找<dis>的个数及位置
						// int[] arrBegin = findItem(tmpString,strItem);
						// 查找</dis>的个数及位置
						findItem(tmpString, "</" + item1 + ">");
					} catch (NumberFormatException ex) {
						if (tmpString.indexOf("<" + item1 + " ") > -1) {
							int int_pos = tmpString.lastIndexOf("<" + item1
									+ " ");
							ht_end.put("</" + item1 + ">", int_pos);
						} else {
							int int_pos = tmpString.lastIndexOf("<" + item1
									+ ">");
							ht_end.put("</" + item1 + ">", int_pos);
						}
					}
				}
			}
			/** ***************************************************************************************** */
			Set entry = ht_begin.entrySet();
			int[] arrB = new int[ht_begin.size()];
			int int_b = 0;
			it = entry.iterator();
			Map.Entry me = null;
			while (it.hasNext()) {
				me = (Map.Entry) it.next();
				// System.out.println(me.getKey()+":"+me.getValue());
				arrB[int_b] = ((Integer) me.getValue()).intValue();
				int_b++;
			}
			String tmp = "";
			if (arrB != null && arrB.length > 0) {
				Arrays.sort(arrB);
				// tmpString
				for (int i = 0; i < arrB.length; i++) {
					it = entry.iterator();
					while (it.hasNext()) {
						me = (Map.Entry) it.next();
						// System.out.println(me.getKey()+":"+me.getValue());
						if (arrB[i] == ((Integer) me.getValue()).intValue()) {
							tmpString = (String) me.getKey() + tmpString;
						}
					}
				}
			}
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			entry = ht_end.entrySet();
			int[] arrE = new int[ht_end.size()];
			int int_e = 0;
			it = entry.iterator();
			while (it.hasNext()) {
				me = (Map.Entry) it.next();
				// System.out.println(me.getKey()+":"+me.getValue());
				arrE[int_e] = ((Integer) me.getValue()).intValue();
				int_e++;
			}

			tmp = "";
			if (arrE != null && arrE.length > 0) {
				Arrays.sort(arrE);
				/*
				 * for(int j=0;j<arrE.length;j++){ System.out.println(arrE[j]); }
				 */
				// tmpString
				for (int i = 0; i < arrE.length; i++) {
					it = entry.iterator();
					while (it.hasNext()) {
						me = (Map.Entry) it.next();
						// System.out.println(me.getKey()+":"+me.getValue());
						if (arrE[i] == ((Integer) me.getValue()).intValue()) {
							tmp = (String) me.getKey() + tmp;
						}
					}
				}
			}
			tmpString += tmp;
			// tmp.toLowerCase();
			/** ***************************************************************************************** */
						
			tmpString = replaceInnerPICXML(rootPath, tmpString, strAN, strPD);// 20080621
			// System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			// System.out.println(tmpString);
			// <embed width=800 height=1142
			// src="http://192.168.3.217/figures/fm/2006/20061018/200510041897.3/A0110849400051.tif"
			// type="image/tiff">

			// 如果"权利要求书"的内容前后没有<claim id="ci26"
			// num="026">和</claim>,在ie中就什么都显示不出来
			if (ft_type == 1 && tmpString.indexOf("</claim>") < 0) {
				if (tmpString.indexOf("<claim-text>") < 0) {
					tmpString = "<claim><claim-text>" + tmpString
							+ "</claim-text></claim>";
				} else {
					tmpString = "<claim>" + tmpString + "</claim>";
				}
			}
			if (ft_type == 2 && tmpString.indexOf("</p>") < 0) {
				tmpString = "<p>" + tmpString + "</p>";
			}
			tmpString = strPrefix + tmpString;
			tmpString = tmpString + strPostfix;
			/*
			 * System.out.println("---------------------------------------------------------------");
			 * System.out.println(tmpString);
			 * System.out.println("---------------------------------------------------------------");
			 */
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		}
		// System.out.println(tmpString);
		return tmpString;
	}
	
	@SuppressWarnings("unchecked")
	public String replaceInnerPICXML(String rootPath, String tmpString,
			String strAN, String strPD) {

		String strANShort = strAN;
		if (Integer.parseInt(strPD.substring(0, 4)) < 1989) {
			if (strAN.indexOf(".") > -1) {
				strANShort = strAN.substring(0, strAN.indexOf("."));
			}
		}
		strANShort = strANShort.toUpperCase().replace("CN", "");

		String strRenderInnerXMLPath = rootPath + "/xml/RenderInnerXML";
//		System.out.println("patent_type----:"+patent_type);
		if(patent_type!=null&&"sq".equalsIgnoreCase(patent_type)){
			ICoreBizFacade client = CoreBizClient.getCoreBizClient(2);
			DetailSearchResponse detailResponse=null;
			try {
				detailResponse = client.executeDetailSearch("fmsq_ft","an="+strAN,"","","",2,115,false,0,"");
			} catch (Exception e) {
				e.printStackTrace();
			}
			strPD=detailResponse.getPatentInfo().getPd().replace(".", "");
 			//System.out.println(detailResponse.getPatentInfo().getSqTifPath());
//			System.out.println(strPD);
		}else{
			ICoreBizFacade client = CoreBizClient.getCoreBizClient(2);
			DetailSearchResponse detailResponse=null;
			try {
				detailResponse = client.executeDetailSearch("fmzl_ft,syxx_ft","an="+strAN,"","","",2,115,false,0,"");
			} catch (Exception e) {
				e.printStackTrace();
			}
			strPD=detailResponse.getPatentInfo().getPd().replace(".", "");
		}
		
		String strInnerXMLPath = patent_type + "\\" + strPD + "\\" + strANShort;

		Pattern pattern = Pattern.compile("file=\"[^\u4e00-\u9fa5]+." + strGif_Tif + "\"");
		Matcher matcher = pattern.matcher(tmpString);

		List strList = new ArrayList();
		if (matcher.find()) {
			/*******************************************************************************/
			pattern = Pattern.compile("(file=\"[^\u4e00-\u9fa5]+?(." + strGif_Tif + ")\")+");
			matcher = pattern.matcher(tmpString);
			int end = 0;
			while (matcher.find()) {
				String strImgName = matcher.group().substring(
						"file=\"".length(), matcher.group().lastIndexOf("\""));
				String picURL = chrFigureVirtualPath + patent_type + "/"
						+ strPD.replaceAll("\\.", "") + "/" + strANShort + "/"
						+ strImgName;
				if(SetupAccess.getProperty(SetupConstant.XMLFUTUTYPE)!=null && SetupAccess.getProperty(SetupConstant.XMLFUTUTYPE).equals("gif") )					
				{		
					picURL = picURL.replace("TIF", "gif");
					picURL = picURL.replace("tif", "gif");
					strImgName = strImgName.replace("TIF", "gif").replace("tif", "gif");
				}
//				System.out.println("strImgName----:"+picURL);
				if (httpGetInstance != null) {
					// 这里如果是与IIS数据同机房的一定要用内网地址，否则下不了数据
					httpGetInstance.addItem(DataAccess.getProperty("XMLIntranetServerURL") + patent_type + "/"
							+ strPD.replaceAll("\\.", "") + "/" + strANShort + "/"
							+ strImgName, strImgName);
				}
				
				String result = "file=\"" + picURL + "\"";
//				 System.out.println("result---::"+result);
				strList.add(tmpString.substring(end, matcher.start()));
				strList.add(result);
				end = matcher.end();
			}
			String old = tmpString;
			tmpString = "";
			for (int i = 0; i < strList.size(); i++) {
				tmpString += (String) strList.get(i);
			}
			tmpString = tmpString + old.substring(end);

		}
		/** *************************************************************************** */
		strList = new ArrayList();
		/** *************************************************************************** */
		pattern = Pattern.compile("(file=\"[^\u4e00-\u9fa5]+?(.xml|XML)\")+");
		matcher = pattern.matcher(tmpString);

		int end = 0;
		while (matcher.find()) {
			String xml = matcher.group().substring("file=\"".length(),
					matcher.group().lastIndexOf("\""));
			String result = "file=\"" + strRenderInnerXMLPath + "?path="
					+ strInnerXMLPath + "&amp;xml=" + xml + "\"";
			// System.out.println(result);
			strList.add(tmpString.substring(end, matcher.start()));
			strList.add(result);
			end = matcher.end();
		}
		String old = tmpString;
		tmpString = "";
		for (int i = 0; i < strList.size(); i++) {
			tmpString += (String) strList.get(i);
		}
		tmpString = tmpString + old.substring(end);

		return tmpString;
	}

	// 查找有几个<dis ...>，记录下位置，并放到数组中
	private int[] findItem(String tmpString, String strItem)
			throws NumberFormatException {
		int[] arr = null;
		try {
			// tmpString = "</dis>845747<dis id=\"ci1\" num=\"001\">ljffdksd<p
			// id=\"d28\"
			// num=\"029\">yirt;k</p><p>3129475</p></dis><p>08jpou89</p><dis>fgr343</dis><dis>";
			// tmpString = "</dis>845747<dis>ljffdksd<p id=\"d28\"
			// num=\"029\">yirt;k</p><p>3129475</p></dis>";
			// strItem = "</dis>";
			// System.out.println(tmpString.endsWith(strItem));

			Pattern pattern = Pattern.compile(strItem);
			Matcher matcher = pattern.matcher(tmpString);

			String str = "";

			while (matcher.find()) {// 取出内容
				// System.out.println(matcher.start());
				str += matcher.start() + ",";
			}
			String[] arrTemp = str.split(",");
			arr = new int[arrTemp.length];
			for (int i = 0; i < arrTemp.length; i++) {
				// System.out.println(arrTemp[i]);
				arr[i] = Integer.parseInt(arrTemp[i]);
			}
		} catch (NumberFormatException ex) {
			throw ex;
		}
		return arr;
	}

	private String getPatentType(String channelName) {
		String patentType = "";
		try {
			if (channelName.indexOf("fmzl") > -1 || channelName.indexOf("FMZL") > -1) {
				patentType = "fm";
			}
			if (channelName.indexOf("syxx") > -1 || channelName.indexOf("SYXX") > -1) {
				patentType = "xx";
			}
			if (channelName.indexOf("wgzl") > -1  || channelName.indexOf("WGZL") > -1) {
				patentType = "wg";
			}
			if (channelName.indexOf("fmsq") > -1 || channelName.indexOf("FMSQ") > -1 ) {
				patentType = "sq";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return patentType;
	}

	public HttpGet getHttpGetInstance() {
		return httpGetInstance;
	}

}
