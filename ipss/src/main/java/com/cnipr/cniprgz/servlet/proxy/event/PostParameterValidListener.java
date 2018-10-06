package com.cnipr.cniprgz.servlet.proxy.event;

import java.util.EventObject;

import com.cnipr.cniprgz.log.CniprLogger;


public class PostParameterValidListener implements IListener{

	public void performed(EventObject e) {
		CniprLogger.LogDebug("PostParameterValidListener -> performed");
	}
	
}
