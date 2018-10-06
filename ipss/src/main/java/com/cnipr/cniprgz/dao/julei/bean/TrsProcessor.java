package com.cnipr.cniprgz.dao.julei.bean;

import java.util.ArrayList;
import java.util.List;

import org.apache.xmlbeans.XmlException;
import org.dom4j.Element;
import org.dom4j.Node;

public class TrsProcessor extends Processor {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 专利解析
	 * 
	 * @param patentNode
	 * @return List<Patent>
	 * @throws XmlException
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<Patent> patentParse(Node patentNode){
		List<Element> list = patentNode.selectNodes(".//CL_patent");
		if (list.isEmpty()) {
			throw new RuntimeException("聚类专利为空");
		}
		List<Patent> result = new ArrayList<Patent>();
		for (Element e : list) {
			Patent patent = new Patent();
			String id = e.attributeValue("num");
			String[] arrId = id.split(";");
			String ap = arrId[0];
			String area = ap != null && !"".equals(ap) ? ap.substring(0, 2) : "";
			patent.setId(id);
			patent.setAp(ap);
			patent.setSimilarity(e.attributeValue("similarity"));
			patent.setX(e.attributeValue("cx"));
			patent.setY(e.attributeValue("cy"));
			patent.setZ(e.attributeValue("cz"));
			patent.setTi(e.attributeValue("f1"));
			patent.setPa(e.attributeValue("f2"));
			patent.setIpc(e.attributeValue("f3"));
			patent.setCc(e.attributeValue("f4"));
			patent.setArea(area);
			result.add(patent);
		}
		return result;
	}
}
