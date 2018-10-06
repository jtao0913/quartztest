package com.cnipr.cniprgz.commons;

/**
 * IP�������ת��
 * @author liuqi
 *
 */

public class IP2Long {
	//	��127.0.0.1 ��ʽ��IP��ַת����10������������û�н����κδ�����
	public static long ipToLong(String strIP) {
		long[] ip = new long[4];
		//���ҵ�IP��ַ�ַ���.��λ��
		int position1 = strIP.indexOf(".");
		int position2 = strIP.indexOf(".", position1 + 1);
		int position3 = strIP.indexOf(".", position2 + 1);
		//��ÿ��.֮����ַ�ת��������
		ip[0] = Long.parseLong(strIP.substring(0, position1));
		ip[1] = Long.parseLong(strIP.substring(position1 + 1, position2));
		ip[2] = Long.parseLong(strIP.substring(position2 + 1, position3));
		ip[3] = Long.parseLong(strIP.substring(position3 + 1));
		return (ip[0] << 24) + (ip[1] << 16) + (ip[2] << 8) + ip[3];
	}

	//��10����������ʽת����127.0.0.1��ʽ��IP��ַ
	public static String longToIP(long longIP) {
		StringBuffer sb = new StringBuffer("");
		//ֱ������24λ
		sb.append(String.valueOf(longIP >>> 24));
		sb.append(".");
		//����8λ��0��Ȼ������16λ
		sb.append(String.valueOf((longIP & 0x00FFFFFF) >>> 16));
		sb.append(".");
		sb.append(String.valueOf((longIP & 0x0000FFFF) >>> 8));
		sb.append(".");
		sb.append(String.valueOf(longIP & 0x000000FF));
		return sb.toString();
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
//		String ipStr = "192.168.0.1";
//		long ipLong = IP2Long.ipToLong(ipStr);
	}

}
