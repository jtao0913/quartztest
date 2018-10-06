var pwindow = window.dialogArguments;
var arr = new Array();
var arr_value = new Array();
var SelectItem;

function GetArray(oSel)
{
  //将select中的所有option的value值将保存在Array中
  for (var i = 0; i < SelectItem.length; i++)
  {
    arr[i] = oSel.options[i].text;
	arr_value[i] = oSel.options[i].value;
  }
}
//向上移动
function MoveUp(oSel)
{
  //选中项的ID号
  var selectIndex = oSel.selectedIndex;
  SelectItem = oSel;
  
  if(selectIndex == -1)
  {
    alert('请先选择要移动的项');
    return false;
  }

  GetArray(oSel);
  if(ChangOrder(selectIndex,'UP') == true)
  {
	  DisabledButton(true);
	  UpdateSelect();
	  //设定原来选定的项  
	  SelectItem.selectedIndex = selectIndex - 1;
	  DisabledButton(false);
  }
  else
	  SelectItem.selectedIndex = selectIndex;
}

function DisabledButton(flag)
{
	document.form1.moveup.disabled = flag;
	document.form1.movedown.disabled = flag;
}

//向下移动
function MoveDown(oSel)
{
  //选中项的ID号
  var selectIndex = oSel.selectedIndex;
  SelectItem = oSel;
  
  if(selectIndex == -1)
  {
    alert('请先选择要移动的项');
    return false;
  }

  GetArray(oSel);
  if(ChangOrder(selectIndex,'DOWN') == true)
  {
		DisabledButton(true);
		UpdateSelect();
	
		//设定原来选定的项  
		SelectItem.selectedIndex = selectIndex + 1;
		DisabledButton(false);
  }
  else
		SelectItem.selectedIndex = selectIndex;

}

function ChangOrder(i,t)
{
  var s1;
  var s2;
  var s3;
  var s4
  var m;

  if(t == "UP" && i == 0)
  {
    alert('已经是第一项了');
    return false;
  }
  if(t == "DOWN" && i == SelectItem.length - 1)
  {
    alert('已经是最末项了');
    return false;  
  }

  if(t == 'UP' && i > 0)
    m = i - 1;
  if(t == "DOWN" && i < SelectItem.length-1)
    m = i + 1;


  for(j = 0; j < arr.length; j++)
  {
    if(j == m)
    {s1 = arr[j];s3=arr_value[j];}
    if(j == i)
    {s2 = arr[j];s4=arr_value[j];}
  }
  arr[m] = s2;
  arr[i] = s1;
  
  arr_value[m]=s4;
  arr_value[i]=s3;
  return true;
}

function UpdateSelect()
{
	//清空Select中全部Option
	var ln = SelectItem.length;
	while (ln--)
	{
	  SelectItem.options[ln] = null;
	}
	
	//将排序后的数组重新添加到Select中
	for (i = 0; i < arr.length; i++)
	{
	  SelectItem.add (new Option(arr[i], arr_value[i]));
	}
}
function getSelectedFields(sel_dest)
{
   var sel_dest_len = sel_dest.length;
   var sel_dests="";
   for (var j=0; j<sel_dest_len; j++)
   {
     var SelectedText = sel_dest.options[j].value;
//     sel_dest.options.add(new Option(SelectedText));
	 sel_dests=sel_dests+"#"+SelectedText;
   }
   sel_dests=sel_dests.substring(1);
//alert(sel_dests);
	return sel_dests; 
}
function setCookie(sel_dest, strType)
{
	var strSelectedFields = getSelectedFields(sel_dest);

	var strCookieName = "CNDisplayCookies=";
	if(strType == "0")
		strCookieName = "CNDisplayCookies=";
	else
		strCookieName = "FRDisplayCookies=";

	if(document.all.txtSaveDays.value != null && document.all.txtSaveDays.value != "" && document.all.txtSaveDays.value != 0)
	{
		var tmpSaveDays = document.all.txtSaveDays.value;
		if(isNaN(parseInt(tmpSaveDays)))
			tmpSaveDays = 1;
		var dtToday = new Date();
		var strSaveDays = dtToday.getTime() + ((parseInt(tmpSaveDays))*24*60*60*1000);
		dtToday.setTime(strSaveDays);
		document.cookie = strCookieName+escape(strSelectedFields)+" ; expires="+dtToday.toGMTString()+" ; path=/"; 
	}
	else
	{
		document.cookie = strCookieName+escape(strSelectedFields);
	}
	pwindow.location.reload();
	window.close();
}