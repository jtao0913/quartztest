package com.cnipr.cniprgz.dao.julei.bean;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.xmlbeans.XmlException;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;

public class Processor  implements Serializable {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 解析
	 * 
	 * @param str
	 * @return List<Cluster>
	 * @throws DocumentException
	 * @throws XmlException
	 */
	public List<Cluster> parse(String str) throws DocumentException {
		Document doc = DocumentHelper.parseText(str);
		return clusterParse(doc);
	}

	/**
	 * 类解析
	 * 
	 * @param doc
	 * @return List<Cluster>
	 * @throws XmlException
	 */
	@SuppressWarnings("unchecked")
	public List<Cluster> clusterParse(Document doc) {
		List<Node> list = doc.selectNodes("//CL_cluster"); // 所有CL_cluster节点
		if (list.isEmpty()) {
			throw new RuntimeException("聚类为空");
		}
		List<Cluster> result = new ArrayList<Cluster>();
		for (Node node : list) {
			Cluster cluster = new Cluster();
			cluster.setId(node.valueOf("@cnum"));
			cluster.setX(node.valueOf("@cx"));
			cluster.setY(node.valueOf("@cy"));
			cluster.setZ(node.valueOf("@cz"));
			Node wordNode = node.selectSingleNode("./CL_vector_table"); // 当前节点下的CL_vector_table节点
			cluster.setLstWord(wordParse(wordNode));
			Node patentNode = node.selectSingleNode("./CL_patent_table");
			cluster.setLstPatent(patentParse(patentNode));
			result.add(cluster);
		}
		return result;
	}

	/**
	 * 关键词解析
	 * 
	 * @param wordNode
	 * @return List<Word>
	 * @throws XmlException
	 */
	@SuppressWarnings("unchecked")
	public List<Word> wordParse(Node wordNode) {
		List<Element> list = wordNode.selectNodes(".//CL_vword"); // 当前节点下的所有CL_vword子节点
		if (list.isEmpty()) {
			throw new RuntimeException("聚类关键词为空");
		}
		List<Word> result = new ArrayList<Word>();
		for (Element e : list) {
			Word word = new Word();
			word.setWord(e.attributeValue("name"));
			word.setWeight(e.attributeValue("weight"));
			result.add(word);
		}
		return result;
	}

	/**
	 * 专利解析
	 * 
	 * @param patentNode
	 * @return List<Patent>
	 * @throws XmlException
	 */
	@SuppressWarnings("unchecked")
	public List<Patent> patentParse(Node patentNode) {
		List<Element> list = patentNode.selectNodes(".//CL_patent");
		if (list.isEmpty()) {
			throw new RuntimeException("聚类专利为空");
		}
		List<Patent> result = new ArrayList<Patent>();
		for (Element e : list) {
			Patent patent = new Patent();
			patent.setId(e.attributeValue("num"));
			patent.setSimilarity(e.attributeValue("similarity"));
			patent.setX(e.attributeValue("cx"));
			patent.setY(e.attributeValue("cy"));
			patent.setZ(e.attributeValue("cz"));
			result.add(patent);
		}
		return result;
	}

	/**
	 * 创建xml
	 * 
	 * @param out
	 * @param list
	 * @throws IOException
	 */
	public void write(OutputStream out, List<Cluster> list) throws IOException {
		Document doc = create(list);
		OutputFormat format = OutputFormat.createPrettyPrint();
		format.setEncoding("UTF-8");
		XMLWriter writer = new XMLWriter(out, format);
		writer.write(doc);
		writer.flush();
	}

	/**
	 * 输出为字符串
	 * 
	 * @param list
	 * @return String
	 * @throws IOException
	 */
	public String createXmlString(List<Cluster> list) throws IOException {
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		try {
			write(out, list);
			return out.toString("UTF-8");
		} catch (UnsupportedEncodingException uee) {
			throw uee;
		} catch (IOException ioe) {
			throw ioe;
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	/**
	 * 创建
	 * 
	 * @param list
	 * @return Document
	 */
	public Document create(List<Cluster> list) {
		Document doc = DocumentHelper.createDocument();
		Element root = doc.addElement("DEM");
		for (Cluster cluster : list) {
			Element eCluster = root.addElement("CL_cluster");
			eCluster.addAttribute("cnum", cluster.getId());
			eCluster.addAttribute("cx", cluster.getX());
			eCluster.addAttribute("cy", cluster.getY());
			eCluster.addAttribute("cz", cluster.getZ());
			Element eVector = eCluster.addElement("CL_vector_table");
			List<Word> lstWord = cluster.getLstWord();
			for (Word word : lstWord) {
				Element eWord = eVector.addElement("CL_vword");
				eWord.addAttribute("name", word.getWord());
				eWord.addAttribute("weight", word.getWeight());
			}
			Element ePatentTable = eCluster.addElement("CL_patent_table");
			List<Patent> lstPatent = cluster.getLstPatent();
			for (Patent patent : lstPatent) {
				Element ePatent = ePatentTable.addElement("CL_patent");
				ePatent.addAttribute("num", patent.getAp());
				ePatent.addAttribute("similarity", patent.getSimilarity());
				ePatent.addAttribute("dx", patent.getX());
				ePatent.addAttribute("dy", patent.getY());
				ePatent.addAttribute("dz", patent.getZ());
			}
		}
		return doc;
	}
	
	
	public  void  setDisplay(String display,List<Cluster> lstCluster){
		for (Cluster cluster : lstCluster) {
			// 显示关键词
			List<Word> lstWord = cluster.getLstWord();
			String word = "";
			for (int i = 0; i < lstWord.size(); i++) {
				word += lstWord.get(i).getWord();
				if (i < lstWord.size() - 1) {
					word += ",";
				}
			}
			List<Patent> lstPatent = cluster.getLstPatent();
			word += " (" + lstPatent.size() + ")";
			cluster.setWord(word);
			// 显示专利字段
			List<String> lstExp = new ArrayList<String>();
			for (Patent patent : lstPatent) {
				// 设置显示
				patent.setDisplay(CluDisplayParser.getDisplay(display, patent));
				String[] arrId = patent.getId().split(";");
				String ap = arrId[0];
				String pn = arrId[1];
				// 设置表达式
				String exp = "(申请号=('" + ap + "') and 公开（公告）号=('" + pn + "'))";
				lstExp.add(exp);
			}
			StringBuffer sb = new StringBuffer();
			for(String s : lstExp){
				sb.append(s).append(" or ");
			}
			sb.delete(sb.lastIndexOf("or"), sb.length());
			cluster.setExp(sb.toString());
		}
	}
}