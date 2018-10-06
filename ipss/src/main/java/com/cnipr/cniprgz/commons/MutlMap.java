package com.cnipr.cniprgz.commons;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.httpclient.NameValuePair;
/**
 * 重复KEY值的MAP
 * @author Liushuai
 */
public final class MutlMap {
	
	private List<NameValuePair> pair = null;
	
	public MutlMap() {
		this.pair = new ArrayList<NameValuePair>();
	}

	public int size() {
		return pair.size();
	}

	public synchronized void put(String key, String value) {
		pair.add(new NameValuePair(key,value));
	}
	
	public NameValuePair[] toNameValuePair(){
		if(size()>0){
			NameValuePair[] temp =new NameValuePair[size()];
			int index = 0;
			for(NameValuePair p : pair){
				temp[index++] = p;
			}
			return temp;
		}else{
			return null;
		}
		
	}
}
