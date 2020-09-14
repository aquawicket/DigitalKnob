////////////////////////////////////
function DKEditor_BrowserMenu_Init()
{
	DKDEBUGFUNC();	
	DKCreate("DKEditor/DKEditor_BrowserMenu.html");
	DKAddEvent("window", "mousedown", DKEditor_BrowserMenu_OnEvent);
	
	DKEditor_BrowserMenu_Populate();
}

///////////////////////////////////
function DKEditor_BrowserMenu_End()
{
	DKDEBUGFUNC();	
	DKRemoveEvents(DKEditor_BrowserMenu_OnEvent);
	DKClose("DKEditor/DKEditor_BrowserMenu.html");
}

////////////////////////////////////////////
function DKEditor_BrowserMenu_OnEvent(event)
{
	DKDEBUGFUNC(event);
	console.log("DKEditor_BrowserMenu_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	if(event.currentTarget.id == "DKEditor_BrowserMenu_Chrome"){
		DK_Run("C:/Program Files (x86)/Google/Chrome/Application/chrome.exe", "--allow-file-access-from-files "+DKApp_url);
	}
	if(event.currentTarget.id == "DKEditor_BrowserMenu_Firefox"){
		DK_Run("C:/Program Files (x86)/Mozilla Firefox/firefox.exe", DKApp_url);
	}
	if(event.currentTarget.id == "DKEditor_BrowserMenu_IE"){
		var url = DKApp_url.replace("file:///", "");
		DK_Run("C:/Program Files (x86)/Internet Explorer/iexplore.exe", url);
	}
	if(event.currentTarget.id == "DKEditor_BrowserMenu_Opera"){
		DK_Run("C:/Program Files/Opera/launcher.exe", "--allow-file-access-from-files "+DKApp_url);
	}
	if(event.currentTarget.id == "DKEditor_BrowserMenu_Safari"){
		DK_Run("C:/Program Files (x86)/Safari/Safari.exe", DKApp_url);
	}
	
	///////////////////////////
	if(event.currentTarget == window){
		if(byId("DKEditor/DKEditor_BrowserMenu.html").contains(DKWidget_GetHoverElement())){
			return;
		}
	}
	
	DKClose("DKEditor/DKEditor_BrowserMenu.js");
}

////////////////////////////////////////
function DKEditor_BrowserMenu_Populate()
{
	DKDEBUGFUNC();	
	DKEditor_BrowserMenu_AddChrome();
	DKEditor_BrowserMenu_AddFirefox();
	DKEditor_BrowserMenu_AddIE();
	DKEditor_BrowserMenu_AddOpera();
	DKEditor_BrowserMenu_AddSafari();
}

/////////////////////////////////////////
function DKEditor_BrowserMenu_AddChrome()
{
	DKDEBUGFUNC();	
	DKWidget_CreateElement("DKEditor/DKEditor_BrowserMenu.html", "div", "DKEditor_BrowserMenu_Chrome");
	DKWidget_SetAttribute("DKEditor_BrowserMenu_Chrome", "class", "option");
	DKWidget_SetInnerHtml("DKEditor_BrowserMenu_Chrome", "Chrome");
	DKAddEvent("DKEditor_BrowserMenu_Chrome", "click", DKEditor_BrowserMenu_OnEvent);
}


//////////////////////////////////////////
function DKEditor_BrowserMenu_AddFirefox()
{
	DKDEBUGFUNC();	
	DKWidget_CreateElement("DKEditor/DKEditor_BrowserMenu.html", "div", "DKEditor_BrowserMenu_Firefox");
	DKWidget_SetAttribute("DKEditor_BrowserMenu_Firefox", "class", "option");
	DKWidget_SetInnerHtml("DKEditor_BrowserMenu_Firefox", "Firefox");
	DKAddEvent("DKEditor_BrowserMenu_Firefox", "click", DKEditor_BrowserMenu_OnEvent);
}

/////////////////////////////////////
function DKEditor_BrowserMenu_AddIE()
{
	DKDEBUGFUNC();	
	DKWidget_CreateElement("DKEditor/DKEditor_BrowserMenu.html", "div", "DKEditor_BrowserMenu_IE");
	DKWidget_SetAttribute("DKEditor_BrowserMenu_IE", "class", "option");
	DKWidget_SetInnerHtml("DKEditor_BrowserMenu_IE", "Internet Explorer");
	DKAddEvent("DKEditor_BrowserMenu_IE", "click", DKEditor_BrowserMenu_OnEvent);
}

////////////////////////////////////////
function DKEditor_BrowserMenu_AddOpera()
{
	DKDEBUGFUNC();	
	DKWidget_CreateElement("DKEditor/DKEditor_BrowserMenu.html", "div", "DKEditor_BrowserMenu_Opera");
	DKWidget_SetAttribute("DKEditor_BrowserMenu_Opera", "class", "option");
	DKWidget_SetInnerHtml("DKEditor_BrowserMenu_Opera", "Opera");
	DKAddEvent("DKEditor_BrowserMenu_Opera", "click", DKEditor_BrowserMenu_OnEvent);
}

/////////////////////////////////////////
function DKEditor_BrowserMenu_AddSafari()
{
	DKDEBUGFUNC();	
	DKWidget_CreateElement("DKEditor/DKEditor_BrowserMenu.html", "div", "DKEditor_BrowserMenu_Safari");
	DKWidget_SetAttribute("DKEditor_BrowserMenu_Safari", "class", "option");
	DKWidget_SetInnerHtml("DKEditor_BrowserMenu_Safari", "Safari");
	DKAddEvent("DKEditor_BrowserMenu_Safari", "click", DKEditor_BrowserMenu_OnEvent);
}