<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
 

 
<script type="text/javascript">
	// 分页检索
	function doPagination(start){
		// 设定起始页
		$("#start").val(start);
		// 检索
		//doSearch();
		 
		$("#searchForm").submit();
	}
			
	// 检索内容		
	function isRightPager(totalPage,pageSize ){
		var pager = $("#pager").val();
		var RegExpNum = /^\d+$/;
		if(!RegExpNum.test(pager)){
			alert("请输入页数.");
			return;
		}
		if( pager < 1 ){
			alert("页数必须大于0");
			return;
		}
		else{
			if( pager > totalPage ){
				alert("您只能输入1~"+totalPage+"的数");
				return;
			}
		}
		doPagination(pager);
	}
</script>

      

  <span title="记录总数"  style="padding: 0px 4px;" class="gray">记录总数: <strong><%=pagination.getTotalCount() %></strong></span><span style="padding: 0px 6px;">第<strong><%=pagination.getStart() %></strong>页（共<strong><%=pagination.getTotalPage()%></strong>页）</span>
          <% if(start>pagination.getTotalPage()) start=1; %> 
           <% if(pagination.isFirstPage()){ %>
				 <input type='button' class="firstpage" value='首页' /><input type='button' class="mpage" value='上一页' /> 
			<%}else{ %>
				 <input type='button' onclick="javascript:doPagination('1');" class='firstpage' value='首页'>
				<input type='button' onclick="javascript:doPagination('<%if(pagination.getPrePage()>=0)out.print(pagination.getPrePage()); %>')" class='mpage' value='上一页'/>
			<%} %>
			
			<% if(start-5 >= 1){ %>
				  <% if(pagination.getTotalPage() >= start+4){ %> 
					<%for(int i=start-5;i<=start+4;i++){ %> 
					    <%if(i==start){ %> 
							<span class="currentpage"><%=i%></span>
						<%}else{ %>
							<a href="javascript:doPagination(<%if(i>=0) out.print(i);%>)" class='norpage'><%=i%></a>
						<%} %>
					<%} %>
				  <%}else{ %>
					  <%for(int i=pagination.getTotalPage()-5;i<=pagination.getTotalPage();i++){ %> 
						    <%if(i==start){ %> 
								<span class="currentpage"><%=i%></span>
							<%}else{ %>
								<a href="javascript:doPagination(<%if(i>=0) out.print(i);%>)" class='norpage'><%=i%></a>
							<%} %>
						<%} %> 
				<%} %>
			<%}else{ %>
				 <% if(pagination.getTotalPage() >= 10 ){ %> 
				 		<%for(int i=1;i<=10;i++){ %> 
						    <%if(i==start){ %> 
								<span class="currentpage"><%=i%></span>
							<%}else{ %>
								<a href="javascript:doPagination(<%if(i>=0) out.print(i);%>)" class='norpage'><%=i%></a>
							<%} %> 
						<%} %>  
				 <%}else{ %>
				 		<%for(int i=1;i<=pagination.getTotalPage();i++){ %> 
						    <%if(i==start){ %> 
								<span class="currentpage"><%=i%></span>
							<%}else{ %>
								<a href="javascript:doPagination(<%if(i>=0) out.print(i);%>)" class='norpage'><%=i%></a>
							<%} %> 
						<%} %>   
				<%} %>
			<%} %>
			
			 <% if(pagination.isLastPage()){ %> 
				<input type='button'   class="mpage" value='下一页' /><input type='button' class="lastpage" value='尾页'/>
			 <%}else{ %>
				<input type='button' onclick="javascript:doPagination('<%=pagination.getNextPage() %>')" class='mpage' value='下一页'/>
				<input type='button' onclick="javascript:doPagination('<%=pagination.getTotalPage() %>')" class='lastpage' value="尾页"/>
			<%} %>
				
		<!-- <span style="padding: 0px 4px;"><img src="../images/next.gif" alt="后十页"/></span> -->
		     
	    <input type="text" id="pager" name="pager" size="1" value="" class="t" />
       <input type='button'  class='turnpage' name="search"   onClick="isRightPager(<%=pagination.getTotalPage() %>,<%=pagination.getPageSize() %>);" value='跳转' />
  
 







 
