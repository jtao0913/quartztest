<%@ page language="java" pageEncoding="UTF-8"%>
<%
//System.out.println("areacode = " + areacode);
if(areacode.equals("041")){

}else if(areacode.equals("shaanxiyangling")){%>
<div style="height:30px;"></div>
<div class="container" style="font-size: 12px;color:#666666;">
	<div class="row-fluid text-center">
        项目实施：中国杨凌农业知识产权信息中心&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;技术支持：知识产权出版社有限责任公司
	</div>
</div>

<%}else if(areacode.equals("020")){
//System.out.println("------------------20------------------");
%>
<div style="height:30px;"></div>
<div class="container" style="font-size: 12px;color:#666666;">
	<div class="row-fluid text-center">
        ©2018 IPPH.cn&nbsp;&nbsp; <%=website_title%>&nbsp;&nbsp;苏ICP备10228452号-9 <br>技术支持：<a href="http://www.ipph.cn" target="_blank">知识产权出版社有限责任公司</a>  IT运维电话：4001880860<br>
        浏览器：IE9及以上，<a href="http://www.firefox.com.cn/download/" target="_blank">火狐</a> ，<a href="http://www.google.com.hk/chrome/" target="_blank">谷歌</a> ，<a href="http://www.apple.com/cn/safari/" target="_blank">safari</a> ，<a href="http://chrome.360.cn/" target="_blank">360</a>，<a href="http://www.opera.com/zh-cn" target="_blank">opera</a>  等<br><br>
	</div>
</div>
<%}else if(areacode.equals("000")){
	//System.out.println("------------------20------------------");
	%>
	<div style="height:30px;"></div>
	<div class="container" style="font-size: 12px;color:#666666;">
		<div class="row-fluid text-center">
	        ©2018 IPPH.cn&nbsp;&nbsp; PatViewer专利搜索引擎<br>主办单位：知识产权出版社有限责任公司&nbsp;&nbsp;IT运维电话：4001880860<br>
	        浏览器：IE9及以上、火狐等&nbsp;&nbsp;京ICP备09007110号 <img src="image/gongan.png"> 京公网安备 11010802026659号<br><br>
		</div>
	</div>
<%}else{
//System.out.println("------------------其他------------------");
%>
<div style="height:30px;"></div>
<div class="container" style="font-size: 12px;color:#666666;">
	<div class="row-fluid text-center">
        ©2018 IPPH.cn&nbsp;&nbsp; <%=website_title%> <br>支持单位：<a href="http://www.ipph.cn" target="_blank">知识产权出版社有限责任公司</a>  IT运维电话：4001880860<br>
        <!-- 浏览器：IE9及以上，<a href="http://www.firefox.com.cn/download/" target="_blank">火狐</a> ，<a href="http://www.google.com.hk/chrome/" target="_blank">谷歌</a> ，<a href="http://www.apple.com/cn/safari/" target="_blank">safari</a> ，<a href="http://chrome.360.cn/" target="_blank">360</a>，<a href="http://www.opera.com/zh-cn" target="_blank">opera</a>  等  -->
    浏览器：IE9及以上，火狐 ，谷歌 ，safari ，360，opera 等 Powered by PatViewer
	</div>
</div>
<%}%>

<div style="height:60px;"></div>