// Copyright 2002 . All rights reserved.

//--------------- LOCALIZEABLE GLOBALS ---------------
//---------------   GLOBAL VARIABLES   ---------------

//---------------     API FUNCTIONS    ---------------

//---------------    LOCAL FUNCTIONS   ---------------

	function addcolumn() 
	{
		var columnlistobj = document.getElementById("columnlist");//list column  object
		var columnselectobj = document.getElementById("columnselect");//list selected column object
		var selectedobj;
		var oOption = document.createElement("OPTION");
		var order="";
		var orderby="";
		for(var i = 0 ; i < columnlistobj.options.length ; i++)
		{
			if (columnlistobj.options(i).selected)
			{
				selectedobj = columnlistobj.options(i);
				columnlistobj.options.remove(i);
				if(i<columnlistobj.length)
				{
					columnlistobj.options(i).selected=true;
				}else
				{
					if(columnlistobj.options.length>0)
					{
						columnlistobj.options(0).selected=true;
					}
				}
			}
		}
		if (selectedobj != null)
		{
			if (!(columnselectobj.contains(selectedobj)))
			{
				columnselectobj.options.add(oOption);
				oOption.innerText = selectedobj.text;
				oOption.value = selectedobj.value;
				oOption.selected = true;
			}
		}
	}
//------------------------remove selected column from list-----------------------------------------------//
	function removecolumn()//remove column from selected list（删除字段从选择列表）
	{
		var columnlistobj = document.getElementById("columnlist");//list column  object
		var columnselectobj = document.getElementById("columnselect");//list selected column object
		for(var i = 0 ; i < columnselectobj.options.length ; i++)
		{
			if (columnselectobj.options(i).selected)
			{
				selectobj=columnselectobj.options(i);
				var oOption = document.createElement("OPTION");
				columnlistobj.options.add(oOption);
				oOption.innerText=selectobj.text;
				oOption.value=selectobj.value;
				columnselectobj.options.remove(i);			//removing selected column
				if(i<columnselectobj.length)
				{
					columnselectobj.options(i).selected=true;
				}else
				{
					if(columnselectobj.options.length>0)
					{
						columnselectobj.options(0).selected=true;
					}
				}
			}
		}
	}
//-------------------------------------------------------------------------------------------------------
	function removeAllcolumn()//remove all column from selected list（删除所有字段从选择列表）
	{
		var columnselectobj = document.getElementById("columnselect");
		var columnlistobj = document.getElementById("columnlist");
		for(var i = 0 ; i < columnselectobj.options.length ; i++)//add all column to selected box
		{
			var oOption = document.createElement("OPTION");
			columnlistobj.options.add(oOption);
			oOption.innerText = columnselectobj.options(i).text;
			oOption.Value = columnselectobj.options(i).value;
		}
		var length=columnselectobj.options.length;
		for(var i = 0 ; i < length ; i++)
		{
				columnselectobj.options.remove(0);
		}
		oOption=null;
	}
//-------------------------------------------------------------------------------------------------------
function addallcolumn()//add all list column to selected（添加所有字段从选择列表）
	{
		var columnlistobj = document.getElementById("columnlist");
		var columnselectobj = document.getElementById("columnselect");
		for(var i = 0 ; i < columnlistobj.options.length ; i++)//add all column to selected box
		{
			var oOption = document.createElement("OPTION");
			columnselectobj.options.add(oOption);
			oOption.innerText = columnlistobj.options(i).text;
			oOption.Value = columnlistobj.options(i).value;
		}
		var length=columnlistobj.options.length;
		for(var i=0;i <length; i++)
		{
			columnlistobj.options.remove(0);
		}
		oOption=null;
	}
//-------------------------------------------------------------------------------------------------------
	function submitselect()//check selected and submit selected （检查选择并提交）
	{
		var columnselectobj = document.getElementById("columnselect");
		var subvalue = "";
		for (var i = 0 ; i < columnselectobj.options.length ; i++)// join selected column to String 
		{
			
			if (i != columnselectobj.options.length-1)
			{
				subvalue += columnselectobj.options(i).text+"##";
			}
			else
			{
				subvalue += columnselectobj.options(i).text;
			}
		}
		if (subvalue != "") //check 
		{
			document.form1.cvalue.value = subvalue ;
			document.form1.submit();
		}
		else
		{
			document.form1.cvalue.value = "";
			document.form1.submit();

		}
		
	}
//--------------------Edit Outline-----------------------------------------------//
function showColumn(mType)
{
	if(mType!=""&&mType!=undefined)
	{
		window.open('selectcolumn.jsp?type='+mType,'','width=400,height=250,top=240,left=200 ,toolbar=no, menubar=no, scrollbars=no, resizable=yes, location=no, status=no');
	}else
	{
		return false;
	}
}