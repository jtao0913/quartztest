// Copyright 2000 . All rights reserved.

//--------------- LOCALIZEABLE GLOBALS ---------------
	var nodeObj = null;		//�������Ľڵ����
	var startobj=null,endobj=null,backobj=null
    var menuskin = "skin1"
    var display_url = false
    var startnode = null,endnode = null
    var deltext
//---------------   GLOBAL VARIABLES   ---------------
	

//---------------     API FUNCTIONS    ---------------

//---------------    LOCAL FUNCTIONS   ---------------


function showmenuie5()
{
	var rightedge = document.body.clientWidth-event.clientX;
	var bottomedge = document.body.clientHeight-event.clientY;
	if(event.srcElement.name=="node")
	{
		ie5menu.style.left = document.body.scrollLeft + event.clientX;
		if (bottomedge < ie5menu.offsetHeight)
		{
			ie5menu.style.top = document.body.scrollTop + event.clientY - ie5menu.offsetHeight;
		}
		else
		{
			ie5menu.style.top = document.body.scrollTop + event.clientY;
		}
		
		ie5menu.style.display = "block";
		ie5menu.style.visibility = "visible";
		nodeObj = event.srcElement
		deltext = event.srcElement.getAdjacentText("afterBegin")

		return false;
	}
	else
	{
		nodeObj = null
		deltext = null
		return false
	}
}

function hidemenuie5()
{
	ie5menu.style.display = "none";
	moveto.style.display="none";
}

function highlightie5()
{
	if (event.srcElement.className == "menuitems")
	{
		event.srcElement.style.backgroundColor = "highlight";
		event.srcElement.style.color = "white";
		if (display_url)
		{
			window.status = event.srcElement.url;
		}
	}
	if(event.srcElement.className == "moveitems")
	{
		event.srcElement.style.backgroundColor = "highlight";
		event.srcElement.style.color = "white";
	}
}

function lowlightie5()
{
	if (event.srcElement.className == "menuitems")
	{
		event.srcElement.style.backgroundColor = "";
		event.srcElement.style.color = "black";
		window.status = "";
   	}
   	if(event.srcElement.className == "moveitems")
   	{
		event.srcElement.style.backgroundColor = "";
		event.srcElement.style.color = "black";
   	}
}

	function grantmanage()
	{
        var granturl = "../../powermanage/channel/cresourcegrant.jsp?resourcetypename="+document.all.typename.value+"&detailid="+nodeObj.id+"&powercheck=getManageChannelGrant";
        if(nodeObj.name == "node"&&nodeObj.className!="")
        {
			window.open(granturl,event.srcElement.getAttribute("target"),'width=700,height=600,toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no');
        }
	}

	function newtree()//��ʾ��ͬ��
	{
		window.location = "wcmpublish_wcmchanneltree.jsp?wcmsite="+document.all.select.value;
	}

    //����Ƶ���ڵ�
    function createchannel()
    {
        //�õ��õ��Ƶ����
        if(nodeObj.name == "node")
        {
             parent.frames.framechannl.location = "getnode.jsp?id="+nodeObj.id+"&type=createnew";
        }
        //������ִ�д���Ƶ��ҳ����ʾ����Ƶ��������ѡ���Ƶ�����õ�����Դ
    }

	function showNodeMessage()//��ʾƵ���ڵ���Ϣ
	{
		if (nodeObj != null&&nodeObj.className!="")
		{
			parent.frames.framechannl.location = "getnode.jsp?id="+nodeObj.id+"&type=update";
		}
	}
	function createson()
	{
		if (nodeObj != null)
		{
			hidemenuie5()
			if(nodeObj.className=="")
			{
				alert("�ڸ��ڵ㲻�ܴ�����Ƶ��!")
			}
			else
			{
			    parent.frames.framechannl.location = "getnode.jsp?id="+nodeObj.id+"&type=createson";
            }
		}
	}
	function createbatchson()
	{
		if (nodeObj != null)
		{
			hidemenuie5();
			if(nodeObj.className=="")
			{
				alert("�ڸ��ڵ㲻�ܴ�����Ƶ��!")
			}
			else
			{
			    parent.frames.framechannl.location = "getnode.jsp?id="+nodeObj.id+"&type=createbatchson";
            }
		}
	}
		
	function createwcm()
	{
		if (nodeObj != null)
		{
			hidemenuie5()
		        parent.frames.framechannl.location = "selectds.jsp?id="+nodeObj.id
		}
	}
	
	function deleteNode()//ɾ��Ƶ���ڵ�
	{
		
		if (nodeObj != null)
		{
			hidemenuie5()
			if(nodeObj.className=="")
			{
				alert("���ڵ㲻��ɾ��!")
			}
			else
			{
        			if (confirm(" ȷ��Ҫɾ��Ƶ��' " + deltext+" '"))
        			{
        				if((nodeObj.className!="0")&&confirm("�Ƿ�ɾ���ýڵ��µ�������Ƶ����"))
        				{
        				        window.open("deletechannelnode.jsp?id="+nodeObj.id+"&delall=all","","width=600,height=500,scrollbars=yes");
        				}
        				else
        				{
        				        window.open("deletechannelnode.jsp?id="+nodeObj.id,"","width=600,height=500,scrollbars=yes");
        				}
        			}
			}
		}
	}
        function addresource()
        {
        	var channelid = nodeObj.id
        	window.open("addresource.jsp?id="+channelid)
        }
	function grant(channelid)//��Ȩ
	{
		if (channelid != 0)
		{
			window.open("../../usermanager/jsp/resourcegrant.jsp?typename=channel&id="+channelid+"&object=1");
		}
	}
function grant1(channelid)//��Ȩ
{
	if (channelid != 0)
	{
		window.open("../../usermanager/jsp/resourcegrant.jsp?typename=channel&id="+channelid+"&object=0");
	}
}

function grant2(channelid)//��Ȩ
{
	if (channelid != 0)
	{
		window.open("../../usermanager/jsp/resourcegrant.jsp?typename=channel&id="+channelid+"&object=2");
	}
}

function putobj()//for test����δʹ��
{
	if(backobj!=null)
	{
		backobj.style.backgroundColor="transparent" 
	}        
	if (event.srcElement.name == "node" && startobj != null && endobj != null)
	{
		startnode = startobj.id
		endnode    = endobj.id
		document.all.moveto.style.left = event.offsetX
		document.all.moveto.style.top= event.offsetY+50;		
		document.all.moveto.style.visibility="visible";
		document.all.moveto.style.display = "block";
		endobj=null;
		startobj=null;
	}
	startobj = null;
	endobj = null;
}

function getobj()//��ȡ�ڵ����2002-7-17
{
	if (event.srcElement.name == "node") 
	{
    	event.srcElement.style.backgroundColor="transparent"
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
	if(backobj!=null)
	{
    	backobj.style.backgroundColor="transparent"		        
    }
	if(event.srcElement.name == "node" && startobj != null)//����϶�����������Ӳ��Ҳ��ǳ�ʼ��
	{
		if (event.srcElement.id != startobj.id)
		{
			endobj = event.srcElement;
            endobj.style.backgroundColor="#DD9222"	
        	backobj = endobj
        }
		else
		{
			event.srcElement.style.backgroundColor="transparent"
			endobj = null;
		}
		
	}
	else
	{
		endobj = null;
	}
}
        
function fnDragOver() 
{ 
	event.returnValue = false; 
}    
