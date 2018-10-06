package com.cnipr.cniprgz.func;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.cnipr.cniprgz.func.JExpTrans.CLibrary;
import com.sun.jna.WString;

/**
 * 跨语言检索
 * 
 * @author Administrator
 * 
 */
public class CrossLanguage {
	public static String getCrossLanguageExp(String exp) {
		String strTemp = exp;
		strTemp = strTemp.replace("公开（公告）号", "");
		strTemp = strTemp.replace("公开（公告）日", "");
		strTemp = strTemp.replace("申请号", "");

		strTemp = strTemp.replace("申请日", "");
		strTemp = strTemp.replace("专利号", "");
		strTemp = strTemp.replace("名称", "");
		strTemp = strTemp.replace("主分类号", "");
		strTemp = strTemp.replace("分类号", "");
		strTemp = strTemp.replace("申请（专利权）人", "");
		strTemp = strTemp.replace("发明（设计）人", "");
		strTemp = strTemp.replace("摘要", "");
		strTemp = strTemp.replace("主权项", "");
		strTemp = strTemp.replace("优先权", "");
		strTemp = strTemp.replace("同族专利项", "");
		strTemp = strTemp.replace("国省代码", "");
		strTemp = strTemp.replace("分案原申请号", "");
		strTemp = strTemp.replace("地址", "");
		strTemp = strTemp.replace("专利代理机构", "");
		strTemp = strTemp.replace("代理人", "");
		strTemp = strTemp.replace("审查员", "");

		strTemp = strTemp.replace("颁证日", "");
		strTemp = strTemp.replace("国际申请", "");
		strTemp = strTemp.replace("国际公布", "");
		strTemp = strTemp.replace("进入国家日期", "");
		strTemp = strTemp.replace("摘要附图存储路径", "");
		strTemp = strTemp.replace("欧洲主分类号", "");
		strTemp = strTemp.replace("欧洲分类号", "");
		strTemp = strTemp.replace("本国主分类号", "");
		strTemp = strTemp.replace("本国分类号", "");
		strTemp = strTemp.replace("发布路径", "");
		strTemp = strTemp.replace("页数", "");
		strTemp = strTemp.replace("申请国代码", "");
		strTemp = strTemp.replace("专利类型", "");

		strTemp = strTemp.replace("申请来源", "");
		strTemp = strTemp.replace("参考文献", "");
		strTemp = strTemp.replace("范畴分类", "");

		Pattern pattern = Pattern.compile("[\u4e00-\u9fa5]");
		Matcher matcher = pattern.matcher(strTemp);

		// System.out.println("1111   s2  = " + s2);

		if (matcher.find()) {
			JExpTrans obj = JExpTrans.getJExpTrans();
			CLibrary hInst = obj.getCLibrary();
			// WString wsRes = hInst.TranslateExpression( new WString(s2), 1, 0,
			// 0, 1 );
			// System.out.println(wsRes);

			exp = (hInst.TranslateExpression(new WString(exp), 1, 0, 0, 1)).toString();
			exp = exp.replace("公开(公告)号", "公开（公告）号");
			exp = exp.replace("公开(公告)日", "公开（公告）日");
			exp = exp.replace("申请(专利权)人", "申请（专利权）人");
			exp = exp.replace("发明(设计)人", "发明（设计）人");
		}
		
		return exp;
	}
}
