var DKConsole_color = "black";

/////////////////////////
function DKConsole_Init()
{
	//DKLog("DKConsole_Init() \n");
	
	DKCreate("DKConsole/DKConsole.html");
	DKAddEvent("DKConsole_Clear", "click", DKConsole_OnEvent);
	DKAddEvent("DKConsole_Close", "click", DKConsole_OnEvent);
	DKAddEvent("DKLog", "color", DKConsole_OnEvent);
	DKAddEvent("DKLog", "notify", DKConsole_OnEvent);
}

////////////////////////
function DKConsole_End()
{
	//DKLog("DKConsole_End() \n");
	
	DKRemoveEvents(DKConsole_OnEvent);
	DKClose("DKConsole/DKConsole.html");
}

/////////////////////////////////
function DKConsole_OnEvent(event)
{	
	//DKLog("DKConsole_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");

	if(DK_Id(event, "DKConsole_Clear")){
		DKWidget_SetInnerHtml("DKConsole_Content","");
	}
	if(DK_Id(event, "DKConsole_Close")){
		DKClose("DKConsole.js");
	}
	
	if(DK_Type(event, "color")){
		DKConsole_color = DK_GetValue(event);
	}
	
	if(DK_Type(event, "notify")){
		DKConsole_Notify(DK_GetValue(event));
	}
}


/////////////////////////////////
function DKConsole_Notify(string)
{
	var line = DKWidget_CreateElement("DKConsole_Content", "a", "DKConsole_line");
	DKWidget_SetProperty(line,"display","block");
	DKWidget_SetProperty(line,"color",DKConsole_color);
	DKWidget_SetInnerHtml(line, string);
	DKWidget_ScrollToBottom(line);
}