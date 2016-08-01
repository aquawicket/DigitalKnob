/////////////////////////
function DKConsole_Init()
{
	DKCreate("DKConsole/DKConsole.html");
	DKAddEvent("DKConsoleClose", "click", DKConsole_OnEvent);
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
	
	if(DK_Type(event, "DKNotify")){
		DKConsole_Notify(DKWidget_GetValue(event));
	}
}


/////////////////////////////////
function DKConsole_Notify(string)
{
	string = string.replace("\n", "");
	DKWidget_SetAttribute("DKConsoleText", "value", DKWidget_GetAttribute("DKConsoleText", "value")+string+"\n");
	DKWidget_SetAttribute("DKConsoleText", "scrollTop", DKWidget_GetAttribute("DKConsoleText", "scrollHeight"));
}
