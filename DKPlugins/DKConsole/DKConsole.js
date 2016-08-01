/////////////////////////
function DKConsole_Init()
{
	DKCreate("DKConsole/DKConsole.html");
	DKAddEvent("DKConsoleClose", "click", DKConsole_OnEvent);
	DKAddEvent("DKLog", "notify", DKConsole_OnEvent);
	
	/*
	DKConsole_Notify("1");
	DKConsole_Notify("2");
	DKConsole_Notify("3");
	DKConsole_Notify("4");
	DKConsole_Notify("5");
	DKConsole_Notify("6");
	DKConsole_Notify("7");
	DKConsole_Notify("8");
	DKConsole_Notify("9");
	DKConsole_Notify("10");
	DKConsole_Notify("11");
	DKConsole_Notify("12");
	DKConsole_Notify("13");
	DKConsole_Notify("14");
	DKConsole_Notify("15");
	*/
}

////////////////////////
function DKConsole_End()
{
	DKClose("DKConsole/DKConsole.html");
}

/////////////////////////////////
function DKConsole_OnEvent(event)
{	
	if(DK_Id(event, "DKConsoleClose")){
		DKClose("DKConsole/DKConsole.js");
	}
	
	if(DK_Type(event, "notify")){
		DKConsole_Notify(DKWidget_GetValue(event));
	}
}


/////////////////////////////////
function DKConsole_Notify(string)
{
	var line = DKWidget_CreateElement("DKConsole.html", "a", "DKConsole_line");
	DKWidget_SetProperty(line,"display","block");
	DKWidget_SetInnerHtml(line, string);
	DKWidget_ScrollToBottom(line);
}
