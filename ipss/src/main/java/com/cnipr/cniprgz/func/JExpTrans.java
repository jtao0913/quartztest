package com.cnipr.cniprgz.func;

import com.sun.jna.Library;
import com.sun.jna.Native;
import com.sun.jna.WString;

/**
 * @author renlm
 * TRS表达式中英转换JNA接口
 */
public class JExpTrans
{
	// TRS表达式中英转换JNA接口对象
	private static JExpTrans objExpTrans = new JExpTrans();
	
	/**
	 * 构造
	 */
	private JExpTrans()
	{
		CLibrary.hInst.StartExpTransferServer( null );
	}
	
	/**
	 * 功能：获取TRS表达式中英转换JNA接口对象
	 * 输入：无
	 * 输出：TRS表达式中英转换JNA接口对象
	 */
	public static JExpTrans getJExpTrans() 
	{
		return objExpTrans;
	}
	
	public static CLibrary getCLibrary() 
	{
		return CLibrary.hInst;
	}
	
	public interface CLibrary extends Library 
	{
		// TRS表达式中英转换动态库实例
        CLibrary hInst = (CLibrary)Native.loadLibrary( "ExpTransfer", CLibrary.class );

		/**
		 *	功能描述：TRS表达式中英转换服务启动
		 *	参数描述：
		 *		[in] wsPath:词典路径
		 *	返回值描述：
		 *		无
		 */
        void StartExpTransferServer( WString wsPath );
        
        /**
		 *	功能描述：TRS表达式中英转换服务停止
		 *	参数描述：
		 *		无
		 *	返回值描述：
		 *		无
		 */
        public void StopExpTransferServer();
        
        /**
         *	功能描述：翻译指定的检索式子
         *	参数描述：
         *		[in] wsExp：要翻译的检索式子
         * 		[in] nCntoEn：翻译方向(true表示中到英，false表示英到中)
         *		[in] nNeedMT：是否借助机器翻译(true表示当同义词典找不到翻译时，借助机器翻译，false表示不借助机器翻译，直接输出原词语)
         * 		[in] nOptimumTerm：是否优化术语翻译词源(true表示优先从术语词典获取可以组合的翻译，false表示只从同义词典寻找翻译)
         * 		[in] nMorphologic：是否对英文词形变化，如复数变形(true表示同时输出英文词语原形和变形，false表示仅仅输出原形)
         *	返回值描述：
         *		翻译后的检索式子；当语法合法，则返回翻译后的字符串；如果语法不合法，则返回空字符串
         */
        public WString TranslateExpression( WString wsExp, int nCntoEn, int nNeedMT, int nOptimumTerm, int nMorphologic );
    }

    public static void main(String[] args) 
    {
    	JExpTrans obj = JExpTrans.getJExpTrans();
    	CLibrary hInst = obj.getCLibrary();
        WString wsRes = hInst.TranslateExpression( new WString("名称=(计算机 or car or 化工)"), 1, 0, 0, 1 );
        System.out.println(wsRes);
        JExpTrans obj1 = JExpTrans.getJExpTrans();
    	CLibrary hInst1 = obj1.getCLibrary();
        WString wsRes1 = hInst1.TranslateExpression( new WString("名称=(计算机 or car or 化工)"), 1, 0, 0, 1 );
        System.out.println(wsRes1);

    }
}
