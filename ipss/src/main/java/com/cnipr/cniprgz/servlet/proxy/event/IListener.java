package com.cnipr.cniprgz.servlet.proxy.event;

import java.util.EventListener;
import java.util.EventObject;


public interface IListener extends EventListener{
	public abstract void performed(EventObject e);  
}
