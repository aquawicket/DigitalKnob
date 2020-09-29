var DKConsole_color = "black";

/////////////////////////
function DKConsole_Init()
{
	DKCreate("DKConsole/DKConsole.css");
	DKCreate("DKConsole/DKConsole.html");
	DKAddEvent("DKConsole_Clear", "click", DKConsole_OnEvent);
	DKAddEvent("DKConsole_Close", "click", DKConsole_OnEvent);
	DKAddEvent("window", "color", DKConsole_OnEvent);
	DKAddEvent("window", "notify", DKConsole_OnEvent);
}

////////////////////////
function DKConsole_End()
{
	DKRemoveEvents(DKConsole_OnEvent);
	DKClose("DKConsole/DKConsole.html");
	DKClose("DKConsole/DKConsole.css");
}

/////////////////////////////////
function DKConsole_OnEvent(event)
{	
	DKDEBUG("DKConsole_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	if(event.currentTarget.id == "DKConsole_Clear"){
		DKWidget_SetInnerHtml("DKConsole_Content","");
	}
	if(event.currentTarget.id == "DKConsole_Close"){
		DKClose("DKConsole/DKConsole.js");
	}
	
	if(event.type == "color"){
		DKConsole_color = DK_GetValue(event);
	}
	
	if(event.type == "notify"){
		DKConsole_Notify(DK_GetValue(event));
	}
}


/////////////////////////////////
function DKConsole_Notify(string)
{
	var line = DKWidget_CreateElement("DKConsole_Content", "a", "DKConsole_line");
	document.getElementById(line).style.display = "block";
	document.getElementById(line).style.color = DKConsole_color;
	DKWidget_SetInnerHtml(line, string);
	DKWidget_ScrollToBottom(line);
}