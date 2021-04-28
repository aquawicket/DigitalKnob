var DKConsole_color = "black";

/////////////////////////
function DKConsole_init()
{
	dk.create("DKConsole/DKConsole.css");
	dk.create("DKConsole/DKConsole.html");
	window.addEventListener("color", DKConsole_onevent);
	window.addEventListener("notify", DKConsole_onevent);
	byId("DKConsole_Clear").addEventListener("click", DKConsole_onevent);
	byId("DKConsole_Close").addEventListener("click", DKConsole_onevent);
}

////////////////////////
function DKConsole_end()()
{
	window.removeEventListener("color", DKConsole_onevent);
	window.removeEventListener("notify", DKConsole_onevent);
	byId("DKConsole_Clear").removeEventListener("click", DKConsole_onevent);
	byId("DKConsole_Close").removeEventListener("click", DKConsole_onevent);
	dk.close("DKConsole/DKConsole.html");
	dk.close("DKConsole/DKConsole.css");
}

/////////////////////////////////
function DKConsole_OnEvent(event)
{	
	DKDEBUG("DKConsole_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	if(event.currentTarget.id === "DKConsole_Clear"){
		byId("DKConsole_Content").innerHTML = ""; //clear
	}
	if(event.currentTarget.id === "DKConsole_Close"){
		dk.close("DKConsole/DKConsole.js");
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
	DK_ScrollToBottom(line);
}