
function hidefirst()
{
	document.all.first.style.visibility="hidden"
	document.all.second.style.visibility="visible"
	return true
}

function hidesecond()
{
	document.all.second.style.visibility="hidden";
	document.all.first.style.visibility="visible";
	return true;
}
function printcn(str)
{
	if(str=="username")
	{
		document.write("用户名")
	}
	if(str=="operation")
	{
		document.write("操作")
	}
	if(str=="ip")
	{
		document.write("IP")
	}
	if(str=="searchword")
	{
		document.write("检索词")
	}
	if(str=="site")
	{
		document.write("站点")
	}
}

function hideleft()
{
	with(document.all.form1)
	{
		for(var i=0;i<preshow.length;i++)
		{
			if(preshow.options[i].selected)
			{
				for(var j=0;j<show.length;j++)
				{
					if(show.options[j].value=="")
					{
						show.options[j].value=preshow.options[i].value
						show.options[j].text=preshow.options[i].text
						break;
					}
				}
				while(i<preshow.length-1)
				{
					preshow.options[i].text=preshow.options[i+1].text
					preshow.options[i].value = preshow.options[i+1].value
					i++
				}
				preshow.options[preshow.length-1].text = ""
				preshow.options[preshow.length-1].value = ""
				
				return true
			}
		}
		return false;
	}
}
function hideright()
{
	with(document.all.form1)
	{
		for(var i=0;i<show.length;i++)
		{
			if(show.options[i].selected)
			{
				for(var j=0;j<preshow.length;j++)
				{
					if(preshow.options[j].value=="")
					{
						preshow.options[j].value=show.options[i].value
						preshow.options[j].text=show.options[i].text
						break;
					}
				}
				while(i<show.length-1)
				{
					show.options[i].text=show.options[i+1].text
					show.options[i].value = show.options[i+1].value
					i++
				}
				show.options[show.length-1].text = ""
				show.options[show.length-1].value = ""
				
				return true
			}
		}
		return false;
	}
}

function leapYear (Year)
{

        if (((Year % 4)==0) && ((Year % 100)!=0) || ((Year % 400)==0))
	{	
                return (1);
	}
        else
	{
                return (0);
	}
}
function getDaysInMonth(month,year)
{

   var days

   if(month==1||month==3||month==5||month==7||month==8||month==10||month==12)
   {
   	days=31
   }
   else
   {
   	if(month==4||month==6||month==9||month==11)
   	{
   		days=30
   	}
   	else
   	{
		if(leapYear(year)==1) 
		{	
			days=29
		}
		else
		{
			days=28
		}
	}
   }
        return (days)
}

function hideday()
{
       var tyear,tmonth,tday
       with (document.all.form1)
       {
		for(var i=0;i<13;i++)
                {
                     if(start1.options[i].selected)
                     {	
                  	tyear = start1.options[i].value
                     }
                }
                for(var j=0;j<12;j++)
                {
                	if(start2.options[j].selected)
                	{
                		tmonth = start2.options[j].value
                	}
                }

              	tday = getDaysInMonth(tmonth,tyear)

	      if(tday==28)
	      {
	      	start3.options[28].text = ""
	      	start3.options[29].text = ""
	      	start3.options[30].text = ""
	      	start3.options[28].value = ""
	      	start3.options[29].value = ""
	      	start3.options[30].value = ""
		check()
	      }
	      if(tday==29)
	      {
	      	start3.options[28].text = "29"
	      	start3.options[29].text = ""
	      	start3.options[30].text = ""
	      	start3.options[28].value = "29"
	      	start3.options[29].value = ""
	      	start3.options[30].value = ""
		check()
	      }
	      if(tday==30)
	      {
	      	start3.options[28].text = "29"
	      	start3.options[29].text = "30"
	      	start3.options[30].text = ""
	      	start3.options[28].value = "29"
	      	start3.options[29].value = "30"
	      	start3.options[30].value = ""
		check()
	      }
	      if(tday==31)
	      {
	      	start3.options[28].text = "29"
	      	start3.options[29].text = "30"
	      	start3.options[30].text = "31"
	      	start3.options[28].value = "29"
	      	start3.options[29].value = "30"
	      	start3.options[30].value = "31"
	      }
      }
      
}
function hideday1()
{
       var tyear,tmonth,tday
       with (document.all.form1)
       {
		//for(var i=0;i<9;i++)
                {
                     //if(stop1.options[i].selected)
                     {	
                  		tyear = stop1.value
                     }
                }
               // for(var j=0;j<12;j++)
                {
                	//if(stop2.options[j].selected)
                	{
                		tmonth = stop2.value
                	}
                }

              	tday = getDaysInMonth(tmonth,tyear)

	      if(tday==28)
	      {
	      	stop3.options[28].text = ""
	      	stop3.options[29].text = ""
	      	stop3.options[30].text = ""
	      	stop3.options[28].value = ""
	      	stop3.options[29].value = ""
	      	stop3.options[30].value = ""
		check()
	      }
	      if(tday==29)
	      {
	      	stop3.options[28].text = "29"
	      	stop3.options[29].text = ""
	      	stop3.options[30].text = ""
	      	stop3.options[28].value = "29"
	      	stop3.options[29].value = ""
	      	stop3.options[30].value = ""
		check()
	      }
	      if(tday==30)
	      {
	      	stop3.options[28].text = "29"
	      	stop3.options[29].text = "30"
	      	stop3.options[30].text = ""
	      	stop3.options[28].value = "29"
	      	stop3.options[29].value = "30"
	      	stop3.options[30].value = ""
		check()
	      }
	      if(tday==31)
	      {
	      	stop3.options[28].text = "29"
	      	stop3.options[29].text = "30"
	      	stop3.options[30].text = "31"
	      	stop3.options[28].value = "29"
	      	stop3.options[29].value = "30"
	      	stop3.options[30].value = "31"
	      }
      }
      
}

function check()
{
	with(document.all.form1)
	{
		if(start3.options[start3.options.selectedIndex].value=="")
		{
			start3.options[0].selected=true
			return false
		}
		if(stop3.options[stop3.options.selectedIndex].value=="")
		{
			stop3.options[0].selected=true
			return false
		}
		return true
	}
}
function ale()
{
	alert("开始时间不能大于结束的时间")
}

function prepare()
{
	if(!validcheck())
	{
		return false
	}
}

//提交前检查
function checkfeeadd()
{
	var str
	str = document.all.form1.username.value
	//alert(document.all.form1.pipei[0].value+"hello")
	//alert(document.all.form1.pipei[1].value+"hello")
	//alert("username is "+document.all.form1.username.value)
	//alert("s's length is "+str.length+" length")

	if(document.all.form1.pipei[0].checked&&!noempty(document.all.form1.username.value))
	{
		alert("完全匹配时用户名不能为空！")
		return false
	}
	prepare()
	//return true
}


function selall()
{
	with(document.all.form1)
	{
		var j = 0
		for(var i=0;i<show.length;i++)
		{
			if(show.options[i].value!="")
			{
				show.options[i].selected=true
				j++
			}
		}
		if(j==0)
		{
			alert("请选择需要统计的字段!")
			return false
		}
		else
		{
			return true
		}
	}
}

function validcheck()
{
	var startyear,stopyear,startmonth,stopmonth,startday,stopday
	var start,stop
	with(document.all.form1)
	{
		startyear = start1.options[start1.selectedIndex].value
		stopyear  = stop1.options[stop1.selectedIndex].value
		startmonth= start2.options[start2.selectedIndex].value
		stopmonth  = stop2.options[stop2.selectedIndex].value
		startday  = start3.options[start3.selectedIndex].value
		stopday  = stop3.options[stop3.selectedIndex].value
		start = parseInt(startyear+startmonth+startday)
		stop  = parseInt(stopyear+stopmonth+stopday)
	}
	if(start>stop)
	{
		ale()
		return false
	}
	else
	{
		return true
	}
}

function usercheck()
{
	if(!validcheck())
	{
		return false
	}
	if(!checkip())
	{
		document.all.form1.ip1.focus()
		return false
	}
	if(!checkchannel())
	{
		return false
	}
	if(!checkcost()||!checkcost2())
	{
		return false
	}
	if(!selall())
	{
		document.all.form1.preshow.focus()
		return false
	}
	if(!checksite())
	{
	        document.all.form1.siteid.focus()
	        return false
	}
	return true	
}

//检查IP地址的合法性
function checkip()
{
	var strip
	with(document.all.form1)	
	{
		strip = new String(ip1.value)
		//check for valid char
		for(var i=0;i<strip.length;i++)
		{
			if(isNaN(strip.substring(i,i+1)))
			{
				if(strip.substring(i,i+1)==".")
				{
					continue;
				}
				alert("不合法的IP地址："+ strip)
				return false
			}
		}
		//check for valid number
		var str
		str = strip.split(".");
		for(var k=0;k<str.length;k++)
		{
			if(str[k]<0||str[k]>255)
			{
				alert("不合法的IP地址："+ strip)
				return false
			}
			if(k==3&&str[k]<1)
			{
				alert("ip地址第四位应该大于0！")
				return false
			}
		}

		return true		
	}
}

//判断是否为空串
function noempty(str)
{
	var s = new String(str)
	for(var i=0;i<s.length;i++)
	{
		if(str.charAt(i)!=" "&&str.charAt(i)!=""&&str.charAt(i)!=null)	
		{
			return true
		}
	}
	return false
}

function checkchannel()
{
	with(document.all.form1)
	{
		var cid = new String(channelids.value)
		if(isNaN(cid)||parseInt(cid)<0)
		{
			alert("请在频道号的输入框里输入大于0的数字！")
			channelids.focus()
			return false
		}
		return true
	}	
}

//检查输入开销数目
function checkcost()
{
	with(document.all.form1)
	{
		var c1 = new String(cost.value)
		if(isNaN(c1)||parseInt(c1)<0)
		{
			alert("请在费用的输入框里输入大于0的数字！")
			cost.focus()
			return false
		}
		return true
	}
}

function checkcost2()
{
	with(document.all.form1)
	{
		var c2 = new String(cost2.value)
		if(isNaN(c2)||parseInt(c2)<0)
		{
			alert("请在费用的输入框里输入大于0的数字！")
			cost2.focus()
			return false
		}
		return true
	}
}

function checksite()
{
	with(document.all.form1)
	{
		for(var i=0;i<siteid.options.length;i++)	
		{
			if(siteid.options[i].selected)
			{
				return true
			}
		}
	}
	alert("请选则要统计的站点")
	return false
}

