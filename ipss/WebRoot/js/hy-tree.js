
Ext.onReady(function () {
	Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
	
	var root = new Ext.tree.AsyncTreeNode({
		id: "0", 
		text:"行业导航", 
		searchType : "cn",
		draggable:false
	});
	
	var treeLoader = new Ext.tree.DWRTreeLoader({dwrCall:DwrTreeBB.getOrgTree});
	
	var tree = new Ext.tree.TreePanel({
		el:"tree",
		id:"hy-tree", 
		region:"west", 
		title:"行业导航", 
		split:true, 
		buttonAlign:"left", 
		width:225, 
		minSize:175, 
		maxSize:400, 
		collapsible:true, 
		margins:"0 0 5 5", 
		loader:treeLoader, 
		rootVisible:false, 
		autoScroll:true, 
		root:root
	});
	
	var viewport = new Ext.Viewport({
		layout : 'fit',
		items : [tree]
	});
	
	tree.root.expand();
	
	tree.on('click', function(node, e) {
		e.stopEvent();
		alert(node.attributes.expression);
	});
	
});

