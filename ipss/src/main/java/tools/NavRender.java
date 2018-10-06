package tools;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import com.cnipr.cniprgz.db.DBPoolAccessor;
//import com.trs.usermanage.DBConnect;

public class NavRender
{
  public static void main(String[] args)
  {
    String navPath = "D:\\工作\\泰州\\";
    navPath = "D:\\导航表达式\\";
    
//    int i_db_CurrentNo = getDBCurrentID();
    int i_db_CurrentNo = 0;

    InputStreamReader isr = null;
    BufferedReader reader = null;

    OutputStreamWriter osw = null;
    BufferedWriter bw = null;
    try
    {
      String[] arrFile = (String[])null;
      System.out.println(arrFile);
      File dir = new File(navPath);
      if (dir.isDirectory()) {
        arrFile = dir.list();
      }

      FileOutputStream fos = null;

      for (int i = 0; i < arrFile.length; i++) {
        System.out.println("arrFile.length = " + arrFile.length);
        System.out.println("arrFile[i] = " + arrFile[i]);
        if (arrFile[i].indexOf(".txt") <= -1){
        	continue;
        }
        fos = new FileOutputStream(navPath + arrFile[i].replace(".txt", "") + ".sql");
        
        osw = new OutputStreamWriter(fos, "GBK");
        bw = new BufferedWriter(osw);

        isr = new InputStreamReader(new FileInputStream(navPath + arrFile[i]), "GBK");
        reader = new BufferedReader(isr);

        String s_NO = "";
        String s_Name = "";
        String s_CNExp = "";
        String s_FRExp = "";

        String Pid = "";
        String id = "";

        Hashtable ht = new Hashtable();
        Iterator it;
        Map.Entry me;

        String s_SQL = "";
        String temp = reader.readLine();
        while (temp != null) {
          System.out.println(temp);

          if (temp.startsWith("记录号=")) {
            s_NO = temp.substring(4);

            if (s_NO != null){
            	s_NO = s_NO.trim();
            }
            
            if ((s_NO.length() > 1) && (s_NO.contains("-"))) {
              try {
                System.out.println("s_NO=" + s_NO);
                System.out.println("s_NO.length()=" + s_NO.length());
                Pid = s_NO.substring(0, s_NO.lastIndexOf("-"));
              } catch (Exception e) {
                e.printStackTrace();
                break;
              }

              Set entry = ht.entrySet();
              it = entry.iterator();
              me = null;
            }
//            while (true) {
//              me = (Map.Entry)it.next();
//
//              if (me.getKey().equals(Pid)) {
//                Pid = (String)me.getValue();
//              }
//              else
//              {
//                if (it.hasNext()) continue; break;
//
//                Pid = "0";
//              }
//            }
            id = (i_db_CurrentNo + 1)+"";
            ht.put(s_NO, id);
          }
          if (temp.startsWith("名称=")) {
            s_Name = temp.substring(3);
            s_Name = s_Name.trim();
          }

          if (temp.startsWith("中文表达式=")) {
            s_CNExp = temp.substring(6);
            s_CNExp = s_CNExp.replace("'", "\\'");
            s_CNExp = s_CNExp.replace("-", "\\-");
            s_CNExp = s_CNExp.replace("#", "%");
            s_CNExp = s_CNExp.replace("●", "%");
            s_CNExp = s_CNExp.replace("·", "%");
            s_CNExp = s_CNExp.replace("淸", "清");

            s_CNExp = s_CNExp.trim();
          }
          if (temp.startsWith("英文表达式=")) {
            s_FRExp = temp.substring(6);
            s_FRExp = s_FRExp.replace("'", "\\'");
            s_FRExp = s_FRExp.replace("-", "\\-");
            s_CNExp = s_CNExp.replace("●", "%");
            s_CNExp = s_CNExp.replace("·", "%");
            s_CNExp = s_CNExp.replace("淸", "清");
            s_FRExp = s_FRExp.trim();

            s_SQL = s_NO + ";" + s_Name + ";" + s_CNExp + ";" + s_FRExp;

            s_SQL = "INSERT INTO `ipr_navtable` (`intID`,`chrName`,`chrExpression`,`chrFRExpression`,`intParentID`,`intType`) VALUES (" + 
              id + ",'" + s_Name + "','" + s_CNExp + "','" + s_FRExp + "'," + Pid + ",1);";

            i_db_CurrentNo++;
            bw.write(s_SQL, 0, s_SQL.length());
            bw.newLine();
            bw.newLine();
          }

          temp = reader.readLine();
        }

        bw.flush();
        bw.close();
      }

      reader.close();
      isr.close();
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
  }

  public static int getDBCurrentID()
  {
    String strSQL = "select max(intID) maxID from ipr_navtable";
    Connection conn = DBPoolAccessor.getConnection();
    int intMaxID = 0;

    PreparedStatement preparedstatement = null;
    ResultSet resultset = null;
    try
    {
      preparedstatement = conn.prepareStatement(strSQL);
      resultset = preparedstatement.executeQuery();

      while (resultset.next())
      {
        intMaxID = resultset.getInt("maxID");
      }

      resultset.close();
      preparedstatement.close();
//      DBConnect.closeConnection(conn);
      DBPoolAccessor.closeAll(resultset, preparedstatement, conn);
    }
    catch (SQLException sqlexception0)
    {
    	DBPoolAccessor.closeAll(resultset, preparedstatement, conn);
      try
      {
        resultset.close();
        preparedstatement.close();

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
        resultset.close();
        preparedstatement.close();

        if (conn != null) {
          conn.close();
          conn = null;
        }
      } catch (Exception ex) {
        System.out.println();
      }
    }
    return intMaxID;
  }
}