package com.cnipr.cniprgz.func;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.cnipr.cniprgz.dao.AreacodeDAO;
import com.cnipr.cniprgz.entity.ChannelInfo;

public class AreacodeFunc {
	private AreacodeDAO areacodeDAO;

	public AreacodeDAO getAreacodeDAO() {
		return areacodeDAO;
	}
	
	public void setAreacodeDAO(AreacodeDAO areacodeDAO) {
		this.areacodeDAO = areacodeDAO;
	}
	
	public HashMap<String, String> getAllAreacode() throws Exception {
//		List<ChannelInfo> channelList = new ArrayList<ChannelInfo>();		
//		for (int i = 0; i < channelArray.length; i++) {
//			ChannelInfo channelInfo = null;
//			try{
//				channelInfo = channelDAO.getChannelInfoByID(channelArray[i]);
//			}catch(Exception ex){
//				throw ex;
//			}
//			if (channelInfo != null)
//				channelList.add(channelInfo);
//		}		
//		HashMap<String, String> areacodeDAO.getAllAreacode();
		
		return areacodeDAO.getAllAreacode();
	}
	
//	public List<ChannelInfo> getChannelInfoByArea(String area) {		
//		List<ChannelInfo> channelList = new ArrayList<ChannelInfo>();		
//		channelList = channelDAO.getChannels(area);		
//		return channelList;
//	}
//	
//	public List<ChannelInfo> getChannels(String area) {
//		return channelDAO.getChannels(area);
//	}
//	
//	public String getChannelsIDByName(String channelsName) {
//		return channelDAO.getChannelsIDByName(channelsName);
//	}
}
