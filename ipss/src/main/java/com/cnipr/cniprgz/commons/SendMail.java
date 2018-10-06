package com.cnipr.cniprgz.commons;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map.Entry;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.MultiPartEmail;
import org.apache.commons.mail.SimpleEmail;
import org.elasticsearch.xpack.notification.email.attachment.EmailAttachmentParser.EmailAttachment;

public class SendMail {
	
	private static LinkedHashMap<String,String> ht_mailaddress = new LinkedHashMap<String,String>();
	//public DBManage()
	{
		ht_mailaddress.put("jiangtao", "563268729@qq.com");
	}
	
	private static String getMailAddress(String name){
		String mailaddress="";
		
		Set set = ht_mailaddress.entrySet();
		Iterator it = set.iterator();
		while (it.hasNext()) {
			Entry entry = (Entry) it.next();
			System.out.println(entry.getKey() + " - " + entry.getValue());
			
			if(((String)entry.getKey()).equals(name)){
				mailaddress = (String)entry.getValue();
				break;
			}
		}		
		return mailaddress;
	}
	
//	(arrStaff[i],arrShouquanma[i],"全领域数据库（"+ui.getRealname()+"）每日运维晨报",EMailMessage,ui.getEmail());	
	public void staffSendEmail163(String fromAddress,String shouquanma,String subject,String content,String toAddress) {
//	public void sendSimpleEmail(String fromAddress,String shouquanma,String subject,String content,String toAddress) {
		//这个类主要是设置邮件
		try{
//			fromAddress = getMailAddress(fromAddress);
			
			SimpleEmail email = new SimpleEmail();
			email.setHostName("smtp.163.com");
			
//			email.addTo(getMailAddress(toAddress), toAddress);
			
			Pattern pattern = Pattern.compile("^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$");
			Matcher matcher = pattern.matcher(toAddress);

			System.out.println(matcher.matches());

			if(!matcher.matches()){
				email.addTo(getMailAddress(toAddress), toAddress);
			}else{
				email.addTo(toAddress, toAddress);
			}
			
			email.setFrom(fromAddress, "运维监控");
			email.setAuthentication(fromAddress, shouquanma);
			email.setSubject(subject);
			email.setMsg(content.replace("\r\n", ""));
			
			email.send();
		}catch(EmailException ex){
			ex.printStackTrace();
		}
	}
	
	public void sendSimpleEmail(String subject,String content,String toAddress) {
		try{
			SimpleEmail email = new SimpleEmail();
			email.setHostName("smtp.263xmail.com");
			  
			Pattern pattern = Pattern.compile("^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$");
			Matcher matcher = pattern.matcher(toAddress);

			System.out.println(matcher.matches());

			if(!matcher.matches()){
				email.addTo(getMailAddress(toAddress), toAddress);
			}else{
				email.addTo(toAddress, toAddress);
			}

//		  email.setFrom("cniprmonitor@163.com", "运维监控");
//		  email.setAuthentication("cniprmonitor", "cniprmonitor0426");
		  
		  email.setFrom("cniprmonitor@cnipr.com", "运维监控");
		  email.setAuthentication("cniprmonitor@cnipr.com", "ipphmonitor2017!@#");
			
		  email.setSubject(subject);
		  email.setMsg(content.replace("\r\n", ""));
			
		  email.send();
		}catch(EmailException ex){
			ex.printStackTrace();
		}
	}
	
	public void send263noAttachfile(String subject,String content,String toAddress) {
		try{
			  MultiPartEmail email = new MultiPartEmail();
			  email.setHostName("smtp.263xmail.com");
			  
			  email.addTo(getMailAddress(toAddress), toAddress);
			  email.setFrom("cniprmonitor@cnipr.com", "运维监控");
			  email.setAuthentication("cniprmonitor@cnipr.com", "ipphmonitor2017!@#");
			  email.setSubject(subject);
			  email.setMsg(subject + content);
			  
			  // add the attachment

			  // send the email
			  email.send();
			}catch(EmailException ex){
				ex.printStackTrace();
			}
	}
	
	public static void main(String[] args) {
		SendMail sendmail = new SendMail();
		sendmail.sendSimpleEmail("测试title", "测试content", "jiangtao");
	}

}
