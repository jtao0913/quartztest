// Copyright 2000 . All rights reserved.

//--------------- LOCALIZEABLE GLOBALS ---------------
	var nodeObj = null;		//�������Ľڵ����
	var startobj=null,endobj=null;

//---------------   GLOBAL VARIABLES   ---------------
	

//---------------    LOCAL FUNCTIONS   ---------------
	function newtree()//��ʾ��ͬ��
	{
		window.location = "projecttree.jsp?treeid="+document.all.treeid.value;
	}

	function addSubdir()//�½���Ŀ¼
	{
		if (nodeObj != null && nodeObj.type != "0" )
		{
			parent.frames.framechannl.location = "updatesubdir.jsp?siteid="+ nodeObj.siteid+"&pid="+ nodeObj.id ;
		}
		else
		{
			alert("ֻ����Ŀ¼�����½���Ŀ¼��");
		}
		nodeObj=null;
	}
	function addSitemap()//�½� SITEMAP
	{
		if (nodeObj != null && nodeObj.type != "0")
		{
			parent.frames.framechannl.location = "updatesitemap.jsp?siteid="+ nodeObj.siteid+"&pid="+ nodeObj.id ;
		}
		else
		{
			alert("ֻ����Ŀ¼�����½� SiteMap��");
		}		
		nodeObj=null;
	}
	function home()//ָ��һ�� SITEMAP Ϊ��ҳ
	{
		if (nodeObj != null && nodeObj.type == "0")
		{
			parent.frames.framechannl.location = "homesitemapsubmit.jsp?siteid="+ nodeObj.siteid+"&id="+ nodeObj.id ;
		}
		else
		{
			alert("ֻ��ָ�� SiteMap Ϊ��ҳ��");
		}		
		nodeObj=null;
	}	
	function lockNode()//����һ�� SITEMAP 
	{
		if (nodeObj != null && nodeObj.type == "0")
		{
			parent.frames.framechannl.location = "locksitemapsubmit.jsp?siteid="+ nodeObj.siteid+"&id="+ nodeObj.id ;
		}
		else
		{
			alert("ֻ������ SiteMap��");
		}		
		nodeObj=null;
	}	
	function copy() //���� SITEMAP ҳ
	{
		if (nodeObj != null && nodeObj.type != "1")
		{
			parent.frames.framechannl.location = "copysitemap.jsp?siteid="+ nodeObj.siteid+"&id="+ nodeObj.id +"&cut=0";
		}
		else
		{
			alert("�����ڸ������� Site ���̣�");
		}		
		nodeObj=null;
	}
	function cut() //���� SITEMAP ҳ
	{
		if (nodeObj != null && nodeObj.type != "1")
		{
			parent.frames.framechannl.location = "copysitemap.jsp?siteid="+ nodeObj.siteid+"&id="+ nodeObj.id+"&cut=1" ;
		}
		else
		{
			alert("�����ڸ������� Site ���̣�");
		}		
		nodeObj=null;
	}	
	function paste() //ճ�����Ƶ� SITEMAP ҳ
	{
		if (nodeObj != null && nodeObj.type != "0")
		{
			parent.frames.framechannl.location = "pastesitemap.jsp?siteid="+ nodeObj.siteid+"&id="+ nodeObj.id ;
		}
		else
		{
			alert("���Ƶ�Ŀ�겻���� SiteMap��");
		}		
		nodeObj=null;
	}				
	function getNode()//��ʾƵ���༭ҳ��
	{
		if(event.srcElement.name == "node")
		{
			parent.frames.framechannl.location = "modif_channel_1.jsp?channelID="+event.srcElement.id;
		}
	}
	function validate()	//��Ч�Լ��
	{	
		if(nodeObj != null && nodeObj.type == "1")
		{
			if( confirm("�Ƿ�ͬʱ��� SiteMap ���ñ���ȷ�ԣ���ʱ��������") )
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
			alert("ֻ�ܶ�վ�������Ч�Լ�飡");
		}		
		nodeObj=null;
	}
	function publish()	//����
	{	
		if(nodeObj != null && nodeObj.type == "1")
		{
			parent.frames.framechannl.location = "publish.jsp?siteid="+nodeObj.siteid; 
		}
		else
		{
			alert("ֻ�ܶ���Ŀ���в��������");
		}		
		nodeObj=null;
	}
	function preview()	//վ��Ԥ��
	{	
		if(nodeObj != null && nodeObj.type == "1")
		{
			parent.frames.framechannl.location = "preview.jsp";
		}
		else
		{
			alert("ֻ�ܶ�վ�����Ԥ����");
		}		
		nodeObj=null;
	}
	function projectsite()	//ά���������Ѳ���Ӧ�õĹ�ϵ
	{
		if(nodeObj != null && nodeObj.type == "1")
		{
			parent.frames.framechannl.location = "projectsite.jsp?siteid="+nodeObj.siteid;
		}
		else
		{
			alert("ֻ�ܶ���Ŀ����ά��������");
		}		
		nodeObj=null;
	}
	function hiddenmenu()//���ز˵�
	{
		var nodMenu = document.getElementById("ie5menu");
		nodMenu.style.display = "none";
		nodeObj = null;

	}

	function showNodeMassage()//��ʾƵ���ڵ���Ϣ
	{
		if (nodeObj != null)
		{
			parent.frames.framechannl.location = "updateproject.jsp?type=0&siteid="+ nodeObj.siteid+"&id="+nodeObj.id;
		}
		nodeObj = null;
	}	
	
	function deleteNode()//ɾ��������Ŀ
	{
		if (nodeObj != null && nodeObj.type != "1")
		{
			if (confirm("�����Ŀ���е�ָ���Ľڵ㣨�����Ŀ¼�����������ҳ���Ŀ¼�𣿣�"))
			{
				location="deletesitemap.jsp?siteid="+ nodeObj.siteid+"&id="+ nodeObj.id;
			}
		}
		else
		{
			if (confirm("���Ҫɾ��������Ŀ����������ĵ�ҳ�����Ŀ¼�𣩣�"))
			{
				location="deletesite.jsp?siteid="+ nodeObj.siteid+"&id="+ nodeObj.id+"&come=1";
			}
		}
		nodeObj = null;
	}

	function deleteNodeSon()//ɾ��Ƶ���ӽڵ�,��δʵ��
	{
		if (nodeObj != null)
		{
			if (confirm(" ɾ����Ƶ����"))
			{
				parent.frames.framechannl.location="deletechannelnodeson.jsp?channelID="+nodeObj.id;
			}
		}
	}
	function grant()//��Ȩ
	{
		if (nodeObj != null)
		{
			window.open("../../usermanager/jsp/resourcegrant.jsp?typename=channel&id="+nodeObj.id+"&object=1");
		}
	}
	function grant1()//��Ȩ
	{
		if (nodeObj != null)
		{
			window.open("../../usermanager/jsp/resourcegrant.jsp?typename=channel&id="+nodeObj.id+"&object=0");
		}
	}
	function grant2()//��Ȩ
	{
		if (nodeObj != null)
		{
			window.open("../../usermanager/jsp/resourcegrant.jsp?typename=channel&id="+nodeObj.id+"&object=2");
		}
	}
	function putobj()//for test����δʹ��
	{
				
		if (event.srcElement.name == "node" && startobj != null && endobj != null)
		{
			alert(startobj.id+" ---> "+endobj.id);
		}
		startobj = null;
		endobj = null;

	}

	function getobj()//��ȡ�ڵ����2002-7-17
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
	function enterobj()//��ȡĿ�����
	{
		if(event.srcElement.name == "node" && startobj != null)//����϶�����������Ӳ��Ҳ��ǳ�ʼ��
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