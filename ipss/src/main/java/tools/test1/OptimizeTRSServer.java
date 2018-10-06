package tools.test1;
import com.trs.client.TRSConnection;
import com.trs.client.TRSDataBase;
import com.trs.client.TRSException;


public class OptimizeTRSServer {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		TRSConnection conn = null;
		try {
			conn = new TRSConnection();
			conn.connect("127.0.0.1", "8888",
					"system", "QU89m1Knv2307XzA5");
			TRSDataBase[] db = conn.getDataBases("*patent");
			for (TRSDataBase dataBase : db) {
//				System.out.println("正在优化.... "+dataBase);
//				dataBase.optimize("", null);
				
				System.out.println("正在验证索引.... "+dataBase);
				dataBase.validateIndex("");
			}
			System.out.println("优化完成");
		} catch (TRSException e) {
//			System.out.println("ErrorCode: " +serverInfos.getHost() + e.getErrorCode());
			System.out.println("ErrorString: 错误编号:"+ e.getErrorString());
		} finally {
			if (conn != null)
				conn.close();
			conn = null;
		}

	}

}
