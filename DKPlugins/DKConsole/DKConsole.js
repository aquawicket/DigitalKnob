var DKConsole_color = "black";

/////////////////////////
function DKConsole_Init()
{
	DKCreate("DKConsole/DKConsole.html");
	DKAddEvent("DKConsole_Clear", "click", DKConsole_OnEvent);
	DKAddEvent("DKConsole_Close", "click", DKConsole_OnEvent);
	DKAddEvent("DKLog", "color", DKConsole_OnEvent);
	DKAddEvent("DKLog", "notify", DKConsole_OnEvent);
}

////////////////////////
function DKConsole_End()
{
	DKRemoveEvent("DKLog", "color", DKConsole_OnEvent);
	DKRemoveEvent("DKLog", "notify", DKConsole_OnEvent);
	DKClose("DKConsole/DKConsole.html");
}

/////////////////////////////////
function DKConsole_OnEvent(event)
{	
	if(DK_Id(event, "DKConsole_Clear")){
		DKWidget_SetInnerHtml("DKConsole_Content","");
	}
	if(DK_Id(event, "DKConsole_Close")){
		DKClose("DKConsole/DKConsole.js");
	}
	
	if(DK_Type(event, "color")){
		DKConsole_color = DKWidget_GetValue(event);
	}
	
	if(DK_Type(event, "notify")){
		DKConsole_Notify(DKWidget_GetValue(event));
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
