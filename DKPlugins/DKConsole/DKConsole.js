var DKConsole_color = "black";

/////////////////////////
function DKConsole_Init()
{
	DKCreate("DKConsole/DKConsole.html");
	DKAddEvent("DKConsoleClose", "click", DKConsole_OnEvent);
	DKAddEvent("DKLog", "color", DKConsole_OnEvent);
	DKAddEvent("DKLog", "notify", DKConsole_OnEvent);
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
	var line = DKWidget_CreateElement("DKConsole.html", "a", "DKConsole_line");
	DKWidget_SetProperty(line,"display","block");
	DKWidget_SetProperty(line,"color",DKConsole_color);
	DKWidget_SetInnerHtml(line, string);
	DKWidget_ScrollToBottom(line);
}
