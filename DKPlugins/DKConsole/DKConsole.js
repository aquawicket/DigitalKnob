var DKConsole_color = "black";

/////////////////////////
function DKConsole_Init()
{
	DK_Create("DKConsole/DKConsole.css");
	DK_Create("DKConsole/DKConsole.html");
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
	DK_Close("DKConsole/DKConsole.html");
	DK_Close("DKConsole/DKConsole.css");
}

/////////////////////////////////
function DKConsole_OnEvent(event)
{	
	DKDEBUG("DKConsole_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	if(event.currentTarget.id === "DKConsole_Clear"){
		byId("DKConsole_Content").innerHTML = ""; //clear
	}
	if(event.currentTarget.id === "DKConsole_Close"){
		DK_Close("DKConsole/DKConsole.js");
	}
	
	if(event.type === "color"){
		DKConsole_color = DK_GetValue(event);
	}
	
	if(event.type === "notify"){
		DKConsole_Notify(DK_GetValue(event));
	}
}


/////////////////////////////////
function DKConsole_Notify(string)
{
	var line = DK_CreateElement(byId("DKConsole_Content"), "a", "DKConsole_line");
	line.style.display = "block";
	line.style.color = DKConsole_color;
	line.innerHTML = string;
	DKWidget_ScrollToBottom(line);
}