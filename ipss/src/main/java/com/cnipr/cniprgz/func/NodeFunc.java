package com.cnipr.cniprgz.func;

import java.util.ArrayList;
import java.util.List;

import com.cnipr.cniprgz.dao.NodeDAO;
import com.cnipr.cniprgz.entity.NodeModel;

public class NodeFunc {
	
	private NodeDAO nodeDao = new NodeDAO();
	
	public NodeDAO getNodeDAO() {
		return nodeDao;
	}
	
	public void setNodeDAO(NodeDAO nodeDao) {
		this.nodeDao = nodeDao;
	}
	
	public List<NodeModel> getDiyNodesByParent1111111111111(int parentId ,String treeType,String inculeId,String selTrade) {
		List<NodeModel> list = nodeDao.getDiyNodeByParent(parentId,treeType,selTrade);
		// 在这里处理下Node节点
		List<NodeModel> nodeLists = new ArrayList<NodeModel>();
		NodeModel node = null;
		for (NodeModel expNode : list) {
			if (expNode != null) {
//				if(StringTools.isNotBlank(inculeId))
				if(inculeId!=null&&!inculeId.equals(""))
				{
					//children_go 表示是否根据父节点直接便利子节点
					if(expNode.getId().equals(inculeId)||inculeId=="children_go"){
						int count = nodeDao.countByDiyParent(treeType,expNode.getId(),selTrade);
						
						if(count>0){
							node = new NodeModel();
							node.setId(expNode.getId());
							node.setpId(expNode.getpId());						
							node.setClassname(expNode.getClassname());
							node.setName(expNode.getName());
							node.setExpl(expNode.getExpl());
							node.setCnTrsExp(expNode.getCnTrsExp());
							node.setCnTrsTable(expNode.getCnTrsTable());
							node.setSxTrsTable(expNode.getSxTrsTable());
							node.setCnTrsOption(expNode.getCnTrsOption());
							node.setEnTrsExp(expNode.getEnTrsExp());
							node.setEnTrsTable(expNode.getEnTrsTable());
							node.setEnTrsOption(expNode.getEnTrsOption());
							node.setGroupId(expNode.getGroupId());
							if (count > 0) {
								node.setIsParent(true);
								
								//展开所有节点
	//							node.setOpen(true);
								// 如果有子节点，则递归遍历它的子节点
	//							List<NodeModel> childList = getDiyNodesByParent(expNode
	//									.getUuid(),"children_go",groupId);
	//							node.setChildren(childList);
							}
							nodeLists.add(node);
						}
					}
				}else{
					int count = nodeDao.countByDiyParent(treeType,expNode.getId(),selTrade);
					
					if(treeType.equals("0")||treeType.equals("3")||treeType.equals("4")||treeType.equals("5")||
							(!treeType.equals("0")&&!treeType.equals("3")&&!treeType.equals("4")&&!treeType.equals("5")&&
									(parentId==0&&(selTrade+"$").indexOf(expNode.getId()+"$")>-1||parentId!=0)
									)
							)
					{
						node = new NodeModel();
						node.setId(expNode.getId());
						node.setpId(expNode.getpId());
						node.setName((expNode.getClassname()==null?"":expNode.getClassname()) + " " + expNode.getName());
						node.setClassname(expNode.getClassname());
						node.setExpl(expNode.getExpl());
						node.setCnTrsExp(expNode.getCnTrsExp());
						node.setCnTrsTable(expNode.getCnTrsTable());
						node.setSxTrsTable(expNode.getSxTrsTable());
						node.setCnTrsOption(expNode.getCnTrsOption());
						node.setEnTrsExp(expNode.getEnTrsExp());
						node.setEnTrsTable(expNode.getEnTrsTable());
						node.setEnTrsOption(expNode.getEnTrsOption());
						node.setGroupId(expNode.getGroupId());
						if (count > 0) {
							node.setIsParent(true);
							//展开所有节点
	//						node.setOpen(true);
							// 如果有子节点，则递归遍历它的子节点
	//						List<NodeModel> childList = getDiyNodesByParent(expNode
	//								.getUuid(),"",groupId);
	//						node.setChildren(childList);
						}else {
							node.setIsParent(false);
						}
						nodeLists.add(node);
					}
				}
			}
		}
		return nodeLists;
	}
	
	public List<NodeModel> getDiyNodesByParent222222222(int parentId ,String treeType,String selTrade) {
		List<NodeModel> list = nodeDao.getDiyNodeByParent(parentId,treeType,selTrade);
		// 在这里处理下Node节点
		List<NodeModel> nodeLists = new ArrayList<NodeModel>();
		NodeModel node = null;
		for (NodeModel expNode : list) {
			if (expNode != null) {
//				if(StringTools.isNotBlank(inculeId))
				{
					int count = nodeDao.countByDiyParent(treeType,expNode.getId(),selTrade);
					
					if(treeType.equals("0")||treeType.equals("3")||treeType.equals("4")||treeType.equals("5")||
							(!treeType.equals("0")&&!treeType.equals("3")&&!treeType.equals("4")&&!treeType.equals("5")&&
									(parentId==0&&(selTrade+"$").indexOf(expNode.getId()+"$")>-1||parentId!=0)
									)
							)
					{
						node = new NodeModel();
						node.setId(expNode.getId());
						node.setpId(expNode.getpId());
						node.setName((expNode.getClassname()==null?"":expNode.getClassname()) + " " + expNode.getName());
						node.setClassname(expNode.getClassname());
						node.setExpl(expNode.getExpl());
						node.setCnTrsExp(expNode.getCnTrsExp());
						node.setCnTrsTable(expNode.getCnTrsTable());
						node.setSxTrsTable(expNode.getSxTrsTable());
						node.setCnTrsOption(expNode.getCnTrsOption());
						node.setEnTrsExp(expNode.getEnTrsExp());
						node.setEnTrsTable(expNode.getEnTrsTable());
						node.setEnTrsOption(expNode.getEnTrsOption());
						node.setGroupId(expNode.getGroupId());
						if (count > 0) {
							node.setIsParent(true);
							//展开所有节点
	//						node.setOpen(true);
							// 如果有子节点，则递归遍历它的子节点
	//						List<NodeModel> childList = getDiyNodesByParent(expNode
	//								.getUuid(),"",groupId);
	//						node.setChildren(childList);
						}else {
							node.setIsParent(false);
						}
						nodeLists.add(node);
					}
				}
			}
		}
		return nodeLists;
	}
	
	public List<NodeModel> getNodes(int parentId, String treeType, String selTrade) {
		List<NodeModel> list = nodeDao.getByParent(parentId, treeType, selTrade);
		List<NodeModel> nodeLists = new ArrayList<NodeModel>();
		NodeModel node = null;
		for (NodeModel expNode : list) {
			if (expNode != null) {
				int count = nodeDao.countByDiyParent(treeType, expNode.getId(), selTrade);
				node = new NodeModel();
				node.setId(expNode.getId());
				node.setpId(expNode.getpId());
				node.setName((expNode.getClassname() == null ? "" : expNode.getClassname()) + " " + expNode.getName());
				node.setClassname(expNode.getClassname());
				node.setExpl(expNode.getExpl());
				node.setCnTrsExp(expNode.getCnTrsExp());
				node.setCnTrsTable(expNode.getCnTrsTable());
				node.setSxTrsTable(expNode.getSxTrsTable());
				node.setCnTrsOption(expNode.getCnTrsOption());
				node.setEnTrsExp(expNode.getEnTrsExp());
				node.setEnTrsTable(expNode.getEnTrsTable());
				node.setEnTrsOption(expNode.getEnTrsOption());
				node.setGroupId(expNode.getGroupId());
				if (count > 0) {
					node.setIsParent(true);
					// 展开所有节点
					// node.setOpen(true);
					// 如果有子节点，则递归遍历它的子节点
					// List<NodeModel> childList = getDiyNodesByParent(expNode
					// .getUuid(),"",groupId);
					// node.setChildren(childList);
				} else {
					node.setIsParent(false);
				}
				nodeLists.add(node);
			}
		}
		return nodeLists;
	}
	
	public List<NodeModel> getDiyNodesByParent(int parentId ,String treeType,String selTrade) {
		List<NodeModel> list = nodeDao.getDiyNodeByParent(parentId,treeType,selTrade);
//		在这里处理下Node节点
		List<NodeModel> nodeLists = new ArrayList<NodeModel>();
		NodeModel node = null;
		for (NodeModel expNode : list) {
			if (expNode != null) {
//				if(StringTools.isNotBlank(inculeId))
				{
					int count = nodeDao.countByDiyParent(treeType,expNode.getId(),selTrade);
					
/*					if(treeType.equals("0")||treeType.equals("3")||treeType.equals("4")||treeType.equals("5")||
							(!treeType.equals("0")&&!treeType.equals("3")&&!treeType.equals("4")&&!treeType.equals("5")&&
									(parentId==0&&(selTrade+"$").indexOf(expNode.getId()+"$")>-1||parentId!=0)
									)
							)
*/						
					if(treeType.equals("6")
							||
							treeType.equals("0")//IPC
							||
							treeType.equals("4")//GMJJ
							||
							(treeType.equals("1")||treeType.equals("3"))&&(parentId==0&&(selTrade+"$").indexOf(expNode.getId()+"$")>-1||parentId==0&&(selTrade==null||selTrade.equals(""))||parentId!=0)
							||
							treeType.equals("5")&&((selTrade+"$").indexOf(expNode.getId()+"$")>-1||parentId>=Integer.parseInt(selTrade))//地址
							)
					{
						node = new NodeModel();
						node.setId(expNode.getId());
						node.setpId(expNode.getpId());
						node.setName((expNode.getClassname()==null?"":expNode.getClassname()) + " " + expNode.getName());
						node.setClassname(expNode.getClassname());
						node.setExpl(expNode.getExpl());
						node.setCnTrsExp(expNode.getCnTrsExp());
						node.setCnTrsTable(expNode.getCnTrsTable());
						node.setSxTrsTable(expNode.getSxTrsTable());
						node.setCnTrsOption(expNode.getCnTrsOption());
						node.setEnTrsExp(expNode.getEnTrsExp());
						node.setEnTrsTable(expNode.getEnTrsTable());
						node.setEnTrsOption(expNode.getEnTrsOption());
						node.setGroupId(expNode.getGroupId());
						if (count > 0) {
							node.setIsParent(true);
							//展开所有节点
	//						node.setOpen(true);
							// 如果有子节点，则递归遍历它的子节点
	//						List<NodeModel> childList = getDiyNodesByParent(expNode
	//								.getUuid(),"",groupId);
	//						node.setChildren(childList);
						}else {
							node.setIsParent(false);
						}
						nodeLists.add(node);
					}
				}
			}
		}
		return nodeLists;
	}	
	
/*	public NodeModel getNodeInfoByID(String treeType,String Id) {
		return nodeDao.getNodeInfoByID(treeType, Id);
	}*/
	
	public NodeModel getNodeInfoByID(String treeType, String Id) {
		if(Integer.parseInt(treeType)==6) {
			return nodeDao.getNodeInfoByID2(treeType, Id);
		}else {
			return nodeDao.getNodeInfoByID(treeType, Id);
		}
		//return nodeDao.getNodeInfoByID(treeType, Id);
	}
	
	
}
