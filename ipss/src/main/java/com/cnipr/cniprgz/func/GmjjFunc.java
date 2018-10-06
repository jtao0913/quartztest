package com.cnipr.cniprgz.func;

import java.util.ArrayList;
import java.util.List;
import com.cnipr.cniprgz.dao.GmjjDAO;
import com.cnipr.cniprgz.entity.GMJJModel;

public class GmjjFunc {
	
	private GmjjDAO gmjjDao = new GmjjDAO();
	public GmjjDAO getGmjjDao() {
		return gmjjDao;
	}
	public void setGmjjDao(GmjjDAO gmjjDao) {
		this.gmjjDao = gmjjDao;
	}

	public List<GMJJModel> getDiyNodesByParent(String parentId ,String treeType,String inculeId,String selTrade) {
		List<GMJJModel> list = gmjjDao.getDiyNodeByParent(parentId,treeType,selTrade);
		// 在这里处理下Node节点
		List<GMJJModel> nodeLists = new ArrayList<GMJJModel>();
		GMJJModel node = null;
		for (GMJJModel expNode : list) {
			if (expNode != null) {
//				if(StringTools.isNotBlank(inculeId))
				if(inculeId!=null&&!inculeId.equals(""))
				{
					//children_go 表示是否根据父节点直接便利子节点
					if(expNode.getId().equals(inculeId)|| inculeId=="children_go"){
						int count = gmjjDao.countByDiyParent(treeType,expNode.getId(),selTrade);
						node = new GMJJModel();
						node.setId(expNode.getId());
						node.setpId(expNode.getpId());
						node.setName(expNode.getName());
						if (count > 0) {
							node.setIsParent(true);
						}
						nodeLists.add(node);
					}
				}else{
					int count = 0;
					
					if(expNode.getId().length()<4) {
						count = gmjjDao.countByDiyParent(treeType,expNode.getId(),selTrade);
					}
					
					node = new GMJJModel();
					node.setId(expNode.getId());
					node.setpId(expNode.getpId());
					node.setName(expNode.getId() + " " + expNode.getName());
					if (count > 0) {
						node.setIsParent(true);
						//展开所有节点
//						node.setOpen(true);
						// 如果有子节点，则递归遍历它的子节点
//						List<NodeModel> childList = getDiyNodesByParent(expNode
//								.getUuid(),"",groupId);
//						node.setChildren(childList);
					}
					nodeLists.add(node);
				}
			}
		}
		return nodeLists;
	}
	
/*	public GMJJModel getNodeInfoByID(String treeType,String Id) {
		return gmjjDao.getNodeInfoByID(treeType, Id);
	}*/
	
	
}
