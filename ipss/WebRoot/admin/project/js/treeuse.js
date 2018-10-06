// Copyright 2000 . All rights reserved.

//--------------- LOCALIZEABLE GLOBALS ---------------
	var nodeObj = null;		//被触发的节点对象
	var startobj=null,endobj=null;

//---------------   GLOBAL VARIABLES   ---------------
	

//---------------    LOCAL FUNCTIONS   ---------------
	function newtree()//显示不同树
	{
		window.location = "projecttree.jsp?treeid="+document.all.treeid.value;
	}

	function addSubdir()//新建子目录
	{
		if (nodeObj != null && nodeObj.type != "0" )
		{
			parent.frames.framechannl.location = "updatesubdir.jsp?siteid="+ nodeObj.siteid+"&pid="+ nodeObj.id ;
		}
		else
		{
			alert("只能在目录名上新建子目录！");
		}
		nodeObj=null;
	}
	function addSitemap()//新建 SITEMAP
	{
		if (nodeObj != null && nodeObj.type != "0")
		{
			parent.frames.framechannl.location = "updatesitemap.jsp?siteid="+ nodeObj.siteid+"&pid="+ nodeObj.id ;
		}
		else
		{
			alert("只能在目录名上新建 SiteMap！");
		}		
		nodeObj=null;
	}
	function home()//指定一个 SITEMAP 为首页
	{
		if (nodeObj != null && nodeObj.type == "0")
		{
			parent.frames.framechannl.location = "homesitemapsubmit.jsp?siteid="+ nodeObj.siteid+"&id="+ nodeObj.id ;
		}
		else
		{
			alert("只能指定 SiteMap 为首页！");
		}		
		nodeObj=null;
	}	
	function lockNode()//锁定一个 SITEMAP 
	{
		if (nodeObj != null && nodeObj.type == "0")
		{
			parent.frames.framechannl.location = "locksitemapsubmit.jsp?siteid="+ nodeObj.siteid+"&id="+ nodeObj.id ;
		}
		else
		{
			alert("只能锁定 SiteMap！");
		}		
		nodeObj=null;
	}	
	function copy() //复制 SITEMAP 页
	{
		if (nodeObj != null && nodeObj.type != "1")
		{
			parent.frames.framechannl.location = "copysitemap.jsp?siteid="+ nodeObj.siteid+"&id="+ nodeObj.id +"&cut=0";
		}
		else
		{
			alert("不能在复制整个 Site 工程！");
		}		
		nodeObj=null;
	}
	function cut() //剪切 SITEMAP 页
	{
		if (nodeObj != null && nodeObj.type != "1")
		{
			parent.frames.framechannl.location = "copysitemap.jsp?siteid="+ nodeObj.siteid+"&id="+ nodeObj.id+"&cut=1" ;
		}
		else
		{
			alert("不能在复制整个 Site 工程！");
		}		
		nodeObj=null;
	}	
	function paste() //粘贴复制的 SITEMAP 页
	{
		if (nodeObj != null && nodeObj.type != "0")
		{
			parent.frames.framechannl.location = "pastesitemap.jsp?siteid="+ nodeObj.siteid+"&id="+ nodeObj.id ;
		}
		else
		{
			alert("复制的目标不能是 SiteMap！");
		}		
		nodeObj=null;
	}				
	function getNode()//显示频道编辑页面
	{
		if(event.srcElement.name == "node")
		{
			parent.frames.framechannl.location = "modif_channel_1.jsp?channelID="+event.srcElement.id;
		}
	}
	function validate()	//有效性检查
	{	
		if(nodeObj != null && nodeObj.type == "1")
		{
			if( confirm("是否同时检查 SiteMap 的置标正确性（耗时操作）？") )
			{
				parent.frames.framechannl.location = "validatesite.jsp?siteid="+nodeObj.siteid+"&mark=1";
			}
			else
			{
				parent.frames.framechannl.location = "validatesite.jsp?siteid="+nodeObj.siteid+"&mark=0";
			}
		}
		else
		{
			alert("只能对站点进行有效性检查！");
		}		
		nodeObj=null;
	}
	function publish()	//部署
	{	
		if(nodeObj != null && nodeObj.type == "1")
		{
			parent.frames.framechannl.location = "publish.jsp?siteid="+nodeObj.siteid; 
		}
		else
		{
			alert("只能对项目进行部署操作！");
		}		
		nodeObj=null;
	}
	function preview()	//站点预览
	{	
		if(nodeObj != null && nodeObj.type == "1")
		{
			parent.frames.framechannl.location = "preview.jsp";
		}
		else
		{
			alert("只能对站点进行预览！");
		}		
		nodeObj=null;
	}
	function projectsite()	//维护工程与已部署应用的关系
	{
		if(nodeObj != null && nodeObj.type == "1")
		{
			parent.frames.framechannl.location = "projectsite.jsp?siteid="+nodeObj.siteid;
		}
		else
		{
			alert("只能对项目进行维护操作！");
		}		
		nodeObj=null;
	}
	function hiddenmenu()//隐藏菜单
	{
		var nodMenu = document.getElementById("ie5menu");
		nodMenu.style.display = "none";
		nodeObj = null;

	}

	function showNodeMassage()//显示频道节点信息
	{
		if (nodeObj != null)
		{
			parent.frames.framechannl.location = "updateproject.jsp?type=0&siteid="+ nodeObj.siteid+"&id="+nodeObj.id;
		}
		nodeObj = null;
	}	
	
	function deleteNode()//删除整个项目
	{
		if (nodeObj != null && nodeObj.type != "1")
		{
			if (confirm("真的项目树中的指定的节点（如果是目录，包括下面的页面和目录吗？）"))
			{
				location="deletesitemap.jsp?siteid="+ nodeObj.siteid+"&id="+ nodeObj.id;
			}
		}
		else
		{
			if (confirm("真的要删除整个项目（包括下面的的页面和子目录吗）？"))
			{
				location="deletesite.jsp?siteid="+ nodeObj.siteid+"&id="+ nodeObj.id+"&come=1";
			}
		}
		nodeObj = null;
	}

	function deleteNodeSon()//删除频道子节点,尚未实现
	{
		if (nodeObj != null)
		{
			if (confirm(" 删除子频道？"))
			{
				parent.frames.framechannl.location="deletechannelnodeson.jsp?channelID="+nodeObj.id;
			}
		}
	}
	function grant()//授权
	{
		if (nodeObj != null)
		{
			window.open("../../usermanager/jsp/resourcegrant.jsp?typename=channel&id="+nodeObj.id+"&object=1");
		}
	}
	function grant1()//授权
	{
		if (nodeObj != null)
		{
			window.open("../../usermanager/jsp/resourcegrant.jsp?typename=channel&id="+nodeObj.id+"&object=0");
		}
	}
	function grant2()//授权
	{
		if (nodeObj != null)
		{
			window.open("../../usermanager/jsp/resourcegrant.jsp?typename=channel&id="+nodeObj.id+"&object=2");
		}
	}
	function putobj()//for test，尚未使用
	{
				
		if (event.srcElement.name == "node" && startobj != null && endobj != null)
		{
			alert(startobj.id+" ---> "+endobj.id);
		}
		startobj = null;
		endobj = null;

	}

	function getobj()//获取节点对象2002-7-17
	{
				if (event.srcElement.name == "node") 
				{
					startobj = event.srcElement;
					endobj = null;
					

				}
				else
				{
					startobj = null;
					endobj = null;
				}	
	}
	function enterobj()//获取目标对象
	{
		if(event.srcElement.name == "node" && startobj != null)//如果拖动进入的是链接并且不是初始点
		{
			if (event.srcElement.id != startobj.id)
			{
				endobj = event.srcElement;
				
			}
			else
			{
				endobj = null;
			}
			
		}
		else
		{
			endobj = null;
		}
	}