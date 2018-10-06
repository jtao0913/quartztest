package com.cnipr.cniprgz.authority;

abstract public class AbsDataAuthority {
	// 标志位：是否有该数据权限
	private boolean authorityFlag = true;

	public boolean isAuthorityFlag() {
		return authorityFlag;
	}

	public void setAuthorityFlag(boolean authorityFlag) {
		this.authorityFlag = authorityFlag;
	}

	// 是否有检索范围的数据权限
	public abstract boolean hasDataAuthority(String role, String funcName,
			String channelArray, int dataObj);
	
	// 数据权限验证前的要做的一些处理
	public void preValid(){}
	
	// 数据权限验证后的要做的一些处理
	public void postValid(){
	}
}
