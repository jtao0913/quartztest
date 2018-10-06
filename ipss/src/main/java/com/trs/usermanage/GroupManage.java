package com.trs.usermanage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.cnipr.cniprgz.db.DBPoolAccessor;

public class GroupManage
{
    int     intGroupID=0;
    String  chrGroupName=null;
    String  chrChannelID=null;
    String  chrItemGrant=null;
    String  chrGroupMemo=null;
    
    String  chrGroupNames[];
    String  chrGroupMemos[];
    String  chrGroupGrants[];
    int     intItemGrants[];
    int     intGroupIDs[];
    int     intGroupChannelIDs[];
    
    int     intCount=0;
    
    public GroupManage(){}
    
    public static void main(String args[]) throws Exception {
    	new GroupManage(10,2,"");
    }
    
    public GroupManage(int countPerPage,int pageNumber,String searchWord) throws UNIException
    {    	
        String  groupNames[];
        String  groupMemos[];
        int     groupIDs[];
    
        int     count=0;
        int     arrayLen=0;
        int     i=0;
        int     offset=0;
        int     limit=0;
        
    	Connection conn = DBPoolAccessor.getConnection();
    	PreparedStatement PrePareStmt = null;
    	ResultSet rs = null;
    	
    	String strSQL = "";
    	
    	try
        {
            if(searchWord!=null && !searchWord.equals("")){
            	strSQL = "select count(*) from ipr_group where chrGroupName like '%"+searchWord+"%'";
            }else{
            	strSQL = "select count(*) from ipr_group";
            }
            
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              count=rs.getInt(1);
            }
            rs.close();
            
            /******************/
            offset=countPerPage*(pageNumber-1);
            arrayLen=count-countPerPage*(pageNumber-1);
            if(arrayLen>countPerPage)
            {
              arrayLen=countPerPage;
            }
            limit=countPerPage;            
            /******************/

            groupNames=new String[arrayLen];
            groupMemos=new String[arrayLen];
            groupIDs=new int[arrayLen];
                        
            if(searchWord!=null && !searchWord.equals("")){
            	strSQL="select intGroupID,chrGroupName,chrGroupMemo from ipr_group where chrGroupName like '%"+searchWord+"%' limit "+offset+","+limit+" ";
            }else{
            	strSQL="select intGroupID,chrGroupName,chrGroupMemo from ipr_group limit "+offset+","+limit+" ";
            }
            
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            while(rs.next())
            {
            	groupIDs[i]=rs.getInt("intGroupID");
                groupNames[i]=rs.getString("chrGroupName");
                groupMemos[i]=rs.getString("chrGroupMemo");
                i++;
            }
            rs.close();
            
            PrePareStmt.close();
//            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
            
            setGroupNames(groupNames);
            setGroupMemos(groupMemos);
            setGroupIDs(groupIDs);
            setCount(count);
        }
        catch(SQLException e)
        {
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
            throw new UNIException(200, "�û������ִ�� SQL ������", e);
        }
    }
    
    public GroupManage(int groupID) throws UNIException
    {
    	String groupName=null;
    	String groupMemo=null;
    	String channelID=null;
    	String itemGrant=null;
    	String strChannelIDs[];
    	String strItemGrants[];
    	int    channelIDs[];
    	int    itemGrants[];
    	String groupGrants[];
    	Connection conn = DBPoolAccessor.getConnection();
    	//���Ȼ�ȡ�û���Ļ�����
        String strSQL = "select chrGroupName,chrChannelID,chrItemGrant,chrGroupMemo from ipr_group where intGroupID="+groupID;
        try
        {
            PreparedStatement PrePareStmt = conn.prepareStatement(strSQL);
            ResultSet rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              groupName=rs.getString("chrGroupName");
              groupMemo=rs.getString("chrGroupMemo");
              channelID=rs.getString("chrChannelID");
              itemGrant=rs.getString("chrItemGrant");
            }
            rs.close();
            //���û����Ƶ����Ȩ�޴��ֶ��зֿ�������
            strChannelIDs=Tools.splitString(channelID,",");
            strItemGrants=Tools.splitString(itemGrant,",");
            itemGrants=new int[strItemGrants.length];
            groupGrants=new String[strItemGrants.length];
            channelIDs=new int[strChannelIDs.length];
            for(int j=0;j<strItemGrants.length;j++)
            {
              itemGrants[j]=Integer.parseInt(strItemGrants[j]);
            }
            Grant grant=new Grant();
            for(int j=0;j<strItemGrants.length;j++)
            {
              grant.setSingle(itemGrants[j]);
              groupGrants[j]=grant.getGrantName();
            }
            
            for(int j=0;j<strChannelIDs.length;j++)
            {
              channelIDs[j]=Integer.parseInt(strChannelIDs[j]);
            }
            
            PrePareStmt.close();
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
            
            setGroupName(groupName);
            setGroupMemo(groupMemo);
            setGroupGrants(groupGrants);
            setGroupChannelIDs(channelIDs);
            setItemGrants(itemGrants);
        }
        catch(Exception e)
        {
        	DBPoolAccessor.closeAll(null, null, conn);
        }
    }
    
    public void setMulti() throws Exception
    {
        String  groupNames[];
        String  groupMemos[];
        int     groupIDs[];
    
        int     count=0;
        int     arrayLen=0;
        int     i=0;
    	Connection conn = DBPoolAccessor.getConnection();
        String strSQL = "select count(*) from ipr_group";
        try
        {
            PreparedStatement PrePareStmt = conn.prepareStatement(strSQL);
            ResultSet rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              count=rs.getInt(1);
            }
            rs.close();
            arrayLen=count;
            groupNames=new String[arrayLen];
            groupMemos=new String[arrayLen];
            groupIDs=new int[arrayLen];
            strSQL="select intGroupID,chrGroupName,chrGroupMemo from ipr_group ";
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            while(rs.next())
                {
                	groupIDs[i]=rs.getInt("intGroupID");
                	groupNames[i]=rs.getString("chrGroupName");					
	                groupMemos[i]=rs.getString("chrGroupMemo");	
	                i++;			
                }
            rs.close();
            
            PrePareStmt.close();
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
            
            setGroupNames(groupNames);
            setGroupMemos(groupMemos);
            setGroupIDs(groupIDs);
            setCount(count);
        }
        catch(SQLException e)
        {
        	DBPoolAccessor.closeAll(null, null, conn);
            throw new UNIException(200, "�û������ִ�� SQL ������", e);
        }
    }

    public int getGroupID()
    {
      return 	intGroupID;
    }
    
    public void setGroupID(int groupID)
    {
      intGroupID=groupID;
    }
    
    public String getGroupName()
    {
      return chrGroupName;
    }
    
    public void setGroupName(String groupName)
    {
      chrGroupName=groupName;
    }
   
    public String getChannelID()
    {
      return 	chrChannelID;
    }
    
    public void setChannelID(String channelID)
    {
      chrChannelID=channelID;
    }
    
    public String getItemGrant()
    {
      return 	chrItemGrant;
    }
    
    public void setItemGrant(String itemGrant)
    {
      chrItemGrant=itemGrant;
    }
    
    public String getGroupMemo()
    {
      return 	chrGroupMemo;
    }
    
    public void setGroupMemo(String groupMemo)
    {
      chrGroupMemo=groupMemo;
    }
    
    public String[] getGroupNames()
    {
      return 	chrGroupNames;
    }
    
    public void setGroupNames(String[] groupNames)
    {
      chrGroupNames=groupNames;
    }
    
    public String[] getGroupMemos()
    {
      return 	chrGroupMemos;
    }
    
    public void setGroupMemos(String[] groupMemos)
    {
      chrGroupMemos=groupMemos;
    }
    
    public int[] getGroupIDs()
    {
      return intGroupIDs;	
    }
    
    public void setGroupIDs(int groupIDs[])
    {
      intGroupIDs=groupIDs;
    }
    
    public int getCount()
    {
      return intCount;	
    }
    
    public void setCount(int count)
    {
      intCount=count;
    }

    public String[] getGroupGrants()
    {
      return chrGroupGrants;
    }
    
    public void setGroupGrants(String[] groupGrants)
    {
      chrGroupGrants=groupGrants;
    }
    
    public int[] getGroupChannelIDs()
    {
      return intGroupChannelIDs;
    }
    
    public void setGroupChannelIDs(int[] channelIDs)
    {
      intGroupChannelIDs=channelIDs;
    }
    
    public int[] getItemGrants()
    {
      return intItemGrants;
    }
    
    public void setItemGrants(int[] itemGrants)
    {
      intItemGrants=itemGrants;
    }
    
    public int updateGroup(int intGroupID,String groupName,String groupMemo,String itemGrant,String[] itemGrants) throws Exception
    {
    	String groupChannelID="";
    	Connection conn = DBPoolAccessor.getConnection();
        String strSQL = "select chrGroupName from ipr_group where chrGroupName='"+groupName+"' and intGroupID!="+intGroupID;
        try
        {
            PreparedStatement PrePareStmt = conn.prepareStatement(strSQL);
            ResultSet rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              rs.close();
              PrePareStmt.close();
              DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
              return -2;
            }
            rs.close();
            if(itemGrants!=null)
            {
              strSQL="select distinct intChannelID from ipr_grant where intGrantID="+itemGrants[0];
              for(int i=1;i<itemGrants.length;i++)
              {
                strSQL=strSQL+" or intGrantID="+itemGrants[i];
              }
              PrePareStmt = conn.prepareStatement(strSQL);
              rs = PrePareStmt.executeQuery();
              while(rs.next())
              {
              	groupChannelID=groupChannelID+rs.getString("intChannelID")+",";
              }
              rs.close();
              groupChannelID=groupChannelID.substring(0,groupChannelID.length()-1);
            }
            strSQL="update ipr_group set chrGroupName='"+groupName+"',chrGroupMemo='"+groupMemo+"',chrChannelID='"+groupChannelID+"',chrItemGrant='"+itemGrant+"' where intGroupID="+intGroupID;
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            PrePareStmt.close();
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
            return 1;
        }
        catch(Exception e)
        {
        	DBPoolAccessor.closeAll(null, null, conn);
            return -1;
        }
    }
    
    public int addGroup(String groupName,String groupMemo,String itemGrant,String[] itemGrants) throws Exception
    {
        String groupChannelID="";
    	Connection conn = DBPoolAccessor.getConnection();
        String strSQL = "select chrGroupName from ipr_group where chrGroupName='"+groupName+"' ";
        try
        {
            PreparedStatement PrePareStmt = conn.prepareStatement(strSQL);
            ResultSet rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              rs.close();
              PrePareStmt.close();
              DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
              return -2;
            }
            rs.close();
            if(itemGrants!=null)
            {
              strSQL="select distinct intChannelID from ipr_grant where intGrantID="+itemGrants[0];
              for(int i=1;i<itemGrants.length;i++)
              {
                strSQL=strSQL+" or intGrantID="+itemGrants[i];
              }
              PrePareStmt = conn.prepareStatement(strSQL);
              rs = PrePareStmt.executeQuery();
              while(rs.next())
              {
              	groupChannelID=groupChannelID+rs.getString("intChannelID")+",";
              }
              rs.close();
              groupChannelID=groupChannelID.substring(0,groupChannelID.length()-1);
            }
            strSQL="insert into ipr_group(chrGroupName,chrChannelID,chrItemGrant,chrGroupMemo) values('"+groupName+"','"+groupChannelID+"','"+itemGrant+"','"+groupMemo+"')";
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            PrePareStmt.close();
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
            return 1;
        }
        catch(Exception e)
        {
        	DBPoolAccessor.closeAll(null, null, conn);
            return -1;
        }
    }
    
    public void deleteGroup(int intGroupID) throws Exception
    {
        Connection conn = DBPoolAccessor.getConnection();
        String strSQL = "delete from ipr_group where intGroupID="+intGroupID;
        try
        {
            PreparedStatement PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            PrePareStmt.close();
            DBPoolAccessor.closeAll(null, PrePareStmt, conn);
        }
        catch(Exception e)
        {
            DBPoolAccessor.closeAll(null, null, conn);
        }
    }

}
