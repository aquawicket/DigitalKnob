////////////////////////////////////
function DKEditor_BrowserMenu_Init()
{
	DKLog("DKEditor_BrowserMenu_Init()\n");	
	
	DKCreate("DKEditor/DKEditor_BrowserMenu.html");
	DKAddEvent("GLOBAL", "mousedown", DKEditor_BrowserMenu_OnEvent);
	
	DKEditor_BrowserMenu_Populate();
}

///////////////////////////////////
function DKEditor_BrowserMenu_End()
{
	DKLog("DKEditor_BrowserMenu_End()\n");
	
	DKRemoveEvent("GLOBAL", "mousedown", DKEditor_BrowserMenu_OnEvent);
	DKRemoveEvents(DKEditor_BrowserMenu_OnEvent);
	DKClose("DKEditor/DKEditor_BrowserMenu.html");
}

////////////////////////////////////////////
function DKEditor_BrowserMenu_OnEvent(event)
{
	DKLog("DKEditor_BrowserMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event, "DKEditor_BrowserMenu_IE")){
		DKLog("DKEditor_BrowserMenu_IE \n");
		var url = DKApp_url.replace("file:///", "");
		url = url.replace("//", "/");
		alert(url);
		DK_Run("C:/Program Files (x86)/Internet Explorer/iexplore.exe", url);
	}
	if(DK_Id(event, "DKEditor_BrowserMenu_Chrome")){
		DKLog("DKEditor_BrowserMenu_Chrome \n");
		DK_Run("C:\Program Files (x86)/Google/Chrome/Application/chrome.exe", DKApp_url); //--allow-file-access-from-files does not work
	}
	
	///////////////////////////
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKEditor_BrowserMenu.html")){
			return;
		}
	}
	
	DKClose("DKEditor/DKEditor_BrowserMenu.js");
}

////////////////////////////////////////
function DKEditor_BrowserMenu_Populate()
{
	DKEditor_BrowserMenu_AddIE();
	DKEditor_BrowserMenu_AddChrome();
}

/////////////////////////////////////
function DKEditor_BrowserMenu_AddIE()
{
	DKWidget_CreateElement("DKEditor_BrowserMenu.html", "div", "DKEditor_BrowserMenu_IE");
	DKWidget_SetAttribute("DKEditor_BrowserMenu_IE", "class", "option");
	DKWidget_SetInnerHtml("DKEditor_BrowserMenu_IE", "Internet Explorer");
	DKAddEvent("DKEditor_BrowserMenu_IE", "click", DKEditor_BrowserMenu_OnEvent);
}

/////////////////////////////////////////
function DKEditor_BrowserMenu_AddChrome()
{
	DKWidget_CreateElement("DKEditor_BrowserMenu.html", "div", "DKEditor_BrowserMenu_Chrome");
	DKWidget_SetAttribute("DKEditor_BrowserMenu_Chrome", "class", "option");
	DKWidget_SetInnerHtml("DKEditor_BrowserMenu_Chrome", "Chrome");
	DKAddEvent("DKEditor_BrowserMenu_Chrome", "click", DKEditor_BrowserMenu_OnEvent);
}