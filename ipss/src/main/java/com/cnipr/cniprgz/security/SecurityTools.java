// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   SecurityTools.java

package com.cnipr.cniprgz.security;

import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Properties;


public class SecurityTools {
	private static Properties _properties = null;

	public static String getSecurityCode(String verify) {
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("MD5");
			md.update((verify + getProperty("key")).getBytes("utf-8"));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new BigInteger(1, md.digest()).toString(16);
	}

	/**
	 * @wfunction getProperty by key
	 * @wparam key
	 * @wreturn
	 */
	public static String getProperty(String key) {
		if (_properties == null) {
			try {
				InputStream ins = SecurityTools.class
						.getResourceAsStream("/app.properties");
				_properties = new Properties();
				_properties.load(ins);
			} catch (Exception ex) {
				_properties = null;
			}
		}

		return _properties.getProperty(key);
	}

	public static void main(String args[]) {
		// System.out.println(digest("hello world"));65265B98-0126-1000-E000-0003C0A803B4
		// //for(int i = 0; i < 1000; i++)
		// System.out.println(decrypt("key", encrypt("key", "hello world")));
		String a = SecurityTools.getSecurityCode("hello world");
		System.out.println(a);
		// System.out.println(decrypt("cnipr",
		// "U5mXmWJSKpRcBTNoZi9Fzk5zRK+/66vtAknpmDkNwJfW2bI2hUwMEA=="));
	}

}
