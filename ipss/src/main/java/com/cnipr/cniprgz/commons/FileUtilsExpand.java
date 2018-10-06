package com.cnipr.cniprgz.commons;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipOutputStream;

import org.apache.commons.io.FileUtils;

public class FileUtilsExpand extends FileUtils {

	/**
	 * 
	 * @param inputFileName
	 *            被压缩的文件夹
	 * @param outFileZipName
	 *            压缩后的文件夹.zip
	 * @return
	 * @throws Exception
	 */
	public static String zip(String inputFileName, String outFileZipName)
			throws Exception {
//		System.out.println("要压缩的文件夹路径"+inputFileName);
		zip(outFileZipName, new File(inputFileName));
		return outFileZipName;
	}

	/**
	 * 
	 * @param zipFileName
	 *            压缩后的文件路径
	 * @param inputFile
	 *            被压缩的文件夹
	 * @throws Exception
	 */
	private static void zip(String zipFileName, File inputFile)
			throws Exception {
		ZipOutputStream out = new ZipOutputStream(new FileOutputStream(
				zipFileName));
		zipFolder(out, inputFile, "");
//		System.out.println("zip done");
		out.close();
	}

	/**
	 * 压缩文件夹中的每个文件
	 * 
	 * @param out
	 *            压缩后的文件夹流
	 * @param f
	 *            被压缩的文件夹
	 * @param base
	 * @return
	 * @throws IOException
	 */
	private static String zipFolder(ZipOutputStream out, File f, String base)
			throws IOException {
		if (f.isDirectory()) {
			File[] fl = f.listFiles();
			base = base.length() == 0 ? "" : base + "/";
			for (int i = 0; i < fl.length; i++) {
				zipFolder(out, fl[i], base + fl[i].getName());
			}
		} else {
			out.putNextEntry(new org.apache.tools.zip.ZipEntry(base));
			FileInputStream in = new FileInputStream(f);
			int b;
			while ((b = in.read()) != -1) {
				out.write(b);
			}
			in.close();
		}
		return null;
	}

	public static boolean createTempFile(String xmlContent, String des) {
		File desFile;
		desFile = new File(des);
		FileOutputStream fos = null;

		try {
			desFile.createNewFile();
			fos = new FileOutputStream(desFile);
			fos.write(xmlContent.getBytes("UTF-8"));
			fos.flush();
			fos.close();
		} catch (IOException e) {
			System.out.println(e);
			return false;
		}
		return true;
	}
}
