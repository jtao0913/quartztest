package com.cnipr.cniprgz.func;

import java.util.Vector;

import com.cnipr.cniprgz.event.CniprEvent;
import com.cnipr.cniprgz.listener.ICniprListener;
import com.cnipr.cniprgz.listener.impl.CniprListener;

abstract public class AbsCniprFunc {
	private Vector<ICniprListener> listeners = new Vector<ICniprListener>();
	
	public AbsCniprFunc() {
		this.addListener(new CniprListener());
	}
	
	public synchronized void addListener(ICniprListener a) {
		listeners.addElement(a);
	}

	public synchronized void removeListener(ICniprListener a) {
		listeners.removeElement(a);
	}
	
	@SuppressWarnings({ "unchecked" })
	public void fireEvent(CniprEvent evt) {

		Vector currentListeners = null;

		synchronized (this) {
			currentListeners = (Vector) listeners.clone();
		}

		for (int i = 0; i < currentListeners.size(); i++) {
			ICniprListener listener = (ICniprListener) currentListeners
					.elementAt(i);
			listener.performed(evt);
		}
	}
}
