package com.trs.usermanage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.trs.Tools;

public class NavTree {

	int intID = 0; // 用户ID
	private String chrName = null; // 用户名
	private String chrExpression = null; // 用户密码
	private String chrFRExpression = null; // 真实姓名
	private String chrMemo = null; // 真实姓名
 
	private String chrSelNavIDs="";
    //*********************************************
	public NavTree(){}
	
	public void getAllNavIDs(String[] arrTradeList){
		try{
			for(int i=0;i<arrTradeList.length;i++){
				if(Tools.isNumeric(arrTradeList[i])){
					chrSelNavIDs+=arrTradeList[i]+",";
					getNavIDsByParentID(Integer.parseInt(arrTradeList[i]));
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
	private void getNavIDsByParentID(int parentID){
		String strNavIDs="";
		
		//Connection conn = null;
		PreparedStatement PrePareStmtUpdate = null;
		PreparedStatement PrePareStmtQuery = null;
		ResultSet rs = null;		
		Connection conn = DBPoolAccessor.getConnection();
		try {
			//conn = DBConnect.getConnection();
			String strSQL = "";
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			strSQL="select intID from ipr_navtable where intParentID=" + parentID;
			
			PrePareStmtQuery = conn.prepareStatement(strSQL);
		    rs = PrePareStmtQuery.executeQuery();
		    int intParentID=0;
            while(rs.next())
            {
            	chrSelNavIDs+=rs.getInt("intID")+",";
            	
				boolean bflag=has_child(rs.getInt("intID"));
				if (bflag)
				{
					getNavIDsByParentID(rs.getInt("intID"));					
					/*
					strSQL = "select * from ipr_navtable where intParentID="+ intID;
					
					PrePareStmtQuery = conn.prepareStatement(strSQL);
					rs = PrePareStmtQuery.executeQuery();
	
		            while(rs.next())
		            {
		            	int intChildID = rs.getInt("intID");
		            	//String strSql2 = "delete from ipr_navtable where intID="+ intID0;
		            	//executeUpdate(strSql2);
		            	deleteAll(intChildID,intAdministerID);
		            }
		            */
				}
            }
			rs.close();
			PrePareStmtQuery.close();			
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		}catch (Exception ex) {
			ex.printStackTrace();
		}
		finally
		{
			try
			{   
				rs.close();
				PrePareStmtQuery.close();
				if(!conn.isClosed()){
					//DBConnect.closeConnection(conn);
					DBPoolAccessor.closeAll(rs, PrePareStmtQuery, conn);
				}
			}
			catch(Exception e)
			{e.printStackTrace();}
		}
	}
	
	public static void main(String[] args) {
		NavTree navTree=new NavTree();
		
		navTree.getNavIDsByParentID(1373);
		System.out.println(navTree.chrSelNavIDs);
	}

	public void updateUserNav(int intNavID,int intUserID,String chrUserIP){
		//Connection conn = null;
		PreparedStatement PrePareStmtQuery = null;
		PreparedStatement PrePareStmtUpdate = null;
		ResultSet rs = null;
		String strSQL="";
		Connection conn = DBPoolAccessor.getConnection();
		try {
			//conn = DBConnect.getConnection();
			/*
			strSQL="select intChannelID,dtUpdateTime from ipr_channel";
			PrePareStmtQuery = conn.prepareStatement(strSQL);
	        rs = PrePareStmtQuery.executeQuery();
			while(rs.next()){
				String dtUpdateTime = rs.getString("dtUpdateTime");
				int intChannelID=rs.getInt("intChannelID");
				
				strSQL = "update ipr_user_nav set dtUpdateTime='"+dtUpdateTime+
						"' where intUserID="+intUserID+" and intNavID="+intNavID+" and intTRSTable="+intChannelID;
	        	//System.out.println(strSQL);
				PrePareStmtUpdate = conn.prepareStatement(strSQL);
				PrePareStmtUpdate.executeUpdate();
				PrePareStmtUpdate.close();
			}
			*/
			java.text.SimpleDateFormat sformat = new java.text.SimpleDateFormat("yyyy-MM-dd");
			String dtUpdateDate = sformat.format(new java.util.Date());
			
			strSQL = "update ipr_user_nav set intCNCount=0,intFRCount=0,dtUpdateDate='"+dtUpdateDate+"' where intUserID="+intUserID+" and intNavID="+intNavID+" and chrUserIP='"+chrUserIP+"'";
	//System.out.println(strSQL);
			PrePareStmtUpdate = conn.prepareStatement(strSQL);
			PrePareStmtUpdate.executeUpdate();
			PrePareStmtUpdate.close();			
		}
		catch(SQLException ex){
        	ex.printStackTrace();
        }
		catch(Exception ex){
        	ex.printStackTrace();
        }
        finally{
			try{
				rs.close();
				PrePareStmtQuery.close();
				PrePareStmtUpdate.close();
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				System.out.println(ex.toString());
			}
		}
	}
	
	public String getNavStr_OLD(int intUserID){
		//Connection conn = null;
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;		
		String strNav = "";
		PreparedStatement PrePareStmtNav = null;
		ResultSet rsNav = null;
		Connection conn = DBPoolAccessor.getConnection();
		try {
			//conn = DBConnect.getConnection();
			String strSQL = "select intAdministerID,intNavID,dtUpdateTime,intTRSTable from ipr_user_nav where intUserID="+intUserID;
			PrePareStmt = conn.prepareStatement(strSQL);
	        rs = PrePareStmt.executeQuery();
			while(rs.next()){
				String dtUpdateTime = rs.getString("dtUpdateTime");
				int  intTRSTable = rs.getInt("intTRSTable");
				
				//strSQL="select dtUpdateTime from ipr_channel where intChannelID="+intTRSTable;
				strSQL="select dtUpdateTime from ipr_channel where intChannelID="+intTRSTable+" and dtUpdateTime>'"+dtUpdateTime+"'";
				//System.out.println("@@@@@@@@@@"+strSQL);
				PrePareStmtNav = conn.prepareStatement(strSQL);
				rsNav = PrePareStmtNav.executeQuery();
				if(rsNav.next()){				
					strNav += rs.getInt("intNavID")+"|new#";
				}else{
					strNav += rs.getInt("intNavID")+"#";
				}
				rsNav.close();
				PrePareStmtNav.close();
			}
			rs.close();
			PrePareStmt.close();
		}
		catch(SQLException ex){
        	System.out.println(ex.toString());
        }
		catch(Exception ex){
        	System.out.println(ex.toString());
        }
        finally{
			try{
				rsNav.close();
				PrePareStmtNav.close();
				rs.close();
	            PrePareStmt.close();
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				System.out.println(ex.toString());
			}
		}
        return strNav;
	}
	
	private String strSelNav1="";//管理员赋予的权限，用户有权限的一级菜单
	private String strNavNew="";//在用户有权限的菜单中，需要显示new的
	
	private String strNavNewCN="";
	private String strNavNewFR="";
	
	public void getNavShow(int intUserID){
		//Connection conn = null;
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		
		String strSQL = "";
		strNavNew = "";
		strNavNewCN="";
		strNavNewFR="";
		
		strSelNav1="";
		Connection conn = DBPoolAccessor.getConnection();
		try {
			//conn = DBConnect.getConnection();
			/*
			strSQL = "select intNavID from ipr_user_nav where (intCNCount!=0 or intFRCount!=0) and intUserID="+intUserID;
			//System.out.println(strSQL);
			PrePareStmt = conn.prepareStatement(strSQL);
	        rs = PrePareStmt.executeQuery();
			while(rs.next()){				
				strNavNew += rs.getInt("intNavID")+"#";
			}
			rs.close();
			PrePareStmt.close();
			*/
			/****************************************************************/
			strSQL = "select intNavID from ipr_user_nav where (intCNCount!=0) and intUserID="+intUserID;
			//System.out.println(strSQL);
			PrePareStmt = conn.prepareStatement(strSQL);
	        rs = PrePareStmt.executeQuery();
			while(rs.next()){				
				strNavNewCN += rs.getInt("intNavID")+"#";
			}
			rs.close();
			PrePareStmt.close();
			
			strSQL = "select intNavID from ipr_user_nav where (intFRCount!=0) and intUserID="+intUserID;
			//System.out.println(strSQL);
			PrePareStmt = conn.prepareStatement(strSQL);
	        rs = PrePareStmt.executeQuery();
			while(rs.next()){				
				strNavNewFR += rs.getInt("intNavID")+"#";
			}
			rs.close();
			PrePareStmt.close();
			/****************************************************************/
			strSQL="select intNavID from ipr_user_nav,ipr_navtable where ipr_user_nav.intNavID=ipr_navtable.intID and ipr_navtable.intParentID=0 and ipr_user_nav.intUserID="+intUserID;
			//System.out.println(strSQL);
			PrePareStmt = conn.prepareStatement(strSQL);
	        rs = PrePareStmt.executeQuery();
			while(rs.next()){				
				strSelNav1 += rs.getInt("intNavID")+"#";
			}
			rs.close();
			PrePareStmt.close();
		}
		catch(SQLException ex){
        	ex.printStackTrace();
        }
		catch(Exception ex){
        	ex.printStackTrace();
        }
        finally{
			try{
				rs.close();
	            PrePareStmt.close();
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				System.out.println(ex.toString());
			}
		}
	}
	
	public static String getNavName(int intNavID){
		String strNavName="";
		//Connection conn = null;
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		
		String strSQL = "";
		Connection conn = DBPoolAccessor.getConnection();
		try {			
			//conn = DBConnect.getConnection();

			strSQL = "select chrName from ipr_navtable where intID="+intNavID;
			//System.out.println(strSQL);
			PrePareStmt = conn.prepareStatement(strSQL);
	        rs = PrePareStmt.executeQuery();
			if(rs.next()){				
				strNavName = rs.getString("chrName");
			}
			rs.close();
			PrePareStmt.close();
		}
		catch(SQLException ex){
        	ex.printStackTrace();
        }
		catch(Exception ex){
        	ex.printStackTrace();
        }
        finally{
			try{
				rs.close();
	            PrePareStmt.close();
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				System.out.println(ex.toString());
			}
		}
		return strNavName;
	}
	
	public int getRootID(int intParentID){
		int intRootID=0;
		//Connection conn = null;
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		
		String strSQL = "";
		Connection conn = DBPoolAccessor.getConnection();
		try {
			int parentID=0;
			//conn = DBConnect.getConnection();

			strSQL = "select intParentID from ipr_navtable where intID="+intParentID;
			//System.out.println(strSQL);
			PrePareStmt = conn.prepareStatement(strSQL);
	        rs = PrePareStmt.executeQuery();
			if(rs.next()){				
				parentID = rs.getInt("intParentID");
			}
			rs.close();
			PrePareStmt.close();
			
			if(parentID!=0){
				intRootID=getRootID(parentID);
			}else{
				intRootID=intParentID;
			}
		}
		catch(SQLException ex){
        	ex.printStackTrace();
        }
		catch(Exception ex){
        	ex.printStackTrace();
        }
        finally{
			try{
				rs.close();
	            PrePareStmt.close();
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				System.out.println(ex.toString());
			}
		}
		
		return intRootID;
	}
	
	public boolean getGDNavShow(int intUserID,int parentID){
		boolean b_use=false;
		//Connection conn = null;
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		
		String strSQL = "";
		int rootID=getRootID(parentID);
		Connection conn = DBPoolAccessor.getConnection();
		try {
			//conn = DBConnect.getConnection();

			strSQL = "select intNavID from ipr_user_nav where intUserID="+intUserID+" and intNavID="+rootID;
			//System.out.println(strSQL);
			PrePareStmt = conn.prepareStatement(strSQL);
	        rs = PrePareStmt.executeQuery();
			if(rs.next()){				
				b_use=true;
			}
			rs.close();
			PrePareStmt.close();

		}
		catch(SQLException ex){
        	ex.printStackTrace();
        }
		catch(Exception ex){
        	ex.printStackTrace();
        }
        finally{
			try{
				rs.close();
	            PrePareStmt.close();
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				System.out.println(ex.toString());
			}
		}
        return b_use;
	}
	
	public boolean has_child(int parentid){
//System.out.println("parentid="+parentid);
		boolean b=false;
		//Connection conn = null;
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		
		PreparedStatement PrePareStmtQuery = null;
		ResultSet resultSet = null;
		Connection conn = DBPoolAccessor.getConnection();
		try {
			//conn = DBConnect.getConnection();
			String strSQL="select intType,chrClass from ipr_navtable where intID=" + parentid;
//System.out.println(strSQL);
			PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            
            if(rs.next()){
            	int intType=rs.getInt("intType");
            	String chrClass=rs.getString("chrClass");
//System.out.println(chrClass);
            	strSQL="";
            	if(intType==0 && chrClass!=null && chrClass.length()==4){
            		strSQL="select * from patent_grade7 where GRADETHREE='" + chrClass + "'";
            	}else if(intType==0 && chrClass!=null && chrClass.length()<4){
        			strSQL="select * from ipr_navtable where intParentID=" + parentid;
            	}
            	else if(intType==1){
        			strSQL="select * from ipr_navtable where intParentID=" + parentid;
            	}
//System.out.println(strSQL);
            	if(strSQL!=null && !strSQL.equals("")){
	            	PrePareStmtQuery = conn.prepareStatement(strSQL);
	            	resultSet = PrePareStmtQuery.executeQuery();
	    			
	    			if(resultSet.next()) {
	    				b=true;
	    			}
	    			resultSet.close();
	    			PrePareStmtQuery.close();
            	}
            }
            rs.close();
            PrePareStmt.close();
		}catch(SQLException ex){
        	ex.printStackTrace();
        }
		catch(Exception ex){
        	ex.printStackTrace();
        }
        finally{
			try{
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}		
		return b;
	}
	
	public boolean has_child_(int parentid){
		boolean b=false;
		//Connection conn = null;
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		Connection conn = DBPoolAccessor.getConnection();
		try {
			//conn = DBConnect.getConnection();
			String strSQL="select * from ipr_navtable where intParentID="
								+ parentid + " order by intID";
			PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
			
			if(rs.next()) {
				b=true;
			}
			rs.close();			
		}catch(SQLException ex){
        	System.out.println(ex.toString());
        }
		catch(Exception ex){
        	System.out.println(ex.toString());
        }
        finally{
			try{
				rs.close();
	            PrePareStmt.close();
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				System.out.println(ex.toString());
			}
		}
		return b;
	}
	
	public String[] getIPCNodeInfo(String parentIPCCode){
		String[] arrNodeItem=null;
		
		String strNodeInfo="";
		//Connection conn = null;
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
				
		String strSQL="";
		try {
/*
strSQL="select intID intMainID,chrClass,chrName,chrExpression,chrFRExpression,chrCNChannels,chrFRChannels,(select count(*) from ipr_navtable where intType="+ipc_nav+" and " +
"intParentID=intMainID) countChildren from ipr_navtable where intType="+ipc_nav+" and intParentID="+parentid;

int intChildren=rs.getInt("countChildren");
*/			
			
			if(parentIPCCode.equals("0")){
				strSQL="select * from ipr_navtable where Length(chrClass)=1";
			}else if(parentIPCCode.length()<4){
				int l=0;
				if(parentIPCCode.length()==1){
					l=3;
				}else if(parentIPCCode.length()==3){
					l=4;
				}				
				strSQL="select * from ipr_navtable where chrClass!='"+parentIPCCode+"' and left(chrClass,"+parentIPCCode.length()+")='"+parentIPCCode+"' and length(chrClass)="+l+" and intType=0";
			}else if(parentIPCCode.length()==4){
				strSQL="select * from patent_grade7 where GRADETHREE='" + parentIPCCode + "' order by id"; 
			}
//System.out.println(strSQL);
			Connection conn = DBPoolAccessor.getConnection();
			//conn = DBConnect.getConnection();
			PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            
            rs.last();
            arrNodeItem=new String[rs.getRow()];
            rs.beforeFirst();
            
            int i=0;
     if(parentIPCCode.length()==4){
			while(rs.next()) {	
				int intID=rs.getInt("id");
				String chrClass=(rs.getString("GRADEFOUR")==null || rs.getString("GRADEFOUR").equals(""))?" ":rs.getString("GRADEFOUR");
				String chrName=(rs.getString("DESCRIPTION")==null || rs.getString("DESCRIPTION").equals(""))?" ":(chrClass+rs.getString("DESCRIPTION"));
				chrClass=chrClass.replaceAll("\\/", "☆");
				String chrExpression=chrClass;
				String chrFRExpression=chrClass;
				String chrCNChannels="";
				String chrFRChannels="";
				
				strNodeInfo=intID+"@"+chrClass+"@"+chrName+"@"
							+chrExpression+"@"
							+chrFRExpression+"@"
							+chrCNChannels+"@"
							+chrFRChannels;
				arrNodeItem[i]=strNodeInfo;
				i++;
			}
			
     }else{            
   			while(rs.next()) {	
   				int intID=rs.getInt("intID");
   				String chrClass=(rs.getString("chrClass")==null || rs.getString("chrClass").equals(""))?" ":rs.getString("chrClass");
   				String chrName=(rs.getString("chrName")==null || rs.getString("chrName").equals(""))?" ":rs.getString("chrName");
   				String chrExpression=(rs.getString("chrExpression")==null || rs.getString("chrExpression").equals(""))?" ":rs.getString("chrExpression");
   				String chrFRExpression=(rs.getString("chrFRExpression")==null || rs.getString("chrFRExpression").equals(""))?" ":rs.getString("chrFRExpression");
   				String chrCNChannels=(rs.getString("chrCNChannels")==null || rs.getString("chrCNChannels").equals(""))?" ":rs.getString("chrCNChannels");
   				String chrFRChannels=(rs.getString("chrFRChannels")==null || rs.getString("chrFRChannels").equals(""))?" ":rs.getString("chrFRChannels");
   				
   				strNodeInfo=intID+"@"+chrClass+"@"+chrName+"@"
    							+chrExpression+"@"
    							+chrFRExpression+"@"
    							+chrCNChannels+"@"
    							+chrFRChannels;
   				arrNodeItem[i]=strNodeInfo;
				i++;
    		}
      }
   		rs.close();
			PrePareStmt.close();
		}catch(SQLException ex){
        	ex.printStackTrace();
        }
		catch(Exception ex){
        	ex.printStackTrace();
        }
        finally{
			try{
				/*if(conn!=null){
					conn.close();
					conn=null;
				}*/
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
		/*
		if(strNodeInfo.length()>0){
        	strNodeInfo=strNodeInfo.substring(0,strNodeInfo.length()-1);
        	arrNodeItem=strNodeInfo.split("#");
        }
		*/
		return arrNodeItem;
	}
	
	String recursedNodes="";
	public String[] getNodeInfo(String OnlyNation_NavID,int parentid,int ipc_nav){
//System.out.println("NavTree------>getNodeInfo....................................");
		
		String[] arrNodeItem=null;
		String strNodeInfo="";
		Connection conn = null;
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		try {
			//conn = DBConnect.getConnection();
			String strSQL="select intID intMainID,chrClass,chrName,chrExpression,chrFRExpression,chrCNChannels,chrFRChannels,(select count(*) from ipr_navtable where intType="+ipc_nav+" and " +
					"intParentID=intMainID) countChildren from ipr_navtable where intType="+ipc_nav+" and intParentID="+parentid;
			
			if(parentid==0 && !OnlyNation_NavID.equals("")){
				strSQL+=" and intID = "+OnlyNation_NavID;
			}
			strSQL+=" order by intSequenceNum";

			//System.out.println("================================================");
			//System.out.println(strSQL);
			
			PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            
			while(rs.next()) {	
				int intID=rs.getInt("intMainID");
				String chrClass=(rs.getString("chrClass")==null || rs.getString("chrClass").equals(""))?" ":rs.getString("chrClass");
				String chrName=(rs.getString("chrName")==null || rs.getString("chrName").equals(""))?" ":rs.getString("chrName");
				String chrExpression=(rs.getString("chrExpression")==null || rs.getString("chrExpression").equals(""))?" ":rs.getString("chrExpression");
				String chrFRExpression=(rs.getString("chrFRExpression")==null || rs.getString("chrFRExpression").equals(""))?" ":rs.getString("chrFRExpression");
				String chrCNChannels=(rs.getString("chrCNChannels")==null || rs.getString("chrCNChannels").equals(""))?" ":rs.getString("chrCNChannels");
				String chrFRChannels=(rs.getString("chrFRChannels")==null || rs.getString("chrFRChannels").equals(""))?" ":rs.getString("chrFRChannels");
				int intChildren=rs.getInt("countChildren");
				//int intCNNavCount=rs.getInt("intCNNavCount");
				//int intFRNavCount=rs.getInt("intFRNavCount");
				
				strNodeInfo+=intID+"@"+chrClass+"@"+chrName+"@"
							+chrExpression+"@"
							+chrFRExpression+"@"
							+chrCNChannels+"@"
							+chrFRChannels+"@"
							+intChildren
							//+"@"
							//+intCNNavCount+"@"
							//+intFRNavCount
							+"#";
			}
//System.out.println(strNodeInfo);
			rs.close();			
		}catch(SQLException ex){
        	ex.printStackTrace();
        }
		catch(Exception ex){
        	ex.printStackTrace();
        }
        finally{
			try{
				rs.close();
	            PrePareStmt.close();
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				System.out.println(ex.toString());
			}
		}
        if(strNodeInfo.length()>0){
        	strNodeInfo=strNodeInfo.substring(0,strNodeInfo.length()-1);
        	arrNodeItem=strNodeInfo.split("#");
        }
		return arrNodeItem;
	}
	
	public String[] getNodeInfoRight(int parentid,int intUserID){
		String[] arrNodeItem=null;
		String strNodeInfo="";
		Connection conn = null;
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		try {
			conn = DBConnect.getConnection();
			String strSQL="";
			
			if(parentid==0){
				strSQL="select * from ipr_user_nav,ipr_navtable where intType=1 and ipr_user_nav.intUserID="+intUserID+" and intParentID=0" +
						" and ipr_user_nav.intNavID=ipr_navtable.intID order by intSequenceNum";
			}else{
				strSQL="select * from ipr_navtable where intType=1 and intParentID=" + parentid + " order by intSequenceNum";
			}
			
//System.out.println(strSQL);
			PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            
			while(rs.next()) {	
				int intID=rs.getInt("ipr_navtable.intID");
				String chrClass=(rs.getString("chrClass")==null || rs.getString("chrClass").equals(""))?" ":rs.getString("chrClass");
				String chrName=(rs.getString("chrName")==null || rs.getString("chrName").equals(""))?" ":rs.getString("chrName");
				String chrExpression=(rs.getString("chrExpression")==null || rs.getString("chrExpression").equals(""))?" ":rs.getString("chrExpression");
				String chrFRExpression=(rs.getString("chrFRExpression")==null || rs.getString("chrFRExpression").equals(""))?" ":rs.getString("chrFRExpression");
				String chrCNChannels=(rs.getString("chrCNChannels")==null || rs.getString("chrCNChannels").equals(""))?" ":rs.getString("chrCNChannels");
				String chrFRChannels=(rs.getString("chrFRChannels")==null || rs.getString("chrFRChannels").equals(""))?" ":rs.getString("chrFRChannels");
				
				strNodeInfo+=intID+"@"+chrClass+"@"+chrName+"@"
							+chrExpression+"@"
							+chrFRExpression+"@"
							+chrCNChannels+"@"
							+chrFRChannels
							+"#";
			}
//System.out.println(strNodeInfo);
			rs.close();			
		}catch(SQLException ex){
        	System.out.println(ex.toString());
        }
		catch(Exception ex){
        	System.out.println(ex.toString());
        }
        finally{
			try{
				rs.close();
	            PrePareStmt.close();
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				System.out.println(ex.toString());
			}
		}
        if(strNodeInfo.length()>0){
        	strNodeInfo=strNodeInfo.substring(0,strNodeInfo.length()-1);
        	arrNodeItem=strNodeInfo.split("#");
        }
		return arrNodeItem;
	}
	
	public String[] getNodeInfo_OLD(int parentid,int ipc_nav){
		String[] arrNodeItem=null;
		String strNodeInfo="";
		Connection conn = null;
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		
		PreparedStatement PrePareStmtQuery = null;
		ResultSet resultSet = null;
		try {
/*
			conn = DBConnect.getConnection();
			String strSQL="select * from ipr_navtable where intType="+ipc_nav+" and intParentID="
				+ parentid + " order by intID";
//System.out.println(strSQL);
			PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
			
			while(rs.next()) {	
				int intID=rs.getInt("intID");
				String chrClass=(rs.getString("chrClass")==null || rs.getString("chrClass").equals(""))?" ":rs.getString("chrClass");
				String chrName=(rs.getString("chrName")==null || rs.getString("chrName").equals(""))?" ":rs.getString("chrName");
				String chrExpression=(rs.getString("chrExpression")==null || rs.getString("chrExpression").equals(""))?" ":rs.getString("chrExpression");
				String chrFRExpression=(rs.getString("chrFRExpression")==null || rs.getString("chrFRExpression").equals(""))?" ":rs.getString("chrFRExpression");
				String chrCNChannels=(rs.getString("chrCNChannels")==null || rs.getString("chrCNChannels").equals(""))?" ":rs.getString("chrCNChannels");
				String chrFRChannels=(rs.getString("chrFRChannels")==null || rs.getString("chrFRChannels").equals(""))?" ":rs.getString("chrFRChannels");
				
				strNodeInfo+=intID+"@"+chrClass+"@"+chrName+"@"
							+chrExpression+"@"
							+chrFRExpression+"@"
							+chrCNChannels+"@"
							+chrFRChannels
							+"#";
			}
//System.out.println(strNodeInfo);
			rs.close();
*/
			conn = DBConnect.getConnection();			
			String strSQL="";
			
			if(ipc_nav==0){
				strSQL="select * from ipr_navtable where intParentID=" + parentid + " and intType=0";
				
				PrePareStmtQuery = conn.prepareStatement(strSQL);
	            rs = PrePareStmtQuery.executeQuery();
	            
	            if(rs.next()){
	            	rs.beforeFirst();
	    			while(rs.next()) {	
	    				int intID=rs.getInt("intID");
	    				String chrClass=(rs.getString("chrClass")==null || rs.getString("chrClass").equals(""))?" ":rs.getString("chrClass");
	    				String chrName=(rs.getString("chrName")==null || rs.getString("chrName").equals(""))?" ":rs.getString("chrName");
	    				String chrExpression=(rs.getString("chrExpression")==null || rs.getString("chrExpression").equals(""))?" ":rs.getString("chrExpression");
	    				String chrFRExpression=(rs.getString("chrFRExpression")==null || rs.getString("chrFRExpression").equals(""))?" ":rs.getString("chrFRExpression");
	    				String chrCNChannels=(rs.getString("chrCNChannels")==null || rs.getString("chrCNChannels").equals(""))?" ":rs.getString("chrCNChannels");
	    				String chrFRChannels=(rs.getString("chrFRChannels")==null || rs.getString("chrFRChannels").equals(""))?" ":rs.getString("chrFRChannels");
	    				
	    				strNodeInfo+=intID+"@"+chrClass+"@"+chrName+"@"
	    							+chrExpression+"@"
	    							+chrFRExpression+"@"
	    							+chrCNChannels+"@"
	    							+chrFRChannels
	    							+"#";
	    			}
	            }else{
	            	strSQL="select intType,chrClass from ipr_navtable where intID=" + parentid;
	            	PrePareStmtQuery = conn.prepareStatement(strSQL);
	                resultSet = PrePareStmtQuery.executeQuery();
	                
	                if(resultSet.next()){
		            	int intType=resultSet.getInt("intType");
		            	String strClass=resultSet.getString("chrClass");
		            	
		            	if(intType==0 && strClass.length()==4){
		            		strSQL="select * from patent_grade7 where GRADETHREE='" + strClass + "' order by id";            		
		            		//GRADEFOUR
		            		//DESCRIPTION
		            		PrePareStmt = conn.prepareStatement(strSQL);
		                    rs = PrePareStmt.executeQuery();
		                    
		        			while(rs.next()) {	
		        				int intID=rs.getInt("id");
		        				String chrClass=(rs.getString("GRADEFOUR")==null || rs.getString("GRADEFOUR").equals(""))?" ":rs.getString("GRADEFOUR");
		        				String chrName=(rs.getString("DESCRIPTION")==null || rs.getString("DESCRIPTION").equals(""))?" ":(chrClass+rs.getString("DESCRIPTION"));
		        				String chrExpression=chrClass;
		        				String chrFRExpression=chrClass;
		        				String chrCNChannels="";
		        				String chrFRChannels="";
		        				
		        				strNodeInfo+=intID+"@"+chrClass+"@"+chrName+"@"
		        							+chrExpression+"@"
		        							+chrFRExpression+"@"
		        							+chrCNChannels+"@"
		        							+chrFRChannels
		        							+"#";
		        			}
		        			rs.close();
		        			PrePareStmt.close();
		            	}
	                }
	                PrePareStmtQuery.close();
		            resultSet.close();
	            }	            
			}else{
        		strSQL="select * from ipr_navtable where intParentID=" + parentid + " and intType=1 order by intID";
    			
    			PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
    			while(rs.next()) {	
    				int intID=rs.getInt("intID");
    				String chrClass=(rs.getString("chrClass")==null || rs.getString("chrClass").equals(""))?" ":rs.getString("chrClass");
    				String chrName=(rs.getString("chrName")==null || rs.getString("chrName").equals(""))?" ":rs.getString("chrName");
    				String chrExpression=(rs.getString("chrExpression")==null || rs.getString("chrExpression").equals(""))?" ":rs.getString("chrExpression");
    				String chrFRExpression=(rs.getString("chrFRExpression")==null || rs.getString("chrFRExpression").equals(""))?" ":rs.getString("chrFRExpression");
    				String chrCNChannels=(rs.getString("chrCNChannels")==null || rs.getString("chrCNChannels").equals(""))?" ":rs.getString("chrCNChannels");
    				String chrFRChannels=(rs.getString("chrFRChannels")==null || rs.getString("chrFRChannels").equals(""))?" ":rs.getString("chrFRChannels");
    				
    				strNodeInfo+=intID+"@"+chrClass+"@"+chrName+"@"
    							+chrExpression+"@"
    							+chrFRExpression+"@"
    							+chrCNChannels+"@"
    							+chrFRChannels
    							+"#";
    			}
//System.out.println(strNodeInfo);
    			rs.close();
    			PrePareStmt.close();
			}
			
		}catch(SQLException ex){
        	ex.printStackTrace();
        }
		catch(Exception ex){
        	ex.printStackTrace();
        }
        finally{
			try{
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
        if(strNodeInfo.length()>0){
        	strNodeInfo=strNodeInfo.substring(0,strNodeInfo.length()-1);
        	arrNodeItem=strNodeInfo.split("#");
        }
		return arrNodeItem;
	}
	
	private String chrEmail="";
    public String getSubEmailNavIDsByUser(int UserID,String strIPAddr){
    	String strSQL="";
    	//Connection conn = DBConnect.getConnection();
    	Connection conn = DBPoolAccessor.getConnection();
    	PreparedStatement PrePareStmt = null;
    	ResultSet rs = null;

    	String SubEmailNavIDs="";
        try
        {
        	strSQL="select chrSubEmailNavIDs,chrEmail from ipr_user_subemail where intUserID="+UserID+" and chrUserIP='"+strIPAddr+"'";
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
            	SubEmailNavIDs=rs.getString("chrSubEmailNavIDs")==null?"":rs.getString("chrSubEmailNavIDs");
            	chrEmail=rs.getString("chrEmail")==null?"":rs.getString("chrEmail");
				rs.close();
				PrePareStmt.close();              
            }
			//DBConnect.closeConnection(conn);
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
        }catch(Exception ex){
        	//DBConnect.closeConnection(conn);
        	DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
        	ex.printStackTrace();
        }
        return SubEmailNavIDs;
    }
	
	public NavTree(int intID) throws Exception{
		Connection conn = null;
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		try {
			conn = DBConnect.getConnection();
			String strSQL = "select * from ipr_navtable where intID = " + intID;
			PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
			
			if (rs.next()) {
				chrName = (String) rs.getString("chrName");
				chrExpression = (String) rs.getString("chrExpression");
				chrFRExpression = (String) rs.getString("chrFRExpression");
				//scoreOfStudent >= 60 ? '是' : '否')
				chrMemo = (String) rs.getString("chrMemo");
				chrMemo = chrMemo==null ? "" : chrMemo;
			}
			setName(chrName);
			setchrExpression(chrExpression);
			setchrFRExpression(chrFRExpression);
			setchrMemo(chrMemo);

			rs.close();

		}catch(SQLException ex){
        	System.out.println(ex.toString());
        }
        finally{
			try{
				rs.close();
	            PrePareStmt.close();
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				System.out.println(ex.toString());
			}
		}
	}

	public void setName(String name) {
		this.chrName = name;
	}

	public void setchrExpression(String Expression) {
		this.chrExpression = Expression;
	}

	public void setchrFRExpression(String FRExpression) {
		this.chrFRExpression = FRExpression;
	}

	public void setchrMemo(String Memo) {
		this.chrMemo = Memo;
	}
	
	public String getName()
	{
		return this.chrName;
	}
	public String getchrExpression()
	{
		return this.chrExpression;
	}
	public String getchrFRExpression()
	{
		return this.chrFRExpression;
	}
	public String getchrMemo()
	{
		return this.chrMemo;
	}

	public String getChrSelNavIDs() {
		return chrSelNavIDs;
	}

	public String getStrSelNav1() {
		return strSelNav1;
	}

	public String getStrNavNew() {
		return strNavNew;
	}

	public String getChrEmail() {
		return chrEmail;
	}

	public String getStrNavNewCN() {
		return strNavNewCN;
	}

	public String getStrNavNewFR() {
		return strNavNewFR;
	}
}
