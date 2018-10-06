package com.cnipr.cniprgz.tonzu.service.impl;

import com.cnipr.cniprgz.dao.ChannelDAO;
import com.cnipr.cniprgz.func.search.SearchFunc;
import com.cnipr.cniprgz.tonzu.bean.TowDataAnalysis;
import com.cnipr.cniprgz.tonzu.service.TonZuService;
import com.cnipr.corebiz.search.entity.PatentInfo;
import com.cnipr.corebiz.search.ws.response.DetailSearchResponse;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.collections.CollectionUtils;

/**
 * 同族业务处理
 */
public class TonZuServiceImpl implements TonZuService {
	private ChannelDAO cdao = null;
	private SearchFunc searchFunc = null;
	public TowDataAnalysis tonZuDataProc(String arg, String arg1)
			throws Exception {
		// TODO Auto-generated method stub
		cdao = new ChannelDAO();
		searchFunc = new SearchFunc();
		String chrTRSTables = cdao.getEnablechrTRSTables(arg1);
		String[] sqIDes = arg.split(";");
		Set<String> countryX = new HashSet<String>();
		Set<Integer> yearY = new HashSet<Integer>();
		DetailSearchResponse detailResponse = null;
		TowDataAnalysis towDataAnalysisBean = new TowDataAnalysis();
		//Map<String, Object[]> map = new HashMap<String, Object[]>();
		Map<String, List<Object[]>> map = new HashMap<String, List<Object[]>>();
		String ad = null;
		Integer year = 0;
		for (String sqID : sqIDes) {
			Object[] obj = new Object[2];
			String country = sqID.substring(0, 2);
			detailResponse = searchFunc.detailSearch(null,chrTRSTables, "申请号=("+ sqID + ")", "RELEVANCE", "", "", 2, 115, false, 0, "");
			if(null==detailResponse){
				detailResponse=new DetailSearchResponse();
			}
			PatentInfo patentInfo = detailResponse.getPatentInfo();
			if (null != patentInfo) {
				ad = patentInfo.getAd();
				year = new Integer(null == ad || "".equals(ad) ? "" : ad
						.substring(0, 4));
				countryX.add(country);
				yearY.add(year);
				obj[0] = ad;
				obj[1] = sqID;
				String key=country + year;
				List<Object[]> list=map.get(key);
				if(list!=null){
					list.add(obj);
					map.put(key, list);
				}else{
					list=new ArrayList<Object[]>();
					list.add(obj);
					map.put(key, list);
				}
			}
		}
		List<Integer> listY = sort(yearY);
		int begin = listY.get(0);
		int end = listY.get(listY.size() - 1);
		for (int i = begin; i <= end; i++) {
			yearY.add(i);
		}
		List<String> listX = new ArrayList<String>();
		CollectionUtils.addAll(listX, countryX.toArray());
		listY = sort(yearY);
		towDataAnalysisBean = dataProcess(listX, listY, map);
		return towDataAnalysisBean;
	}

	/**
	 * 返回二维数据
	 * 
	 * @param arg1
	 * @param arg2
	 * @param map
	 * @return
	 */
	private TowDataAnalysis dataProcess(List<String> listX,
			List<Integer> listY, Map<String, List<Object[]>> map) {
		Object[][] objs = new Object[listX.size()][listY.size()];
		TowDataAnalysis towDataAnalysisBean = new TowDataAnalysis();
		int i = 0;
		for (String str : listX) {
			int j = 0;
			for (Integer data : listY) {
				String strs = str + data;
				List<Object[]> list = map.get(strs);
				if (null == list) {
					list=new ArrayList<Object[]>();
					Object[] obj=new Object[]{"",""};
					list.add(obj);
				}
				objs[i][j] = list;
				j++;
			}
			i++;
		}
		towDataAnalysisBean.setListSX(listX);
		towDataAnalysisBean.setListIY(listY);
		towDataAnalysisBean.setObj(objs);
		return towDataAnalysisBean;
	}

	/**
	 * 对集合进行排序
	 * 
	 * @param args
	 * @return
	 */
	private List<Integer> sort(Set<Integer> args) {
		List<Integer> list = new ArrayList<Integer>();
		CollectionUtils.addAll(list, args.toArray());
		Collections.sort(list);
		return list;
	}
}
