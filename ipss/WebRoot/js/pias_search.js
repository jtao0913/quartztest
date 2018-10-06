//进度条
var bar=0; 
var line="||"; 
var amount="||";

function count(){ 
	bar=bar+2 ;
	amount =amount + line; 
	document.loading.chart.value=amount; 
	document.loading.percent.value=bar+"%"; 
	if (bar<99) 
	{
		setTimeout("count()",700);
	}
} 


//显示和隐藏select控件	
function DispalySelect(val)
{  
  var dispalyType;
  var arrdispalyType=["hidden","visible"];
  var arrObjSelect=document.getElementsByTagName("select");
  for (i=0;i<arrObjSelect.length;i++)
  {
    arrObjSelect[i].style.visibility=arrdispalyType[val];
  }
}
  
//显示等待窗口  
function showFullDiv()
{//alert("me");
	 
	
	var lightBox=document.getElementById("lightbox");
	lightbox.style.display="block";
	lightbox.style.left=(document.body.clientWidth/2-parseInt(lightbox.style.width,10)/2+"px");
	lightbox.style.top=(document.body.clientHeight/2-parseInt(lightbox.style.height,10)/2+"px");


	//document.piasform.submit();	
}

var pathHead="pias";//项目的布署名

//
var httpRequest;
function createRequest()
{
    try{
        request=new XMLHttpRequest();
    }catch(trymicrosoft)
    {
        try{
            request=new ActiveXObject("Msxml2.XMLHTTP");
        }catch(othermicrosoft)
        {
            try{
                request=new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch(failed)
            {
                request=false;
            }
        }
    }
    if(!request)
    {
       alert("err Happend!");
       return null;
    }        
    return request;
}

function send()
{
	showMask();
	showFullDiv();
  
	bar=0; 
	line="||"; 
	amount="||";
	count(); 
	  
  /*第一种方式
  $.getJSON("http://218.240.13.217/pias/jsp/data/search/searchdo_jiangsu.jsp?" + "searchword=" + encodeURI(document.piasform.searchword.value) + "&channelid=" + document.piasform.channelid.value + "&extension=" + document.piasform.extension.value + "&cizi=" + document.piasform.cizi.value + "&recordnum=" + document.piasform.recordnum.value + "&callback=?",
  function(data){
  	alert(data[0].name);
  	}
  
  ); 
  */

  
  //第二种方式
  $.ajax({
	   type: "GET",
	   url: "http://218.240.13.217/pias/jsp/data/search/searchdo_yinzhou.jsp?" + "searchword=" + encodeURI(document.piasform.searchword.value) + "&channelid=" + document.piasform.channelid.value + "&extension=" + document.piasform.extension.value + "&cizi=" + document.piasform.cizi.value + "&recordnum=" + document.piasform.recordnum.value + "&callback=?",
 	   //data: "searchword=" + encodeURI(document.piasform.searchword.value) + "&channelid=" + document.piasform.channelid.value + "&extension=" + document.piasform.extension.value + "&cizi=" + document.piasform.cizi.value + "&recordnum=" + document.piasform.recordnum.value ,
	   //async: false,
	   dataType:"jsonp",
   	   jsonp:"callback",
	   error:function() {
	   	alert("出错了。");	
	   },
	   success: function(msg){
		document.loading.percent.value=bar+"%"; 
		if (bar<99) 
		{
			document.loading.percent.value="100%";
		}
	
	   	var lightBox=document.getElementById("lightbox");
	   	lightbox.style.display="none";
	    	
	    	closeMask();
	    	
	    	//alert(msg[0].name);
	    	
	    	
	    	if (msg[0].name=="0")
	    	{
	    		alert("没有检索到相关记录。");	
	    	} else if (msg[0].name.indexOf("^")>0)
	    	{
	        	var msgarr=msg[0].name.split("^");
	        
	        	if (msgarr!=null)
	        	{
	        		//alert(msgarr[0]);
	        	 	if (msgarr[0]=="2")
	        		{
	        			alert("分析数据超过上限 " + msgarr[1] + "条专利，请缩小范围，重新进行分析。");	
	        		}	
	        	}  else 
	        	{
	        		alert("分析出错，请您重新进行分析。");	
	        	}	
	        } else if (msg!=null &&  msg!="" && msg!="null")	
	        {
	        		//alert(msgarr[1]);
	        		var open = window.open(msg[0].name,"piaswin");
	        		open.focus();
	        } else
	        {
	        	alert("分析出错，请您重新进行分析。");	
	        }
	       	       
	   }
   });
   

       
   
 
}

//
function disResult()
{

    if(httpRequest.readyState==4)
    {
        if(httpRequest.Status==200)
        {
            
            var docmsg=httpRequest.responseText;
            //alert(docmsg);

	    var lightBox=document.getElementById("lightbox");
	    lightbox.style.display="none";

	    if (docmsg=="")
	    {
		alert("分析出错，请重新分析。");
            } else
	    {
            	window.open(docmsg); 		            
            }
            //alert('done');
        }
        else
        {
            alert('Something Wrong has Happend!');
        }
    }
}

/**   
 * 页面遮罩   
 * 在body后：   
 *  <!-- 透明遮罩 -->   
 *      <DIV id="divMask"></div>   
 *  <!-- 透明遮罩 end -->   
 *             
 * 调用 showMask() 打开遮罩   closeMask()关闭遮罩   
 * author:lym6520@qq.com  08/11/25   
 */   

function showMask(){  
      DispalySelect(0);	  
      
      //var h=document.documentElement.clientHeight;
      //var w=document.documentElement.clientWidth;
      var divMask = document.getElementById('divMask');    
      divMask.style.backgroundColor = '#ccc';    
      divMask.style.left = '0px';     
      divMask.style.position = 'absolute';    
      divMask.style.top = '0px';   
      //divMask.style.width=w + "px";
      divMask.style.height="100%";
          
      resizeMask();    
      window.onresize = resizeMask;    
      
      //opacity:0.5;
      //-moz-opacity:0.5;
}    
function closeMask()    
{     
      DispalySelect(1);
      var divMask = document.getElementById('divMask');    
      divMask.style.width = "0px";    
      divMask.style.height = "0px";    
      window.onresize = null;    
}    
function resizeMask()    
{     var divMask = document.getElementById('divMask');    
      divMask.style.width = document.body.scrollWidth;    
      divMask.style.height = document.body.scrollHeight;    
   
}   
