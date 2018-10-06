package com.cnipr.cniprgz.commons;

import java.util.Comparator;

public class ComparatorMenuId implements Comparator<Object>{

	public int compare(Object o1, Object o2) {
		// TODO Auto-generated method stub
		Integer i1 = Integer.parseInt((String)o1);
		Integer i2 = Integer.parseInt((String)o2);
		return i1.compareTo(i2);
	}


}
