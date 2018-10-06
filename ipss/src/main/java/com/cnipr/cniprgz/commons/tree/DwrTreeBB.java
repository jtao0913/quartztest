package com.cnipr.cniprgz.commons.tree;

/**
 * 
 */

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cnipr.cniprgz.commons.SetupAccess;
import com.cnipr.cniprgz.commons.SetupConstant;
import com.cnipr.cniprgz.dao.ChannelDAO;
import com.cnipr.cniprgz.dao.TreeDAO;
import com.cnipr.cniprgz.entity.IprNavtableInfo;

/**
 * 
 */
public class DwrTreeBB {

	private static final long serialVersionUID = 4111866697531811228L;

	public TreeDAO getTreeDAO() {
		return treeDAO;
	}

	public void setTreeDAO(TreeDAO treeDAO) {
		this.treeDAO = treeDAO;
	}

	private TreeDAO treeDAO = new TreeDAO();

	
	/**
	 * 获得树
	 * 
	 * @param parentId
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public List getOrgTree(String nodeId, String searchType) throws IOException {
		List returnList = new ArrayList();

		// if (nodeId == null || nodeId.equals("")) {
		// nodeId = "0";
		// }
		//
		// List<IprNavtableInfo> iprNavtableInfoList = treeDAO
		// .getHYTreeNodes(Integer.parseInt(nodeId));
		//
		// for (IprNavtableInfo info : iprNavtableInfoList) {
		// Map map = new HashMap();
		// String expression = "";
		// if (searchType.equals("cn"))
		// expression = info.getCnExpression();
		// else
		// expression = info.getFrExpression();
		// map.put("expression", expression);
		// map.put("id", info.getId());
		// map.put("text", info.getName());
		// map.put("leaf", treeDAO.isLeaf(info.getId()));
		// map.put("searchType", searchType);
		//			
		// returnList.add(map);
		// }

		return returnList;
	}

	@SuppressWarnings( { "unchecked", "deprecation" })
	public List getTree(String nodeId, String searchType, String treeType, String userId, String strClass) throws IOException {		
	//	System.out.println("noteId= "+nodeId );
		List returnList = new ArrayList();
		
		List<IprNavtableInfo> iprNavtableInfoList = null;

		if (nodeId == null || nodeId.equals("") || nodeId.equals("null")) {
			nodeId = "0";
		} 
		
		boolean isIpcTreeLastLev = false;
		
		if (strClass != null && strClass.length() == 4 && treeType != null && treeType.equals("0")) {
			iprNavtableInfoList = treeDAO.getIPCFourLev(strClass);
			isIpcTreeLastLev = true; 
		//	System.out.println("treeType1 = "+treeType);
		} else {
		//	System.out.println("treeType2 = "+treeType);
			iprNavtableInfoList = treeDAO.getTreeNodes(
					Integer.parseInt(nodeId), searchType, Integer
							.parseInt(treeType), userId); 
		//	System.out.println(" -------"+treeType);
		}
			
		for (IprNavtableInfo info : iprNavtableInfoList) {
			Map map = new HashMap();
			// String expression = "";
			// if (searchType.equals("cn"))
			// expression = info.getCnExpression();
			// else
			// expression = info.getFrExpression();
			//map.put("userId", userId);
			String cnExpression = info.getCnExpression();
			String frExpression = info.getFrExpression();
			map.put("cnExpression", cnExpression);
			map.put("frExpression", frExpression);
			map.put("id",  info.getId());
			StringBuffer text = new StringBuffer();
			String chrLapsedChannels = info.getChrLapsedChannels();
			// text.append(info.getName());
			if ((cnExpression != null && !cnExpression.equals(""))
					|| (frExpression != null && !frExpression.equals(""))
					|| (chrLapsedChannels != null && !chrLapsedChannels
							.equals(""))) {
				
				text.append("<a href=\"\" onMouseOver='javascript:document.getElementById(\"div1_");
				text.append(info.getId());
				text.append("\").style.display=\"\";' onMouseOut='javascript:document.getElementById(\"div1_");
				text.append(info.getId());
				text.append("\").style.display=\"none\";'><span id=\"div1_");
				text.append(info.getId());
				text.append("\" style=\"display:none\" >");
				
				if (cnExpression != null && !cnExpression.equals("")) {
					text.append("<img src=\"../../images/CN.gif\" onclick=\"setSearchArea('cn');\">");
					String strChannel = info.getChrCNChannels();
					if (strChannel == null || strChannel.equals("")) {
						map.put("chrCNChannels", SetupAccess.getProperty(SetupConstant.NAVCNCHANNELS));
					} else {
						map.put("chrCNChannels", strChannel);
					}
				}
				
				if(SetupAccess.getProperty(SetupConstant.FRCHANNEL)!=null && SetupAccess.getProperty(SetupConstant.FRCHANNEL).equals("1"))
				{
					if (frExpression != null && !frExpression.equals("")) {
						text.append("<img src=\"../../images/FR.gif\" onclick=\"setSearchArea('fr');\">");	
						String strChannel = info.getChrFRChannels();
						if (strChannel == null || strChannel.equals("")) {
							map.put("chrFRChannels", SetupAccess.getProperty(SetupConstant.NAVFRCHANNELS));
						} else {
							map.put("chrFRChannels", strChannel);
						}
					}
				}
				
				if(SetupAccess.getProperty(SetupConstant.EFFECTLIB )!=null && SetupAccess.getProperty(SetupConstant.EFFECTLIB ).equals("1"))
				{					 
					//if (chrLapsedChannels != null && !chrLapsedChannels.equals(""))
					{
						text.append("<img src=\"../../images/YX.gif\" onclick=\"setSearchArea('yx');\">");
						map.put("chrYXLapsedChannels", SetupAccess.getProperty(SetupConstant.NAVEFFECTCHANNEL));
					}
				}
				
				if(SetupAccess.getProperty(SetupConstant.SHIXIAOSEARCH )!=null && SetupAccess.getProperty(SetupConstant.SHIXIAOSEARCH ).equals("1"))
				{ 
					 
					//if (chrLapsedChannels != null && !chrLapsedChannels.equals(""))
					{
						text.append("<img src=\"../../images/SX.gif\" onclick=\"setSearchArea('sx');\">");
						map.put("chrLapsedChannels", SetupAccess.getProperty(SetupConstant.NAVSXCHANNELS));
					}
				}
				
				text.append("</span>").append(info.getName()).append("</a>");
				// System.out.println(text.toString());
				// text = "<a href=\"\"
				// onMouseOver='javascript:document.getElementById(\"div1_"
				// + info.getId()
				// + "\").style.display=\"\";'
				// onMouseOut='javascript:document.getElementById(\"div1_"
				// + info.getId()
				// + "\").style.display=\"none\";'><span id=\"div1_"
				// + info.getId()
				// + "\" style=\"display:none\" ><img
				// src=\"../../images/CN.gif\"
				// onclick=\"setSearchArea('cn');\"><img
				// src=\"../../images/FR.gif\"
				// onclick=\"setSearchArea('fr');\"></span>"
				// + text + "</a>";
			} else {
				text.append(info.getName());
			}
			// map.put("text", text);
			map.put("text", text.toString());
			
			if (isIpcTreeLastLev) {
				map.put("leaf", true);
			} else {
				if (treeType != null && treeType.equals("0"))
					map.put("leaf", false);
				else 
					map.put("leaf", treeDAO.isLeaf(info.getId(), Integer
						.parseInt(treeType)));
			}
			
			map.put("searchType", searchType);
			map.put("treeType", treeType);
			map.put("strClass", info.getStrClass());

			returnList.add(map);
		}
		 
		return returnList;
	}

	public List getVocationTree(String nodeId) throws IOException {
		List returnList = new ArrayList();

		return returnList;
	}

	public static void main(String[] args) throws IOException {
		// DwrTreeBB tt = new DwrTreeBB();
		// List returnList = tt.getOrgTree("D:\\dirs.xml");
		// int i = 0;
		// while (i < returnList.size()) {
		// Map m = (Map) returnList.get(i);
		// Iterator it = m.entrySet().iterator();
		// while (it.hasNext()) {
		// Entry e = (Entry) it.next();
		// System.out.println("key:" + e.getKey());
		// System.out.println("value:" + e.getValue());
		// System.out.println("---------------------------");
		// }
		// System.out.println("***********************************");
		// i++;
		// }
		// Date startDate = new Date();
		// Document doc = null;
		// List l = null;
		// try {
		// doc = ReadFileInfo.parse("D:\\dirs.xml");
		// l = ReadFileInfo.getMenuOnly(doc, "D:\\temp\\新しいフォルダ");
		// } catch (JDOMException e) {
		// e.printStackTrace();
		// }
		// Date endDate = new Date();
		// System.out.println(endDate.getTime() - startDate.getTime() + " ms");
		// System.out.println("***********************************");
	}
}
