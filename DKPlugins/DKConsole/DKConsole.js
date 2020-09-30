var DKConsole_color = "black";

/////////////////////////
function DKConsole_Init()
{
	DKCreate("DKConsole/DKConsole.css");
	DKCreate("DKConsole/DKConsole.html");
	window.addEventListener("color", DKConsole_OnEvent);
	window.addEventListener("notify", DKConsole_OnEvent);
	byId("DKConsole_Clear").addEventListener("click", DKConsole_OnEvent);
	byId("DKConsole_Close").addEventListener("click", DKConsole_OnEvent);
}

////////////////////////
function DKConsole_End()
{
	window.removeEventListener("color", DKConsole_OnEvent);
	window.removeEventListener("notify", DKConsole_OnEvent);
	byId("DKConsole_Clear").removeEventListener("click", DKConsole_OnEvent);
	byId("DKConsole_Close").removeEventListener("click", DKConsole_OnEvent);
	DKClose("DKConsole/DKConsole.html");
	DKClose("DKConsole/DKConsole.css");
}

/////////////////////////////////
function DKConsole_OnEvent(event)
{	
	DKDEBUG("DKConsole_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	if(event.currentTarget.id == "DKConsole_Clear"){
		byId("DKConsole_Content").innerHTML = ""; //clear
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
	var line = DKWidget_CreateElement(byId("DKConsole_Content"), "a", "DKConsole_line");
	document.getElementById(line).style.display = "block";
	document.getElementById(line).style.color = DKConsole_color;
	byId(line).innerHTML = string;
	DKWidget_ScrollToBottom(line);
}