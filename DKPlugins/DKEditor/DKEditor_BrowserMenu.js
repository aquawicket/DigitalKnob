////////////////////////////////////
function DKEditor_BrowserMenu_Init()
{
	DK_Create("DKEditor/DKEditor_BrowserMenu.html");
	window.addEventListener("mousedown", DKEditor_BrowserMenu_OnEvent);
	
	DKEditor_BrowserMenu_Populate();
}

///////////////////////////////////
function DKEditor_BrowserMenu_End()
{
	window.removeEventListener("mousedown", DKEditor_BrowserMenu_OnEvent);
	DK_Close("DKEditor/DKEditor_BrowserMenu.html");
}

////////////////////////////////////////////
function DKEditor_BrowserMenu_OnEvent(event)
{
	console.log("DKEditor_BrowserMenu_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	if(event.currentTarget.id === "DKEditor_BrowserMenu_Chrome"){
		DK_Run("C:/Program Files (x86)/Google/Chrome/Application/chrome.exe", "--allow-file-access-from-files "+DKApp_url);
	}
	if(event.currentTarget.id === "DKEditor_BrowserMenu_Firefox"){
		DK_Run("C:/Program Files (x86)/Mozilla Firefox/firefox.exe", DKApp_url);
	}
	if(event.currentTarget.id === "DKEditor_BrowserMenu_IE"){
		var url = DKApp_url.replace("file:///", "");
		DK_Run("C:/Program Files (x86)/Internet Explorer/iexplore.exe", url);
	}
	if(event.currentTarget.id === "DKEditor_BrowserMenu_Opera"){
		DK_Run("C:/Program Files/Opera/launcher.exe", "--allow-file-access-from-files "+DKApp_url);
	}
	if(event.currentTarget.id === "DKEditor_BrowserMenu_Safari"){
		DK_Run("C:/Program Files (x86)/Safari/Safari.exe", DKApp_url);
	}
	
	//////////////////////////////////
	if(event.currentTarget === window){
		if(byId("DKEditor/DKEditor_BrowserMenu.html").contains(DKWidget_GetHoverElement())){
			return;
		}
	}
	
	DK_Close("DKEditor/DKEditor_BrowserMenu.js");
}

////////////////////////////////////////
function DKEditor_BrowserMenu_Populate()
{
	DKEditor_BrowserMenu_AddChrome();
	DKEditor_BrowserMenu_AddFirefox();
	DKEditor_BrowserMenu_AddIE();
	DKEditor_BrowserMenu_AddOpera();
	DKEditor_BrowserMenu_AddSafari();
}

/////////////////////////////////////////
function DKEditor_BrowserMenu_AddChrome()
{
	DKWidget_CreateElement(byId("DKEditor/DKEditor_BrowserMenu.html"), "div", "DKEditor_BrowserMenu_Chrome");
	byId("DKEditor_BrowserMenu_Chrome").class = "option";
	byId("DKEditor_BrowserMenu_Chrome").innerHTML = "Chrome";
	byId("DKEditor_BrowserMenu_Chrome").addEventListener("click", DKEditor_BrowserMenu_OnEvent);
}


//////////////////////////////////////////
function DKEditor_BrowserMenu_AddFirefox()
{
	DKWidget_CreateElement(byId("DKEditor/DKEditor_BrowserMenu.html"), "div", "DKEditor_BrowserMenu_Firefox");
	byId("DKEditor_BrowserMenu_Firefox").class = "option";
	byId("DKEditor_BrowserMenu_Firefox").innerHTML = "Firefox";
	byId("DKEditor_BrowserMenu_Firefox").addEventListener("click", DKEditor_BrowserMenu_OnEvent);
}

/////////////////////////////////////
function DKEditor_BrowserMenu_AddIE()
{
	DKWidget_CreateElement(byId("DKEditor/DKEditor_BrowserMenu.html"), "div", "DKEditor_BrowserMenu_IE");
	byId("DKEditor_BrowserMenu_IE").class = "option";
	byId("DKEditor_BrowserMenu_IE").innerHTML = "Internet Explorer";
	byId("DKEditor_BrowserMenu_IE").addEventListener("click", DKEditor_BrowserMenu_OnEvent);
}

////////////////////////////////////////
function DKEditor_BrowserMenu_AddOpera()
{
	DKWidget_CreateElement(byId("DKEditor/DKEditor_BrowserMenu.html"), "div", "DKEditor_BrowserMenu_Opera");
	byId("DKEditor_BrowserMenu_Opera").class = "option";
	byId("DKEditor_BrowserMenu_Opera").innerHTML = "Opera";
	byId("DKEditor_BrowserMenu_Opera").addEventListener("click", DKEditor_BrowserMenu_OnEvent);
}

/////////////////////////////////////////
function DKEditor_BrowserMenu_AddSafari()
{
	DKWidget_CreateElement(byId("DKEditor/DKEditor_BrowserMenu.html"), "div", "DKEditor_BrowserMenu_Safari");
	byId("DKEditor_BrowserMenu_Safari").class = "option";
	byId("DKEditor_BrowserMenu_Safari").innerHTML = "Safari";
	byId("DKEditor_BrowserMenu_Safari").addEventListener("click", DKEditor_BrowserMenu_OnEvent);
}