//package com.cnipph.ipc;
//
//import java.util.ArrayList;
//
//import org.apache.commons.logging.Log;
//import org.apache.commons.logging.LogFactory;
//
//import com.cnipph.db.TrsBaseDAO;
//import com.cnipph.util.Util;
//import com.eprobiti.trs.TRSConstant;
//import com.eprobiti.trs.TRSException;
//import com.eprobiti.trs.TRSResultSet;
//
///**
// * @author Liuc IPC分类DAO
// */
//public class IpcDAO extends TrsBaseDAO {
//
//	/**
//	 * 跟踪日志
//	 */
//	private static final Log logger = LogFactory.getLog(IpcDAO.class);
//
//	/**
//	 * 检索IPC分类
//	 * 
//	 * @param expression
//	 * @param db
//	 * @return ipcList
//	 * @throws TRSException
//	 */
//	public ArrayList queryIpcFromTRS(String expression, String db) throws TRSException {
////System.out.println(expression);
//		
//		TRSResultSet rs = null;
//		ArrayList ipcList = new ArrayList();
//		try {
//			logger.debug("[TRS]" + expression);
//			rs = pTrsConn.executeSelect(db, expression, "分类号", "", "", TRSConstant.TCM_IDEOSINGLE, TRSConstant.TCE_OFFSET, false);
//			while (rs.moveNext()) {
//				IpcVO ipcVO = new IpcVO();
//				ipcVO.setCode(Util.trimString(rs.getString("分类号")));
//				ipcVO.setLabel(Util.trimString(rs.getString("中文注释", "red")));
//				ipcVO.setNode(Util.trimString(rs.getString("分类号位置")));
//				ipcVO.setParent(Util.trimString(rs.getString("父节点分类号")));
//				ipcVO.setLeaf(Util.trimString(rs.getString("叶")));
//				ipcList.add(ipcVO);
//			}
//		} catch (TRSException trse) {
//			logger.error(trse.getMessage(), trse);
//			throw trse;
//		} finally {
//			this.cleanup(rs);
//		}
//		return ipcList;
//	}
//
//	/**
//	 * 检索命中数
//	 * 
//	 * @param expression
//	 * @param db
//	 * @return count
//	 * @throws TRSException
//	 */
//	public String queryCountFromTRS(String expression, String db) throws TRSException {
//		String count = null;
//		TRSResultSet rs = null;
//		try {
//			pTrsConn.setAutoExtend("", "", "", 0);
//			logger.debug("[TRS]" + expression);
//			rs = pTrsConn.executeSelect(db, expression, null, "", "", TRSConstant.TCM_IDEOSINGLE, TRSConstant.TCE_NOTHIT, false);
//			count = String.valueOf(rs.getRecordCount());
//		} catch (TRSException trse) {
//			logger.error(trse.getMessage(), trse);
//			throw trse;
//		} finally {
//			this.cleanup(rs);
//		}
//		return count;
//	}
//
//	/**
//	 * 取得LicenceCode
//	 * 
//	 * @return licenceCode
//	 * @throws TRSException
//	 */
//	public String getLicenceCodeFromTRS() throws TRSException {
//		String licenceCode = null;
//		try {
//			licenceCode = pTrsConn.getLicenceCode();
//		} catch (TRSException trse) {
//			logger.error(trse.getMessage(), trse);
//			throw trse;
//		}
//		return licenceCode;
//	}
//}