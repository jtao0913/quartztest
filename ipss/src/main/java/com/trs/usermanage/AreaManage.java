package com.trs.usermanage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.cnipr.cniprgz.db.DBPoolAccessor;

public class AreaManage
{
  private int rows = 0;
  private int[] areaIDs;
  private String[] areaNames;
  private String[] areaMemos;

  public int delArea(String IDs)
  {
    String strPost = "";
    String[] arrID = IDs.split(",");
    for (int i = 0; i < arrID.length; i++) {
      strPost = strPost + "intID=" + arrID[i] + " or ";
    }
    strPost = strPost.substring(0, strPost.length() - 4);

    String strSQL = "delete from ipr_area where " + strPost;

    Connection conn = DBPoolAccessor.getConnection();
    PreparedStatement PrePareStmtUpdate = null;
    try {
      PrePareStmtUpdate = conn.prepareStatement(strSQL);
      PrePareStmtUpdate.executeUpdate();
      PrePareStmtUpdate.close();
      return 1;
    }
    catch (Exception ex)
    {
      return -1;
    } finally {
      try {
        PrePareStmtUpdate.close();
        PrePareStmtUpdate.close();
        if (conn != null) {
          conn.close();
          conn = null;
        } } catch (Exception localException3) {
      }
    }
  }

  public int editArea(int areaID, String areaName, String areaMemo) {
    areaName = areaName.trim();
    areaMemo = areaMemo.trim();

    String strSQL = "select intID from ipr_area where chrName='" + areaName + "' and intID!=" + areaID;

    Connection conn = DBPoolAccessor.getConnection();
    PreparedStatement PrePareStmt = null;
    PreparedStatement PrePareStmtUpdate = null;
    ResultSet rs = null;
    try
    {
      PrePareStmt = conn.prepareStatement(strSQL);
      rs = PrePareStmt.executeQuery();

      if (rs.next()) {
        return -2;
      }
      rs.close();
      PrePareStmt.close();

      strSQL = "update ipr_area set chrName='" + areaName + "',chrMemo='" + areaMemo + "' where intID=" + areaID;

      PrePareStmtUpdate = conn.prepareStatement(strSQL);
      PrePareStmtUpdate.executeUpdate();
      PrePareStmtUpdate.close();
      return 1;
    }
    catch (Exception ex)
    {
      return -1;
    } finally {
      try {
        rs.close();
        PrePareStmt.close();
        PrePareStmtUpdate.close();
        if (conn != null) {
          conn.close();
          conn = null;
        } } catch (Exception localException4) {
      }
    }
  }

  public int addArea(String areaName, String areaMemo)
  {
    areaName = areaName.trim();
    String strSQL = "select intID from ipr_area where chrName='" + areaName + "'";

    Connection conn = DBPoolAccessor.getConnection();
    PreparedStatement PrePareStmt = null;
    PreparedStatement PrePareStmtUpdate = null;
    ResultSet rs = null;
    try
    {
      PrePareStmt = conn.prepareStatement(strSQL);
      rs = PrePareStmt.executeQuery();

      if (rs.next()) {
        return -2;
      }
      rs.close();
      PrePareStmt.close();

      int maxcodeID = 0;
      strSQL = "select max(intID) as maxcode from ipr_area";
      PrePareStmt = conn.prepareStatement(strSQL);
      rs = PrePareStmt.executeQuery();

      if (rs.next()) {
        maxcodeID = rs.getInt("maxcode") + 1;
      }
      rs.close();
      PrePareStmt.close();

      strSQL = "insert into ipr_area(intID,chrName,chrMemo) values(" + maxcodeID + ",'" + areaName + "','" + areaMemo + "')";
      PrePareStmtUpdate = conn.prepareStatement(strSQL);
      PrePareStmtUpdate.executeUpdate();
      PrePareStmtUpdate.close();
    }
    catch (SQLException localSQLException)
    {
      return -1;
    } finally {
      try {
        rs.close();
        PrePareStmt.close();

        if (conn != null) {
          conn.close();
          conn = null;
        }
      } catch (Exception ex) {
        System.out.println();
      }
    }
    try
    {
      rs.close();
      PrePareStmt.close();

      if (conn != null) {
        conn.close();
        conn = null;
      }
    } catch (Exception ex) {
      System.out.println();
    }

    return 1;
  }

  public void setMulti(String searchWord, int countPerPage, int pageNumber)
  {
    int rows = 0;
    int[] areaIDs = (int[])null;
    String[] areaNames = (String[])null;
    String[] areaMemos = (String[])null;

    Connection conn = DBPoolAccessor.getConnection();
    PreparedStatement PrePareStmt = null;
    ResultSet rs = null;
    try
    {
      String strSQL = "select count(intID) rows from ipr_area";
      searchWord = searchWord.trim();
      if (!searchWord.equals("")) {
        strSQL = strSQL + " where chrName like '%" + searchWord + "%'";
      }

      PrePareStmt = conn.prepareStatement(strSQL);
      rs = PrePareStmt.executeQuery();
      if (rs.next()) {
        this.rows = rs.getInt("rows");
      }
      rs.close();
      PrePareStmt.close();

      strSQL = "select intID,chrName,chrMemo from ipr_area";
      if (!searchWord.equals("")) {
        strSQL = strSQL + " where chrName like '%" + searchWord + "%'";
      }
      strSQL = strSQL + " limit " + (pageNumber - 1) * countPerPage + "," + countPerPage;

      PrePareStmt = conn.prepareStatement(strSQL);
      rs = PrePareStmt.executeQuery();

      if (rs.last()) {
        rows = rs.getRow();
        areaIDs = new int[rows];
        areaNames = new String[rows];
        areaMemos = new String[rows];
      }
      rs.beforeFirst();

      int i = 0;
      while (rs.next()) {
        areaIDs[i] = rs.getInt("intID");
        areaNames[i] = (rs.getString("chrName") == null ? "" : rs.getString("chrName"));
        areaMemos[i] = (rs.getString("chrMemo") == null ? "" : rs.getString("chrMemo"));
        i++;
      }
      setAreaIDs(areaIDs);
      setAreaNames(areaNames);
      setAreaMemos(areaMemos);
    }
    catch (SQLException localSQLException)
    {
      try {
        rs.close();
        PrePareStmt.close();

        if (conn != null) {
          conn.close();
          conn = null;
        }
      } catch (Exception ex) {
        System.out.println();
      }
    }
    finally
    {
      try
      {
        rs.close();
        PrePareStmt.close();

        if (conn != null) {
          conn.close();
          conn = null;
        }
      } catch (Exception ex) {
        System.out.println();
      }
    }
  }

  public static String[] getAreaInfo(int intAdminID) {
    String[] areaInfo = (String[])null;

    Connection conn = DBPoolAccessor.getConnection();
    PreparedStatement PrePareStmt = null;
    ResultSet rs = null;
    try
    {
      String strSQL = "select intID,chrName from ipr_area";
      if (intAdminID != 1)
      {
        strSQL = "select ipr_area.intID,ipr_area.chrName from ipr_area,ipr_user where ipr_user.intAdminAreaID=ipr_area.intID and ipr_user.intUserID=" + intAdminID;
      }

      String str = "";
      PrePareStmt = conn.prepareStatement(strSQL);
      rs = PrePareStmt.executeQuery();
      while (rs.next()) {
        str = str + rs.getInt("intID") + "#" + rs.getString("chrName") + "##";
      }
      if (!str.equals("")) {
        areaInfo = str.split("##");
      }
      rs.close();
      PrePareStmt.close();
      conn.close();
      String[] arrayOfString1 = areaInfo;
      return arrayOfString1;
    }
    catch (SQLException ex)
    {
      return null;
    } finally {
      try {
        rs.close();
        PrePareStmt.close();

        if (conn != null) {
          conn.close();
          conn = null;
        }
      } catch (Exception ex) {
        System.out.println();
      }
    }
    
  }

  public static void main(String[] args) {
    AreaManage area = new AreaManage();

    getAreaInfo(2);
  }

  public String[] getAreaNames() {
    return this.areaNames;
  }

  public void setAreaNames(String[] areaNames) {
    this.areaNames = areaNames;
  }

  public String[] getAreaMemos() {
    return this.areaMemos;
  }

  public void setAreaMemos(String[] areaMemos) {
    this.areaMemos = areaMemos;
  }

  public int[] getAreaIDs() {
    return this.areaIDs;
  }

  public void setAreaIDs(int[] areaIDs) {
    this.areaIDs = areaIDs;
  }

  public int getRows() {
    return this.rows;
  }
}