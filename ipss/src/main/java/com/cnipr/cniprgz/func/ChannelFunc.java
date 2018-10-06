package com.cnipr.cniprgz.func;

import java.util.ArrayList;
import java.util.List;

import com.cnipr.cniprgz.dao.ChannelDAO;
import com.cnipr.cniprgz.entity.ChannelInfo;

public class ChannelFunc {
	private ChannelDAO channelDAO;

	public ChannelDAO getChannelDAO() {
		return channelDAO;
	}

	public void setChannelDAO(ChannelDAO channelDAO) {
		this.channelDAO = channelDAO;
	}
	
	public List<ChannelInfo> getInfoMapByChannel(String[] channelArray) throws Exception {
		List<ChannelInfo> channelList = new ArrayList<ChannelInfo>();
		
		for (int i = 0; i < channelArray.length; i++) {
			ChannelInfo channelInfo = null;
			try{
				channelInfo = channelDAO.getChannelInfoByID(channelArray[i]);
			}catch(Exception ex){
				throw ex;
			}
			if (channelInfo != null)
				channelList.add(channelInfo);
		}	
		
		return channelList;
	}
	
	public List<ChannelInfo> getChannelInfoByArea(String area) {
		
		List<ChannelInfo> channelList = new ArrayList<ChannelInfo>();
		
		channelList = channelDAO.getChannels(area);
		
		return channelList;
	}
	
	public List<ChannelInfo> getChannels(String area) {
		return channelDAO.getChannels(area);
	}
	
	public String getChannelsIDByName(String channelsName) {
		return channelDAO.getChannelsIDByName(channelsName);
	}
}
