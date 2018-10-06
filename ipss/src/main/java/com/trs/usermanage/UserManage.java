package com.trs.usermanage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;

import Acme.Crypto.ShaHash;

import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.ChannelInfo;
import com.trs.was.WASException;
public class UserManage
{
	int     intUserID=0;		//用户ID
    String  chrUserName=null;		//用户名
    String  chrUserPass=null;		//用户密码
    String  chrRealName=null;		//真实姓名
    String  chrEmail=null;		//电子邮件
    String  chrPhone=null;		//联系电话
    String  chrMobile=null;		//手机
    String  chrAddress=null;		//用户地址
    String  chrDepartment=null;		//工作单位
    String  chrFax=null;		//用户传真
    String  dtRegisterTime=null;	//注册时间
    String  dtCurrentCardTime=null;	//当前卡过期时间
    String  dtExpireTime=null;		//总的过期时间
    int     intMaxLogin=0;		//最大登录数
    int     intCHCount=0;		//国内专利下载数
    int     intFRCount=0;		//国外专利下载数
    String  dtLastVisitTime=null;	//最后一次登录时间
    String  chrLastVisitIP=null;	//最后一次登录IP
    int     intUserState=0;		//用户状态，0为未开通，1为开通
    int     intGroupID=0;		//用户所属组
    String  chrAdminMemo=null;		//管理员修改备注
    long    intBeginIP=0;		//集团用户组起始ip
    long    intEndIP=0;			//集团用户组终止ip
    String  chrDefaultIP=null;		//集团用户默认IP
    
    String chrMerchantID=null;	//集团用户看cnipr上说明书原文所使用的ID
    String chrMAC=null;			//集团用户webserver的mac地址
    String chrIPAdress=null;	//集团用户的用户的IP地址
    
    String chrHerbal_Name=null;
    int intHerbal_DataBase=0;
    
    int intIPLimit=0;
    
    int intAdministerState;
    String chrEnterpriseName;
    int intMaxSearchCount;
    int intMaxNavCount;
    int intMaxUserCount;
    
    int intAnalyseState;
    int intAnalyseNumUpperlimit;
    
    String chrItemGrant;
    
    int intUserAreaID=0;
    int intAdminAreaID=0;
    
    int intAdministerID=0;	//此用户属于某个管理员
    
    int intNumberPerPage = 10;	//定义用户每页显示的记录数
    int intABSTBatchCount = 0;	//分析系统文摘批量下载数量
    int intDownloadedCount = 0;	//今年已经下载过的数量
    
////用于显示多行查询结果
    String  numbers[];
    String  chrUserNames[];
    String  chrRealNames[];
    String  dtRegisterTimes[];
    String  dtExpireTimes[];
    int     intUserIDs[];
    
    int     intCount=0;
    int     intPages=0;			//检索结果集总页数
    
    
    public static int getAdminID(String strUserName) throws Exception
    {
//    	管理后台navi_bar.jsp取到UserName,想得到AdminRights，
    	String strSQL = "select intAdministerID from ipr_user where chrUserName='"+strUserName+"'";
    	Connection conn = DBPoolAccessor.getConnection();
    	int intAdministerID=0;
    	
    	PreparedStatement preparedstatement = null;
        ResultSet resultset = null;
    	try
        {    		
            preparedstatement = conn.prepareStatement(strSQL);
            resultset = preparedstatement.executeQuery();

            if(resultset.next())
            {
            	intAdministerID = resultset.getInt("intAdministerID");
            }
            
            
            DBPoolAccessor.closeAll(resultset, preparedstatement, conn);
        }
    	catch(SQLException sqlexception0)
        {
    		DBPoolAccessor.closeAll(resultset, preparedstatement, conn);
//            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);DBPoolAccessor.closeAll(resultset, preparedstatement, conn);
        }finally{
			try{
				resultset.close();
	            preparedstatement.close();
	            
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				ex.printStackTrace();
				System.out.println();			
			}
		}
    	return intAdministerID;
    }
    
    public UserManage(){}
    
    public UserManage(int countPerPage,int pageNumber){
    	String userNames[];
    	String numbers[];
    	
    	int limit=0;
    	int offset=0;
    	int arrayLen=0;
    	int count=0;
    	int i=0;
    	int pages=0;
    	
    	Connection conn = DBPoolAccessor.getConnection();
    	PreparedStatement PrePareStmt = null;
    	ResultSet rs = null;
    	String countSql="select count(1) from ipr_user_stat";
		try {
			PrePareStmt = conn.prepareStatement(countSql);
			rs = PrePareStmt.executeQuery();
			if(rs.next()){
			  count=rs.getInt(1);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	offset=countPerPage*(pageNumber-1);
        arrayLen=count-countPerPage*(pageNumber-1);
        if(arrayLen>countPerPage){
          arrayLen=countPerPage;
        }
    	limit=countPerPage;
    	
    	userNames=new String[arrayLen];
    	numbers=new String[arrayLen];
    	
    	String sql="select username,numbers from ipr_user_stat order by userid  limit "+offset+","+limit+" ";
    	
    	try {
			PrePareStmt = conn.prepareStatement(sql);
			rs = PrePareStmt.executeQuery();
			while(rs.next()){
				userNames[i]=rs.getString("username");
				numbers[i]=rs.getString("numbers");
				i++;
			}
			
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
            
            if(count==0){
              setPages(0);
            }
            else{
              pages=(count-1)/countPerPage+1;
              setPages(pages);
            }
            
            setUserNames(userNames);
			setNumbers(numbers);
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    
    //countPerPage 每页显示的记录数 pageNumber 当前页码
    public UserManage(int countPerPage,int pageNumber,int adminState) throws WASException
    {
        String  userNames[];
        String  realNames[];
        String  registerTimes[];
        String  expireTimes[];
        int     userIDs[];
        int		administerID[];

        int     count=0;
        int     arrayLen=0;
        int     limit=0;
        int     offset=0;
        int     i=0;
        int     pages=0;
        
    	Connection conn = DBPoolAccessor.getConnection();
    	PreparedStatement PrePareStmt = null;
    	ResultSet rs = null;
    	
    	String strSQL = "";
    	if(adminState==1){
    		strSQL = "select count(*) from ipr_user where (intAdministerState is not null and intAdministerState=1)";
    	}else{
    		strSQL = "select count(*) from ipr_user where (intAdministerState is null or intAdministerState=0)";
    	}
        
        try
        {
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              count=rs.getInt(1);
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
            registerTimes=new String[arrayLen];
            expireTimes=new String[arrayLen];
            userIDs=new int[arrayLen];
            administerID=new int[arrayLen];
            
            if(adminState==1){
            	strSQL="select intUserID, chrUserName,chrRealName,dtRegisterTime,dtExpireTime,intAdministerID from ipr_user where (intAdministerState is not null and intAdministerState=1) order by intUserID limit "+offset+","+limit+" ";
            }
            else{
            	strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime,intAdministerID from ipr_user where (intAdministerState is null or intAdministerState=0) order by intUserID limit "+offset+","+limit+" ";
            }
//            System.out.println("出错的11：："+strSQL);
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            while(rs.next()){
               	userIDs[i]=rs.getInt("intUserID");
               	userNames[i]=rs.getString("chrUserName");					
	            realNames[i]=rs.getString("chrRealName");	
	            registerTimes[i]=rs.getString("dtRegisterTime").split(" ")[0];
	            expireTimes[i]=rs.getString("dtExpireTime").split(" ")[0];
	            administerID[i]=rs.getInt("intAdministerID");
	            i++;			
            }
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
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
            setRegisterTimes(registerTimes);
            setExpireTimes(expireTimes);
            setUserIDs(userIDs);
            setCount(count);
        }
        catch(Exception ex)
        {       	
        	ex.printStackTrace();
        	throw new WASException(ex.getMessage());
        }finally{
			try{
				rs.close();
				PrePareStmt.close();
	            
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){}
		}
    }
    
    
    //用于检索某一个用户ID下该用户的全部信息
    public UserManage(int intUserID) throws WASException
    {
    	String userName=null;
    	String userPass=null;
    	String realName=null;
    	String eMail=null;
    	String phone=null;
    	String mobile=null;
    	String fax=null;
    	String department=null;
    	String address=null;
    	String registerTime=null;
    	String currentCardTime=null;
    	String expireTime=null;
    	int    maxLogin=0;
    	int    chCount=0;
    	int    frCount=0;
    	String lastVisitTime=null;
    	String lastVisitIP=null;
    	int    userState=0;
    	int    groupID=0;
    	String adminMemo=null;
    	long   beginIP=0;
    	long   endIP=0;
    	String ipRange=null;
    	String defaultIP=null;
    	
    	String MerchantID=null;
    	String MAC=null;
    	String IPAdress=null;
    	int AdministerID=0;
    	
    	String Herbal_Name=null;
        int Herbal_DataBase=0;    	
    	
        int intIPLimit = 0;
        
    	int	   intNumberPerPage = 10;	//用户每页显示的记录数，默认为10
        int		intABSTBatchCount = 0;	//分析系统文摘批量下载数量
        int 	intDownloadedCount = 0;	//今年已经下载过的数量
        
        int intAdministerState = 0;
        int intAnalyseNumUpperlimit = 0;
        
        String chrEnterpriseName=null;
        int intMaxSearchCount=0;
        int intMaxNavCount=0;
        int intMaxUserCount=0;
        
        int intAnalyseState=0;
        
        String ItemGrant=null;
        int intUserAreaID=0;
        int intAdminAreaID=0;
//System.out.println("userManager.java------->构造函数 intUserID="+intUserID);
    	
        Connection conn = DBPoolAccessor.getConnection();
    	PreparedStatement PrePareStmt = null;
    	ResultSet rs = null;
    	
        String strSQL = "select * from ipr_user where intUserID="+intUserID;
        String strExtSql = "select * from ipr_user_extinfo where intUserID="+intUserID;
        try
        {
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              userName=rs.getString("chrUserName");
//System.out.println("userManager.java------->构造函数 userName="+userName);
    	      userPass=rs.getString("chrUserPass");
    	      realName=rs.getString("chrRealName");
    	      eMail=rs.getString("chrEmail");
    	      phone=rs.getString("chrPhone");
    	      mobile=rs.getString("chrMobile");
    	      fax=rs.getString("chrFax");
    	      department=rs.getString("chrDepartment");
    	      address=rs.getString("chrAddress");
    	      registerTime=rs.getString("dtRegisterTime");
//    	      currentCardTime=rs.getString("dtCurrentCardTime");
    	      expireTime=rs.getString("dtExpireTime");
    	      maxLogin=rs.getInt("intMaxLogin");
    	      chCount=rs.getInt("intCHCount");
    	      frCount=rs.getInt("intFRCount");
    	      lastVisitTime=rs.getString("dtLastVisitTime");
    	      lastVisitIP=rs.getString("chrLastVisitIP");
    	      userState=rs.getInt("intUserState");
    	      groupID=rs.getInt("intGroupID");
    	      adminMemo=rs.getString("chrAdminMemo");
    	      intABSTBatchCount = rs.getInt("intMaximum");
    	      intDownloadedCount = rs.getInt("intDownloadedNumber");

    	      //((input%2 == 1) ? 'Y': 'N')); 
    	      MerchantID=(rs.getString("chrMerchantID")==null)? "":rs.getString("chrMerchantID");
    	      MAC=(rs.getString("chrMAC")==null)? "":rs.getString("chrMAC");
    	      IPAdress=(rs.getString("chrIPAdress")==null)? "":rs.getString("chrIPAdress");
    	      //如果此用户所属的intAdministerID没有内容，就算作admin的用户
    	      AdministerID=rs.getInt("intAdministerID");
    	      
    	      Herbal_Name=(rs.getString("chrHerbal_Name")==null?"":rs.getString("chrHerbal_Name"));
    	      Herbal_DataBase=rs.getInt("intHerbal_DataBase");
    	      
    	      intIPLimit=rs.getInt("intIPLimit");
//    	      System.out.println("Herbal_Name="+Herbal_Name);
//    	      System.out.println("Herbal_DataBase="+Herbal_DataBase);
//    	      System.out.println("rs.getInt('intHerbal_DataBase')="+rs.getInt("intHerbal_DataBase"));

    	      intAdministerState=rs.getInt("intAdministerState");
    	      intAnalyseNumUpperlimit=rs.getInt("intAnalyseNumUpperlimit");
    	      if(intAnalyseNumUpperlimit==0) {
    	    	  intAnalyseNumUpperlimit=50000;
    	      }
    	      
    	      chrEnterpriseName=rs.getString("chrEnterpriseName")==null?"":rs.getString("chrEnterpriseName");
    	      intMaxSearchCount=rs.getInt("intMaxSearchCount");
    	      intMaxNavCount=rs.getInt("intMaxNavCount");
    	      intMaxUserCount=rs.getInt("intMaxUserCount");

    	      intAnalyseState=rs.getInt("intAnalyseState");
    	      ItemGrant=rs.getString("chrItemGrant");
//    	      System.out.println("***********"+ItemGrant);
    	      intUserAreaID=rs.getInt("intUserAreaID");
    	      intAdminAreaID=rs.getInt("intAdminAreaID");
            }
            rs.close();
            PrePareStmt = conn.prepareStatement(strExtSql);
            rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              intNumberPerPage = rs.getInt("intNumberPerPage");
            }
            else
            {
            	//如果没有找到记录，在表中加入一条新记录
            	PrePareStmt = conn.prepareStatement("Insert into ipr_user_extinfo (intUserID) values ("+intUserID+")");
            	PrePareStmt.executeUpdate();

	            PrePareStmt = conn.prepareStatement(strExtSql);
	            rs = PrePareStmt.executeQuery();
 
	            if(rs.next())
	            {
	              intNumberPerPage = rs.getInt("intNumberPerPage");
	            }
            }
            rs.close();

            strSQL="select intBeginIP,intEndIP from ipr_ipaddress where chrUserName='"+userName+"'";
//            strSQL="select intBeginIP,intEndIP from ipr_ipaddress where intUserID="+intUserID;
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            while(rs.next())
            {
                try
                {
                	beginIP=rs.getLong("intBeginIP");
                	endIP=rs.getLong("intEndIP");
                	if(beginIP==endIP)
                	{
                	  if(ipRange==null)
                	  {
                	    ipRange=Tools.long2ip(beginIP);
                	  }
                	  else
                	  {
                	    ipRange=ipRange+";"+Tools.long2ip(beginIP);
                	  }
                	}
                	else
                	{
                	  if(ipRange==null)
                	  {
                	    ipRange=Tools.long2ip(beginIP)+"-"+Tools.long2ip(endIP);
                	  }
                	  else
                	  {
                	    ipRange=ipRange+";"+Tools.long2ip(beginIP)+"-"+Tools.long2ip(endIP);
                	  }
                	}
	            }
	            catch(Exception e)
	            {
	            	System.out.println("UserManage ————> exception ： "+e.toString());
	            }			
            }
            defaultIP=ipRange;
            
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
            
            setUserName(userName);
            setRealName(realName);
            setEmail(eMail);
            setPhone(phone);
            setMobile(mobile);
            setDepartment(department);
            setAddress(address);
            setFax(fax);
            setCurrentCardTime(currentCardTime);
            setRegisterTime(registerTime);
            setExpireTime(expireTime);
            setMaxLogin(maxLogin);
            setCHCount(chCount);
            setFRCount(frCount);
            setLastVisitTime(lastVisitTime);
            setLastVisitIP(lastVisitIP);
            setUserState(userState);
            setGroupID(groupID);
            setAdminMemo(adminMemo);
            setUserID(intUserID);
            setDefaultIP(defaultIP);
            setNumberPerPage(intNumberPerPage);
            setABSTBatchCount(intABSTBatchCount);
            setDownloadedCount(intDownloadedCount);
            
            setMerchantID(MerchantID);
            setMAC(MAC);
            setIPAdress(IPAdress);
            setAdministerID(AdministerID);
            
            setHerbal_Name(Herbal_Name);
            setHerbal_DataBase(Herbal_DataBase);            
            
            setIPLimit(intIPLimit);
            
            setAdministerState(intAdministerState);
            setEnterpriseName(chrEnterpriseName);            
            setMaxSearchCount(intMaxSearchCount);
            setMaxNavCount(intMaxNavCount);
            setMaxUserCount(intMaxUserCount);
            
            setAnalyseState(intAnalyseState);            
            setAnalyseNumUpperlimit(intAnalyseNumUpperlimit);
            
            setItemGrant(ItemGrant);
            
            setUserAreaID(intUserAreaID);
            setAdminAreaID(intAdminAreaID);
        }
        catch(Exception ex)
        {
        	throw new WASException(ex.getMessage());
        }finally{
			try{
				rs.close();
				PrePareStmt.close();
	            
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){}
		}
    }
    
    //设定检索结果集，在用户管理中，列举根据条件检索到的用户，countPerPage表示每页显示的行数，pageNumber表示当前页码
    public void setMulti1111111111(String searchMark,String searchWord,int countPerPage,int pageNumber,int adminID) throws WASException
    {
    	//System.out.println("searchMark="+searchMark);    	
        String  userNames[];
        String  realNames[];
        String  registerTimes[];
        String  expireTimes[];
        int     userIDs[];
    
        int     count=0;
        int     arrayLen=0;
        int     limit=0;
        int     offset=0;
        int     i=0;
        int     pages=0;
        searchMark=Tools.dealSingleQuot(searchMark);
        searchWord=Tools.dealSingleQuot(searchWord);
    	Connection conn = DBPoolAccessor.getConnection();
        String strSQL = "";
        if(searchMark.equals("cardNumber"))
        {
        	if(adminID==1){
        		strSQL="select count(*) from ipr_card,ipr_user where chrCardNo='"+searchWord+"'";
        	}else{
        		strSQL="select count(*) from ipr_card,ipr_user where chrCardNo='"+searchWord+"' and ipr_user.intUserID=ipr_card.intUserID and ipr_user.intAdministerID="+adminID;
        	}
        }
        if(searchMark.equals("userName"))
        {
        	if(adminID==1){
        		strSQL="select count(*) from ipr_user where chrUserName like '%"+searchWord+"%'";
        	}else{
        		strSQL="select count(*) from ipr_user where chrUserName like '%"+searchWord+"%' and intAdministerID="+adminID;
        	}
        }
        if(searchMark.equals("realName"))
        {
        	if(adminID==1){
        		strSQL="select count(*) from ipr_user where chrRealName like '%"+searchWord+"%'";
        	}else{
        		strSQL="select count(*) from ipr_user where chrRealName like '%"+searchWord+"%' and intAdministerID="+adminID;
        	}
        }
        if(searchMark.equals("approaching"))
        {
        	java.util.Date today = new java.util.Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = formatter.format(today);
            //String strYear = time.substring(0,4);
            //String strRegisterTime=time; 
        	if(adminID==1){
        		strSQL="select count(*) from ipr_user where (To_Days(dtExpireTime)-To_Days('"+time+"'))<7 and (To_Days(dtExpireTime)-To_Days('"+time+"'))>0";
        	}else{
        		strSQL="select count(*) from ipr_user where (To_Days(dtExpireTime)-To_Days('"+time+"'))<7 and (To_Days(dtExpireTime)-To_Days('"+time+"'))>0 and intAdministerID="+adminID;
        	}        	
        }
        if(searchMark.equals("expired"))
        {
        	java.util.Date today = new java.util.Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = formatter.format(today);
        	if(adminID==1){
        		strSQL="select count(*) from ipr_user where (To_Days(dtExpireTime)-To_Days('"+time+"'))<0";
        	}else{
        		strSQL="select count(*) from ipr_user where (To_Days(dtExpireTime)-To_Days('"+time+"'))<0 and intAdministerID="+adminID;
        	}
        }
        strSQL+=" and (intAdministerState is null or intAdministerState=0)";
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
            rs.close();
            PrePareStmt.close();
            offset=countPerPage*(pageNumber-1);
            arrayLen=count-countPerPage*(pageNumber-1);
            if(arrayLen>countPerPage)
            {
              arrayLen=countPerPage;
            }
            limit=countPerPage;
            
            userNames=new String[arrayLen];
            realNames=new String[arrayLen];
            registerTimes=new String[arrayLen];
            expireTimes=new String[arrayLen];
            userIDs=new int[arrayLen];
            
            if(searchMark.equals("cardNumber"))
            {
            	if(adminID==1){
            		strSQL="select ipr_user.intUserID,ipr_user.chrUserName,ipr_user.chrRealName,ipr_user.dtRegisterTime,ipr_user.dtExpireTime from ipr_card,ipr_user where ipr_user.intUserID=ipr_card.intUserID and ipr_card.chrCardNo='"+searchWord+"'";
            	}else{
            		strSQL="select ipr_user.intUserID,ipr_user.chrUserName,ipr_user.chrRealName,ipr_user.dtRegisterTime,ipr_user.dtExpireTime from ipr_card,ipr_user where ipr_user.intUserID=ipr_card.intUserID and ipr_card.chrCardNo='"+searchWord+"' and ipr_user.intAdministerID="+adminID;
            	}
            	strSQL+=" and (intAdministerState is null or intAdministerState=0)";
            	PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                i=0;
                while(rs.next())
                {
                	userIDs[i]=rs.getInt("ipr_user.intUserID");
                	userNames[i]=rs.getString("ipr_user.chrUserName");					
	                realNames[i]=rs.getString("ipr_user.chrRealName");	
	                registerTimes[i]=rs.getString("ipr_user.dtRegisterTime").split(" ")[0];
	                expireTimes[i]=rs.getString("ipr_user.dtExpireTime").split(" ")[0];
	                i++;			
                }
                rs.close();
                PrePareStmt.close();
            }
            if(searchMark.equals("userName"))
            {
            	if(adminID==1){
            		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where chrUserName like '%"+searchWord+"%' and (intAdministerState is null or intAdministerState=0) limit "+offset+","+limit+" ";
            	}else{
            		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where chrUserName like '%"+searchWord+"%' and (intAdministerState is null or intAdministerState=0) and ipr_user.intAdministerID="+adminID+" limit "+offset+","+limit+" ";
            	}
                PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                i=0;
                while(rs.next())
                {
                	userIDs[i]=rs.getInt("intUserID");
                	userNames[i]=rs.getString("chrUserName");					
	                realNames[i]=rs.getString("chrRealName");	
	                registerTimes[i]=rs.getString("dtRegisterTime").split(" ")[0];
	                expireTimes[i]=rs.getString("dtExpireTime").split(" ")[0];
	                i++;			
                }
                rs.close();
                PrePareStmt.close();
            }
            if(searchMark.equals("realName"))
            {
            	if(adminID==1){
            		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where chrRealName like '%"+searchWord+"%' and (intAdministerState is null or intAdministerState=0) limit "+offset+","+limit+" ";
            	}else{
            		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where chrRealName like '%"+searchWord+"%' and (intAdministerState is null or intAdministerState=0) and ipr_user.intAdministerID="+adminID+" limit "+offset+","+limit+" ";
            	}
                PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                i=0;
                while(rs.next())
                {
                	userIDs[i]=rs.getInt("intUserID");
                	userNames[i]=rs.getString("chrUserName");					
	                realNames[i]=rs.getString("chrRealName");	
	                registerTimes[i]=rs.getString("dtRegisterTime").split(" ")[0];
	                expireTimes[i]=rs.getString("dtExpireTime").split(" ")[0];
	                i++;		
                }
                rs.close();
                PrePareStmt.close();
            }
            if(searchMark.equals("approaching"))
            {
            	java.util.Date today = new java.util.Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String time = formatter.format(today);
                //String strYear = time.substring(0,4);
                //String strRegisterTime=time; 
            	if(adminID==1){
            		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where (To_Days(dtExpireTime)-To_Days('"+time+"'))<7 and (To_Days(dtExpireTime)-To_Days('"+time+"'))>0 and (intAdministerState is null or intAdministerState=0) limit "+offset+","+limit;
            	}else{
            		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where (To_Days(dtExpireTime)-To_Days('"+time+"'))<7 and (To_Days(dtExpireTime)-To_Days('"+time+"'))>0 and (intAdministerState is null or intAdministerState=0) and intAdministerID="+adminID+" limit "+offset+","+limit;
            	}
            	PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                i=0;
                while(rs.next())
                {
                	userIDs[i]=rs.getInt("intUserID");
                	userNames[i]=rs.getString("chrUserName");					
	                realNames[i]=rs.getString("chrRealName");	
	                registerTimes[i]=rs.getString("dtRegisterTime").split(" ")[0];
	                expireTimes[i]=rs.getString("dtExpireTime").split(" ")[0];
	                i++;		
                }
                rs.close();
                PrePareStmt.close();
            }
            if(searchMark.equals("expired"))
            {
            	java.util.Date today = new java.util.Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String time = formatter.format(today);
            	if(adminID==1){
            		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where (To_Days(dtExpireTime)-To_Days('"+time+"'))<0 and (intAdministerState is null or intAdministerState=0) limit "+offset+","+limit;
            	}else{
            		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where (To_Days(dtExpireTime)-To_Days('"+time+"'))<0 and (intAdministerState is null or intAdministerState=0) and intAdministerID="+adminID+" limit "+offset+","+limit;
            	}
//System.out.println(strSQL);
                PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                i=0;                
//System.out.println("userIDs.length="+userIDs.length);                
                while(rs.next())
                {
//System.out.println(rs.getInt("intUserID"));
                	userIDs[i]=rs.getInt("intUserID");
                	userNames[i]=rs.getString("chrUserName");
	                realNames[i]=rs.getString("chrRealName");
	                registerTimes[i]=rs.getString("dtRegisterTime").split(" ")[0];
	                expireTimes[i]=rs.getString("dtExpireTime").split(" ")[0];
	                i++;		
                }
                rs.close();
                PrePareStmt.close();
            }
            //System.out.println(strSQL);
            
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
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
            setRegisterTimes(registerTimes);
            setExpireTimes(expireTimes);
            setUserIDs(userIDs);
            setCount(count);
        }
        catch(Exception ex)
        {
        	throw new WASException(ex.getMessage());
        }finally{
			try{
				rs.close();
				PrePareStmt.close();
	            
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){}
		}
    }
    
    //设定检索结果集，在用户管理中，列举根据条件检索到的用户，countPerPage表示每页显示的行数，pageNumber表示当前页码
    public void setMulti(String searchMark,String searchWord,int countPerPage,int pageNumber,int adminState) throws WASException
    {
    	//System.out.println("searchMark="+searchMark);    	
        String  userNames[];
        String  realNames[];
        String  registerTimes[];
        String  expireTimes[];
        int     userIDs[];
    
        int     count=0;
        int     arrayLen=0;
        int     limit=0;
        int     offset=0;
        int     i=0;
        int     pages=0;
        searchMark=Tools.dealSingleQuot(searchMark);
        searchWord=Tools.dealSingleQuot(searchWord);
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
        if(searchMark.equals("approaching"))
        {
        	java.util.Date today = new java.util.Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = formatter.format(today);
            //String strYear = time.substring(0,4);
            //String strRegisterTime=time;
        	strSQL="select count(*) from ipr_user where (To_Days(dtExpireTime)-To_Days('"+time+"'))<7 and (To_Days(dtExpireTime)-To_Days('"+time+"'))>0";
        }
        if(searchMark.equals("expired"))
        {
        	java.util.Date today = new java.util.Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = formatter.format(today);
       		strSQL="select count(*) from ipr_user where (To_Days(dtExpireTime)-To_Days('"+time+"'))<0";
        }
        if(adminState==0) {
        	strSQL+=" and (intAdministerState is null or intAdministerState=0)";
        }
        
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
            rs.close();
            PrePareStmt.close();
            offset=countPerPage*(pageNumber-1);
            arrayLen=count-countPerPage*(pageNumber-1);
            if(arrayLen>countPerPage)
            {
              arrayLen=countPerPage;
            }
            limit=countPerPage;
            
            userNames=new String[arrayLen];
            realNames=new String[arrayLen];
            registerTimes=new String[arrayLen];
            expireTimes=new String[arrayLen];
            userIDs=new int[arrayLen];

            if(searchMark.equals("userName"))
            {
           		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where chrUserName like '%"+searchWord+"%' and (intAdministerState is null or intAdministerState=0) limit "+offset+","+limit+" ";

                PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                i=0;
                while(rs.next())
                {
                	userIDs[i]=rs.getInt("intUserID");
                	userNames[i]=rs.getString("chrUserName");					
	                realNames[i]=rs.getString("chrRealName");	
	                registerTimes[i]=rs.getString("dtRegisterTime").split(" ")[0];
	                expireTimes[i]=rs.getString("dtExpireTime").split(" ")[0];
	                i++;			
                }
                rs.close();
                PrePareStmt.close();
            }
            if(searchMark.equals("realName"))
            {
           		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where chrRealName like '%"+searchWord+"%' and (intAdministerState is null or intAdministerState=0) limit "+offset+","+limit+" ";

                PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                i=0;
                while(rs.next())
                {
                	userIDs[i]=rs.getInt("intUserID");
                	userNames[i]=rs.getString("chrUserName");					
	                realNames[i]=rs.getString("chrRealName");	
	                registerTimes[i]=rs.getString("dtRegisterTime").split(" ")[0];
	                expireTimes[i]=rs.getString("dtExpireTime").split(" ")[0];
	                i++;		
                }
                rs.close();
                PrePareStmt.close();
            }
            if(searchMark.equals("approaching"))
            {
            	java.util.Date today = new java.util.Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String time = formatter.format(today);
                //String strYear = time.substring(0,4);
                //String strRegisterTime=time; 
           		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where (To_Days(dtExpireTime)-To_Days('"+time+"'))<7 and (To_Days(dtExpireTime)-To_Days('"+time+"'))>0 and (intAdministerState is null or intAdministerState=0) limit "+offset+","+limit;

            	PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                i=0;
                while(rs.next())
                {
                	userIDs[i]=rs.getInt("intUserID");
                	userNames[i]=rs.getString("chrUserName");					
	                realNames[i]=rs.getString("chrRealName");	
	                registerTimes[i]=rs.getString("dtRegisterTime").split(" ")[0];
	                expireTimes[i]=rs.getString("dtExpireTime").split(" ")[0];
	                i++;		
                }
                rs.close();
                PrePareStmt.close();
            }
            if(searchMark.equals("expired"))
            {
            	java.util.Date today = new java.util.Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String time = formatter.format(today);

           		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where (To_Days(dtExpireTime)-To_Days('"+time+"'))<0 and (intAdministerState is null or intAdministerState=0) limit "+offset+","+limit;

//System.out.println(strSQL);
                PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                i=0;                
//System.out.println("userIDs.length="+userIDs.length);                
                while(rs.next())
                {
//System.out.println(rs.getInt("intUserID"));
                	userIDs[i]=rs.getInt("intUserID");
                	userNames[i]=rs.getString("chrUserName");
	                realNames[i]=rs.getString("chrRealName");
	                registerTimes[i]=rs.getString("dtRegisterTime").split(" ")[0];
	                expireTimes[i]=rs.getString("dtExpireTime").split(" ")[0];
	                i++;		
                }
                rs.close();
                PrePareStmt.close();
            }
            //System.out.println(strSQL);
            
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
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
            setRegisterTimes(registerTimes);
            setExpireTimes(expireTimes);
            setUserIDs(userIDs);
            setCount(count);
        }
        catch(Exception ex)
        {
        	throw new WASException(ex.getMessage());
        }finally{
			try{
				rs.close();
				PrePareStmt.close();
	            
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){}
		}
    }

    
    
    
    //设定检索结果集，列举某一组的用户，countPerPage表示每页显示的行数，pageNumber表示当前页码
    public void setMulti(int groupID,int countPerPage,int pageNumber,int adminID) throws WASException
    {
        String  userNames[];
        String  realNames[];
        String  registerTimes[];
        String  expireTimes[];
        int     userIDs[];
    
        int     count=0;
        int     arrayLen=0;
        int     limit=0;
        int     offset=0;
        int     i=0;
        int     pages=0;
    	Connection conn = DBPoolAccessor.getConnection();
    	String strSQL=null;
    	if(adminID==1){
    		strSQL = "select count(*) from ipr_user where intGroupID="+groupID;
    	}else{    	
    		strSQL = "select count(*) from ipr_user where intGroupID="+groupID+" and intAdministerID="+adminID;
    	}
    	
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
            registerTimes=new String[arrayLen];
            expireTimes=new String[arrayLen];
            userIDs=new int[arrayLen];
            if(adminID==1){
            	strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where intGroupID="+groupID+" limit "+offset+","+limit+" ";
            }else{
            	strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where intGroupID="+groupID+" and intAdministerID="+adminID+" limit "+offset+","+limit+" ";
            }
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            i=0;
            while(rs.next())
            {
               	userIDs[i]=rs.getInt("intUserID");
               	userNames[i]=rs.getString("chrUserName");
		        realNames[i]=rs.getString("chrRealName");
		        registerTimes[i]=rs.getString("dtRegisterTime");
		        expireTimes[i]=rs.getString("dtExpireTime");
		        i++;
            }
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
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
            setRegisterTimes(registerTimes);
            setExpireTimes(expireTimes);
            setUserIDs(userIDs);
            setCount(count);
        }
        catch(Exception ex)
        {
        	throw new WASException(ex.getMessage());
        }finally{
			try{
				rs.close();
				PrePareStmt.close();
	            
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				System.out.println();			
			}
		}
    }
    
    //设定检索结果集，在用户组管理中，列举根据条件检索到的某一组中的用户，countPerPage表示每页显示的行数，pageNumber表示当前页码
    public void setMulti(int intGroupID,int countPerPage,int pageNumber,String searchMark,String searchWord,int adminID) throws WASException
    {
        String  userNames[];
        String  realNames[];
        String  registerTimes[];
        String  expireTimes[];
        int     userIDs[];
    
        int     count=0;
        int     arrayLen=0;
        int     limit=0;
        int     offset=0;
        int     i=0;
        int     pages=0;
        searchMark=Tools.dealSingleQuot(searchMark);
        searchWord=Tools.dealSingleQuot(searchWord);
    	Connection conn = DBPoolAccessor.getConnection();
        String strSQL = "";
        if(searchMark.equals("userName"))
        {
        	if(adminID==1){
        		strSQL="select count(*) from ipr_user where chrUserName like '%"+searchWord+"%' and intGroupID="+intGroupID;
        	}else{        	
        		strSQL="select count(*) from ipr_user where chrUserName like '%"+searchWord+"%' and intGroupID="+intGroupID+" and intAdministerID="+adminID;
        	}
        }
        if(searchMark.equals("realName"))
        {
        	if(adminID==1){
        		strSQL="select count(*) from ipr_user where chrRealName like '%"+searchWord+"%' and intGroupID="+intGroupID;
        	}else{
        		strSQL="select count(*) from ipr_user where chrRealName like '%"+searchWord+"%' and intGroupID="+intGroupID+" and intAdministerID="+adminID;
        	}	
        }
        
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
            registerTimes=new String[arrayLen];
            expireTimes=new String[arrayLen];
            userIDs=new int[arrayLen];
            if(searchMark.equals("userName"))
            {
            	if(adminID==1){
            		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where chrUserName like '%"+searchWord+"%' and intGroupID="+intGroupID+" limit "+offset+","+limit+" ";
            	}else{
            		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where chrUserName like '%"+searchWord+"%' and intGroupID="+intGroupID+" and intAdministerID="+adminID+" limit "+offset+","+limit+" ";
            	}
                PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                i=0;
                while(rs.next())
                {
                	userIDs[i]=rs.getInt("intUserID");
                	userNames[i]=rs.getString("chrUserName");					
	                realNames[i]=rs.getString("chrRealName");	
	                registerTimes[i]=rs.getString("dtRegisterTime");
	                expireTimes[i]=rs.getString("dtExpireTime");
	                i++;			
                }
                rs.close();
            }
            if(searchMark.equals("realName"))
            {
            	if(adminID==1){
            		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where chrRealName like '%"+searchWord+"%' intGroupID="+intGroupID+" limit "+offset+","+limit+" ";
            	}else{
            		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where chrRealName like '%"+searchWord+"%' intGroupID="+intGroupID+" and intAdministerID="+adminID+" limit "+offset+","+limit+" ";	
            	}
                
                PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                i=0;
                while(rs.next())
                {
                	userIDs[i]=rs.getInt("intUserID");
                	userNames[i]=rs.getString("chrUserName");					
	                realNames[i]=rs.getString("chrRealName");	
	                registerTimes[i]=rs.getString("dtRegisterTime");
	                expireTimes[i]=rs.getString("dtExpireTime");
	                i++;		
                }
                rs.close();
            }            
            
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
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
            setRegisterTimes(registerTimes);
            setExpireTimes(expireTimes);
            setUserIDs(userIDs);
            setCount(count);
        }
        catch(Exception ex)
        {
        	throw new WASException(ex.getMessage());
        }finally{
			try{
				rs.close();
				PrePareStmt.close();
	            
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){}
		}
    }
    
    //设定检索结果集，在用户组管理中，列举根据条件检索到的某一组中的用户，countPerPage表示每页显示的行数，pageNumber表示当前页码
    public void setGroupUserMulti(int intGroupID,int countPerPage,int pageNumber,int adminID) throws WASException
    {
        String  userNames[];
        String  realNames[];
        String  registerTimes[];
        String  expireTimes[];
        int     userIDs[];
    
        int     count=0;
        int     arrayLen=0;
        int     limit=0;
        int     offset=0;
        int     i=0;
        int     pages=0;
    	Connection conn = DBPoolAccessor.getConnection();;
        String strSQL = "";
        if(adminID==1){
        	strSQL = "select count(*) from ipr_user where intGroupID!="+intGroupID;
        }else
        {
        	strSQL = "select count(*) from ipr_user where intGroupID!="+intGroupID+" and intAdministerID="+adminID;
        }
        
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
            registerTimes=new String[arrayLen];
            expireTimes=new String[arrayLen];
            userIDs=new int[arrayLen];
            if(adminID==1){
            	strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where  intGroupID!="+intGroupID+" limit "+offset+","+limit+" ";
            }else{
            	strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where  intGroupID!="+intGroupID+" and intAdministerID="+adminID+" limit "+offset+","+limit+" ";	
            }
            
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            i=0;
            while(rs.next())
            {
               	userIDs[i]=rs.getInt("intUserID");
               	userNames[i]=rs.getString("chrUserName");					
		        realNames[i]=rs.getString("chrRealName");	
		        registerTimes[i]=rs.getString("dtRegisterTime");
		        expireTimes[i]=rs.getString("dtExpireTime");
		        i++;			
            }
            rs.close();
            
            PrePareStmt.close();
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
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
            setRegisterTimes(registerTimes);
            setExpireTimes(expireTimes);
            setUserIDs(userIDs);
            setCount(count);
        }
        catch(Exception ex)
        {
        	throw new WASException(ex.getMessage());
        }finally{
			try{
				rs.close();
				PrePareStmt.close();
	            
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){}
		}
    }
    
    //用户组管理中，在添加用户中检索某一个用户
    public void setGroupUserMulti(int intGroupID,int countPerPage,int pageNumber,String searchMark,String searchWord,int adminID) throws WASException
    {
        String  userNames[];
        String  realNames[];
        String  registerTimes[];
        String  expireTimes[];
        int     userIDs[];
    
        int     count=0;
        int     arrayLen=0;
        int     limit=0;
        int     offset=0;
        int     i=0;
        int     pages=0;
        searchMark=Tools.dealSingleQuot(searchMark);
        searchWord=Tools.dealSingleQuot(searchWord);
    	Connection conn = DBPoolAccessor.getConnection();;
        String strSQL = "";
        if(searchMark.equals("userName"))
        {
        	if(adminID==1){
        		strSQL="select count(*) from ipr_user where chrUserName like '%"+searchWord+"%' and intGroupID!="+intGroupID;	
        	}else{
        		strSQL="select count(*) from ipr_user where chrUserName like '%"+searchWord+"%' and intGroupID!="+intGroupID+" and intAdministerID="+adminID;
        	}            
        }
        if(searchMark.equals("realName"))
        {
        	if(adminID==1){
        		strSQL="select count(*) from ipr_user where chrRealName like '%"+searchWord+"%' and intGroupID!="+intGroupID;	
        	}else{
        		strSQL="select count(*) from ipr_user where chrRealName like '%"+searchWord+"%' and intGroupID!="+intGroupID+" and intAdministerID="+adminID;
        	}            
        }
        
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
            registerTimes=new String[arrayLen];
            expireTimes=new String[arrayLen];
            userIDs=new int[arrayLen];
            if(searchMark.equals("userName"))
            {
            	if(adminID==1){
            		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where chrUserName like '%"+searchWord+"%' and intGroupID!="+intGroupID+" limit "+offset+","+limit+" ";	
            	}else{
            		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where chrUserName like '%"+searchWord+"%' and intGroupID!="+intGroupID+" and intAdministerID="+adminID+" limit "+offset+","+limit+" ";
            	}            	
                
                PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                i=0;
                while(rs.next())
                {
                	userIDs[i]=rs.getInt("intUserID");
                	userNames[i]=rs.getString("chrUserName");					
	                realNames[i]=rs.getString("chrRealName");	
	                registerTimes[i]=rs.getString("dtRegisterTime");
	                expireTimes[i]=rs.getString("dtExpireTime");
	                i++;			
                }
                rs.close();
            }
            if(searchMark.equals("realName"))
            {
            	if(adminID==1){
            		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where chrRealName like '%"+searchWord+"%' and intGroupID!="+intGroupID+" limit "+offset+","+limit+" ";	
            	}else{
            		strSQL="select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where chrRealName like '%"+searchWord+"%' and intGroupID!="+intGroupID+" and intAdministerID="+adminID+" limit "+offset+","+limit+" ";
            	}
                
                PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                i=0;
                while(rs.next())
                {
                	userIDs[i]=rs.getInt("intUserID");
                	userNames[i]=rs.getString("chrUserName");					
	                realNames[i]=rs.getString("chrRealName");	
	                registerTimes[i]=rs.getString("dtRegisterTime");
	                expireTimes[i]=rs.getString("dtExpireTime");
	                i++;		
                }
                rs.close();
            }            
            
            PrePareStmt.close();
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
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
            setRegisterTimes(registerTimes);
            setExpireTimes(expireTimes);
            setUserIDs(userIDs);
            setCount(count);
        }
        catch(Exception ex)
        {
        	throw new WASException(ex.getMessage());
        }finally{
			try{
				rs.close();
				PrePareStmt.close();
	            
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){}
		}
    }
    
    /************ 现在只用这个addUser ************/
    //向数据库添加一个新的用户，该用户没有指定IP，非集团用户
    public int addUser(ServletContext application , 
    		String strUserName,String strPassword,String strRealName,String strPhone,String strMobile,String strFax,String strEmail,String strAddress,
    		String strDepartment,String strMaxLogin,String strAdminMemo,int intCount_in,int intCount_out,String strExpireTime,int intGroupID,
    		int intNumberPerPage, int intABSTBatchCount, String strMerchantID,String strMAC,String strIPAdress,int adminID,String strHerbal_Name,String strHerbal_Database,
    		int intIPLimit, 
    		String chrMenu,int intAdministerState,String chrEnterpriseName,int intMaxSearchCount,int intMaxNavCount,int intMaxUserCount,
    		String[] arrTradeList,
    		int intAnalyseState,int intAnalyseNumUpperlimit,
    		int intUserAreaID,int intAdminAreaID) throws WASException
    {    	
//    	System.out.println("新的。。。。");
    	String chrChannelID="";//14,16,15,17,18,19,20,21,22,23,24,25
    	
    	List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>)application.getAttribute("channelInfoList_cn");
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>)application.getAttribute("channelInfoList_fr");
    	
		Iterator<ChannelInfo> iter = channelInfoList_cn.iterator();
		while(iter.hasNext())
		{
			ChannelInfo ci = iter.next();
			if(!chrChannelID.equals("")){
				chrChannelID += ",";
			}
			chrChannelID += ci.getIntChannelID();
		}
		iter = channelInfoList_fr.iterator();
		while(iter.hasNext())
		{
			ChannelInfo ci = iter.next();
			if(!chrChannelID.equals("")){
				chrChannelID += ",";
			}
			chrChannelID += ci.getIntChannelID();
		}
    	
    	
//    	if(DataAccess.get("chrChannelID")!=null){
//    		chrChannelID=DataAccess.get("chrChannelID");
//    	}
    	String chrItemGrant="simplesearchleft;openphysicaldb;gaojifenxi;detailxiangsisearch;dingqiyujing;gongsidaima;quanwensearch;autoIndex;agencyhelpsearch;frchannel;openphysicaldbadmin;evaluation;daimahuaview;viewwggb;openbatchdownload;yuyisearch;senioroperator;batchsearch;agencysearch;effectlib;shixiaosearch;fenxi;ipchelpsearch;crossLanguage;huoyuezhishuyujing;daimahuadownload;detailsearchreport;lawwarn;translate;";;
    	
    	if(DataAccess.get("chrItemGrant")!=null){
    		chrItemGrant=DataAccess.get("chrItemGrant");
    	}
    	
//    	System.out.println("向数据库添加一个新的用户，该用户没有指定IP，非集团用户");
    	String strSQL="";
    	Connection conn = DBPoolAccessor.getConnection();;
    	PreparedStatement PrePareStmt = null;
    	ResultSet rs = null;
    	
    	int intMaxLogin=1;
        String strRegisterTime=null;
        strUserName=Tools.dealSingleQuot(strUserName);
        strRealName=Tools.dealSingleQuot(strRealName);
        strPhone=Tools.dealSingleQuot(strPhone);
        strMobile=Tools.dealSingleQuot(strMobile);
        strFax=Tools.dealSingleQuot(strFax);
        strEmail=Tools.dealSingleQuot(strEmail);
        strAddress=Tools.dealSingleQuot(strAddress);
        strDepartment=Tools.dealSingleQuot(strDepartment);
        strAdminMemo=Tools.dealSingleQuot(strAdminMemo);
        
        strHerbal_Name=Tools.dealSingleQuot(strHerbal_Name);
        chrEnterpriseName=Tools.dealSingleQuot(chrEnterpriseName);
        chrMenu=Tools.dealSingleQuot(chrMenu);
        int intHerbal_Database=0;
//        MerchantID=(rs.getString("chrMerchantID")==null)? "":rs.getString("chrMerchantID");
        strMerchantID=strMerchantID==null?"":strMerchantID;
        strMerchantID=Tools.dealSingleQuot(strMerchantID);
        strMAC=Tools.dealSingleQuot(strMAC);        
        strIPAdress=Tools.dealSingleQuot(strIPAdress);
        /*
        String searchgroupChannelID="";
        try{
            if(itemGrants!=null)
            {
            	strSQL="select distinct intChannelID from ipr_grant where intGrantID="+itemGrants[0];
				for(int i=1;i<itemGrants.length;i++)
				{
					strSQL=strSQL+" or intGrantID="+itemGrants[i];
				}
				//System.out.println(strSQL);
				
              PrePareStmt = conn.prepareStatement(strSQL);
              rs = PrePareStmt.executeQuery();
              while(rs.next())
              {
              	searchgroupChannelID=searchgroupChannelID+rs.getString("intChannelID")+",";
              }
              rs.close();
              searchgroupChannelID=searchgroupChannelID.substring(0,searchgroupChannelID.length()-1);
            }
        }catch(Exception ex){
        	ex.printStackTrace();
        }
        */        
        
        ShaHash m_shahash = new ShaHash();
        m_shahash.addASCII(strPassword);
        byte bPassword[] = m_shahash.get();
        strPassword = CryptoUtils.toStringBlock(bPassword);
        if(strMaxLogin!=null)
        {
          intMaxLogin=Integer.parseInt(strMaxLogin);
        }

        //获得日期
		java.util.Date today = new java.util.Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = formatter.format(today);
        String strYear = time.substring(0,4);
        strRegisterTime=time;        
        strSQL = "select chrUserName from ipr_user where chrUserName='"+strUserName+"'";

//strSQL1是验证MerchantID是否唯一的，这里不附加adminID也唯一的限制，分属不同的admin，username可以相同，但merchant不能相同
        String strSQL1 = "select chrMerchantID from ipr_user where chrMerchantID='"+strMerchantID+"'";     
        
        try
        {
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();

            if(rs.next())
            {
              rs.close();
              PrePareStmt.close();
              DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
              return -2;
            }
            
            strSQL = "select chrUserName from ipr_user where intUserAreaID="+intUserAreaID+" and intUserAreaID!=0";
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              rs.close();
              PrePareStmt.close();
              DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
              return -4;
            }
            /*
            strSQL="insert into ipr_user(chrUserName,chrUserPass,chrRealName,chrPhone,chrMobile,chrFax,chrEmail,chrAddress,chrDepartment,intMaxLogin,chrAdminMemo,intCHCount,intFRCount,dtExpireTime,dtCurrentCardTime,dtRegisterTime,intUserState,chrOnlineList,intMaximum,chrYear,chrMerchantID,chrMAC,chrIPAdress,intAdministerID,chrHerbal_Name,intHerbal_DataBase," +
            		"chrMenu,intAdministerState,chrEnterpriseName,intMaxSearchCount,intMaxNavCount,intMaxUserCount,intAnalyseState,chrChannelID,chrItemGrant,intUserAreaID,intAdminAreaID) " +
            		"values('"+strUserName+"','"+strPassword+"','"+strRealName+"','"+strPhone+"','"+strMobile+"','"+strFax+"','"+strEmail+"','"+strAddress+"','"+strDepartment+"',"+intMaxLogin+",'"+strAdminMemo+"',"+intCount_in+","+intCount_out+",'"+strExpireTime+"','"+strExpireTime+"','"+strRegisterTime+"',1,'',"+intABSTBatchCount+",'"+strYear+"','"+strMerchantID+"','"+strMAC+"','"+strIPAdress+"',"+adminID+",'"+strHerbal_Name+"',"+intHerbal_Database
            		+",'"+chrMenu+"',"+intAdministerState+",'"+chrEnterpriseName+"',"+intMaxSearchCount+","+intMaxNavCount+","+intMaxUserCount+","+intAnalyseState+",'"+searchgroupChannelID+"','"+itemGrant+"',"+intUserAreaID+","+intAdminAreaID+")";
            */
            strSQL="insert into ipr_user(chrUserName,chrUserPass," +
            		"chrRealName,chrPhone,chrMobile,chrFax,chrEmail,chrAddress,chrDepartment," +
            		"intMaxLogin,chrAdminMemo,intCHCount,intFRCount,dtExpireTime,intGroupID," +
            		"dtCurrentCardTime,dtRegisterTime,intUserState,chrOnlineList,intMaximum," +
            		"chrYear,chrMerchantID,chrMAC,chrIPAdress,intAdministerID,chrHerbal_Name,intHerbal_DataBase," +
            		"intIPLimit," +
		    		"chrMenu,intAdministerState,chrEnterpriseName," +
		    		"intMaxSearchCount,intMaxNavCount,intMaxUserCount,intAnalyseState,intAnalyseNumUpperlimit,intUserAreaID,intAdminAreaID,chrChannelID,chrItemGrant) " +
		    		"values('"+strUserName+"','"+strPassword+"','"+
		    		strRealName+"','"+strPhone+"','"+strMobile+"','"+strFax+"','"+strEmail+"','"+strAddress+"','"+strDepartment+"',"+
		    		intMaxLogin+",'"+strAdminMemo+"',"+intCount_in+","+intCount_out+",'"+strExpireTime+"',"+intGroupID+",'"+
		    		strExpireTime+"','"+strRegisterTime+"',1,'',"+intABSTBatchCount+",'"+
		    		strYear+"','"+strMerchantID+"','"+strMAC+"','"+strIPAdress+"',"+adminID+",'"+strHerbal_Name+"',"+intHerbal_Database+","+
		    		intIPLimit+",'"+
		    		chrMenu+"',"+intAdministerState+",'"+chrEnterpriseName+"',"+
		    		intMaxSearchCount+","+intMaxNavCount+","+intMaxUserCount+","+intAnalyseState+","+intAnalyseNumUpperlimit+","+intUserAreaID+","+intAdminAreaID+",'"+chrChannelID+"','"+chrItemGrant+"')";

//System.out.println(strSQL);
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            PrePareStmt.close();
            
            strSQL="select intUserID from ipr_user where chrUserName='"+strUserName+"'";
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            while(rs.next())
            {
            	intUserID=rs.getInt("intUserID");
            }
            rs.close();
            PrePareStmt.close();

			//更新ipr_user_extinfo表中的信息
            strSQL="insert into ipr_user_extinfo (intUserID,intNumberPerPage) values("+intUserID+","+String.valueOf(intNumberPerPage)+")";
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            PrePareStmt.close();
            
            //arrTradeList
       if(arrTradeList!=null){
    	   /*
            for(int i=0;i<arrTradeList.length;i++){
            	int NavID=Integer.parseInt(arrTradeList[i]);
            	
            	String chrCNChannels="";
            	String chrFRChannels="";
            	
            	strSQL="select chrCNChannels,chrFRChannels from ipr_navtable where intID="+NavID;
//System.out.println(strSQL);
            	PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                while(rs.next())
                {
                	chrCNChannels=rs.getString("chrCNChannels").trim();
                	chrFRChannels=rs.getString("chrFRChannels").trim();
                }
                rs.close();
                PrePareStmt.close();
                
                String strChannel=chrCNChannels;
                if(!strChannel.equals("")){
                	if(!chrFRChannels.equals("")){
                		strChannel+=","+chrFRChannels;
                	}                	
                }else{
                	strChannel=chrFRChannels;
                }
                
                String[] arrCNChannel=strChannel.split(",");
                for(int j=0;j<arrCNChannel.length;j++){
                	String dtUpdateTime="";
                	
                	strSQL="select dtUpdateTime from ipr_channel where intChannelID="+arrCNChannel[j];
//System.out.println(strSQL);
                	PrePareStmt = conn.prepareStatement(strSQL);
                    rs = PrePareStmt.executeQuery();
                    while(rs.next())
                    {
                    	dtUpdateTime=rs.getString("dtUpdateTime");
                    }
                    rs.close();
                    PrePareStmt.close();
                    
                    
					strSQL="insert into ipr_user_nav(intUserID,intNavID,dtUpdateTime,intTRSTable) " +
					       "values("+intUserID+","+NavID+",'"+dtUpdateTime+"',"+arrCNChannel[j]+")";
//System.out.println(strSQL);
					PrePareStmt = conn.prepareStatement(strSQL);
					PrePareStmt.executeUpdate();
					PrePareStmt.close();
                }
            }*/
    	   PreparedStatement PrePareStmtTrade=null;
    	   String strSQLTrade="";
			java.text.SimpleDateFormat sformat = new java.text.SimpleDateFormat("yyyy-MM-dd");
			String dtUpdateDate = sformat.format(new java.util.Date());
/*
        	  NavTree navTree=new NavTree();
        	  navTree.getAllNavIDs(arrTradeList);
        	  String strSelNavIDs = navTree.getChrSelNavIDs();
        	  String[] arrSelNavID=strSelNavIDs.split(",");
        	  for(int i=0;i<arrSelNavID.length;i++){
				strSQLTrade="insert into ipr_user_nav(intUserID,intNavID,dtUpdateDate) " +
					"values("+intUserID+","+arrSelNavID[i]+",'"+dtUpdateDate+"')";
				//System.out.println(strSQLTrade);
				PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
				PrePareStmtTrade.executeUpdate();
				PrePareStmtTrade.close();
        	  }
*/
        	  
        	  NavTree navTree=new NavTree();
        	  navTree.getAllNavIDs(arrTradeList);
        	  //String strSelNavIDs = navTree.getChrSelNavIDs();
        	  //String[] arrSelNavID=strSelNavIDs.split(",");
        	  for(int i=0;i<arrTradeList.length;i++){
				strSQLTrade="insert into ipr_user_nav(intUserID,intNavID,dtUpdateDate) " +
					"values("+intUserID+","+arrTradeList[i]+",'"+dtUpdateDate+"')";
				//System.out.println(strSQLTrade);
				PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
				PrePareStmtTrade.executeUpdate();
				PrePareStmtTrade.close();
        	  }
       }
       /*************************** END ******************************/
       PrePareStmt.close();
       DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
       return 1;
	}
    catch(SQLException ex)
    {
    	ex.printStackTrace();
    	return -1;
    }
	catch(Exception ex)
	{
	    return -1;
	}finally{
		try{
			rs.close();
			PrePareStmt.close();
            
			if(conn!=null){
				conn.close();
				conn=null;
			}
		}catch(Exception ex){}
	}
    }
    
    /**************** 原来的默认登录IP（strDefaultIP）被用户区域ID（intUserAreaID）代替了，此函数现在不用 *****************/
    //向数据库添加一个新的用户，该用户与IP绑定，是一个集团用户
    public int addUser_(String strUserName,String strPassword,String strRealName,String strPhone,String strMobile,String strFax,String strEmail,String strAddress,
    		String strDepartment,String strMaxLogin,String strAdminMemo,int intCount_in,int intCount_out,String strExpireTime,int intGroupID,
    		String strDefaultIP,int intNumberPerPage,int intABSTBatchCount, String strMerchantID,String strMAC,String strIPAdress,int adminID,String strHerbal_Name,String strHerbal_Database,
    		String chrMenu,int intAdministerState,String chrEnterpriseName,int intMaxSearchCount,int intMaxNavCount,int intMaxUserCount,String[] arrTradeList,int intAnalyseState,
    		//String itemGrant,String[] itemGrants,
    		int intUserAreaID,int intAdminAreaID) throws WASException
    {
    	//System.out.println("向数据库添加一个新的用户，该用户指定IP，是集团用户");
    	String strSQL="";
    	Connection conn = DBPoolAccessor.getConnection();;
    	PreparedStatement PrePareStmt = null;
    	ResultSet rs = null;
    	
    	int intMaxLogin=1;
        long beginIP=0;
        long endIP=0;
        int  userID=0;
        String strRegisterTime=null;
        if(strMaxLogin!=null)
        {
          intMaxLogin=Integer.parseInt(strMaxLogin);
        }
        strUserName=Tools.dealSingleQuot(strUserName);
        strRealName=Tools.dealSingleQuot(strRealName);
        strPhone=Tools.dealSingleQuot(strPhone);
        strMobile=Tools.dealSingleQuot(strMobile);
        strFax=Tools.dealSingleQuot(strFax);
        strEmail=Tools.dealSingleQuot(strEmail);
        strAddress=Tools.dealSingleQuot(strAddress);
        strDepartment=Tools.dealSingleQuot(strDepartment);
        strAdminMemo=Tools.dealSingleQuot(strAdminMemo);
        strMerchantID=Tools.dealSingleQuot(strMerchantID);
        strMAC=Tools.dealSingleQuot(strMAC);
        strIPAdress=Tools.dealSingleQuot(strIPAdress);
        
        /*
        String searchgroupChannelID="";
        try{
            if(itemGrants!=null)
            {
            	strSQL="select distinct intChannelID from ipr_grant where intGrantID="+itemGrants[0];
              for(int i=1;i<itemGrants.length;i++)
              {
            	  strSQL=strSQL+" or intGrantID="+itemGrants[i];
              }
              //System.out.println("@@"+strSQL);
              PrePareStmt = conn.prepareStatement(strSQL);
              rs = PrePareStmt.executeQuery();
              while(rs.next())
              {
              	searchgroupChannelID=searchgroupChannelID+rs.getString("intChannelID")+",";
              }
              rs.close();
              searchgroupChannelID=searchgroupChannelID.substring(0,searchgroupChannelID.length()-1);
            }
        }catch(Exception ex){
        	ex.printStackTrace();
        }
        */
        strHerbal_Name=Tools.dealSingleQuot(strHerbal_Name);
        int intHerbal_Database=0;
        
        chrEnterpriseName=Tools.dealSingleQuot(chrEnterpriseName);
        chrMenu=Tools.dealSingleQuot(chrMenu);
        
        //strDefaultIP=Tools.dealSingleQuot(strDefaultIP);
        ShaHash m_shahash = new ShaHash();
        m_shahash.addASCII(strPassword);
        byte bPassword[] = m_shahash.get();
        strPassword = CryptoUtils.toStringBlock(bPassword);
        //获得日期
        java.util.Date today = new java.util.Date();
    	
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //formatter = new SimpleDateFormat("yyyy-mm-dd");
        String time = formatter.format(today);
        String strYear = time.substring(0,4);
        strRegisterTime=time;

        
        strSQL= "select chrUserName from ipr_user where chrUserName='"+strUserName+"'";
        String strSQL1 = "select chrMerchantID from ipr_user where chrMerchantID='"+strMerchantID+"'";
        try
        {
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              rs.close();
              PrePareStmt.close();
              DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
              return -2;
            }

            strSQL = "select chrUserName from ipr_user where intUserAreaID="+intUserAreaID+" and intUserAreaID!=0";
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              rs.close();
              PrePareStmt.close();
              DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
              return -4;
            }
/*
            strSQL="insert into ipr_user(chrUserName,chrUserPass,chrRealName,chrPhone,chrMobile,chrFax,chrEmail,chrAddress,chrDepartment,intMaxLogin,chrAdminMemo,intCHCount,intFRCount,dtExpireTime,intGroupID,dtCurrentCardTime,dtRegisterTime,intUserState,chrOnlineList,intMaximum,chrYear,chrMerchantID,chrMAC,chrIPAdress,intAdministerID,chrHerbal_Name,intHerbal_DataBase," +
            		"chrMenu,intAdministerState,chrEnterpriseName,intMaxSearchCount,intMaxNavCount,intMaxUserCount,intAnalyseState,chrChannelID,chrItemGrant,intUserAreaID,intAdminAreaID) " +
            		" values('"+strUserName+"','"+strPassword+"','"+strRealName+"','"+strPhone+"','"+strMobile+"','"+strFax+"','"+strEmail+"','"+strAddress+"','"+strDepartment+"',"+intMaxLogin+",'"+strAdminMemo+"',"+intCount_in+","+intCount_out+",'"+strExpireTime+"',"+intGroupID+",'"+strExpireTime+"','"+strRegisterTime+"',1,'',"+intABSTBatchCount+",'"+strYear+"','"+strMerchantID+"','"+strMAC+"','"+strIPAdress+"',"+adminID+",'"+strHerbal_Name+"',"+intHerbal_Database
            		+",'"+chrMenu+"',"+intAdministerState+",'"+chrEnterpriseName+"',"+intMaxSearchCount+","+intMaxNavCount+","+intMaxUserCount+","+intAnalyseState+",'"+searchgroupChannelID+"','"+itemGrant+"',"+intUserAreaID+","+intAdminAreaID+")";
*/
            strSQL="insert into ipr_user(chrUserName,chrUserPass,chrRealName,chrPhone,chrMobile,chrFax,chrEmail,chrAddress,chrDepartment,intMaxLogin,chrAdminMemo,intCHCount,intFRCount,dtExpireTime,intGroupID,dtCurrentCardTime,dtRegisterTime,intUserState,chrOnlineList,intMaximum,chrYear,chrMerchantID,chrMAC,chrIPAdress,intAdministerID,chrHerbal_Name,intHerbal_DataBase," +
    		"chrMenu,intAdministerState,chrEnterpriseName,intMaxSearchCount,intMaxNavCount,intMaxUserCount,intAnalyseState,intUserAreaID,intAdminAreaID) " +
    		" values('"+strUserName+"','"+strPassword+"','"+strRealName+"','"+strPhone+"','"+strMobile+"','"+strFax+"','"+strEmail+"','"+strAddress+"','"+strDepartment+"',"+intMaxLogin+",'"+strAdminMemo+"',"+intCount_in+","+intCount_out+",'"+strExpireTime+"',"+intGroupID+",'"+strExpireTime+"','"+strRegisterTime+"',1,'',"+intABSTBatchCount+",'"+strYear+"','"+strMerchantID+"','"+strMAC+"','"+strIPAdress+"',"+adminID+",'"+strHerbal_Name+"',"+intHerbal_Database
    		+",'"+chrMenu+"',"+intAdministerState+",'"+chrEnterpriseName+"',"+intMaxSearchCount+","+intMaxNavCount+","+intMaxUserCount+","+intAnalyseState+","+intUserAreaID+","+intAdminAreaID+")";

            //System.out.println(strSQL);
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();

            strSQL="select intUserID from ipr_user where chrUserName='"+strUserName+"'";
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            while(rs.next())
            {
            	intUserID=rs.getInt("intUserID");
            }

            /*
   			//更新ipr_user_extinfo表中的信息
            strSQL="insert into ipr_user_extinfo (intUserID,intNumberPerPage) values("+intUserID+","+String.valueOf(intNumberPerPage)+")";
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();

            String ipRanges[]=Tools.splitString(strDefaultIP,";");
            for(int j=0;j<ipRanges.length;j++)
            {
              if(ipRanges[j].indexOf("-")!=-1)
              {
                beginIP=Tools.ip2long(ipRanges[j].substring(0,ipRanges[j].indexOf("-")));
                endIP=Tools.ip2long(ipRanges[j].substring(ipRanges[j].indexOf("-")+1));
              }
              else
              {
                beginIP=endIP=Tools.ip2long(ipRanges[j]);
              }
              try
              {
                if(beginIP!=-1&&endIP!=-1)
                {
                  strSQL="insert into ipr_ipaddress(chrUserName,intBeginIP,intEndIP) values('"+strUserName+"',"+beginIP+","+endIP+")";
//                  strSQL="insert into ipr_ipaddress(intUserID,intBeginIP,intEndIP) values("+userID+","+beginIP+","+endIP+")";

                  PrePareStmt = conn.prepareStatement(strSQL);
                  PrePareStmt.executeUpdate();
                  PrePareStmt.close();
                }
              }
              catch(SQLException e)
              {
                DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
                return -1;
              }
           }
            */
/******************************增加行业信息***************************************/
            //arrTradeList
       if(arrTradeList!=null){
    	   /*
            for(int i=0;i<arrTradeList.length;i++){
            	int NavID=Integer.parseInt(arrTradeList[i]);
            	
            	String chrCNChannels="";
            	String chrFRChannels="";
            	
            	strSQL="select chrCNChannels,chrFRChannels from ipr_navtable where intID="+NavID;
            	PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                while(rs.next())
                {
                	chrCNChannels=rs.getString("chrCNChannels").trim();
                	chrFRChannels=rs.getString("chrFRChannels").trim();
                }
                rs.close();
                PrePareStmt.close();
                
                String strChannel=chrCNChannels;
                if(!strChannel.equals("")){
                	if(!chrFRChannels.equals("")){
                		strChannel+=","+chrFRChannels;
                	}                	
                }else{
                	strChannel=chrFRChannels;
                }
                
                String[] arrCNChannel=strChannel.split(",");
                for(int j=0;j<arrCNChannel.length;j++){
                	String dtUpdateTime="";
                	
                	strSQL="select dtUpdateTime from ipr_channel where intChannelID="+arrCNChannel[j];
                	PrePareStmt = conn.prepareStatement(strSQL);
                    rs = PrePareStmt.executeQuery();
                    while(rs.next())
                    {
                    	dtUpdateTime=rs.getString("dtUpdateTime");
                    }
                    rs.close();
                    PrePareStmt.close();
                    
                    
					strSQL="insert into ipr_user_nav(intUserID,intNavID,dtUpdateTime,intTRSTable) " +
					       "values("+intUserID+","+NavID+",'"+dtUpdateTime+"',"+arrCNChannel[j]+")";
					PrePareStmt = conn.prepareStatement(strSQL);
					PrePareStmt.executeUpdate();
					PrePareStmt.close();
                }
            }
            */
    	   PreparedStatement PrePareStmtTrade=null;
    	   String strSQLTrade="";
			java.text.SimpleDateFormat sformat = new java.text.SimpleDateFormat("yyyy-MM-dd");
			String dtUpdateDate = sformat.format(new java.util.Date());
/*
        	  NavTree navTree=new NavTree();
        	  navTree.getAllNavIDs(arrTradeList);
        	  String strSelNavIDs = navTree.getChrSelNavIDs();
        	  String[] arrSelNavID=strSelNavIDs.split(",");
        	  for(int i=0;i<arrSelNavID.length;i++){
				strSQLTrade="insert into ipr_user_nav(intUserID,intNavID,dtUpdateDate) " +
					"values("+intUserID+","+arrSelNavID[i]+",'"+dtUpdateDate+"')";
				//System.out.println(strSQLTrade);
				PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
				PrePareStmtTrade.executeUpdate();
				PrePareStmtTrade.close();
        	  }
*/
      	  NavTree navTree=new NavTree();
    	  navTree.getAllNavIDs(arrTradeList);
    	  //String strSelNavIDs = navTree.getChrSelNavIDs();
    	  //String[] arrSelNavID=strSelNavIDs.split(",");
    	  for(int i=0;i<arrTradeList.length;i++){
			strSQLTrade="insert into ipr_user_nav(intUserID,intNavID,dtUpdateDate) " +
				"values("+intUserID+","+arrTradeList[i]+",'"+dtUpdateDate+"')";
			//System.out.println(strSQLTrade);
			PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
			PrePareStmtTrade.executeUpdate();
			PrePareStmtTrade.close();
    	  }
       }
/********************************* END ************************************/            
		DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
		return 1;
	}
	catch(Exception e)
	{
	    return -1;
	}finally{
		try{
			rs.close();
			PrePareStmt.close();
            
			if(conn!=null){
				conn.close();
				conn=null;
			}
		}catch(Exception ex){}
	}
    }

    public int getUserID()
    {
      return 	intUserID;
    }
    
    public void setUserID(int userID)
    {
      intUserID=userID;
    }
    
    public String getUserName()
    {
      return chrUserName;
    }
    
    public void setUserName(String userName)
    {
      chrUserName=userName;
    }
   
    public String getUserPass()
    {
      return 	chrUserPass;
    }
    
    public void setUserPass(String userPass)
    {
      chrUserPass=userPass;
    }
    
    public String getRealName()
    {
      return 	chrRealName;
    }
    
    public void setRealName(String realName)
    {
      chrRealName=realName;
    }
    
    public String getEmail()
    {
      return 	chrEmail;
    }
    
    public void setEmail(String eMail)
    {
      chrEmail=eMail;
    }
    
    public String getPhone()
    {
      return 	chrPhone;
    }
    
    public void setPhone(String phone)
    {
      chrPhone=phone;
    }
    
    public String getMobile()
    {
      return 	chrMobile;
    }
    
    public void setMobile(String mobile)
    {
      chrMobile=mobile;
    }
    
    public String getAddress()
    {
      return 	chrAddress;
    }
    
    public void setAddress(String address)
    {
      chrAddress=address;
    }
    
    public String getRegisterTime()
    {
      return 	dtRegisterTime;
    }
    
    public void setRegisterTime(String registerTime)
    {
      dtRegisterTime=registerTime;
    }
    
    public String getCurrentCardTime()
    {
      return 	dtCurrentCardTime;
    }
    
    public void setCurrentCardTime(String currentCardTime)
    {
      dtCurrentCardTime=currentCardTime;
    }
    
    public String getExpireTime()
    {
      return 	dtExpireTime;
    }
    
    public void setExpireTime(String expireTime)
    {
      dtExpireTime=expireTime;
    }
    
    public int getMaxLogin()
    {
      return 	intMaxLogin;
    }
    
    public void setMaxLogin(int maxLogin)
    {
      intMaxLogin=maxLogin;
    }
    
    public int getCHCount()
    {
      return 	intCHCount;
    }
    
    public void setCHCount(int chCount)
    {
      intCHCount=chCount;
    }
    
    public int getFRCount()
    {
      return 	intFRCount;
    }
    
    public void setFRCount(int frCount)
    {
      intFRCount=frCount;
    }
    
    public String getLastVisitTime()
    {
      return 	dtLastVisitTime;
    }
    
    public void setLastVisitTime(String lastVisitTime)
    {
      dtLastVisitTime=lastVisitTime;
    }
    
    public String getLastVisitIP()
    {
      return 	chrLastVisitIP;
    }
    
    public void setLastVisitIP(String lastVisitIP)
    {
      chrLastVisitIP=lastVisitIP;
    }
    
    public int getUserState()
    {
      return intUserState;	
    }
    
    public void setUserState(int userState)
    {
      intUserState=userState;
    }
    
    public int getGroupID()
    {
      return intGroupID;	
    }
    
    public void setGroupID(int groupID)
    {
      intGroupID=groupID;
    }
    
    public String getAdminMemo()
    {
      return 	chrAdminMemo;
    }
    
    public void setAdminMemo(String adminMemo)
    {
      chrAdminMemo=adminMemo;
    }
    
    public String[] getUserNames()
    {
      return 	chrUserNames;
    }
    
    public void setUserNames(String[] userNames)
    {
      chrUserNames=userNames;
    }
    
    public String[] getNumbers() {
		return numbers;
	}

	public void setNumbers(String[] numbers) {
		this.numbers = numbers;
	}
    
    public String[] getRealNames()
    {
      return 	chrRealNames;
    }
    
    public void setRealNames(String[] realNames)
    {
      chrRealNames=realNames;
    }
    
    public String[] getRegisterTimes()
    {
      return 	dtRegisterTimes;
    }
    
    public void setRegisterTimes(String[] registerTimes)
    {
      dtRegisterTimes=registerTimes;
    }
    
    public String[] getExpireTimes()
    {
      return 	dtExpireTimes;
    }
    
    public void setExpireTimes(String[] expireTimes)
    {
      dtExpireTimes=expireTimes;
    }
    
    public int[] getUserIDs()
    {
      return intUserIDs;	
    }
    
    public void setUserIDs(int userIDs[])
    {
      intUserIDs=userIDs;
    }
    
    public int getCount()
    {
      return intCount;	
    }
    
    public void setCount(int count)
    {
      intCount=count;
    }
    
    public String getDefaultIP()
    {
      return 	chrDefaultIP;
    }
    
    public void setDefaultIP(String strDefaultIP)
    {
      chrDefaultIP=strDefaultIP;
    }

    public String getMerchantID()
    {
      return chrMerchantID;
    }    
    public void setMerchantID(String strMerchantID)
    {
    	chrMerchantID=strMerchantID;
    }
    
    public String getHerbal_Name()
    {
      return chrHerbal_Name;
    }    
    public void setHerbal_Name(String strHerbal_Name)
    {
    	chrHerbal_Name=strHerbal_Name;
    }
    public int getHerbal_DataBase()
    {
      return intHerbal_DataBase;
    }    
    public void setHerbal_DataBase(int Herbal_DataBase)
    {
    	intHerbal_DataBase=Herbal_DataBase;
    }
    
    public String getMAC()
    {
      return chrMAC;
    }    
    public void setMAC(String strmac)
    {
    	chrMAC = strmac;
    }
    public String getIPAdress()
    {
      return chrIPAdress;
    }    
    public void setIPAdress(String strIPAdress)
    {
    	chrIPAdress = strIPAdress;
    } 
    public int getAdministerID()
    {
      return intAdministerID;
    } 
    //setAdministerID
    public void setAdministerID(int AdministerID)
    {
    	intAdministerID = AdministerID;
    } 
    public String getFax()
    {
      return 	chrFax;
    }
    
    public void setFax(String strFax)
    {
      chrFax=strFax;
    }
    
    public String getDepartment()
    {
      return 	chrDepartment;
    }
    
    public void setDepartment(String strDepartment)
    {
      chrDepartment=strDepartment;
    }
    
    public void setPages(int pages)
    {
      intPages=pages;
    }
    
    public int getPages()
    {
      return intPages;
    }


    public void setNumberPerPage(int page)
    {
      intNumberPerPage = page;
    }
    
    public int getNumberPerPage()
    {
      return intNumberPerPage;
    }

    public void setABSTBatchCount(int i)
    {
      intABSTBatchCount = i;
    }
    
    public int getABSTBatchCount()
    {
      return intABSTBatchCount;
    }

    public void setDownloadedCount(int i)
    {
      intDownloadedCount = i;
    }

    public int getDownloadedCount()
    {
      return intDownloadedCount;
    }
    
    public void setAdministerState(int intAdministerState)
    {
    	this.intAdministerState=intAdministerState;	
    }
    public int getAdministerState(){
    	return intAdministerState;
    }
    public void setEnterpriseName(String chrEnterpriseName){
    	this.chrEnterpriseName=chrEnterpriseName;
    }
    public String getEnterpriseName(){
    	return chrEnterpriseName;
    }    
    public void setMaxSearchCount(int intMaxSearchCount){
    	this.intMaxSearchCount=intMaxSearchCount;
    }
    public int getMaxSearchCount(){
    	return intMaxSearchCount;
    }
    public void setMaxNavCount(int intMaxNavCount){
    	this.intMaxNavCount=intMaxNavCount;
    }
    public int getMaxNavCount(){
    	return intMaxNavCount;
    }
    public void setMaxUserCount(int intMaxUserCount){
    	this.intMaxUserCount=intMaxUserCount;
    }
    public int getMaxUserCount(){
    	return intMaxUserCount;
    }
    
    
    public void deleteUser1111(int userID) throws WASException
    {
    	String[] arrSubUserName=null;
    	int[] arrSubUserID=null;
    	
        String userName="";
        Connection conn = DBPoolAccessor.getConnection();;
        
        String strSQL ="select chrUserName from ipr_user where intUserID="+userID;
        
        PreparedStatement PrePareStmt = null;
        ResultSet rs = null;
        try
        {
            //首先获取用户名
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              userName=rs.getString("chrUserName");
            }
            
            strSQL ="select intUserID,chrUserName from ipr_user where intAdministerID="+userID;
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            rs.last();
            
            arrSubUserName=new String[rs.getRow()];
        	arrSubUserID=new int[rs.getRow()];
            rs.beforeFirst();
        	
            int i=0;
            while(rs.next())
            {
            	arrSubUserName[i]=rs.getString("chrUserName");
            	arrSubUserID[i]=rs.getInt("intUserID");
            	i++;
            }            
            
            //直接删除用户
            strSQL = "delete from ipr_user where intUserID="+userID;
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            PrePareStmt.close();
            strSQL = "delete from ipr_user where intAdministerID="+userID;
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            PrePareStmt.close();
            
            //删除ipr_user_extinfo表中的用户信息
            strSQL = "delete from ipr_user_extinfo where intUserID="+userID;
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            PrePareStmt.close();
            
            for(int j=0;j<arrSubUserID.length;j++){
	            strSQL = "delete from ipr_user_extinfo where intUserID="+arrSubUserID[j];
	//System.out.println(strSQL);
	            PrePareStmt = conn.prepareStatement(strSQL);
	            PrePareStmt.executeUpdate();
	            PrePareStmt.close();
            }
//删除集团用户中的IP段
            strSQL="delete from ipr_ipaddress where chrUserName='"+userName+"'";
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            PrePareStmt.close();
            for(int j=0;j<arrSubUserName.length;j++){
	            strSQL = "delete from ipr_ipaddress where chrUserName='"+arrSubUserName[j]+"'";
	            PrePareStmt = conn.prepareStatement(strSQL);
	            PrePareStmt.executeUpdate();
	            PrePareStmt.close();
            }
            
            strSQL="delete from ipr_user_nav where intUserID="+userID;
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            PrePareStmt.close();
            for(int j=0;j<arrSubUserID.length;j++){
	            strSQL = "delete from ipr_user_nav where intUserID="+arrSubUserID[j];
	            PrePareStmt = conn.prepareStatement(strSQL);
	            PrePareStmt.executeUpdate();
	            PrePareStmt.close();
            }

            strSQL="delete from ipr_navtable where intAdministerID="+userID;//+" and intType=1";
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            PrePareStmt.close();  
/*********************************************************************************************/
            //在日志中删除此用户
			strSQL="delete from ipr_all_logs where ipr_all_logs.chrUserName='"+userName+"'";
			//strSQL="delete from ipr_ipaddress where intUserID="+userID;
			PrePareStmt = conn.prepareStatement(strSQL);
			PrePareStmt.executeUpdate();
			PrePareStmt.close();
			//在日志中删除此用户建立的用户的日志信息
			for(int j=0;j<arrSubUserName.length;j++){
				strSQL="delete from ipr_all_logs where chrUserName='"+arrSubUserName[j]+"'";
				//strSQL="delete from ipr_ipaddress where intUserID="+userID;
				PrePareStmt = conn.prepareStatement(strSQL);
				PrePareStmt.executeUpdate();
				PrePareStmt.close();
			}
            //在日志中删除此用户
			strSQL="delete from ipr_today_logs where ipr_today_logs.chrUserName='"+userName+"'";
			PrePareStmt = conn.prepareStatement(strSQL);
			PrePareStmt.executeUpdate();
			PrePareStmt.close();
			//在日志中删除此用户建立的用户的日志信息
			for(int j=0;j<arrSubUserName.length;j++){
				strSQL="delete from ipr_today_logs where chrUserName='"+arrSubUserName[j]+"'";
				//strSQL="delete from ipr_ipaddress where intUserID="+userID;
				PrePareStmt = conn.prepareStatement(strSQL);
				PrePareStmt.executeUpdate();
				PrePareStmt.close();
			}
			
			//ipr_saveexpression
			strSQL="delete from ipr_saveexpression where intUserID="+userID;
			PrePareStmt = conn.prepareStatement(strSQL);
			PrePareStmt.executeUpdate();
			PrePareStmt.close();
			for(int j=0;j<arrSubUserID.length;j++){
				strSQL="delete from ipr_saveexpression where intUserID="+arrSubUserID[j];
				PrePareStmt = conn.prepareStatement(strSQL);
				PrePareStmt.executeUpdate();
				PrePareStmt.close();
			}
			
			//ipr_searchlogs
			strSQL="delete from ipr_searchlogs where intUserID="+userID;
			PrePareStmt = conn.prepareStatement(strSQL);
			PrePareStmt.executeUpdate();
			PrePareStmt.close();
			for(int j=0;j<arrSubUserID.length;j++){
				strSQL="delete from ipr_searchlogs where intUserID="+arrSubUserID[j];
				PrePareStmt = conn.prepareStatement(strSQL);
				PrePareStmt.executeUpdate();
				PrePareStmt.close();
			}
			
			//ipr_searchresult
			strSQL="delete from ipr_searchresult where intUserID="+userID;
			PrePareStmt = conn.prepareStatement(strSQL);
			PrePareStmt.executeUpdate();
			PrePareStmt.close();
			for(int j=0;j<arrSubUserID.length;j++){
				strSQL="delete from ipr_searchresult where intUserID="+arrSubUserID[j];
				PrePareStmt = conn.prepareStatement(strSQL);
				PrePareStmt.executeUpdate();
				PrePareStmt.close();
			}
/*********************************************************************************************/
			
            rs.close();
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
        }
        catch(Exception ex)
        {
//        	ex.printStackTrace();
        	throw new WASException(ex.getMessage());
        }finally{
    		try{
    			rs.close();
    			PrePareStmt.close();
                
    			if(conn!=null){
    				conn.close();
    				conn=null;
    			}
    		}catch(Exception ex){}
    	}
    }
    
    public void deleteUser(int userID) throws WASException
    {
        Connection conn = DBPoolAccessor.getConnection();        
        String strSQL ="";
        
        PreparedStatement PrePareStmt = null;
//        PreparedStatement PrePareStmtUpdate = null;
        ResultSet rs = null;
        try
        {
//            直接删除用户
            strSQL = "delete from ipr_user where intUserID="+userID;			
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            PrePareStmt.close();
            
            strSQL="delete from ipr_user_nav where intUserID="+userID;
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            PrePareStmt.close();

/*********************************************************************************************/
            //在日志中删除此用户
/*			strSQL="delete from ipr_all_logs where ipr_all_logs.chrUserName='"+userName+"'";
			PrePareStmt = conn.prepareStatement(strSQL);
			PrePareStmt.executeUpdate();
			PrePareStmt.close();*/
            //在日志中删除此用户
/*			strSQL="delete from ipr_today_logs where ipr_today_logs.chrUserName='"+userName+"'";
			PrePareStmt = conn.prepareStatement(strSQL);
			PrePareStmt.executeUpdate();
			PrePareStmt.close();*/
//			在日志中删除此用户建立的用户的日志信息
			
			//ipr_saveexpression
			strSQL="delete from ipr_saveexpression where intUserID="+userID;
			PrePareStmt = conn.prepareStatement(strSQL);
			PrePareStmt.executeUpdate();
			PrePareStmt.close();
			
			//ipr_searchlogs
			strSQL="delete from ipr_searchlogs where intUserID="+userID;
			PrePareStmt = conn.prepareStatement(strSQL);
			PrePareStmt.executeUpdate();
			PrePareStmt.close();
			
			//ipr_searchresult
			strSQL="delete from ipr_searchresult where intUserID="+userID;
			PrePareStmt = conn.prepareStatement(strSQL);
			PrePareStmt.executeUpdate();
			PrePareStmt.close();
/*********************************************************************************************/
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
        }
        catch(Exception ex)
        {
        	ex.printStackTrace();
        }finally{
    		try{
    			rs.close();
    			PrePareStmt.close();
                
    			if(conn!=null){
    				conn.close();
    				conn=null;
    			}
    		}catch(Exception ex){}
    	}
    }

    
    /************ 现在只用这个updateUser ************/
    //非集团用户的更新
    public int updateUser(String strUserName,String strPassword,String strRealName,String strPhone,String strMobile,
    		String strFax,String strEmail,String strAddress,String strDepartment,String strMaxLogin,String strAdminMemo,
    		int intCount_in,int intCount_out,String strExpireTime,int intGroupID,int intUserState,
    		String strMendGroup,int intUserID,int intNumberPerPage,int intABSTBatchCount,int intDownloadedCount, 
    		String strMerchantID,String strMAC,String strIPAdress,int adminID,String strHerbal_Name,String strHerbal_Database,
    		int intIPLimit,
    		String chrMenu,int intAdministerState,String chrEnterpriseName,int intMaxSearchCount,int intMaxNavCount,int intMaxUserCount,
    		String[] arrTradeList,int intAnalyseState,int intAnalyseNumUpperlimit,
    		//String itemGrant,String[] itemGrants,
    		int intUserAreaID,int intAdminAreaID) throws WASException
    {
//System.out.println("UserManage................非集团用户的更新updateUser....................");
//System.out.println("strIPAdress="+strIPAdress);
    	
    	String strSQL="";
    	Connection conn = DBPoolAccessor.getConnection();;
    	PreparedStatement PrePareStmt = null;
    	ResultSet rs = null;

        int intMaxLogin=1;
        String strRegisterTime=null;
        if(strMaxLogin!=null)
        {
          intMaxLogin=Integer.parseInt(strMaxLogin);
        }
        strUserName=Tools.dealSingleQuot(strUserName);
        strRealName=Tools.dealSingleQuot(strRealName);
        strPhone=Tools.dealSingleQuot(strPhone);
        strMobile=Tools.dealSingleQuot(strMobile);
        strFax=Tools.dealSingleQuot(strFax);
        strEmail=Tools.dealSingleQuot(strEmail);
        strAddress=Tools.dealSingleQuot(strAddress);
        strDepartment=Tools.dealSingleQuot(strDepartment);
        strAdminMemo=Tools.dealSingleQuot(strAdminMemo);
        
        strMerchantID=Tools.dealSingleQuot(strMerchantID);
        strMAC=Tools.dealSingleQuot(strMAC);
        strIPAdress=Tools.dealSingleQuot(strIPAdress);
        /*
        String searchgroupChannelID="";
        try{
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
              	searchgroupChannelID=searchgroupChannelID+rs.getString("intChannelID")+",";
              }
              rs.close();
              searchgroupChannelID=searchgroupChannelID.substring(0,searchgroupChannelID.length()-1);
            }
        }catch(Exception ex){
        	ex.printStackTrace();
        }
        */
        strHerbal_Name=Tools.dealSingleQuot(strHerbal_Name);
        
        chrEnterpriseName=Tools.dealSingleQuot(chrEnterpriseName);
        chrMenu=Tools.dealSingleQuot(chrMenu);
        
        int intHerbal_Database=0;
        
        if(strPassword!=null&&!strPassword.equals(""))
        {
            ShaHash m_shahash = new ShaHash();
            m_shahash.addASCII(strPassword);
            byte bPassword[] = m_shahash.get();
            strPassword = CryptoUtils.toStringBlock(bPassword);
        }
        //获得日期
        java.util.Date today = new java.util.Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = formatter.format(today);
        strRegisterTime=time;
        
//      String strSQL = "select chrUserName from ipr_user where chrUserName='"+strUserName+"' and intUserID!="+intUserID+" and intAdministerID="+intAdministerID;
        strSQL = "select chrUserName from ipr_user where chrUserName='"+strUserName+"' and intUserID!="+intUserID;
        String strSQL1 = "select chrMerchantID from ipr_user where chrUserName not in ('" + strUserName + "') and chrMerchantID='"+strMerchantID+"'";
       
        try
        {
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              rs.close();
              PrePareStmt.close();
              DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
              return -2;
            }

            strSQL = "select chrUserName from ipr_user where intUserAreaID="+intUserAreaID+" and intUserID!="+intUserID+" and intUserAreaID!=0";
            //System.out.println("非集团用户:"+strSQL);
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              rs.close();
              PrePareStmt.close();
              DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
              return -4;
            }
            
            if(strMendGroup.equals("1"))
            {
              if(strPassword==null || strPassword.equals(""))
              {
                strSQL="update ipr_user set chrUserName='"+strUserName+"',chrRealName='"+strRealName+"',chrPhone='"+strPhone+"',chrMobile='"+strMobile+"',chrFax='"+strFax+"',chrEmail='"+strEmail+"',chrAddress='"+strAddress+"',chrDepartment='"+strDepartment+"',intMaxLogin="+intMaxLogin+",chrAdminMemo='"+strAdminMemo+"',intCHCount=intCHCount + "+intCount_in+",intFRCount=intFRCount+"+intCount_out+",dtCurrentCardTime='"+strExpireTime+"',dtExpireTime='"+strExpireTime+"',intGroupID="+intGroupID+",intUserState="+intUserState+",intMaximum="+intABSTBatchCount+",intDownloadedNumber="+intDownloadedCount+",chrMerchantID='"+strMerchantID+"',chrMAC='"+strMAC+"',chrIPAdress='"+strIPAdress+"',intAdministerID="+adminID+",chrHerbal_Name='"+strHerbal_Name+"',intHerbal_DataBase="+intHerbal_Database+
		                ",intIPLimit = "+intIPLimit +
                		",chrMenu='"+chrMenu+"'"+
		              	",intAdministerState="+intAdministerState+
		        		",chrEnterpriseName='"+chrEnterpriseName+"'"+                		
		        		",intMaxSearchCount="+intMaxSearchCount+
		        		",intMaxNavCount="+intMaxNavCount+
		        		",intMaxUserCount="+intMaxUserCount+
		        		",intAnalyseState="+intAnalyseState+
		        		",intAnalyseNumUpperlimit="+intAnalyseNumUpperlimit+
		        		
		        		
		        		//",chrChannelID='"+searchgroupChannelID+"'"+
		        		//",chrItemGrant='"+itemGrant+"'"+
		        		",intUserAreaID="+intUserAreaID+
		        		",intAdminAreaID="+intAdminAreaID+
		              	" where intUserID="+intUserID;
//System.out.println(strSQL);
              }else
              {
                strSQL="update ipr_user set chrUserName='"+strUserName+"',chrUserPass='"+strPassword+"',chrRealName='"+strRealName+"',chrPhone='"+strPhone+"',chrMobile='"+strMobile+"',chrFax='"+strFax+"',chrEmail='"+strEmail+"',chrAddress='"+strAddress+"',chrDepartment='"+strDepartment+"',intMaxLogin="+intMaxLogin+",chrAdminMemo='"+strAdminMemo+"',intCHCount=intCHCount+"+intCount_in+",intFRCount=intFRCount+"+intCount_out+",dtCurrentCardTime='"+strExpireTime+"',dtExpireTime='"+strExpireTime+"',intGroupID="+intGroupID+",intUserState="+intUserState+",intMaximum="+intABSTBatchCount+",intDownloadedNumber="+intDownloadedCount+",chrMerchantID='"+strMerchantID+"',chrMAC='"+strMAC+"',chrIPAdress='"+strIPAdress+"',intAdministerID="+adminID+",chrHerbal_Name='"+strHerbal_Name+"',intHerbal_DataBase="+intHerbal_Database+
                			",intIPLimit = "+intIPLimit +
                			",chrMenu='"+chrMenu+"'"+
			              	",intAdministerState="+intAdministerState+
			        		",chrEnterpriseName='"+chrEnterpriseName+"'"+                		
			        		",intMaxSearchCount="+intMaxSearchCount+
			        		",intMaxNavCount="+intMaxNavCount+
			        		",intMaxUserCount="+intMaxUserCount+
			        		",intAnalyseState="+intAnalyseState+
			        		",intAnalyseNumUpperlimit="+intAnalyseNumUpperlimit+
			        		//",chrChannelID='"+searchgroupChannelID+"'"+
			        		//",chrItemGrant='"+itemGrant+"'"+
			        		",intUserAreaID="+intUserAreaID+
			        		",intAdminAreaID="+intAdminAreaID+
			              	" where intUserID="+intUserID;
//System.out.println("UserManage222 -----> strSQL : "+strSQL);
              }
/*************mend管group、menu和trade,程序一开始就考虑了group,现在又增加了对menu和admin信息的处理
              现在开始处理trade,我打算把ipr_user_nav表中此用户的内容全部删除,再重新insert******/
              String strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID;

              strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID + " and intNavID IN (select intID from ipr_navtable where intType=3)";
      		
              /*
              if(adminID==1){
            	  strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID;
            	  System.out.println("adminID==1:::"+strSQLTrade);
              }else{
            	  String strNav="intNavID IN (";
            	  
            	  String strSQLNav="select intID from ipr_navtable where intAdministerID="+adminID;
            	  PreparedStatement PrePareStmtNav = conn.prepareStatement(strSQLNav);
            	  ResultSet rsNav = PrePareStmtNav.executeQuery(strSQLNav);
            	  while(rsNav.next()){
            		  strNav+=rsNav.getInt("intID")+",";
            	  }
            	  PrePareStmtNav.close();
            	  
            	  if(!strNav.equals("intNavID IN (")){
            		  strNav=strNav.substring(0,strNav.length()-1)+")";
            		  
            		  strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID+" and "+strNav;
            	  }else{
            		  strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID;
            	  }
              }
              */
//              System.out.println("@@@@@@@@@@@@@@"+strSQLTrade);
              
              
              PreparedStatement PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
              PrePareStmtTrade.executeUpdate();
              PrePareStmtTrade.close();
              /**********此处代码拷贝adduser***********/
              if(arrTradeList!=null){
            	  /*
                   for(int i=0;i<arrTradeList.length;i++){
                   	int NavID=Integer.parseInt(arrTradeList[i]);
                   	
                   	String chrCNChannels="";
                   	String chrFRChannels="";
                   	
                   	strSQLTrade="select chrCNChannels,chrFRChannels from ipr_navtable where intID="+NavID;
                   	//System.out.println(strSQLTrade);
                   	PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
                    ResultSet rsTrade = PrePareStmtTrade.executeQuery();
                       while(rsTrade.next())
                       {
                       	chrCNChannels=rsTrade.getString("chrCNChannels")==null?"14,15,16":rsTrade.getString("chrCNChannels").trim();
                       	chrFRChannels=rsTrade.getString("chrFRChannels")==null?"18,19,20,21,22,23,24,25":rsTrade.getString("chrFRChannels").trim();
                       }
                       rsTrade.close();
                       PrePareStmtTrade.close();
                       
                       String strChannel=chrCNChannels;
                       if(!strChannel.equals("")){
                       	if(!chrFRChannels.equals("")){
                       		strChannel+=","+chrFRChannels;
                       	}                	
                       }else{
                       	strChannel=chrFRChannels;
                       }
                       
                       String[] arrChannel=strChannel.split(",");
                       for(int j=0;j<arrChannel.length;j++){
                    	   String dtUpdateTime="";
                    	   strSQLTrade="select dtUpdateTime from ipr_channel where intChannelID="+arrChannel[j];
							PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
							rsTrade = PrePareStmtTrade.executeQuery();
							while(rsTrade.next())
							{
								dtUpdateTime=rsTrade.getString("dtUpdateTime");
							}
							rsTrade.close();
							PrePareStmtTrade.close();
								                           
							strSQLTrade="insert into ipr_user_nav(intUserID,intNavID,dtUpdateTime,intTRSTable) " +
								       "values("+intUserID+","+NavID+",'"+dtUpdateTime+"',"+arrChannel[j]+")";
							//System.out.println(strSQLTrade);
							PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
							PrePareStmtTrade.executeUpdate();
							PrePareStmtTrade.close();
                       }
                   }
                   */
				java.text.SimpleDateFormat sformat = new java.text.SimpleDateFormat("yyyy-MM-dd");
				String dtUpdateDate = sformat.format(new java.util.Date());
/*
            	  NavTree navTree=new NavTree();
            	  navTree.getAllNavIDs(arrTradeList);
            	  String strSelNavIDs = navTree.getChrSelNavIDs();
            	  String[] arrSelNavID=strSelNavIDs.split(",");
            	  for(int i=0;i<arrSelNavID.length;i++){
					strSQLTrade="insert into ipr_user_nav(intUserID,intNavID,dtUpdateDate) " +
						"values("+intUserID+","+arrSelNavID[i]+",'"+dtUpdateDate+"')";
					//System.out.println(strSQLTrade);
					PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
					PrePareStmtTrade.executeUpdate();
					PrePareStmtTrade.close();
            	  }
*/
	        	  NavTree navTree=new NavTree();
	        	  navTree.getAllNavIDs(arrTradeList);
	        	  //String strSelNavIDs = navTree.getChrSelNavIDs();
	        	  //String[] arrSelNavID=strSelNavIDs.split(",");
	        	  for(int i=0;i<arrTradeList.length;i++){
					strSQLTrade="insert into ipr_user_nav(intUserID,intNavID,dtUpdateDate) " +
								"values("+intUserID+","+arrTradeList[i]+",'"+dtUpdateDate+"')";
					//System.out.println(strSQLTrade);
					PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
					PrePareStmtTrade.executeUpdate();
					PrePareStmtTrade.close();
	        	  }            	  
              }
              /******************************* END ***************************************/
            }
            else
            {
              if(strPassword==null || strPassword.equals(""))
              {
            	  strSQL="update ipr_user set chrUserName='"+strUserName+"',chrRealName='"+strRealName+"',chrPhone='"+strPhone+"',chrMobile='"+strMobile+"',chrFax='"+strFax+"',chrEmail='"+strEmail+"',chrAddress='"+strAddress+"',chrDepartment='"+strDepartment+"',intMaxLogin="+intMaxLogin+",chrAdminMemo='"+strAdminMemo+"',intCHCount=intCHCount+"+intCount_in+",intFRCount=intFRCount+"+intCount_out+",dtCurrentCardTime='"+strExpireTime+"',dtExpireTime='"+strExpireTime+"',intUserState="+intUserState+",intMaximum="+intABSTBatchCount+",intDownloadedNumber="+intDownloadedCount+",chrMerchantID='"+strMerchantID+"',chrMAC='"+strMAC+"',chrIPAdress='"+strIPAdress+"',intAdministerID="+adminID+",chrHerbal_Name='"+strHerbal_Name+"',intHerbal_DataBase="+intHerbal_Database+
		              	//",chrMenu='"+chrMenu+"'"+
              			",intIPLimit = "+intIPLimit +
              			",intAdministerState="+intAdministerState+
		        		",chrEnterpriseName='"+chrEnterpriseName+"'"+                		
		        		",intMaxSearchCount="+intMaxSearchCount+
		        		",intMaxNavCount="+intMaxNavCount+
		        		",intMaxUserCount="+intMaxUserCount+
		        		",intAnalyseState="+intAnalyseState+
		        		",intAnalyseNumUpperlimit="+intAnalyseNumUpperlimit+
		        		//",chrChannelID='"+searchgroupChannelID+"'"+
		        		//",chrItemGrant='"+itemGrant+"'"+
		        		",intUserAreaID="+intUserAreaID+
		        		",intAdminAreaID="+intAdminAreaID+
		              	" where intUserID="+intUserID;
//System.out.println(strSQL);
              }
              else
              {
            	  strSQL="update ipr_user set chrUserName='"+strUserName+"',chrUserPass='"+strPassword+"',chrRealName='"+strRealName+"',chrPhone='"+strPhone+"',chrMobile='"+strMobile+"',chrFax='"+strFax+"',chrEmail='"+strEmail+"',chrAddress='"+strAddress+"',chrDepartment='"+strDepartment+"',intMaxLogin="+intMaxLogin+",chrAdminMemo='"+strAdminMemo+"',intCHCount=intCHCount+"+intCount_in+",intFRCount=intFRCount+"+intCount_out+",dtCurrentCardTime='"+strExpireTime+"',dtExpireTime='"+strExpireTime+"',intUserState="+intUserState+",intMaximum="+intABSTBatchCount+",intDownloadedNumber="+intDownloadedCount+",chrMerchantID='"+strMerchantID+"',chrMAC='"+strMAC+"',chrIPAdress='"+strIPAdress+"',intAdministerID="+adminID+",chrHerbal_Name='"+strHerbal_Name+"',intHerbal_DataBase="+intHerbal_Database+
		              	//",chrMenu='"+chrMenu+"'"+
              			",intIPLimit = "+intIPLimit +
		              	",intAdministerState="+intAdministerState+
		        		",chrEnterpriseName='"+chrEnterpriseName+"'"+                		
		        		",intMaxSearchCount="+intMaxSearchCount+
		        		",intMaxNavCount="+intMaxNavCount+
		        		",intMaxUserCount="+intMaxUserCount+
		        		",intAnalyseState="+intAnalyseState+
		        		",intAnalyseNumUpperlimit="+intAnalyseNumUpperlimit+
		        		//",chrChannelID='"+searchgroupChannelID+"'"+
		        		//",chrItemGrant='"+itemGrant+"'"+
		        		",intUserAreaID="+intUserAreaID+
		        		",intAdminAreaID="+intAdminAreaID+
		              	" where intUserID="+intUserID;     
              	//System.out.println(strSQL);
              }
            }
//System.out.println(strSQL);            
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            
            strSQL="delete from ipr_ipaddress where chrUserName='"+strUserName+"'";
//          strSQL="delete from ipr_ipaddress where intUserID="+intUserID;
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            
            //更新ipr_user_extinfo表中的信息
            strSQL = "update ipr_user_extinfo set intNumberPerPage = "+ String.valueOf(intNumberPerPage) + " Where intUserID="+String.valueOf(intUserID);
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            /*************************************************************/
            PrePareStmt.close();
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
            return 1;
	}
	catch(SQLException ex)
	{
	    return -1;
	}
	finally{
		try{
			rs.close();
			PrePareStmt.close();
			if(conn!=null){
				conn.close();
				conn=null;
			}
		}catch(Exception ex){}
	}
    }
    
    /**************** 原来的默认登录IP（strDefaultIP）被用户区域ID（intUserAreaID）代替了，此函数现在不用 *****************/
    //集团用户的更新
    public int updateUser_(String strUserName,String strPassword,String strRealName,String strPhone,String strMobile,
    		String strFax,String strEmail,String strAddress,String strDepartment,String strMaxLogin,String strAdminMemo,
    		int intCount_in,int intCount_out,String strExpireTime,int intGroupID,String strDefaultIP,int intUserState,
    		String strMendGroup,int intUserID,int intNumberPerPage,int intABSTBatchCount,int intDownloadedCount, 
    		String strMerchantID,String strMAC,String strIPAdress,int adminID,String strHerbal_Name,String strHerbal_Database,
    		String chrMenu,int intAdministerState,String chrEnterpriseName,int intMaxSearchCount,int intMaxNavCount,int intMaxUserCount,
    		String[] arrTradeList,int intAnalyseState,
    		//String itemGrant,String[] itemGrants,
    		int intUserAreaID,int intAdminAreaID) throws WASException
    {
//System.out.println("UserManage................集团用户的更新updateUser....................");
    	//System.out.println("intUserAreaID="+intUserAreaID);
//System.out.println("strIPAdress="+strIPAdress);
    	
    	String strSQL="";
    	Connection conn = DBPoolAccessor.getConnection();;
    	PreparedStatement PrePareStmt = null;
    	ResultSet rs = null;
    	
        int intMaxLogin=1;
        long beginIP=0;
        long endIP=0;
        String strRegisterTime=null;
        String userName=null;
        if(strMaxLogin!=null)
        {
          intMaxLogin=Integer.parseInt(strMaxLogin);
        }
        strUserName=Tools.dealSingleQuot(strUserName);
        strRealName=Tools.dealSingleQuot(strRealName);
        strPhone=Tools.dealSingleQuot(strPhone);
        strMobile=Tools.dealSingleQuot(strMobile);
        strFax=Tools.dealSingleQuot(strFax);
        strEmail=Tools.dealSingleQuot(strEmail);
        strAddress=Tools.dealSingleQuot(strAddress);
        strDepartment=Tools.dealSingleQuot(strDepartment);
        strAdminMemo=Tools.dealSingleQuot(strAdminMemo);
        
        strMerchantID=Tools.dealSingleQuot(strMerchantID);
        strMAC=Tools.dealSingleQuot(strMAC);
        strIPAdress=Tools.dealSingleQuot(strIPAdress);
        /*
        String searchgroupChannelID="";
        try{
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
              	searchgroupChannelID=searchgroupChannelID+rs.getString("intChannelID")+",";
              }
              rs.close();
              searchgroupChannelID=searchgroupChannelID.substring(0,searchgroupChannelID.length()-1);
            }
        }catch(Exception ex){
        	ex.printStackTrace();
        }
        */
        strHerbal_Name=Tools.dealSingleQuot(strHerbal_Name);
        
        chrEnterpriseName=Tools.dealSingleQuot(chrEnterpriseName);
        chrMenu=Tools.dealSingleQuot(chrMenu);
        
        int intHerbal_Database=0;
        
        if(strPassword!=null&&!strPassword.equals(""))
        {
            ShaHash m_shahash = new ShaHash();
            m_shahash.addASCII(strPassword);
            byte bPassword[] = m_shahash.get();
            strPassword = CryptoUtils.toStringBlock(bPassword);
        }
        //获得日期
        java.util.Date today = new java.util.Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String time = formatter.format(today);
        strRegisterTime=time;
        strSQL = "select chrUserName from ipr_user where chrUserName='"+strUserName+"' and intUserID!="+intUserID;
//select chrMerchantID from ipr_user where chrUserName not in ('qaz') and chrMerchantID='SZ006'
        String strSQL1 = "select chrMerchantID from ipr_user where chrUserName not in ('" + strUserName + "') and chrMerchantID='"+strMerchantID+"'";
        
        try
        {
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              rs.close();
              PrePareStmt.close();
              DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
              return -2;
            }
            
            strSQL = "select chrUserName from ipr_user where intUserAreaID="+intUserAreaID+" and intUserID!="+intUserID+" and intUserAreaID!=0";
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            //System.out.println(strSQL);
            if(rs.next())
            {
              rs.close();
              PrePareStmt.close();
              DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
              return -4;
            }
            
            strSQL="select chrUserName from ipr_user where intUserID="+intUserID;
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
              userName=rs.getString("chrUserName");
              rs.close();
            }
            if(strMendGroup.equals("1"))
            {
              if(strPassword==null||strPassword.equals(""))
              {
                strSQL="update ipr_user set chrUserName='"+strUserName+"',chrRealName='"+strRealName+"',chrPhone='"+strPhone+"',chrMobile='"+strMobile+"',chrFax='"+strFax+"',chrEmail='"+strEmail+"',chrAddress='"+strAddress+"',chrDepartment='"+strDepartment+"',intMaxLogin="+intMaxLogin+",chrAdminMemo='"+strAdminMemo+"',intCHCount=intCHCount+"+intCount_in+",intFRCount=intFRCount+"+intCount_out+",dtCurrentCardTime='"+strExpireTime+"',dtExpireTime='"+strExpireTime+"',intGroupID="+intGroupID+",intUserState="+intUserState+",intMaximum="+intABSTBatchCount+",intDownloadedNumber="+intDownloadedCount+",chrMerchantID='"+strMerchantID+"',chrMAC='"+strMAC+"',chrIPAdress='"+strIPAdress+"',intAdministerID="+adminID+",chrHerbal_Name='"+strHerbal_Name+"',intHerbal_DataBase="+intHerbal_Database+
		                ",chrMenu='"+chrMenu+"'"+
		              	",intAdministerState="+intAdministerState+
		        		",chrEnterpriseName='"+chrEnterpriseName+"'"+                		
		        		",intMaxSearchCount="+intMaxSearchCount+
		        		",intMaxNavCount="+intMaxNavCount+
		        		",intMaxUserCount="+intMaxUserCount+
		        		",intAnalyseState="+intAnalyseState+
		        		//",chrChannelID='"+searchgroupChannelID+"'"+
		        		//",chrItemGrant='"+itemGrant+"'"+
		        		",intUserAreaID="+intUserAreaID+
		        		",intAdminAreaID="+intAdminAreaID+
		              	" where intUserID="+intUserID;
              }
              else
              {
                strSQL="update ipr_user set chrUserName='"+strUserName+"',chrUserPass='"+strPassword+"',chrRealName='"+strRealName+"',chrPhone='"+strPhone+"',chrMobile='"+strMobile+"',chrFax='"+strFax+"',chrEmail='"+strEmail+"',chrAddress='"+strAddress+"',chrDepartment='"+strDepartment+"',intMaxLogin="+intMaxLogin+",chrAdminMemo='"+strAdminMemo+"',intCHCount=intCHCount+"+intCount_in+",intFRCount=intFRCount+"+intCount_out+",dtCurrentCardTime='"+strExpireTime+"',dtExpireTime='"+strExpireTime+"',intGroupID="+intGroupID+",intUserState="+intUserState+",intMaximum="+intABSTBatchCount+",intDownloadedNumber="+intDownloadedCount+",chrMerchantID='"+strMerchantID+"',chrMAC='"+strMAC+"',chrIPAdress='"+strIPAdress+"',intAdministerID="+adminID+",chrHerbal_Name='"+strHerbal_Name+"',intHerbal_DataBase="+intHerbal_Database+
		                ",chrMenu='"+chrMenu+"'"+
		              	",intAdministerState="+intAdministerState+
		        		",chrEnterpriseName='"+chrEnterpriseName+"'"+                		
		        		",intMaxSearchCount="+intMaxSearchCount+
		        		",intMaxNavCount="+intMaxNavCount+
		        		",intMaxUserCount="+intMaxUserCount+
		        		",intAnalyseState="+intAnalyseState+
		        		//",chrChannelID='"+searchgroupChannelID+"'"+
		        		//",chrItemGrant='"+itemGrant+"'"+
		        		",intUserAreaID="+intUserAreaID+
		        		",intAdminAreaID="+intAdminAreaID+
		              	" where intUserID="+intUserID;
              }
              
/*************mend管group、menu和trade,程序一开始就考虑了group,现在又增加了对menu和admin信息的处理
              现在开始处理trade,我打算把ipr_user_nav表中此用户的内容全部删除,再重新insert******/
              String strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID;
              
              if(adminID==1){
            	  strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID;
              }else{
            	  String strNav="intNavID IN (";
            	  
            	  String strSQLNav="select intID from ipr_navtable where intAdministerID="+adminID;
            	  PreparedStatement PrePareStmtNav = conn.prepareStatement(strSQLNav);
            	  ResultSet rsNav = PrePareStmtNav.executeQuery(strSQLNav);
            	  while(rsNav.next()){
            		  strNav+=rsNav.getInt("intID")+",";
            	  }
            	  PrePareStmtNav.close();
            	  
            	  if(!strNav.equals("intNavID IN (")){
            		  strNav=strNav.substring(0,strNav.length()-1)+")";
            		  
            		  strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID+" and "+strNav;
            	  }else{
            		  strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID;
            	  }
              }              
              
              PreparedStatement PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
              PrePareStmtTrade.executeUpdate();
              /**********此处代码拷贝adduser***********/
              //arrTradeList
              if(arrTradeList!=null){
            	  /*
                   for(int i=0;i<arrTradeList.length;i++){
                   	int NavID=Integer.parseInt(arrTradeList[i]);
                   	
                   	String chrCNChannels="";
                   	String chrFRChannels="";
                   	
                   	strSQLTrade="select chrCNChannels,chrFRChannels from ipr_navtable where intID="+NavID;
                   	PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
                    ResultSet rsTrade = PrePareStmtTrade.executeQuery();
                       while(rsTrade.next())
                       {
                       	chrCNChannels=rsTrade.getString("chrCNChannels")==null?"14,15,16":rsTrade.getString("chrCNChannels").trim();
                       	chrFRChannels=rsTrade.getString("chrFRChannels")==null?"18,19,20,21,22,23,24,25":rsTrade.getString("chrFRChannels").trim();
                       }
                       rsTrade.close();
                       PrePareStmtTrade.close();
                       
                       String strChannel=chrCNChannels;
                       if(!strChannel.equals("")){
                       	if(!chrFRChannels.equals("")){
                       		strChannel+=","+chrFRChannels;
                       	}                	
                       }else{
                       	strChannel=chrFRChannels;
                       }
                       
                       String[] arrCNChannel=strChannel.split(",");
                       for(int j=0;j<arrCNChannel.length;j++){
                       	String dtUpdateTime="";
                       	
                       	strSQLTrade="select dtUpdateTime from ipr_channel where intChannelID="+arrCNChannel[j];
                       	PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
                           rsTrade = PrePareStmtTrade.executeQuery();
                           while(rsTrade.next())
                           {
                           	dtUpdateTime=rsTrade.getString("dtUpdateTime");
                           }
                           rsTrade.close();
                           PrePareStmtTrade.close();
                           
                           
       					strSQLTrade="insert into ipr_user_nav(intUserID,intNavID,dtUpdateTime,intTRSTable) " +
       					       "values("+intUserID+","+NavID+",'"+dtUpdateTime+"',"+arrCNChannel[j]+")";
       					//System.out.println(strSQL);
       					PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
       					PrePareStmtTrade.executeUpdate();
       					PrePareStmtTrade.close();
                       }
                   }
                   */
  				java.text.SimpleDateFormat sformat = new java.text.SimpleDateFormat("yyyy-MM-dd");
				String dtUpdateDate = sformat.format(new java.util.Date());
/*
            	  NavTree navTree=new NavTree();
            	  navTree.getAllNavIDs(arrTradeList);
            	  String strSelNavIDs = navTree.getChrSelNavIDs();
            	  String[] arrSelNavID=strSelNavIDs.split(",");
            	  for(int i=0;i<arrSelNavID.length;i++){
					strSQLTrade="insert into ipr_user_nav(intUserID,intNavID,dtUpdateDate) " +
						"values("+intUserID+","+arrSelNavID[i]+",'"+dtUpdateDate+"')";
					//System.out.println(strSQLTrade);
					PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
					PrePareStmtTrade.executeUpdate();
					PrePareStmtTrade.close();
            	  }
*/            	  
            	  NavTree navTree=new NavTree();
            	  navTree.getAllNavIDs(arrTradeList);
            	  //String strSelNavIDs = navTree.getChrSelNavIDs();
            	  //String[] arrSelNavID=strSelNavIDs.split(",");
            	  for(int i=0;i<arrTradeList.length;i++){
    				strSQLTrade="insert into ipr_user_nav(intUserID,intNavID,dtUpdateDate) " +
    					"values("+intUserID+","+arrTradeList[i]+",'"+dtUpdateDate+"')";
    				//System.out.println(strSQLTrade);
    				PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
    				PrePareStmtTrade.executeUpdate();
    				PrePareStmtTrade.close();
            	  }
              }
              /******************************* END ***************************************/
            }
            else
            {
              if(strPassword==null||strPassword.equals(""))
              {
                strSQL="update ipr_user set chrUserName='"+strUserName+"',chrRealName='"+strRealName+"',chrPhone='"+strPhone+"',chrMobile='"+strMobile+"',chrFax='"+strFax+"',chrEmail='"+strEmail+"',chrAddress='"+strAddress+"',chrDepartment='"+strDepartment+"',intMaxLogin="+intMaxLogin+",chrAdminMemo='"+strAdminMemo+"',intCHCount=intCHCount+"+intCount_in+",intFRCount=intFRCount+"+intCount_out+",dtCurrentCardTime='"+strExpireTime+"',dtExpireTime='"+strExpireTime+"',intUserState="+intUserState+",intMaximum="+intABSTBatchCount+",intDownloadedNumber="+intDownloadedCount+",chrMerchantID='"+strMerchantID+"',chrMAC='"+strMAC+"',chrIPAdress='"+strIPAdress+"',intAdministerID="+adminID+",chrHerbal_Name='"+strHerbal_Name+"',intHerbal_DataBase="+intHerbal_Database+
		                //",chrMenu='"+chrMenu+"'"+
		              	",intAdministerState="+intAdministerState+
		        		",chrEnterpriseName='"+chrEnterpriseName+"'"+                		
		        		",intMaxSearchCount="+intMaxSearchCount+
		        		",intMaxNavCount="+intMaxNavCount+
		        		",intMaxUserCount="+intMaxUserCount+
		        		",intAnalyseState="+intAnalyseState+
		        		//",chrChannelID='"+searchgroupChannelID+"'"+
		        		//",chrItemGrant='"+itemGrant+"'"+
		        		",intUserAreaID="+intUserAreaID+
		        		",intAdminAreaID="+intAdminAreaID+
		              	" where intUserID="+intUserID;
              }
              else
              {
                strSQL="update ipr_user set chrUserName='"+strUserName+"',chrUserPass='"+strPassword+"',chrRealName='"+strRealName+"',chrPhone='"+strPhone+"',chrMobile='"+strMobile+"',chrFax='"+strFax+"',chrEmail='"+strEmail+"',chrAddress='"+strAddress+"',chrDepartment='"+strDepartment+"',intMaxLogin="+intMaxLogin+",chrAdminMemo='"+strAdminMemo+"',intCHCount=intCHCount+"+intCount_in+",intFRCount=intFRCount+"+intCount_out+",dtCurrentCardTime='"+strExpireTime+"',dtExpireTime='"+strExpireTime+"',intUserState="+intUserState+",intMaximum="+intABSTBatchCount+",intDownloadedNumber="+intDownloadedCount+",chrMerchantID='"+strMerchantID+"',chrMAC='"+strMAC+"',chrIPAdress='"+strIPAdress+"',intAdministerID="+adminID+",chrHerbal_Name='"+strHerbal_Name+"',intHerbal_DataBase="+intHerbal_Database+
		                //",chrMenu='"+chrMenu+"'"+
		              	",intAdministerState="+intAdministerState+
		        		",chrEnterpriseName='"+chrEnterpriseName+"'"+                		
		        		",intMaxSearchCount="+intMaxSearchCount+
		        		",intMaxNavCount="+intMaxNavCount+
		        		",intMaxUserCount="+intMaxUserCount+
		        		",intAnalyseState="+intAnalyseState+
		        		//",chrChannelID='"+searchgroupChannelID+"'"+
		        		//",chrItemGrant='"+itemGrant+"'"+
		        		",intUserAreaID="+intUserAreaID+
		        		",intAdminAreaID="+intAdminAreaID+
		              	" where intUserID="+intUserID;
              }
            }
            //System.out.println(strSQL);
            
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            
            //更新ipr_user_extinfo表中的信息
            strSQL = "update ipr_user_extinfo set intNumberPerPage = "+String.valueOf(intNumberPerPage) + " Where intUserID="+String.valueOf(intUserID);
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();

            return 1;
            /*
            strSQL="delete from ipr_ipaddress where chrUserName='"+userName+"'";
            PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            String ipRanges[]=Tools.splitString(strDefaultIP,";");
            for(int j=0;j<ipRanges.length;j++)
            {
              if(ipRanges[j].indexOf("-")!=-1)
              {
                beginIP=Tools.ip2long(ipRanges[j].substring(0,ipRanges[j].indexOf("-")));
                endIP=Tools.ip2long(ipRanges[j].substring(ipRanges[j].indexOf("-")+1));
              }
              else
              {
                beginIP=endIP=Tools.ip2long(ipRanges[j]);
              }
              try
              {
                if(beginIP!=-1&&endIP!=-1)
                {
                  strSQL="insert into ipr_ipaddress(chrUserName,intBeginIP,intEndIP) values('"+strUserName+"',"+beginIP+","+endIP+")";
//                  strSQL="insert into ipr_ipaddress(intUserID,intBeginIP,intEndIP) values("+intUserID+","+beginIP+","+endIP+")";
                  PrePareStmt = conn.prepareStatement(strSQL);
                  PrePareStmt.executeUpdate();
                  PrePareStmt.close();
                }
              }
              catch(SQLException e)
              {
                DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
                return -1;
              }
              
           }
            PrePareStmt.close();
            DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
            
            */
	}
	catch(SQLException e)
	{
	    return -1;
	}finally{
		try{
			rs.close();
			PrePareStmt.close();
			if(conn!=null){
				conn.close();
				conn=null;
			}
		}catch(Exception ex){}
	}
    }
    
    public void updateuser(int groupID,int[] userIDs) throws Exception
    {
        Connection conn = DBPoolAccessor.getConnection();;
        String strSQL = "update ipr_user set intGroupID="+groupID+" where intUserID="+userIDs[0];
        for(int i=1;i<userIDs.length;i++)
        {
            strSQL=strSQL+" or intUserID="+userIDs[i];
        }
        try
        {
            PreparedStatement PrePareStmt = conn.prepareStatement(strSQL);
            PrePareStmt.executeUpdate();
            PrePareStmt.close();
            DBPoolAccessor.closeAll(null, PrePareStmt, conn);
		}
		catch(SQLException e)
		{
//		    DBPoolAccessor.closeAll(null, PrePareStmt, conn);
		}finally{
			try{				
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				System.out.println(ex.toString());
			}
		}
    }
    
    int[] arrMenuID;
    String[] arrMenuName;
    
    public int[] getMenuIDs(){
    	return arrMenuID;
    }
    private void setMenuIDs(int[] arrMenuID)
    {
    	this.arrMenuID=arrMenuID;
    }
    public String[] getMenuNames(){
    	return arrMenuName;
    }
    private void setMenuNames(String[] arrMenuName)
    {
    	this.arrMenuName=arrMenuName;
    }   
    
    public String getMenuIDsByUserID(){
    	int intUserID=getUserID();
    	
    	String strMenuIDSel=null;
    	
    	Connection conn = DBPoolAccessor.getConnection();;
    	PreparedStatement PrePareStmt = null;
        ResultSet rs = null;
        try
        {
        	String strSQL="select chrMenu from ipr_user where intUserID="+intUserID;
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            
            String strMenuID="";
            while(rs.next()){
            	strMenuIDSel=rs.getString("chrMenu");
            }

            rs.close();
            PrePareStmt.close();
            conn.close();        
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
    	
    	return strMenuIDSel;
    }
    
    public String getMenuInfoByUserID() throws WASException{
    	String strUserMenu="";
    	int intUserID=getUserID();
    	Connection conn = DBPoolAccessor.getConnection();;
    	PreparedStatement PrePareStmt = null;
        ResultSet rs = null;
        try{
		    String strSQL="select chrMenu from ipr_user where intUserID="+intUserID;
	        PrePareStmt = conn.prepareStatement(strSQL);
	        rs = PrePareStmt.executeQuery();

	        while(rs.next())
	        {
	        	strUserMenu=rs.getString("chrMenu");
	        }
        }catch(SQLException ex){
        	throw new WASException(ex.getMessage());
        }
        finally{
			try{
				rs.close();
	            PrePareStmt.close();
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){}
		}
    	return strUserMenu;
    }
    
    public void getMenuInfo() throws WASException{
    	int[] arrMenuID=null;
    	String[] arrMenuName=null;
    	
    	Connection conn = DBPoolAccessor.getConnection();;
    	PreparedStatement PrePareStmt = null;
    	PreparedStatement PrePareStmtQuery = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        try
        {
        	/*
        	String strSQL="select * from ipr_user_menu";
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            
		    if(rs.last())
			{
		    	//System.out.println(rs.getRow());
		    	arrMenuID=new int[rs.getRow()];
		    	arrMenuName=new String[rs.getRow()];
			}
		    */
        	String strMenuID="";
        	String strMenuName="";
        	
        	String strSQL="select intMenuID,chrMenuName,chrMenuURL from ipr_user_menu  where intParentID=0 and intState=1 order by intMenuID";
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
//System.out.println(strSQL);
            //int i=0;
            while(rs.next())
            {
            	int intMenuID=0;
            	intMenuID=rs.getInt("intMenuID");
            	
            	//arrMenuID[i]=intMenuID;
            	//arrMenuName[i]="|─"+rs.getString("chrMenuName");
            	
            	strMenuID+=rs.getInt("intMenuID")+",";
            	strMenuName+="|─"+rs.getString("chrMenuName")+",";
            	
            	strSQL="select intMenuID,chrMenuName,chrMenuURL from ipr_user_menu where intParentID="+intMenuID+" and intState=1 order by intMenuID";
//System.out.println(strSQL);
            	PrePareStmtQuery = conn.prepareStatement(strSQL);
                rs1 = PrePareStmtQuery.executeQuery();
            	
                while(rs1.next()){
                	//i++;             	
                    //arrMenuID[i]=rs1.getInt("intMenuID");
                    //arrMenuName[i]="|　|─"+rs1.getString("chrMenuName");
                	strMenuID+=rs1.getInt("intMenuID")+",";
                	strMenuName+="|　|─"+rs1.getString("chrMenuName")+",";
//System.out.println(arrMenuName[i]);
                }
                //i++;
            }
            
            String[] arr=strMenuID.split(",");
            arrMenuID=new int[arr.length];
            for(int i=0;i<arr.length;i++){
            	arrMenuID[i]=Integer.parseInt(arr[i]);
            }
            arrMenuName=strMenuName.split(",");
            
            /*
            for(int j=0;j<arrMenuName.length;j++){
            	System.out.println(arrMenuName[j]);
            }
            */
            rs1.close();
            rs.close();
            PrePareStmt.close();
            PrePareStmtQuery.close();
            conn.close();
            
            setMenuIDs(arrMenuID);
            setMenuNames(arrMenuName);            
        }catch(SQLException ex){
        	throw new WASException(ex.getMessage());
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
    
    public String getTradeInfoSel()
    {
      return strTradeInfo;	
    }    
    private void setTradeInfoSel(String strTradeInfo)
    {
    	this.strTradeInfo=strTradeInfo;
    }
    
    String strTradeInfo="";
//根据用户ID取得用户的行业信息
    public String[] getTradeInfoByUser_XXX(){
    	int intUserID=getUserID();
    	
    	String[] arrTradeInfo=null;
    	
    	String strTradeInfo="";
    	Connection conn = DBPoolAccessor.getConnection();;
    	PreparedStatement PrePareStmt = null;
        ResultSet rs = null;
        try
        {
        	String strSQL="select intNavID from ipr_user_nav,ipr_navtable where " +
        			      "ipr_user_nav.intNavID=ipr_navtable.intID and ipr_navtable.intParentID=0 and intUserID="+intUserID;
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            
            while(rs.next())
            {
/**************把表ipr_user_nav中管理员ID和行业ID换成name*****************************/
            	/*
            	String strNavName="";
            	int intNavID=rs.getInt("intNavID");
            	
            	strSQL="select chrName from ipr_navtable where intID="+intNavID;
            	PreparedStatement PrePareStmt1= conn.prepareStatement(strSQL);
                ResultSet rs1 = PrePareStmt1.executeQuery();
            	
                while(rs1.next()){
                	strNavName=rs1.getString("chrName");
                }
                rs1.close();
                PrePareStmt1.close();
                
            	String strAdministorName="";
            	int intAdministerID= rs.getInt("intAdministerID");
            	
            	strSQL="select chrUserName from ipr_user where intUserID="+intAdministerID;
            	PreparedStatement PrePareStmt2= conn.prepareStatement(strSQL);
                ResultSet rs2 = PrePareStmt2.executeQuery();
            	
                while(rs1.next()){
                	strAdministorName=rs2.getString("chrUserName");
                }
                rs2.close();
                PrePareStmt2.close();
            	

            	strTradeInfo+=rs.getInt("intNavID")+","+rs.getInt("intAdministerID")+";"
							+strNavName
							+"__"+strAdministorName+"#";
				*/
            	//strTradeInfo+=rs.getInt("intNavID")+","+rs.getInt("intAdministerID")+"#";
            	strTradeInfo+=rs.getInt("intNavID")+"#";
            }
            setTradeInfoSel(strTradeInfo);
            if(strTradeInfo.indexOf("#")>-1){
				strTradeInfo=strTradeInfo.substring(0,strTradeInfo.length()-1);
				arrTradeInfo=strTradeInfo.split("#");
            }
            rs.close();
            PrePareStmt.close();
            conn.close();
        }catch(SQLException ex){
        	System.out.println("getTradeInfoByUser...>"+ex.toString());
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
        return arrTradeInfo;
    }
   
    public static void main(String[] args) throws Exception{
    	String aa = "5564$5563$";
    	String[] bbb = aa.split("[$]");
    	for(int i=0;i<bbb.length;i++){
    		System.out.println(bbb[i]);
    	}
    }
    
    public static String[] getEnterpriseInfo(int adminID) throws WASException{
    	String[] arrEnterpriseInfo=new String[4];
    	
    	String strSQL="select chrEnterpriseName,intMaxSearchCount,intMaxNavCount,intMaxUserCount from ipr_user where intUserID="+adminID;
//    	System.out.println("jar包：：："+strSQL);
    	Connection conn = DBPoolAccessor.getConnection();
    	PreparedStatement PrePareStmt = null;
        ResultSet rs = null;
        try
        {
        	PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();

            while(rs.next())
            {
            	arrEnterpriseInfo[0]=rs.getString("chrEnterpriseName")==null?"":rs.getString("chrEnterpriseName");
            	arrEnterpriseInfo[1]=String.valueOf(rs.getInt("intMaxSearchCount"));
            	arrEnterpriseInfo[2]=String.valueOf(rs.getInt("intMaxNavCount"));
            	arrEnterpriseInfo[3]=String.valueOf(rs.getInt("intMaxUserCount"));            	
            }
        }catch(SQLException ex){
        	throw new WASException(ex.getMessage());
        }
        finally{
			try{
				rs.close();
	            PrePareStmt.close();
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){}
		}
    	
    	return arrEnterpriseInfo;
    }
    

//根据管理员ID取得用户的行业信息
    public String[] getTradeInfoByAdmin111(boolean b_All,int intType) throws WASException{
    	int intAdminID=getUserID();
    	
    	String[] arrTradeInfo=null;
    	
    	String strAdministorName="";
    	String strSQL="";
    	Connection conn = DBPoolAccessor.getConnection();;
    	PreparedStatement PrePareStmt = null;
        ResultSet rs = null;
        
        String strSQLAdmin="";
    	PreparedStatement PrePareStmtAdmin = null;
        ResultSet rsAdmin = null;
        
        String strTradeInfo="";
        try
        {
        	if(b_All){//超级管理员
        		int intAdministerID=1;
        		strSQL="select intID,chrName,intAdministerID from ipr_navtable where intType="+intType+" and intParentID=0 order by intSequenceNum";
        		PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                /*
               	if(rs.last())
       			{
       		    	arrTradeInfo=new String[rs.getRow()];
       			}
       		    rs.beforeFirst();            
                */  
                //int i=0;
                while(rs.next())
                {
               		strAdministorName="";
                   	intAdministerID=rs.getInt("intAdministerID");
                   	
                   	strSQL="select chrUserName from ipr_user where intUserID="+intAdministerID;
                   	PreparedStatement PrePareStmtQuery = conn.prepareStatement(strSQL);
                   	ResultSet resultset = PrePareStmtQuery.executeQuery();
                    while(resultset.next()){
                       	strAdministorName=resultset.getString("chrUserName");
                    }
                   	resultset.close();
                   	PrePareStmtQuery.close();  

                   	if(!strAdministorName.equals("")){
                    	//arrTradeInfo[i]=rs.getInt("intID")+","+intAdminID+";"+rs.getString("chrName")+"__"+strAdministorName;            	
                    	//i++;
                    	//strTradeInfo+=rs.getInt("intID")+","+intAdminID+";"+rs.getString("chrName")+"__"+strAdministorName+"#";
                   		strTradeInfo+=rs.getInt("intID")+";"+rs.getString("chrName")+"__"+strAdministorName+"#";
                   	}
                }
                if(strTradeInfo.length()>1){
	                strTradeInfo=strTradeInfo.substring(0,strTradeInfo.length()-1);
	                arrTradeInfo=strTradeInfo.split("#");
                }
                return arrTradeInfo;
        	}else {

        	//普通管理员
            //strSQL="select intID,chrName,intAdministerID from ipr_navtable where intType=1 and intAdministerID="+intAdminID+" and intParentID=0";            
        	strSQL="select distinct(intID),ipr_navtable.chrName from ipr_user_nav,ipr_navtable where intType="+intType+" and ipr_navtable.intParentID=0 and " +
//        			" (ipr_user_nav.intUserID="+intAdminID+" or ipr_navtable.intAdministerID="+intAdminID+") and " +
        			"  ipr_navtable.intID=ipr_user_nav.intNavID order by intSequenceNum";
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            
		    if(rs.last())
			{
		    	//System.out.println(rs.getRow());
		    	arrTradeInfo=new String[rs.getRow()];
			}
		    rs.beforeFirst();            
            
            int i=0;
            while(rs.next())
            {
            	//strSQLAdmin="select chrUserName from ipr_user where intUserID="+rs.getInt("intID");            	
            	strSQLAdmin="select chrUserName from ipr_user,ipr_navtable where intID="+rs.getInt("intID")+" and ipr_navtable.intAdministerID=intUserID";
            	
            	PrePareStmtAdmin = conn.prepareStatement(strSQLAdmin);
                rsAdmin = PrePareStmtAdmin.executeQuery();
                if(rsAdmin.next()){
                	strAdministorName=rsAdmin.getString("chrUserName");
                }
                rsAdmin.close();
                PrePareStmtAdmin.close();
            	//arrTradeInfo[i]=rs.getInt("intID")+","+intAdminID+";"+rs.getString("chrName")+"__"+strAdministorName;            	
            	arrTradeInfo[i]=rs.getInt("intID")+";"+rs.getString("chrName")+"__"+strAdministorName;
            	i++;
            }
            rs.close();
            PrePareStmt.close();
            conn.close();
        }
        }catch(SQLException ex){
        	throw new WASException(ex.getMessage());
        }
        finally{
			try{
				rs.close();
	            PrePareStmt.close();
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){}
		}
        return arrTradeInfo;
    }
    
  //根据管理员ID取得用户的行业信息
    public String[] getAllTradeInfo(int intType) throws WASException{
    	int intAdminID=getUserID();
    	
    	String[] arrTradeInfo=null;
    	
    	String strAdministorName="";
    	String strSQL="";
    	Connection conn = DBPoolAccessor.getConnection();;
    	PreparedStatement PrePareStmt = null;
        ResultSet rs = null;
        
        String strSQLAdmin="";
    	PreparedStatement PrePareStmtAdmin = null;
        ResultSet rsAdmin = null;
        
        String strTradeInfo="";
        try
        {
        	//超级管理员
        		int intAdministerID=1;
        		strSQL="select intID,chrName,intAdministerID from ipr_navtable where intType="+intType+" and intParentID=0 order by intSequenceNum";
        		PrePareStmt = conn.prepareStatement(strSQL);
                rs = PrePareStmt.executeQuery();
                /*
               	if(rs.last())
       			{
       		    	arrTradeInfo=new String[rs.getRow()];
       			}
       		    rs.beforeFirst();            
                */  
                //int i=0;
                while(rs.next())
                {
               		strAdministorName="";
                   	intAdministerID=rs.getInt("intAdministerID");
                   	
                   	strSQL="select chrUserName from ipr_user where intUserID="+intAdministerID;
                   	PreparedStatement PrePareStmtQuery = conn.prepareStatement(strSQL);
                   	ResultSet resultset = PrePareStmtQuery.executeQuery();
                    while(resultset.next()){
                       	strAdministorName=resultset.getString("chrUserName");
                    }
                   	resultset.close();
                   	PrePareStmtQuery.close();  

                   	if(!strAdministorName.equals("")){
                    	//arrTradeInfo[i]=rs.getInt("intID")+","+intAdminID+";"+rs.getString("chrName")+"__"+strAdministorName;            	
                    	//i++;
                    	//strTradeInfo+=rs.getInt("intID")+","+intAdminID+";"+rs.getString("chrName")+"__"+strAdministorName+"#";
                   		strTradeInfo+=rs.getInt("intID")+";"+rs.getString("chrName")+"__"+strAdministorName+"#";
                   	}
                }
                if(strTradeInfo.length()>1){
	                strTradeInfo=strTradeInfo.substring(0,strTradeInfo.length()-1);
	                arrTradeInfo=strTradeInfo.split("#");
                }
        	
        }catch(SQLException ex){
        	throw new WASException(ex.getMessage());
        }
        finally{
			try{
				rs.close();
	            PrePareStmt.close();
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){}
		}
        return arrTradeInfo;
    }

    
    static String  chrAdministratorNames[];
    static int intAdministratorIDs[];
    
    public static void getAdministratorInfo() throws WASException{
    	int administratorIDs[]=null;
    	String[] administratorNames=null;
    	
    	Connection conn = DBPoolAccessor.getConnection();;
    	PreparedStatement PrePareStmt = null;
        ResultSet rs = null;
        try
        {
        	String strSQL="select intUserID,chrUserName from ipr_user where intAdministerState=1";
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            
		    if(rs.last())
			{
		    	//System.out.println(rs.getRow());
		    	administratorIDs=new int[rs.getRow()];
		    	administratorNames=new String[rs.getRow()];
			}
		    rs.beforeFirst();            
            
            int i=0;
            while(rs.next())
            {
            	administratorIDs[i]=rs.getInt("intUserID");
            	administratorNames[i]=rs.getString("chrUserName");            	
            	i++;
            }
            rs.close();
            PrePareStmt.close();
            conn.close();
        }catch(SQLException ex){
        	throw new WASException(ex.getMessage());
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
        setAdministratorIDs(administratorIDs);
        setAdministratorNames(administratorNames);
    }
    
    //在servlet.login中调用，向表ipr_user_nav_subemail加入一条数据
    //一个用户+一个内网地址对应一条记录
    public boolean Login(String UserName,String strIPAddr){
    	String strSQL="";
    	Connection conn = DBPoolAccessor.getConnection();;
    	PreparedStatement PrePareStmt = null;
    	ResultSet rs = null;

        try
        {
        	int intUserID=0;
        	strSQL="select ipr_user_subemail.chrEmail from ipr_user,ipr_user_subemail where " +
        			"ipr_user.intUserID=ipr_user_subemail.intUserID " +
        			"and ipr_user.chrUserName='"+UserName+"' and ipr_user_subemail.chrUserIP='"+strIPAddr+"'";
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            if(rs.next())
            {
				//intUserID=rs.getInt("intUserID");
				rs.close();
				PrePareStmt.close();              
            }else{
            	rs.close();
				PrePareStmt.close();
            	
            	strSQL="select ipr_user.intUserID from ipr_user where ipr_user.chrUserName='"+UserName+"'";
            	
		        PrePareStmt = conn.prepareStatement(strSQL);
		        rs = PrePareStmt.executeQuery();		        
		        
		        if(rs.next())
	            {
		        	intUserID=rs.getInt("intUserID");
		            strSQL="insert into ipr_user_subemail(intUserID,chrUserIP) VALUES ("+intUserID+",'"+strIPAddr+"')";
					PreparedStatement PrePareStmtTrade = conn.prepareStatement(strSQL);
					PrePareStmtTrade.executeUpdate();
					PrePareStmtTrade.close();
	            }
            }
			DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
        }catch(Exception ex){
        	DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
//        	ex.printStackTrace();
        }
        return true;
    }
    
    public boolean updateEmailNavIDs(int UserID,String strIPAddr,String email,String subEmailNavIDs){
    	String strSQL="";
    	Connection conn = DBPoolAccessor.getConnection();;
    	PreparedStatement PrePareStmt = null;
    	ResultSet rs = null;

        try
        {
            strSQL="update ipr_user_subemail set chrEmail='"+email+"',chrSubEmailNavIDs='"+subEmailNavIDs+"' where intUserID="+UserID+" and chrUserIP='"+strIPAddr+"'";
			PreparedStatement PrePareStmtTrade = conn.prepareStatement(strSQL);
			PrePareStmtTrade.executeUpdate();
			PrePareStmtTrade.close();
			DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
        }catch(Exception ex){
        	DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
//        	ex.printStackTrace();
        }
        return true;
    }
    
    public String getUserTradeInfoByUserID(int intUserID,int treeType) throws WASException{
//    	String[] arrUserInfo=null;
    	String userTradeInfo="";
    	
    	String strSQL = "select intUserID,chrUserName from ipr_user where intUserID="+intUserID;
    	
		Connection conn = DBPoolAccessor.getConnection();;
        PreparedStatement PrePareStmt = null;
        PreparedStatement PrePareStmtTrade = null;
        ResultSet rs = null;
        ResultSet rsTrade = null;
        try
        {
        	String str="";
            PrePareStmt = conn.prepareStatement(strSQL);
            rs = PrePareStmt.executeQuery();
            
            if(rs.next()){
            	String strTradeInfo=" ";

            	strSQL="select intNavID from ipr_user_nav,ipr_navtable where " 
            	        			+ "ipr_user_nav.intNavID=ipr_navtable.intID and "
            	        			+ "ipr_navtable.intParentID=0 and "
            	        			+ "intUserID="+rs.getInt("intUserID")+" and "
            	        			+ "ipr_navtable.intType="+treeType;
            	PrePareStmtTrade = conn.prepareStatement(strSQL);
            	rsTrade = PrePareStmtTrade.executeQuery();
            	while(rsTrade.next()){
            		strTradeInfo+=rsTrade.getInt("intNavID")+"$";
            	}
            	if(!strTradeInfo.equals(" ")){
            		strTradeInfo=strTradeInfo.trim();
            	}
            	rsTrade.close();
            	PrePareStmtTrade.close();
            	str+=rs.getInt("intUserID")+"#"+rs.getString("chrUserName")+"#"+strTradeInfo;            	
            }
            rs.close();
            PrePareStmt.close();
            if(!str.equals("")){
//            	arrUserInfo=str.split("##");
            	userTradeInfo = str;
            }
            /*
            for(int i=0;i<arrUserInfo.length;i++){
            	System.out.println(arrUserInfo[i].split("#")[0]+";"+arrUserInfo[i].split("#")[1]+";"+arrUserInfo[i].split("#")[2]);
            }
            */
            return userTradeInfo;
        }catch(SQLException ex){
        	throw new WASException(ex.getMessage());
        }finally{
			try{
				rs.close();
				PrePareStmt.close();
	            
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){}
		}
    }
    
    public int assignHangye1111111111111111(int adminID,int intUserID,String tradeInfo,int tradeType){
    	String strSQLTrade="";
    	String[] arrTradeList=tradeInfo.split(",");
    	//Connection conn = DBPoolAccessor.getConnection();
    	Connection conn = DBPoolAccessor.getConnection();
    	PreparedStatement PrePareStmtNav = null;
    	PreparedStatement PrePareStmtTrade = null;
    	ResultSet rsNav = null;
    	try{
    		/*
    		if(adminID==1){
          	  strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID;
            }else            
            {
          	  String strNav="intNavID IN (";
          	  
          	  String strSQLNav="select intID from ipr_navtable where intAdministerID="+adminID;
          	  PrePareStmtNav = conn.prepareStatement(strSQLNav);
          	  rsNav = PrePareStmtNav.executeQuery(strSQLNav);
          	  while(rsNav.next()){
          		  strNav+=rsNav.getInt("intID")+",";
          	  }
          	  PrePareStmtNav.close();
          	  
          	  if(!strNav.equals("intNavID IN (")){
          		  strNav=strNav.substring(0,strNav.length()-1)+")";
          		  
          		  strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID+" and "+strNav;
          	  }else{
          		  strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID;
          	  }
            }
            */
    		strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID + " and intNavID IN (select intID from ipr_navtable where intType="+tradeType+")";
    		
    		
            //System.out.println("@@@@@@@@@@@@@@"+strSQLTrade);
            
            PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
            PrePareStmtTrade.executeUpdate();
            PrePareStmtTrade.close();
            /**********此处代码拷贝adduser***********/
            if(arrTradeList!=null){
				java.text.SimpleDateFormat sformat = new java.text.SimpleDateFormat("yyyy-MM-dd");
				String dtUpdateDate = sformat.format(new java.util.Date());
/*
          	  NavTree navTree=new NavTree();
          	  navTree.getAllNavIDs(arrTradeList);
          	  String strSelNavIDs = navTree.getChrSelNavIDs();
          	  String[] arrSelNavID=strSelNavIDs.split(",");
          	  for(int i=0;i<arrSelNavID.length;i++){
					strSQLTrade="insert into ipr_user_nav(intUserID,intNavID,dtUpdateDate) " +
						"values("+intUserID+","+arrSelNavID[i]+",'"+dtUpdateDate+"')";
					//System.out.println(strSQLTrade);
					PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
					PrePareStmtTrade.executeUpdate();
					PrePareStmtTrade.close();
          	  }
*/
          	  NavTree navTree=new NavTree();
          	  //navTree.getAllNavIDs(arrTradeList);
          	  //String strSelNavIDs = navTree.getChrSelNavIDs();
          	  //String[] arrSelNavID=strSelNavIDs.split(",");
          	  for(int i=0;i<arrTradeList.length;i++){
					strSQLTrade="insert into ipr_user_nav(intUserID,intNavID,dtUpdateDate) " +
						"values("+intUserID+","+arrTradeList[i]+",'"+dtUpdateDate+"')";
					//System.out.println(strSQLTrade);
					PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
					PrePareStmtTrade.executeUpdate();
					PrePareStmtTrade.close();
          	  }
            }
            return 1;
    	}catch(Exception ex){
//    		ex.printStackTrace();
    		return -1;
    	}finally{
			try{
				rsNav.close();
				PrePareStmtNav.close();
				PrePareStmtTrade.close();
				
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				System.out.println();			
			}
		}
    }    
    
    public int assignTrade(int intUserID,String tradeInfo){
    	String strSQLTrade="";
    	String[] arrTradeList=tradeInfo.split(",");
    	//Connection conn = DBPoolAccessor.getConnection();
    	Connection conn = DBPoolAccessor.getConnection();
    	PreparedStatement PrePareStmtNav = null;
    	PreparedStatement PrePareStmtTrade = null;
    	ResultSet rsNav = null;
    	try{
    		/*
    		if(adminID==1){
          	  strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID;
            }else            
            {
          	  String strNav="intNavID IN (";
          	  
          	  String strSQLNav="select intID from ipr_navtable where intAdministerID="+adminID;
          	  PrePareStmtNav = conn.prepareStatement(strSQLNav);
          	  rsNav = PrePareStmtNav.executeQuery(strSQLNav);
          	  while(rsNav.next()){
          		  strNav+=rsNav.getInt("intID")+",";
          	  }
          	  PrePareStmtNav.close();
          	  
          	  if(!strNav.equals("intNavID IN (")){
          		  strNav=strNav.substring(0,strNav.length()-1)+")";          		  
          		  strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID+" and "+strNav;
          	  }else{
          		  strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID;
          	  }
            }
            */
    		strSQLTrade="delete from ipr_user_nav where intUserID="+intUserID;
    		
            //System.out.println("@@@@@@@@@@@@@@"+strSQLTrade);
            
            PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
            PrePareStmtTrade.executeUpdate();
            PrePareStmtTrade.close();
            /**********此处代码拷贝adduser***********/
            if(arrTradeList!=null){
				java.text.SimpleDateFormat sformat = new java.text.SimpleDateFormat("yyyy-MM-dd");
				String dtUpdateDate = sformat.format(new java.util.Date());
/*
          	  NavTree navTree=new NavTree();
          	  navTree.getAllNavIDs(arrTradeList);
          	  String strSelNavIDs = navTree.getChrSelNavIDs();
          	  String[] arrSelNavID=strSelNavIDs.split(",");
          	  for(int i=0;i<arrSelNavID.length;i++){
					strSQLTrade="insert into ipr_user_nav(intUserID,intNavID,dtUpdateDate) " +
						"values("+intUserID+","+arrSelNavID[i]+",'"+dtUpdateDate+"')";
					//System.out.println(strSQLTrade);
					PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
					PrePareStmtTrade.executeUpdate();
					PrePareStmtTrade.close();
          	  }
*/
          	  NavTree navTree=new NavTree();
          	  //navTree.getAllNavIDs(arrTradeList);
          	  //String strSelNavIDs = navTree.getChrSelNavIDs();
          	  //String[] arrSelNavID=strSelNavIDs.split(",");
          	  for(int i=0;i<arrTradeList.length;i++){
          		  if(arrTradeList[i]!=null&&!arrTradeList[i].trim().equals("")) {
					strSQLTrade="insert into ipr_user_nav(intUserID,intNavID,dtUpdateDate) " +
						"values("+intUserID+","+arrTradeList[i]+",'"+dtUpdateDate+"')";
					//System.out.println(strSQLTrade);
					PrePareStmtTrade = conn.prepareStatement(strSQLTrade);
					PrePareStmtTrade.executeUpdate();
					PrePareStmtTrade.close();					
          		  }					
          	  }
            }
            return 1;
    	}catch(Exception ex){
//    		ex.printStackTrace();
    		return -1;
    	}finally{
			try{
//				rsNav.close();
//				PrePareStmtNav.close();
				PrePareStmtTrade.close();
				
				if(conn!=null){
					conn.close();
					conn=null;
				}
			}catch(Exception ex){
				System.out.println();			
			}
		}
    }    

    
    public static int[] getAdministratorIDs()
    {
      return intAdministratorIDs;	
    }    
    private static void setAdministratorIDs(int[] administratorIDs)
    {
      intAdministratorIDs=administratorIDs;
    }
    public static String[] getAdministratorNames()
    {
      return chrAdministratorNames;
    }    
    private static void setAdministratorNames(String[] administratorNames)
    {
      chrAdministratorNames=administratorNames;
    }

	public int getAnalyseState() {
		return intAnalyseState;
	}

	public void setAnalyseState(int intAnalyseState) {
		this.intAnalyseState = intAnalyseState;
	}
	
	public int getAnalyseNumUpperlimit() {
		return intAnalyseNumUpperlimit;
	}

	public void setAnalyseNumUpperlimit(int intAnalyseNumUpperlimit) {
		this.intAnalyseNumUpperlimit = intAnalyseNumUpperlimit;
	}

	public String getItemGrant() {
		return chrItemGrant;
	}

	public void setItemGrant(String ItemGrant) {
		this.chrItemGrant = ItemGrant;
	}

	public int getUserAreaID() {
		return intUserAreaID;
	}

	public void setUserAreaID(int intUserAreaID) {
		this.intUserAreaID = intUserAreaID;
	}

	public int getAdminAreaID() {
		return intAdminAreaID;
	}

	public void setAdminAreaID(int intAdminAreaID) {
		this.intAdminAreaID = intAdminAreaID;
	}

	public int getIPLimit() {
		return intIPLimit;
	}

	public void setIPLimit(int intIPLimit) {
		this.intIPLimit = intIPLimit;
	}
}
