package com.cnipr.cniprgz.dao.julei;

import java.io.IOException;
import java.util.List;

import org.dom4j.DocumentException;

import com.cnipr.cniprgz.client.CoreBizClient;
import com.cnipr.cniprgz.dao.julei.bean.CluResultModel;
import com.cnipr.cniprgz.dao.julei.bean.Cluster;
import com.cnipr.cniprgz.dao.julei.bean.TrsProcessor;
//import com.cnipr.corebiz.search.entity.CluParam;
//import com.cnipr.corebiz.search.ws.response.PatentCluResponse;
import com.cnipr.corebiz.search.ws.service.ICoreBizFacade;

public class JuLeiDao {
	
	private String ckmHost ;
	private String ckmUser ;
	private String ckmPass ;
	private String trsHost ;
	private String trsPort ;
	private String trsUser ;
	private String trsPass ;
	private String docMax ;
	
	private String clsNum ;
	private String keywordNum ;
	private String docid ;
	private String docCol ;
	static ICoreBizFacade webserviceClient = CoreBizClient.getCoreBizClient(0);
	
	private TrsProcessor processor;
/*	
	public CluResultModel cluster(String sources, String strWhere,String pb,String jq, String option, String synonym, 
			String docCol1, String clsNum1, String keywordNum1, String display) throws DocumentException, IOException{
		CluResultModel model = new CluResultModel ();
		
		
		String cluXml = "";
		CluParam p = new CluParam();
		p.setSources(sources);
		p.setTrsWherexpr(strWhere);
		if(org.apache.commons.lang.StringUtils.isNotBlank(clsNum1)){
			p.setTrsMaxcls(Integer.parseInt(clsNum1.trim()));
		}
		if(org.apache.commons.lang.StringUtils.isNotBlank(keywordNum1)){
			p.setTrsKeywordnum(Integer.parseInt(keywordNum1.trim()));
		}
//		p.set
		PatentCluResponse clu = null;
		try {
			clu = webserviceClient.patentClu(p);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(clu!=null && clu.getStatus()==0){
			cluXml = new String(clu.getXmlBytes());
		}
		List<Cluster> lstCluster = processor.parse(cluXml);
		processor.setDisplay(display, lstCluster);
		String chartXml = cluXml;//processor.createXmlString(lstCluster);
		model.setList(lstCluster);
		model.setXml(chartXml);
		return model;
	}
*/
	public TrsProcessor getProcessor() {
		return processor;
	}

	public void setProcessor(TrsProcessor processor) {
		this.processor = processor;
	}

}
