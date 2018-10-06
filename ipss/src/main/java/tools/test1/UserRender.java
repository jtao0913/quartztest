package tools.test1;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

public class UserRender {

	/**
	 * 以行为单位读取文件，常用于读面向行的格式化文件
	 */
	public static void readFileByLines(String fileName) {
		fileName = "e:\\user.txt";
		File file = new File(fileName);
		BufferedReader reader = null;
		try {
			System.out.println("以行为单位读取文件内容，一次读一整行：");
			reader = new BufferedReader(new FileReader(file));
			String tempString = null;
			int line = 1;
			// 一次读入一行，直到读入null为文件结束
			while ((tempString = reader.readLine()) != null) {
				// 显示行号
				// System.out.println("line " + line + ": " + tempString);

				System.out.println("INSERT INTO ipr_user "
						+ "(`chrUserName`, `chrUserPass`, `chrRealName`, `chrEmail`, `chrPhone`, `chrMobile`, `chrFax`, `chrDepartment`, `chrAddress`, `dtRegisterTime`, `dtCurrentCardTime`, `dtExpireTime`, `intMaxLogin`, `intCHCount`, `intFRCount`, `dtLastVisitTime`, `chrLastVisitIP`, `intUserState`, `intGroupID`, `chrAdminMemo`, `chrOnlineList`, `chrMerchantID`, `chrMAC`, `chrIPAdress`, `intAdministerID`, `intMaximum`, `chrYear`, `intDownloadedNumber`, `chrHerbal_Name`, `intHerbal_DataBase`, `chrMenu`, `intAdministerState`, `chrEnterpriseName`, `intMaxSearchCount`, `intMaxNavCount`, `intMaxUserCount`, `intAnalyseState`, `chrChannelID`, `chrItemGrant`, `intUserAreaID`, `intAdminAreaID`, `chrLastIP`, `dtLastTime`, `intIPLimit`) VALUES "
						+ "('" + tempString + "', '[7c4a8d09ca3762af61e59520943dc26494f8941b]', '" + tempString
						+ "', '', '', '', '', '', '', '2016/10/24 12:45:25', '2055/3/20 00:00:00', '2055/3/20 00:00:00', 1, 0, 0, null, '', 1, 9, '', '', '', '', '', '1', 0, '2016', , '', 0, '1000,1005,1010,1015,1020,2000,2500,6000,3500,5030,5050,15001,', 00, '', 0, 0, 0, 0, '14,15,16,17,5,6,18,19,20,21,22,23,24,25,26,27,28,29,50,51,52,53,54,55,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173', 'simplesearchleft;openphysicaldb;gaojifenxi;detailxiangsisearch;dingqiyujing;gongsidaima;quanwensearch;autoIndex;agencyhelpsearch;frchannel;openphysicaldbadmin;evaluation;daimahuaview;viewwggb;openbatchdownload;yuyisearch;senioroperator;batchsearch;agencysearch;effectlib;shixiaosearch;fenxi;ipchelpsearch;crossLanguage;huoyuezhishuyujing;daimahuadownload;detailsearchreport;lawwarn;translate;', 0, 0, '', null, 0);");

				line++;
			}
			reader.close();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e1) {
				}
			}
		}
	}

	public static void main(String[] args) {

		// File f1 = new File("D:\\other\\other_1.trs");
		// File f2 = new File("D:\\other\\xxxx.trs");
		String GB = "";// 国别
		String line = "";

		// FileOutputStream fos;
		// OutputStreamWriter osw;
		// BufferedWriter bw = null;

		try {
			FileInputStream fis = new FileInputStream("e:\\user.txt");
			InputStreamReader isr = new InputStreamReader(fis, "UTF8");
			BufferedReader br = new BufferedReader(isr);

			FileOutputStream fos = new FileOutputStream("e:\\_user.txt");
			OutputStreamWriter osw = new OutputStreamWriter(fos, "UTF8");
			BufferedWriter bw = new BufferedWriter(osw);

			String patentInfo = "";

			// FileReader reader = new FileReader(f1);
			// FileWriter writer = new FileWriter(f2);
			//
			// BufferedReader br = new BufferedReader(reader);
			// BufferedWriter bw = new BufferedWriter(writer);

			// <REC>
			int n = 100;

			while ((line = br.readLine()) != null) {
				// System.out.println(line);

				String ss = "INSERT INTO ipr_user"
						+ "(`intUserID`, `chrUserPass`, `chrRealName`, `chrEmail`, `chrPhone`, `chrMobile`, `chrFax`, `chrDepartment`, `chrAddress`, `dtRegisterTime`, `dtCurrentCardTime`, `dtExpireTime`, `intMaxLogin`, `intCHCount`, `intFRCount`, `dtLastVisitTime`, `chrLastVisitIP`, `intUserState`, `intGroupID`, `chrAdminMemo`, `chrOnlineList`, `chrMerchantID`, `chrMAC`, `chrIPAdress`, `intAdministerID`, `intMaximum`, `chrYear`, `intDownloadedNumber`, `chrHerbal_Name`, `intHerbal_DataBase`, `chrMenu`, `intAdministerState`, `chrEnterpriseName`, `intMaxSearchCount`, `intMaxNavCount`, `intMaxUserCount`, `intAnalyseState`, `chrChannelID`, `chrItemGrant`, `intUserAreaID`, `intAdminAreaID`, `chrLastIP`, `dtLastTime`, `intIPLimit`)"
						+ " VALUES " + "('" + line + "', '[7c4a8d09ca3762af61e59520943dc26494f8941b]', '" + line
						+ "', '', '', '', '', '', '', '2016/10/24 12:45:25', '2055/3/20 00:00:00', '2055/3/20 00:00:00', 1, 0, 0, '', '', 1, 9, '', '', '', '', '', '1', 0, '2016', , '', 0, '1000,1005,1010,1015,1020,2000,2500,6000,3500,5030,5050,15001,', 0, '', 0, 0, 0, 0, '14,15,16,17,5,6,18,19,20,21,22,23,24,25,26,27,28,29,50,51,52,53,54,55,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173', 'simplesearchleft;openphysicaldb;gaojifenxi;detailxiangsisearch;dingqiyujing;gongsidaima;quanwensearch;autoIndex;agencyhelpsearch;frchannel;openphysicaldbadmin;evaluation;daimahuaview;viewwggb;openbatchdownload;yuyisearch;senioroperator;batchsearch;agencysearch;effectlib;shixiaosearch;fenxi;ipchelpsearch;crossLanguage;huoyuezhishuyujing;daimahuadownload;detailsearchreport;lawwarn;translate;', 0, 0, '', '', 0);";

				ss = "INSERT INTO ipr_user"
						+ " (`intUserID`, `chrUserName`, `chrUserPass`, `chrRealName`, `dtRegisterTime`, `dtExpireTime`, `intUserState`, `intGroupID`, `chrMenu`, `intAdministerState`) VALUES "
						+ "(" + n + ",'" + line + "', '[7c4a8d09ca3762af61e59520943dc26494f8941b]', '" + line
						+ "', '2016/10/24 12:45:25', '2055/3/20 00:00:00',  1, 9, '1000,1005,1010,1015,1020,2000,2500,6000,3500,5030,5050,15001,', 0);";

				// fos = new FileOutputStream("D:\\others_\\"+GB+".trs");
				// osw = new OutputStreamWriter(fos,"GBK");
				// bw = new BufferedWriter(osw);

				bw.write(ss);
				bw.newLine();
				bw.flush();// 在后面填上这句，没这句你只是将数据写入io缓存，并没有写入文件，加上这句就可以了

				n++;
			}
			br.close();
			bw.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}

	}

}
