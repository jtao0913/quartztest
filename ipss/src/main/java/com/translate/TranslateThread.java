package com.translate;

import java.lang.reflect.Proxy;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;

import org.codehaus.xfire.client.Client;
import org.codehaus.xfire.client.XFireProxy;
import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.service.Service;
import org.codehaus.xfire.service.binding.ObjectServiceFactory;

import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.translate.service.ITranslateService;

public class TranslateThread implements Runnable {
	String contents = "";
	int int_RecordCount_now = 0;
	String strResult = "";

	boolean Completed = false;

	Hashtable<String, String> translateLib;

	public void setTranslateLib(Hashtable<String, String> m_translateLib) {
		translateLib = m_translateLib;
	}

	public Hashtable<String, String> getTranslateLib() {
		return translateLib;
	}

	String stranslateLib = "";

	public String getStranslateLib() {
		return stranslateLib;
	}

	public void setStranslateLib(String stranslateLib) {
		this.stranslateLib = stranslateLib;
	}

	public int getRecordCount_now() {
		return int_RecordCount_now;
	}

	public void setRecordCount_now(int int_RecordCount_now) {
		this.int_RecordCount_now = int_RecordCount_now;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String content) {
		this.contents = content;
	}

	public String getResult() {
		return strResult;
	}

	public void setResult(String result) {
		this.strResult = result;
	}

	public void run() {
		if (!Completed) {
			rendering();
		}
	}

	public static void main(String[] args) {
		ResourceBundle rb;
		String TranslateServer = DataAccess.getProperty("TranslateServer");
		
		try {
			Service serviceModel = new ObjectServiceFactory().create(ITranslateService.class);
			ITranslateService service = (ITranslateService) new XFireProxyFactory().create(serviceModel,
					"http://" + TranslateServer + "/TranslateService/services/TranslateService");

			XFireProxy proxy = (XFireProxy) Proxy.getInvocationHandler(service);
			Client client = proxy.getClient();
			client.addOutHandler(new ClientAuthenticationHandler("webtranslate", "webtranslate"));
			short iLanguage = 1;
			String Profession = "";
			String userDict = "";
			// String source="PNEUMATIC VEHICLE TIRE";

			String strRet = "";
			String strContents = "0===G06T3/00===Method and system for creating realistic smooth three-dimensional depth contours from two-dimensional images";

			Hashtable<String, String> m_TranslateLib = new Hashtable<String, String>();

			/////////////////////////////////////////////////////////////////////
			Hashtable<String, String> translateLib =com.cnipr.cniprgz.dao.TranslateDAO.buildTranslateParam();
			String s_translateLib = "";

			Set entry1 = translateLib.entrySet();
			Iterator it1 = entry1.iterator();
			Map.Entry me1 = null;
			while (it1.hasNext()) {
				me1 = (Map.Entry) it1.next();
				
				//out.println("hashtable values  = " + me.getKey()+":"+me.getValue() + "<br>");
				s_translateLib += me1.getKey()+","+me1.getValue() + ";";
				/*
				if (arrContentItem[1].indexOf(me.getKey() + "") > -1) {
					strTranslateLib = me.getValue() + "";
					break;
				}
				*/
			}
			
			String s_TranslateLib = s_translateLib;

//			System.out.println(strContents);

			String[] arrTranslateLib = s_TranslateLib.split(";");
			for (int i = 0; i < arrTranslateLib.length; i++) {
				String[] arrItem = arrTranslateLib[i].split(",");
				m_TranslateLib.put(arrItem[0], arrItem[1]);
			}

			// System.out.println("...................待处理....................");
			// System.out.println(strContents);

			String strTranslateLib = "";

			String[] arrContent = strContents.split("!!!");

			// System.out.println("......待处理数据长度......"+arrContent.length);

			for (int i = 0; i < arrContent.length; i++) {
				// System.out.println(i+"......翻译......"+arrContent[i]);

				String[] arrContentItem = arrContent[i].split("===");

				String strValue = "";

				// System.out.println(arrContent[i]);
				// System.out.println(arrContentItem[0]);
				// System.out.println(arrContentItem[1]);
				// System.out.println(arrContentItem[2]);

				if (arrContentItem.length == 3) {
					Set entry = m_TranslateLib.entrySet();
					Iterator it = entry.iterator();
					Map.Entry me = null;
					while (it.hasNext()) {
						me = (Map.Entry) it.next();
						// System.out.println("jieguo-ys.jsp-->:hashtable values "
						// +
						// me.getKey()+":"+me.getValue());
						// if (arrContentItem[1].indexOf(me.getKey() + "") > -1) {
						if (arrContentItem[1].equals(me.getKey() + "")) {
							strTranslateLib = me.getValue() + "";
							break;
						}
					}

					char[] chars = arrContentItem[2].toCharArray();
					String source = "";
					for (int j = 0; j < chars.length; j++) {
						source += "%" + (int) chars[j];
					}

					// System.out.println("========================== pre =======================");
					// System.out.println("iLanguage = "+iLanguage);
					// System.out.println("strTranslateLib = "+strTranslateLib);
					// System.out.println("userDict = "+userDict);
					//
					// System.out.println("arrContentItem[2] = "+arrContentItem[2]);
					// System.out.println("source = "+source);
					// System.out.println("========================================================");

					source = source.toLowerCase();
					// source="PNEUMATIC VEHICLE TIRE";
					// System.out.println("source = "+source);
//					txjs
					strValue = service.mtTranslate(iLanguage, "jxag", "jxag", source);
					System.out.println(strValue);
					// strValue = service.mtTranslate(iLanguage, strTranslateLib, userDict, source);
				}
				// System.out.println("========================== 翻译结果
				// =======================");
				// System.out.println(strTranslateLib+"........."+arrContentItem[2]+".............."+strValue);

				// strRet += arrContentItem[0] + "===" + strValue;
				// if(i<arrContent.length-1) {
				// strRet += "!!!";
				// }

				if (i > 0) {
					strRet += "!!!";
				}
				strRet += arrContentItem[0] + "===" + strValue;
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}

	public void rendering() {
		Completed = false;

		ResourceBundle rb;
		// rb = ResourceBundle.getBundle("com.trs.was.resource.wasconfig");
		// String TranslateServer = rb.getString("TranslateServer");
		// String TranslateServer = "218.240.13.215:8080";
		String TranslateServer = DataAccess.getProperty("TranslateServer");

		try {
			Service serviceModel = new ObjectServiceFactory().create(ITranslateService.class);
			ITranslateService service = (ITranslateService) new XFireProxyFactory().create(serviceModel,
					"http://" + TranslateServer + "/TranslateService/services/TranslateService");

			XFireProxy proxy = (XFireProxy) Proxy.getInvocationHandler(service);
			Client client = proxy.getClient();
			client.addOutHandler(new ClientAuthenticationHandler("webtranslate", "webtranslate"));
			short iLanguage = 1;
			String Profession = "";
			String userDict = "";
			// String source="PNEUMATIC VEHICLE TIRE";

			String strRet = "";
			String strContents = this.getContents();

			Hashtable<String, String> m_TranslateLib = new Hashtable<String, String>();

			String s_TranslateLib = this.getStranslateLib();

			// System.out.println(strContents);

			String[] arrTranslateLib = s_TranslateLib.split(";");
			for (int i = 0; i < arrTranslateLib.length; i++) {
				String[] arrItem = arrTranslateLib[i].split(",");
				m_TranslateLib.put(arrItem[0], arrItem[1]);
			}

			// System.out.println("...................待处理....................");
			// System.out.println(strContents);

			String strTranslateLib = "";

			String[] arrContent = strContents.split("!!!");

			// System.out.println("......待处理数据长度......"+arrContent.length);

			for (int i = 0; i < arrContent.length; i++) {
				// System.out.println(i+"......翻译......"+arrContent[i]);

				String[] arrContentItem = arrContent[i].split("===");

				String strValue = "";

				// System.out.println(arrContent[i]);
				// System.out.println(arrContentItem[0]);
				// System.out.println(arrContentItem[1]);
				// System.out.println(arrContentItem[2]);

				if (arrContentItem.length == 3) {
					Set entry = m_TranslateLib.entrySet();
					Iterator it = entry.iterator();
					Map.Entry me = null;
					while (it.hasNext()) {
						me = (Map.Entry) it.next();
						// System.out.println("jieguo-ys.jsp-->:hashtable values "
						// +
						// me.getKey()+":"+me.getValue());
						// if (arrContentItem[1].indexOf(me.getKey() + "") > -1) {
						if (arrContentItem[1].equals(me.getKey() + "")) {
							strTranslateLib = me.getValue() + "";
							break;
						}
					}

					char[] chars = arrContentItem[2].toCharArray();
					String source = "";
					for (int j = 0; j < chars.length; j++) {
						source += "%" + (int) chars[j];
					}

					// System.out.println("========================== pre =======================");
					// System.out.println("iLanguage = "+iLanguage);
					// System.out.println("strTranslateLib = "+strTranslateLib);
					// System.out.println("userDict = "+userDict);
					//
					// System.out.println("arrContentItem[2] = "+arrContentItem[2]);
					// System.out.println("source = "+source);
					// System.out.println("========================================================");

					source = source.toLowerCase();
					// source="PNEUMATIC VEHICLE TIRE";
					// System.out.println("source = "+source);

					strValue = service.mtTranslate(iLanguage, strTranslateLib, strTranslateLib, source);
					// strValue = service.mtTranslate(iLanguage, strTranslateLib, userDict, source);
				}
				// System.out.println("========================== 翻译结果
				// =======================");
				// System.out.println(strTranslateLib+"........."+arrContentItem[2]+".............."+strValue);

				// strRet += arrContentItem[0] + "===" + strValue;
				// if(i<arrContent.length-1) {
				// strRet += "!!!";
				// }

				if (i > 0) {
					strRet += "!!!";
				}
				strRet += arrContentItem[0] + "===" + strValue;

				this.setResult(strRet);

				// System.out.println("========================== 最终 =======================");
				// System.out.println(strRet);
				int_RecordCount_now++;
			}
			Completed = true;

		} catch (Exception ex) {
			Completed = true;
			ex.printStackTrace();
		} finally {
			try {
				Completed = true;
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}

	public String translateHelper(String strSource, String strTranslateLib) {
		String source = "";
		String strRet = "";

		ResourceBundle rb;
		rb = ResourceBundle.getBundle("com.trs.was.resource.wasconfig");
		String TranslateServer = rb.getString("TranslateServer");

		try {
			Service serviceModel = new ObjectServiceFactory().create(ITranslateService.class);
			ITranslateService service = (ITranslateService) new XFireProxyFactory().create(serviceModel,
					"http://" + TranslateServer + "/TranslateService/services/TranslateService");

			XFireProxy proxy = (XFireProxy) Proxy.getInvocationHandler(service);
			Client client = proxy.getClient();
			client.addOutHandler(new ClientAuthenticationHandler("webtranslate", "webtranslate"));
			short iLanguage = 1;
			// --------------------------------------------------
			char[] chars = strSource.toCharArray();
			for (int j = 0; j < chars.length; j++) {
				source += "%" + (int) chars[j];
			}

			// --------------------------------------------------
			strRet = service.mtTranslate(iLanguage, strTranslateLib, strTranslateLib, source);

		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return strRet;
	}
}