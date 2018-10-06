function isInteger(inputVal)
{
	inputStr = inputVal.toString();
	for(var i=0;i<inputStr.length;i++)
	{
		var oneChar = inputStr.charAt(i);
		if(oneChar=="-" && i==0)
		{
			continue;
		}
		if(oneChar<"0" || oneChar>"9")
		{
			return false;
		}
	}
	return true;
}