Ext.onReady(function () {
	Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
	
	var treeType = document.getElementById("treeType").value;
	var searchType = document.getElementById("searchType").value;
	var rootId = document.getElementById("rootId").value;
	var userId = document.getElementById("userId").value;
	var title = document.getElementById("title").value;
	var autosearch = document.getElementById("autosearch").value;
	
	var rootVisible = false;
	
	
	
//alert("treeType="+treeType);
//alert("searchType="+searchType);
//alert("rootId="+rootId);
//alert("userId="+userId);
//alert("title="+title);
//alert("autosearch="+autosearch);

	
	
	if (rootId == "0") {
		title = "";
	}  
	if (title.length > 0) {
		rootVisible = true;
	}
	
	var root = new Ext.tree.AsyncTreeNode({
		id: rootId, 
		text: title, 
		searchType : searchType,
		treeType : treeType,
		strClass : '0',
		userId : userId,
		draggable:false
	});
	
	var treeLoader = new Ext.tree.DWRTreeLoader({dwrCall:DwrTreeBB.getTree});


	
	var tree = new Ext.tree.TreePanel({
		el:"tree",
		id:"tree", 
		//region:"west", 
		bodyStyle : 'background-color:#F0F7FF',
		border:false,
		//title: title, 
		split:true, 
		buttonAlign:"left", 
		width:220, 
		height:210,
		minSize:175, 
		maxSize:400, 
		collapsible:true, 
		margins:"0 0 5 5", 
		loader:treeLoader, 
		rootVisible:rootVisible, 
		autoScroll:true, 
		root:root
	});


	if (title != null && title != "") {
		var hyNode = new Ext.tree.AsyncTreeNode({      
			id:rootId, 
			text:title,     
			treeType : '1',
			leaf:false
		});
		
		root.appendChild(hyNode);
	}
	
	var viewport = new Ext.Viewport({
		layout : 'fit',
		items : [tree]
	});
	
	tree.root.expand();



	if (treeType == "0") {
		tree.on('click', function(node, e) {
			e.stopEvent();
			if (node.attributes.expression !== null) {
				if (document.getElementById("areaType").value == 'cn') {
					document.getElementById("areaType").value = null;
					document.getElementById('strWhere').value = node.attributes.cnExpression;
					document.getElementById('strChannels').value = node.attributes.chrCNChannels;
					document.getElementById('area').value = "cn";
					submitSearchForm();
				} else if (document.getElementById("areaType").value == 'fr') {
					document.getElementById("areaType").value = null;
					document.getElementById('strWhere').value = node.attributes.frExpression;
					document.getElementById('strChannels').value = node.attributes.chrFRChannels;
					document.getElementById('area').value = "fr";
					submitSearchForm();
				}else if (document.getElementById("areaType").value == 'sx') {					 
					document.getElementById("areaType").value = null;
					document.getElementById('strWhere').value = node.attributes.cnExpression;
					document.getElementById('strChannels').value = node.attributes.chrLapsedChannels;
					document.getElementById('area').value = "cn";
					submitSearchForm();
				}else {
					document.getElementById('strWhere').value = node.attributes.cnExpression;
					document.getElementById('trsLastWhere').value = node.attributes.cnExpression;
					showSearchForm('secondsearch');
				    //window.parent.parent.parent.rightFrame.document.URL = "../../search.do?method=showSearchForm&area=" + node.attributes.searchType + "&getclass=" + node.attributes.strClass;
				}
			} else {
			    document.getElementById('strWhere').value = node.attributes.cnExpression;
			    document.getElementById('trsLastWhere').value = node.attributes.cnExpression;
			    showSearchForm('secondsearch');
				//window.parent.parent.parent.rightFrame.document.URL = "../../search.do?method=showSearchForm&area=" + node.attributes.searchType + "&getclass=" + node.attributes.strClass;
			}
		});
	} else  {//if(treeType == "2")
		tree.on('click', function(node, e) {
			e.stopEvent();
			if (node.attributes.expression !== null) {
				if (document.getElementById("areaType").value == 'cn') {   
					document.getElementById("areaType").value = null;
					document.getElementById('strWhere').value = node.attributes.cnExpression;
					document.getElementById('strChannels').value = node.attributes.chrCNChannels;
					document.getElementById('area').value = "cn"; 
					submitSearchForm();
				} else if (document.getElementById("areaType").value == 'fr') {					 
					document.getElementById("areaType").value = null;
					document.getElementById('strWhere').value = node.attributes.frExpression;
					document.getElementById('strChannels').value = node.attributes.chrFRChannels;
					document.getElementById('area').value = "fr";
					submitSearchForm();
				} else if (document.getElementById("areaType").value == 'sx') {					 
					document.getElementById("areaType").value = null;
					document.getElementById('strWhere').value = node.attributes.cnExpression;
					document.getElementById('strChannels').value = node.attributes.chrLapsedChannels;
					document.getElementById('area').value = "cn";
					submitSearchForm();
				}
				else if (document.getElementById("areaType").value == 'yx') {					 
					document.getElementById("areaType").value = null;
					document.getElementById('strWhere').value = node.attributes.cnExpression;
					document.getElementById('strChannels').value = node.attributes.chrYXLapsedChannels;
					document.getElementById('area').value = "cn";
					submitSearchForm();
				} 
				else {					
				  document.getElementById('strWhere').value = node.attributes.cnExpression;
				  document.getElementById('trsLastWhere').value = node.attributes.cnExpression;
				  showSearchForm('secondsearch');
				  //  window.parent.parent.parent.rightFrame.document.URL = "../../search.do?method=showSearchForm&area=cn";
				}
			} else {
				document.getElementById('strWhere').value = node.attributes.cnExpression;
				document.getElementById('trsLastWhere').value = node.attributes.cnExpression;
				showSearchForm('secondsearch');
				//window.parent.parent.parent.rightFrame.document.URL = "../../search.do?method=showSearchForm&area=cn";
			}
		});
	}
	/* else {
		// Add Tree Menu
		tree.on('contextmenu', contextmenu, tree);
		
		// 创建右键菜单
		function contextmenu(node, e) {
			if (node.attributes.expression !== null) {
			    treeMenu = new Ext.menu.Menu( {
			        id : 'treeMenu',
			        items : [new Ext.menu.Item( {
			                text : '中',
			                iconCls : 'delete',
			                handler : clickCnHandler
			            }),new Ext.menu.Item( {
			                text : '失效库',
			                iconCls : 'delete',
			                handler : clickCnHandler
			            })]
			    });
			
			    coords = e.getXY();
			    treeMenu.showAt([coords[0], coords[1]]);
		    }
		}
	}*/
});

function setSearchArea(area) {
	 document.getElementById("areaType").value = area; 
}

