package com.trs.usermanage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.cnipr.cniprgz.db.DBPoolAccessor;

public class AdminManage {
    String  chrUserNames[];
    String  chrRealNames[];
    String  dtRegisterTimes[];
    String  dtExpireTimes[];
    int     intUserIDs[];
    int 	child_user[];
    
    int     intCount=0;
    int     intPages=0;			//���������ҳ��
    
	public static void main(String[] args) {
		// TODO Auto-generated method stub
	}
	
	public AdminManage(){}

    //�趨����������û������У��оٸ���������������û���countPerPage��ʾÿҳ��ʾ������pageNumber��ʾ��ǰҳ��
    public void setMulti(String searchMark,String searchWord,int countPerPage,int pageNumber) throws Exception
    {
    	//System.out.println("searchMark="+searchMark);    	
        String  userNames[];
        String  realNames[];
        int     userIDs[];
        int 	child_user[];
    
        int     count=0;
        int     arrayLen=0;
        int     limit=0;
        int     offset=0;
        int     i=0;
        int     pages=0;
        searchMark=Tools.dealSingleQuot(searchMark);
        searchWord=Tools.dealSingleQuot(searchWord);
    	//Connection conn = DBConnect.getConnection();
        Connection conn = DBPoolAccessor.getConnection();
        String strSQL = "";

        if(searchMark.equals("userName"))
        {
       		strSQL="select count(*) from ipr_user where chrUserName like '%"+searchWord+"%'";
        }
        if(searchMark.equals("realName"))
        {
       		strSQL="select count(*) from ipr_user where chrRealName like '%"+searchWord+"%'";
        }
        strSQL+=" and intAdministerState=1";
//System.out.println(strSQL);
        
        PreparedStatement PrePareStmt = null;
        ResultSet rs = null;
        try
        {
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              count=rs.getInt(1);
            }
//            rs.close();
//            PrePareStmt.close();
            offset=countPerPage*(pageNumber-1);
            arrayLen=count-countPerPage*(pageNumber-1);
            if(arrayLen>countPerPage)
            {
              arrayLen=countPerPage;
            }
            limit=countPerPage;
            
            userNames=new String[arrayLen];
            realNames=new String[arrayLen];
            userIDs=new int[arrayLen];
            child_user=new int[arrayLen];
            
            if(searchMark.equals("userName"))
            {
           		strSQL="select intUserID m_intUserID,chrUserName,chrRealName," +
           				"(select count(*) from ipr_user where intAdministerID=m_intUserID) child_user" +
           				" from ipr_user where chrUserName like '%"+searchWord+"%' and intAdministerState=1" +
           				" limit "+offset+","+limit+" ";

                PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                i=0;
                while(rs.next())
                {
                	userIDs[i]=rs.getInt("m_intUserID");
                	userNames[i]=rs.getString("chrUserName");					
	                realNames[i]=rs.getString("chrRealName");
	                child_user[i]=rs.getInt("child_user");
	                i++;			
                }
//                rs.close();
//                PrePareStmt.close();
            }
            if(searchMark.equals("realName"))
            {
           		strSQL="select intUserID m_intUserID,chrUserName,chrRealName," +
           				"(select count(*) from ipr_user where intAdministerID=m_intUserID) child_user from ipr_user where" +
           				" chrRealName like '%"+searchWord+"%' and intAdministerState=1 limit "+offset+","+limit+" ";

                PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                i=0;
                while(rs.next())
                {
                	userIDs[i]=rs.getInt("m_intUserID");
                	child_user[i]=rs.getInt("child_user");
                	userNames[i]=rs.getString("chrUserName");					
	                realNames[i]=rs.getString("chrRealName");
	                i++;		
                }
//                rs.close();
//                PrePareStmt.close();
            }

            //System.out.println(strSQL);
            if(count==0)
            {
              setPages(0);
            }
            else
            {
              pages=(count-1)/countPerPage+1;
              setPages(pages);
            }
            setUserNames(userNames);
            setRealNames(realNames);
            setUserIDs(userIDs);
            setChildUsers(child_user);
            setCount(count);
        }
        catch(SQLException e)
        {
//            DBConnect.closeConnection(conn);
            e.printStackTrace();
        }finally{
			try{
				if (rs != null)
					rs.close();
    			if (PrePareStmt != null)
    				PrePareStmt.close();
				if(conn!=null){
					conn.close();
				}
			}catch(Exception ex){
				System.out.println();			
			}
		}
    }
    
    //countPerPage ÿҳ��ʾ�ļ�¼�� pageNumber ��ǰҳ��
    public AdminManage(int countPerPage,int pageNumber) throws Exception
    {
        String  userNames[];
        String  realNames[];
        int 	child_user[];
        int     userIDs[];
    
        int     count=0;
        int     arrayLen=0;
        int     limit=0;
        int     offset=0;
        int     i=0;
        int     pages=0;
        
    	//Connection conn = DBConnect.getConnection();
    	Connection conn = DBPoolAccessor.getConnection();
    	PreparedStatement PrePareStmt = null;
    	ResultSet rs = null;
    	
    	String strSQL = "select intUserID m_intUserID,chrUserName,chrRealName," +
    			"(select count(*) from ipr_user where intAdministerID=m_intUserID) child_user" +
    			" from ipr_user where intAdministerState=1 order by chrUserName";
        
        try
        {
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            if(rs.last())
            {
              count=rs.getRow();
            }
            rs.close();
            offset=countPerPage*(pageNumber-1);
            arrayLen=count-countPerPage*(pageNumber-1);
            if(arrayLen>countPerPage)
            {
              arrayLen=countPerPage;
            }
            limit=countPerPage;
            userNames=new String[arrayLen];
            realNames=new String[arrayLen];
            userIDs=new int[arrayLen];
            child_user=new int[arrayLen];

           	strSQL = "select intUserID m_intUserID,chrUserName,chrRealName," +
				"(select count(*) from ipr_user where intAdministerID=m_intUserID) child_user" +
				" from ipr_user where intAdministerState=1 order by chrUserName limit "+offset+","+limit;
           	
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            while(rs.next())
            {
               	userIDs[i]=rs.getInt("m_intUserID");
               	userNames[i]=rs.getString("chrUserName");					
	            realNames[i]=rs.getString("chrRealName");
	            child_user[i]=rs.getInt("child_user");
	            i++;			
            }
//            rs.close();
//            
//            PrePareStmt.close();
//            DBConnect.closeConnection(conn);
            if(count==0)
            {
              setPages(0);
            }
            else
            {
              pages=(count-1)/countPerPage+1;
              setPages(pages);
            }
            setUserNames(userNames);
            setRealNames(realNames);
            setUserIDs(userIDs);
            setChildUsers(child_user);
            setCount(count);
        }
        catch(SQLException e)
        {
        	e.printStackTrace();
        }finally{
			try{
				if (rs != null)
					rs.close();
    			if (PrePareStmt != null)
    				PrePareStmt.close();
				if(conn!=null){
					conn.close();
				}
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
    }
  
    public int[] getChildUsers()
    {
      return child_user;	
    }    
    public void setChildUsers(int c_user[])
    {
    	child_user=c_user;
    }
    
    public int[] getUserIDs()
    {
      return intUserIDs;	
    }    
    public void setUserIDs(int userIDs[])
    {
      intUserIDs=userIDs;
    }
    public String[] getUserNames()
    {
      return 	chrUserNames;
    }
    
    public void setUserNames(String[] userNames)
    {
      chrUserNames=userNames;
    }
    
    public String[] getRealNames()
    {
      return 	chrRealNames;
    }
    
    public void setRealNames(String[] realNames)
    {
      chrRealNames=realNames;
    }
    public void setPages(int pages)
    {
      intPages=pages;
    }
    
    public int getPages()
    {
      return intPages;
    }
    public int getCount()
    {
      return intCount;	
    }
    
    public void setCount(int count)
    {
      intCount=count;
    }
}
