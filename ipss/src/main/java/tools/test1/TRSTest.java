package tools.test1;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.corebiz.search.entity.PatentInfo;
import com.trs.client.RecordReport;
import com.trs.client.TRSConnection;
import com.trs.client.TRSDataBase;
import com.trs.client.TRSException;

public class TRSTest {
	/**
	 * @param args
	 */
	public static void main(String[] args) {
        TRSConnection conn = null;
        try
        {
        	conn = new TRSConnection();
            conn.connect("localhost", "8888", "system", "QU89m1Knv2307XzA5");         
            
    		String path = "D:\\others_";
    		File file = new File(path);
    		
    		String[] tempList = file.list();
    		for (int i = 0; i < tempList.length; i++) {
    			File nationfile = new File(tempList[i]);
    			System.out.println(nationfile.getPath());
    			
    			String nation = nationfile.getName().substring(0, 2);
    			
    			TRSDataBase db = new TRSDataBase(conn, nation.toLowerCase()+"patent");
                db.create("otherpatent_.*");
                
//                RecordReport report_createtable = db.loadRecords(path + "\\" + nationfile.getPath(), null, false);
//                System.out.println(report_createtable.lSuccessNum);
                
                RecordReport report_copyrecord = db.copyRecords("otherpatent","SYSTEM","","公开（公告）号="+nation.toUpperCase()+"%","",true);//复制数据库记录。
                System.out.println(report_copyrecord.lSuccessNum);
    		}   
        }
        catch (TRSException e)
        {
        	System.out.println("ErrorCode: " + e.getErrorCode());
            System.out.println("ErrorString: " + e.getErrorString());
        }
        finally
        {
        	if (conn != null) conn.close();
            conn = null;
        }
	}
	
	public static boolean addChannel(int intChannelID,String chrChannelName,String chrTRSTable) {
		boolean result = false;

		Connection conn = null;
		PreparedStatement ps = null;

		try {
			java.text.SimpleDateFormat sformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String time = sformat.format(new java.util.Date());

			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("insert into ipr_channel(intChannelID,chrChannelName,intChannelType,chrTRSTable,intEnable) values (?,?,?,?,?)");
			ps.setInt(1, intChannelID);
			ps.setString(2, chrChannelName);
			ps.setInt(3, 1);
			ps.setString(4, chrTRSTable);
			ps.setInt(5, 1);

			int rs = ps.executeUpdate();
			if (rs == 1) {
				result = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	public static void main2(String[] args) {
		String path = "D:\\others_";
		File file = new File(path);
		
		String path_pic = "D:\\others_pic";
		File file_pic = new File(path_pic);
		String[] tempList_pic = file_pic.list();
		
		int intChannelID = 100;
		String chrChannelName = "";
		
		String[] tempList = file.list();
		for (int i = 0; i < tempList.length; i++) {
			String nation = tempList[i].substring(0, 2).toLowerCase();
			
			for (int n = 0; n < tempList_pic.length; n++) {
				if(tempList_pic[n].toLowerCase().startsWith(nation)){
					chrChannelName = tempList_pic[n].substring(2).replace(".png", "");
					break;
				}
			}
			addChannel(intChannelID, chrChannelName, nation+"patent");
			intChannelID++;
		}
	}
}
