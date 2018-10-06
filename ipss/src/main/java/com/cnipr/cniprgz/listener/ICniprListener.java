package com.cnipr.cniprgz.listener;

import java.util.EventListener;
import com.cnipr.cniprgz.event.CniprEvent;

public interface ICniprListener extends EventListener{
	public abstract void performed(CniprEvent e);  
}
