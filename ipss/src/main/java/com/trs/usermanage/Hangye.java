package com.trs.usermanage;

import com.trs.Tools;
import com.trs.was.WASException;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import com.cnipr.cniprgz.db.DBPoolAccessor;

public class Hangye
{
  String strPath = "";

  private static Connection connection = null;

  private String chrName = "";
  private int intSequenceNum = 0;
  private String chrExpression = "";
  private String chrFRExpression = "";
  private String chrMemo = "";

  private String chrCNChannels = "";
  private String chrFRChannels = "";

  public String getPath(int id, int intAdministerID, int intType)
    throws WASException
  {
    //Connection conn = null;
    Connection conn = DBPoolAccessor.getConnection();
    PreparedStatement PrePareStmt = null;
    ResultSet rs = null;
    try
    {
     // conn = DBConnect.getConnection();
      String strSQL = "select chrName,intParentID from ipr_navtable where intAdministerID=" + 
        intAdministerID + " and intType=" + intType + " and intID=" + id;
      PrePareStmt = conn.prepareStatement(strSQL);
      rs = PrePareStmt.executeQuery();

      while (rs.next()) {
        int intID = rs.getInt("intParentID");
        if (intID == 0) {
          this.strPath = 
            (new StringBuilder("<a href=\"list.jsp?parentid=").append(id)
            .append("&intType=").append(intType).append("\" onClick=\"flushmainfr()\">")
            .append(rs.getString("chrName")).append("</a>").toString() + 
            this.strPath);
          String str1 = this.strPath;
          return str1;
        }
        this.strPath = 
          (getPath(intID, intAdministerID, intType) + " \\ " + 
          new StringBuilder("<a href=\"list.jsp?parentid=").append(id)
          .append("&intType=").append(intType).append("\" onClick=\"flushmainfr()\">")
          .append(rs.getString("chrName")).append("</a>").toString());
      }

      rs.close();
    }
    catch (Exception ex)
    {
      throw new WASException(ex.getMessage());
    } finally {
      try {
        rs.close();
        PrePareStmt.close();
        if (!conn.isClosed())
        //  DBConnect.closeConnection(conn);
        DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
      }
      catch (Exception e) {
        System.out.println("Hangye--getPath--->" + e.toString());
      }
    }
    try
    {
      rs.close();
      PrePareStmt.close();
      if (!conn.isClosed())
        DBConnect.closeConnection(conn);
    }
    catch (Exception e) {
      System.out.println("Hangye--getPath--->" + e.toString());
    }

    return this.strPath;
  }

  public String getPath(int id, int intType)
		    throws WASException
		  {
		    //Connection conn = null;
		    Connection conn = DBPoolAccessor.getConnection();
		    PreparedStatement PrePareStmt = null;
		    ResultSet rs = null;
		    try
		    {
		     // conn = DBConnect.getConnection();
		      String strSQL = "select chrName,intParentID from ipr_navtable where intType=" + intType + " and intID=" + id;
		      PrePareStmt = conn.prepareStatement(strSQL);
		      rs = PrePareStmt.executeQuery();

		      while (rs.next()) {
		        int intID = rs.getInt("intParentID");
		        if (intID == 0) {
/*		          this.strPath = 
		            (new StringBuilder("<a href=\"list.jsp?parentid=").append(id)
		            .append("&intType=").append(intType).append("\" onClick=\"flushmainfr()\">")
		            .append(rs.getString("chrName")).append("</a>").toString() + 
		            this.strPath);*/
			      this.strPath = 
					            (new StringBuilder("").append(id)
					            .append("@@").append(intType).append("@@")
					            .append(rs.getString("chrName")).toString() + 
					            this.strPath);
		        	
		          String str1 = this.strPath;
		          return str1;
		        }
/*		        this.strPath = 
		          (getPath(intID, intType) + " \\ " + 
		          new StringBuilder("<a href=\"list.jsp?parentid=").append(id)
		          .append("&intType=").append(intType).append("\" onClick=\"flushmainfr()\">")
		          .append(rs.getString("chrName")).append("</a>").toString());*/
		        this.strPath = 
				          (getPath(intID, intType) + " \\ " + 
				        		  new StringBuilder("").append(id)
						            .append("@@").append(intType).append("@@")
						            .append(rs.getString("chrName")).toString());
		        
		        
		      }

		      rs.close();
		    }
		    catch (Exception ex)
		    {
		      throw new WASException(ex.getMessage());
		    } finally {
		      try {
		        rs.close();
		        PrePareStmt.close();
		        if (!conn.isClosed())
		        //  DBConnect.closeConnection(conn);
		        DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
		      }
		      catch (Exception e) {
		        System.out.println("Hangye--getPath--->" + e.toString());
		      }
		    }
		    try
		    {
		      rs.close();
		      PrePareStmt.close();
		      if (!conn.isClosed())
		        DBConnect.closeConnection(conn);
		    }
		    catch (Exception e) {
		      System.out.println("Hangye--getPath--->" + e.toString());
		    }

		    return this.strPath;
		  }
  
  public static void main(String[] args) throws Exception {
    Hangye hangye = new Hangye();
  }

  public String[] getTradeList(int intParentID, int intAdministerID, int intType) throws WASException
  {
    //Connection conn = null;
	Connection conn = DBPoolAccessor.getConnection();
    PreparedStatement PrePareStmt = null;
    ResultSet rs = null;
    String[] arrTradeInfo = (String[])null;
    try
    {
      //conn = DBConnect.getConnection();
      String strSQL = "select chrName,intID,intSequenceNum,chrCNChannels,chrFRChannels from ipr_navtable where intAdministerID=" + 
        intAdministerID + " and intType=" + intType + " and intParentID=" + intParentID + " order by intSequenceNum";
//      System.out.println("专题库导航列表：" + strSQL);
      PrePareStmt = conn.prepareStatement(strSQL);
      rs = PrePareStmt.executeQuery();

      if (rs.last()) {
        arrTradeInfo = new String[rs.getRow()];
      }
      rs.beforeFirst();

      int i = 0;
      while (rs.next()) {
        arrTradeInfo[i] = 
          (rs.getInt("intID") + "," + 
          rs.getString("chrName") + "," + 
          rs.getInt("intSequenceNum") + ",");
        i++;
      }
    }
    catch (Exception ex) {
      throw new WASException(ex.getMessage());
    } finally {
      try {
        rs.close();
        PrePareStmt.close();
        if (!conn.isClosed())
         // DBConnect.closeConnection(conn);
        DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
      }
      catch (Exception localException1) {
      }
    }
    return arrTradeInfo;
  }

  private int[] getTRSTable(String chrExpression, String chrFRExpression, String chrCNChannels, String chrFRChannels)
    throws WASException
  {
    int[] arr = (int[])null;
    try
    {
      String strChannels = "";

      strChannels = strChannels + chrCNChannels + ",";
      strChannels = strChannels + chrFRChannels;

      if (!strChannels.equals("")) {
        String[] arrTRSTable = strChannels.split(",");
        arr = new int[arrTRSTable.length];
        for (int i = 0; i < arrTRSTable.length; i++) {
          arr[i] = Integer.parseInt(arrTRSTable[i]);
        }

      }
    }
    catch (Exception ex)
    {
      throw new WASException(ex.getMessage());
    }
    return arr;
  }

  public int insertInfo(int intParentID, int intSequenceNum, String chrName, String chrMemo, String chrExpression, String chrFRExpression, String chrCNChannels, String chrFRChannels, int intAdministerID, String intType) throws WASException
  {
   // Connection conn = null;
	Connection conn = DBPoolAccessor.getConnection();
    PreparedStatement PrePareStmtUpdate = null;
    PreparedStatement PrePareStmtQuery = null;
    ResultSet rs = null;
    
    chrExpression = chrExpression==null?"":chrExpression;
    chrFRExpression = chrFRExpression==null?"":chrFRExpression;
    
    chrCNChannels = chrCNChannels==null?"":chrCNChannels;
    chrFRChannels = chrFRChannels==null?"":chrFRChannels;
    
    chrMemo = chrMemo==null?"":chrMemo;    
    
    try
    {
//      conn = DBConnect.getConnection();

      int maxcodeID = 0;
      String strSQL = "";
      strSQL = "select max(intID) maxcode from ipr_navtable";
      PrePareStmtQuery = conn.prepareStatement(strSQL);
      rs = PrePareStmtQuery.executeQuery();

      while (rs.next())
      {
        maxcodeID = rs.getInt("maxcode") + 1;
      }
      PrePareStmtQuery.close();
      if ((intType == null) || (intType.equals(""))) {
        intType = "1";
      }
      strSQL = "insert into ipr_navtable(intID,intSequenceNum,chrName,chrExpression,chrFRExpression,intParentID,intType,chrMemo,chrCNChannels,chrFRChannels,intAdministerID) values(" + 
        maxcodeID + 
        "," + 
        intSequenceNum + 
        ",'" + 
        chrName.trim() + 
        "','" + 
        chrExpression.trim() + 
        "','" + 
        chrFRExpression.trim() + 
        "'," + 
        intParentID + 
        "," + 
        intType + ",'" + 
        chrMemo.trim() + 
        "','" + 
        chrCNChannels + 
        "','" + 
        chrFRChannels + "'," + intAdministerID + ")";

//      Tools.writelog(strSQL);

      PrePareStmtUpdate = conn.prepareStatement(strSQL);
      PrePareStmtUpdate.executeUpdate();
      PrePareStmtUpdate.close();

//      if (intParentID > 0) {
//        return 1;
//      }
      
      return 1;
    } catch (SQLException ex) {
      ex.printStackTrace();
      return -1;
    } catch (Exception ex) {
      ex.printStackTrace();
      return -1;
    } finally {
      try {
        rs.close();
        PrePareStmtUpdate.close();
        PrePareStmtQuery.close();
        if (!conn.isClosed())
         // DBConnect.closeConnection(conn);
        DBPoolAccessor.closeAll(rs, PrePareStmtUpdate, conn);
        DBPoolAccessor.closeAll(rs, PrePareStmtQuery, conn);
      }
      catch (Exception ex) {
        ex.printStackTrace();
      }
    }
    
  }

  public int editInfo(int intID, int intSequenceNum, String chrName, String chrMemo, String chrExpression, String chrFRExpression, String chrCNChannels, String chrFRChannels, int intAdministerID)
    throws WASException
  {
    //Connection conn = null;
	  Connection conn = DBPoolAccessor.getConnection();
    PreparedStatement PrePareStmtQuery = null;
    PreparedStatement PrePareStmtUpdate = null;
    ResultSet rs = null;
    try
    {
      //conn = DBConnect.getConnection();

      String strSQL = "update ipr_navtable set intSequenceNum=" + 
        intSequenceNum + "," + " chrName='" + chrName.trim() + 
        "'," + "chrExpression='" + chrExpression.trim() + "'," + 
        "chrFRExpression='" + chrFRExpression.trim() + "'," + 
        "chrMemo='" + chrMemo.trim() + "'," + "chrCNChannels='" + 
        chrCNChannels + "'," + "chrFRChannels='" + chrFRChannels + 
        "' " + "where intAdministerID=" + intAdministerID + 
        " and intID=" + intID;

      PrePareStmtUpdate = conn.prepareStatement(strSQL);
      PrePareStmtUpdate.executeUpdate();
      PrePareStmtUpdate.close();

      strSQL = "select intParentID from ipr_navtable where intAdministerID=" + 
        intAdministerID + " and intID=" + intID;
      PrePareStmtQuery = conn.prepareStatement(strSQL);
      rs = PrePareStmtQuery.executeQuery();
      int intParentID = 0;
      while (rs.next()) {
        intParentID = rs.getInt("intParentID");
      }
      if (intParentID > 0) {
        return 1;
      }
      rs.close();
      PrePareStmtQuery.close();

      int[] arrTRSTable = getTRSTable(chrExpression, chrFRExpression, 
        chrCNChannels, chrFRChannels);

      strSQL = "delete from ipr_user_nav where intNavID=" + intID;

      PrePareStmtUpdate = conn.prepareStatement(strSQL);
      PrePareStmtUpdate.executeUpdate();
      PrePareStmtUpdate.close();
      return 1;
    }
    catch (SQLException ex)
    {
      return -1;
    } finally {
      try {
        PrePareStmtUpdate.close();
        if (!conn.isClosed())
      //    DBConnect.closeConnection(conn);
        DBPoolAccessor.closeAll(rs, PrePareStmtUpdate, conn);
        DBPoolAccessor.closeAll(rs, PrePareStmtQuery, conn);
      }
      catch (Exception e) {
        System.out.println("Hangye....editInfo....>" + e.toString());
      }
    }
   
  }

  public void getInfo(int intID, int intAdministerID) throws WASException {
    String chrName = "";
    int intSequenceNum = 0;
    String chrExpression = "";
    String chrFRExpression = "";
    String chrMemo = "";

    String chrCNChannels = "";
    String chrFRChannels = "";

   // Connection conn = null;
    Connection conn = DBPoolAccessor.getConnection();
    PreparedStatement PrePareStmt = null;
    ResultSet rs = null;
    try {
      //conn = DBConnect.getConnection();
      String strSQL = "select * from ipr_navtable where intID = " + intID;
      PrePareStmt = conn.prepareStatement(strSQL);
      rs = PrePareStmt.executeQuery();

      while (rs.next()) {
        chrName = rs.getString("chrName");
        chrName = chrName == null ? "" : chrName;

        intSequenceNum = rs.getInt("intSequenceNum");

        chrExpression = rs.getString("chrExpression");
        chrExpression = chrExpression == null ? "" : chrExpression;

        chrFRExpression = rs.getString("chrFRExpression");
        chrFRExpression = chrFRExpression == null ? "" : 
          chrFRExpression;

        chrMemo = rs.getString("chrMemo");
        chrMemo = chrMemo == null ? "" : chrMemo;

        chrCNChannels = rs.getString("chrCNChannels");
        chrCNChannels = chrCNChannels == null ? "" : chrCNChannels;

        chrFRChannels = rs.getString("chrFRChannels");
        chrFRChannels = chrFRChannels == null ? "" : chrFRChannels;
      }
      setName(chrName);
      setIntSequenceNum(intSequenceNum);
      setchrExpression(chrExpression);
      setchrFRExpression(chrFRExpression);
      setchrMemo(chrMemo);
      setCNChannels(chrCNChannels);
      setFRChannels(chrFRChannels);
    }
    catch (Exception ex) {
      throw new WASException(ex.getMessage());
    } finally {
      try {
        rs.close();
        PrePareStmt.close();
        if (!conn.isClosed())
        //  DBConnect.closeConnection(conn);
        DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
      }
      catch (Exception e) {
        System.out.println("Hangye....getInfo....>" + e.toString());
      }
    }
  }

  public boolean has_child(int parentid, int intAdministerID) throws WASException
  {
    //Connection conn = null;
	  Connection conn = DBPoolAccessor.getConnection();
    PreparedStatement PrePareStmt = null;
    ResultSet rs = null;
    boolean bflag = false;
    try {
      //conn = DBConnect.getConnection();
      String strSQL = "select * from ipr_navtable where intAdministerID=" + 
        intAdministerID + " and intParentID=" + parentid;
      PrePareStmt = conn.prepareStatement(strSQL);
      rs = PrePareStmt.executeQuery();

      bflag = rs.next();
    }
    catch (Exception ex) {
      throw new WASException(ex.getMessage());
    } finally {
      try {
        rs.close();
        PrePareStmt.close();
        if (!conn.isClosed())
       //   DBConnect.closeConnection(conn);
        DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
      }
      catch (Exception e) {
        System.out.println("Hangye....has_child....>" + e.toString());
      }
    }

    return bflag;
  }

  public void deleteAll(int intID, int intAdministerID) throws WASException {
    //Connection conn = null;
	  Connection conn = DBPoolAccessor.getConnection();
    PreparedStatement PrePareStmtUpdate = null;
    PreparedStatement PrePareStmtQuery = null;
    ResultSet rs = null;
    try
    {
     // conn = DBConnect.getConnection();
      String strSQL = "";
      strSQL = "delete from ipr_navtable where intID=" + intID;
      PrePareStmtUpdate = conn.prepareStatement(strSQL);
      PrePareStmtUpdate.executeUpdate();

      strSQL = "select intParentID from ipr_navtable where intID=" + 
        intID;
      PrePareStmtQuery = conn.prepareStatement(strSQL);
      rs = PrePareStmtQuery.executeQuery();
      int intParentID = 0;
      while (rs.next()) {
        intParentID = rs.getInt("intParentID");
      }
      rs.close();
      PrePareStmtQuery.close();

      if (intParentID == 0) {
        strSQL = "delete from ipr_user_nav where intNavID=" + intID;

        PrePareStmtUpdate = conn.prepareStatement(strSQL);
        PrePareStmtUpdate.executeUpdate();
        PrePareStmtUpdate.close();
      }

      boolean bflag = has_child(intID, intAdministerID);
      if (bflag) {
        strSQL = "select * from ipr_navtable where intAdministerID=" + 
          intAdministerID + " and intParentID=" + intID;

        PrePareStmtQuery = conn.prepareStatement(strSQL);
        rs = PrePareStmtQuery.executeQuery();

        while (rs.next()) {
          int intChildID = rs.getInt("intID");

          deleteAll(intChildID, intAdministerID);
        }
      }
    }
    catch (Exception ex) {
      throw new WASException(ex.getMessage());
    } finally {
      try {
        rs.close();
        PrePareStmtUpdate.close();
        PrePareStmtQuery.close();
        if (!conn.isClosed())
//          DBConnect.closeConnection(conn);
        	DBPoolAccessor.closeAll(rs, PrePareStmtUpdate, conn);
        	DBPoolAccessor.closeAll(rs, PrePareStmtQuery, conn);
      }
      catch (Exception e) {
        System.out.println("Hangye....deleteAll....>" + e.toString());
      }
    }
  }

  private void setName(String name) {
    this.chrName = name;
  }

  private void setchrExpression(String Expression) {
    this.chrExpression = Expression;
  }

  private void setchrFRExpression(String FRExpression) {
    this.chrFRExpression = FRExpression;
  }

  private void setchrMemo(String Memo) {
    this.chrMemo = Memo;
  }

  private void setCNChannels(String CNChannels) {
    this.chrCNChannels = CNChannels;
  }

  private void setFRChannels(String FRChannels) {
    this.chrFRChannels = FRChannels;
  }

  public String getName() {
    return this.chrName;
  }

  public String getchrExpression() {
    return this.chrExpression;
  }

  public String getchrFRExpression() {
    return this.chrFRExpression;
  }

  public String getchrMemo() {
    return this.chrMemo;
  }

  public String getCNChannels() {
    return this.chrCNChannels;
  }

  public String getFRChannels() {
    return this.chrFRChannels;
  }

  public int getIntSequenceNum() {
    return this.intSequenceNum;
  }

  public void setIntSequenceNum(int intSequenceNum) {
    this.intSequenceNum = intSequenceNum;
  }
}