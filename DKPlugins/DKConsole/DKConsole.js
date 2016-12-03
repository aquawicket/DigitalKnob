var DKConsole_level;

/////////////////////////
function DKConsole_Init()
{
	DKCreate("DKConsole/DKConsole.html");
	DKAddEvent("DKConsole_Clear", "click", DKConsole_OnEvent);
	DKAddEvent("DKConsole_Close", "click", DKConsole_OnEvent);
	DKAddEvent("DKLog", "string", DKConsole_OnEvent);
	DKAddEvent("DKLog", "level", DKConsole_OnEvent);
}

////////////////////////
function DKConsole_End()
{
	DKRemoveEvent("DKLog", "string", DKConsole_OnEvent);
	DKRemoveEvent("DKLog", "level", DKConsole_OnEvent);
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
	
	if(DK_Type(event, "level")){
		DKConsole_level = DKWidget_GetValue(event);
	}
	
	if(DK_Type(event, "string")){
		DKConsole_Log(DKWidget_GetValue(event));
	}
}


//////////////////////////////
function DKConsole_Log(string)
{
	var line = DKWidget_CreateElement("DKConsole_Content", "a", "DKConsole_line");
	DKWidget_SetProperty(line,"display","block");
	if(DKConsole_level == "0"){
		DKWidget_SetProperty(line,"color","red");
	}
	else if(DKConsole_level == "1"){
		DKWidget_SetProperty(line,"color","yellow");
	}
	else if(DKConsole_level == "2"){
		DKWidget_SetProperty(line,"color","black");
	}
	else if(DKConsole_level == "3"){
		DKWidget_SetProperty(line,"color","blue");
	}
	DKWidget_SetInnerHtml(line, string);
	DKWidget_ScrollToBottom(line);
}
