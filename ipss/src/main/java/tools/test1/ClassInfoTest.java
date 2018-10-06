package tools.test1;

import com.trs.client.ClassInfo;
import com.trs.client.TRSConnection;
import com.trs.client.TRSException;
import com.trs.client.TRSResultSet;

public class ClassInfoTest {

	public static void main(String[] args) {
        TRSConnection conn = null;
        TRSResultSet  rs   = null;
        try
        {
        	conn = new TRSConnection();
            conn.connect("127.0.0.1", "8888", "system", "QU89m1Knv2307XzA5");
            
            rs = conn.executeSelect("otherpatent_", "名称=vehicle", false);
            int iClassNum = rs.classResult("申请国代码", "", 0, "", true, false);
            System.out.println("分类的结果数为:" + iClassNum);
            
            for (int i = 0; i < iClassNum; i++)
            {
            	ClassInfo classInfo = rs.getClassInfo(i);
//              System.out.println("类别" + i + "的分类字段值为:" + classInfo.strValue);
//              System.out.println("类别" + i + "的总记录数为:" + classInfo.iRecordNum);
//              System.out.println("类别" + i + "的有效记录数为:" + classInfo.iValidNum);
                
                System.out.println(classInfo.strValue + "	" + classInfo.iRecordNum);
            }
        }
        catch (TRSException e)
        {
                System.out.println("ErrorCode: " + e.getErrorCode());
                System.out.println("ErrorString: " + e.getErrorString());
        }
        finally
        {
                if (rs != null) rs.close();
                if (conn != null) conn.close();
                rs = null;
                conn = null;
        }
 
	}

}
