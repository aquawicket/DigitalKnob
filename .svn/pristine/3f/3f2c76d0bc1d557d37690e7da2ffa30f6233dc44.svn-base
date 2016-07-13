/////////////////////////
function DKConsole_Init()
{
	DKCreate("DKConsole/DKConsole.html");
	DKAddEvent("DKConsoleClose", "click", DKConsole_OnEvent);
	DKAddEvent("DKConsoleInput", "keydown", DKConsole_OnEvent);
}

////////////////////////
function DKConsole_End()
{
	DKClose("DKConsole.html");
}

/////////////////////////////////
function DKConsole_OnEvent(event)
{	
	/*
	if(DK_Id(event, "DKConsoleClear")){
		DKWidget_SetAttribute("DKConsoleText", "value", "");
		DKWidget_SetAttribute("DKConsoleInput", "value", "");
		DK_System("cls");
	}
	
	if(DK_Id(event, "DKConsoleHide")){
		DKConsole_Hide();
	}
	if(DK_Id(event, "DKConsoleShow")){
		DKConsole_Show()
	}
	*/
	
	if(DK_Id(event, "DKConsoleClose")){
		DKClose("DKWidget,DKConsole/DKConsole.html");
		DKClose("DKJavascript,DKConsole/DKConsole.js");
	}
	
	if(DK_Type(event, "DKNotify")){
		DKConsole_Notify(DKWidget_GetValue(event));
	}
	
	if(DK_Id(event, "DKConsoleInput")){
		var value = DKWidget_GetValue(event);
		if(value != "72"){ return; } //Enter
		DKConsole_Input(DKWidget_GetValue("DKConsoleInput"));
	}
}


/////////////////////////////////
function DKConsole_Notify(string)
{
	string = string.replace("\n", "");
	DKWidget_SetAttribute("DKConsoleText", "value", DKWidget_GetAttribute("DKConsoleText", "value")+string+"\n");
	DKWidget_SetAttribute("DKConsoleText", "scrollTop", DKWidget_GetAttribute("DKConsoleText", "scrollHeight"));
}

////////////////////////////////
function DKConsole_Input(string)
{
	//DKLog("DKConsole_Input("+string+") \n", DKDEBUG);
	DK_RunJavascript(string);
}

/////////////////////////
function DKConsole_Hide()
{
	DKWidget_SetProperty("DKConsole.html", "width", "0px");
	DKWidget_SetProperty("DKConsole.html", "height", "0px");
	DKWidget_Hide("DKConsoleDiv");
	DKWidget_Show("DKConsoleShow");
}

/////////////////////////
function DKConsole_Show()
{
	DKWidget_SetProperty("DKConsole.html", "width", "100%");
	DKWidget_SetProperty("DKConsole.html", "height", "120px");
	DKWidget_Show("DKConsoleDiv");
	DKWidget_Hide("DKConsoleShow");
}


