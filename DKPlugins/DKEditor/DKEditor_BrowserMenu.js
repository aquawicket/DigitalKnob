////////////////////////////////////
function DKEditor_BrowserMenu_Init()
{
	//DKLog("DKEditor_BrowserMenu_Init()\n");	
	
	DKCreate("DKEditor/DKEditor_BrowserMenu.html");
	DKAddEvent("GLOBAL", "mousedown", DKEditor_BrowserMenu_OnEvent);
	
	DKEditor_BrowserMenu_Populate();
}

///////////////////////////////////
function DKEditor_BrowserMenu_End()
{
	//DKLog("DKEditor_BrowserMenu_End()\n");
	
	DKRemoveEvents(DKEditor_BrowserMenu_OnEvent);
	DKClose("DKEditor/DKEditor_BrowserMenu.html");
}

////////////////////////////////////////////
function DKEditor_BrowserMenu_OnEvent(event)
{
	//DKLog("DKEditor_BrowserMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event, "DKEditor_BrowserMenu_Chrome")){
		DK_Run("C:/Program Files (x86)/Google/Chrome/Application/chrome.exe", "--allow-file-access-from-files "+DKApp_url);
	}
	if(DK_Id(event, "DKEditor_BrowserMenu_Firefox")){
		DK_Run("C:/Program Files (x86)/Mozilla Firefox/firefox.exe", DKApp_url);
	}
	if(DK_Id(event, "DKEditor_BrowserMenu_IE")){
		var url = DKApp_url.replace("file:///", "");
		DK_Run("C:/Program Files (x86)/Internet Explorer/iexplore.exe", url);
	}
	if(DK_Id(event, "DKEditor_BrowserMenu_Opera")){
		DK_Run("C:/Program Files/Opera/launcher.exe", "--allow-file-access-from-files "+DKApp_url);
	}
	if(DK_Id(event, "DKEditor_BrowserMenu_Safari")){
		DK_Run("C:/Program Files (x86)/Safari/Safari.exe", DKApp_url);
	}
	
	///////////////////////////
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKEditor/DKEditor_BrowserMenu.html")){
			return;
		}
	}
	
	DKClose("DKEditor/DKEditor_BrowserMenu.js");
}

////////////////////////////////////////
function DKEditor_BrowserMenu_Populate()
{
	//DKLog("DKEditor_BrowserMenu_Populate()\n");
	
	DKEditor_BrowserMenu_AddChrome();
	DKEditor_BrowserMenu_AddFirefox();
	DKEditor_BrowserMenu_AddIE();
	DKEditor_BrowserMenu_AddOpera();
	DKEditor_BrowserMenu_AddSafari();
}

/////////////////////////////////////////
function DKEditor_BrowserMenu_AddChrome()
{
	//DKLog("DKEditor_BrowserMenu_AddChrome()\n");
	
	DKWidget_CreateElement("DKEditor/DKEditor_BrowserMenu.html", "div", "DKEditor_BrowserMenu_Chrome");
	DKWidget_SetAttribute("DKEditor_BrowserMenu_Chrome", "class", "option");
	DKWidget_SetInnerHtml("DKEditor_BrowserMenu_Chrome", "Chrome");
	DKAddEvent("DKEditor_BrowserMenu_Chrome", "click", DKEditor_BrowserMenu_OnEvent);
}


//////////////////////////////////////////
function DKEditor_BrowserMenu_AddFirefox()
{
	//DKLog("DKEditor_BrowserMenu_AddFirefox()\n");
	
	DKWidget_CreateElement("DKEditor/DKEditor_BrowserMenu.html", "div", "DKEditor_BrowserMenu_Firefox");
	DKWidget_SetAttribute("DKEditor_BrowserMenu_Firefox", "class", "option");
	DKWidget_SetInnerHtml("DKEditor_BrowserMenu_Firefox", "Firefox");
	DKAddEvent("DKEditor_BrowserMenu_Firefox", "click", DKEditor_BrowserMenu_OnEvent);
}

/////////////////////////////////////
function DKEditor_BrowserMenu_AddIE()
{
	//DKLog("DKEditor_BrowserMenu_AddIE()\n");
	
	DKWidget_CreateElement("DKEditor/DKEditor_BrowserMenu.html", "div", "DKEditor_BrowserMenu_IE");
	DKWidget_SetAttribute("DKEditor_BrowserMenu_IE", "class", "option");
	DKWidget_SetInnerHtml("DKEditor_BrowserMenu_IE", "Internet Explorer");
	DKAddEvent("DKEditor_BrowserMenu_IE", "click", DKEditor_BrowserMenu_OnEvent);
}

////////////////////////////////////////
function DKEditor_BrowserMenu_AddOpera()
{
	//DKLog("DKEditor_BrowserMenu_AddOpera()\n");
	
	DKWidget_CreateElement("DKEditor/DKEditor_BrowserMenu.html", "div", "DKEditor_BrowserMenu_Opera");
	DKWidget_SetAttribute("DKEditor_BrowserMenu_Opera", "class", "option");
	DKWidget_SetInnerHtml("DKEditor_BrowserMenu_Opera", "Opera");
	DKAddEvent("DKEditor_BrowserMenu_Opera", "click", DKEditor_BrowserMenu_OnEvent);
}

/////////////////////////////////////////
function DKEditor_BrowserMenu_AddSafari()
{
	//DKLog("DKEditor_BrowserMenu_AddSafari()\n");
	
	DKWidget_CreateElement("DKEditor/DKEditor_BrowserMenu.html", "div", "DKEditor_BrowserMenu_Safari");
	DKWidget_SetAttribute("DKEditor_BrowserMenu_Safari", "class", "option");
	DKWidget_SetInnerHtml("DKEditor_BrowserMenu_Safari", "Safari");
	DKAddEvent("DKEditor_BrowserMenu_Safari", "click", DKEditor_BrowserMenu_OnEvent);
}