var selection = "";
var source_url = "";
var link_url = "";
var parent = "";
	
/////////////////////////
function DKBrowser_Init()
{
	//DKCreate("DKCef");
	DKCreate("DKBrowser/DKBrowser.html");

	DKAddEvent("GLOBAL", "keydown", DKBrowser_OnEvent);
	DKAddEvent("GLOBAL", "mousedown", DKBrowser_OnEvent);
	DKAddEvent("GLOBAL", "DKCef_OnLoadingStateChange", DKBrowser_OnEvent);
	DKAddEvent("GLOBAL", "DKCef_OnBeforePopup", DKBrowser_OnEvent);
	DKAddEvent("GLOBAL", "DKCef_OnQueueNewBrowser", DKBrowser_OnEvent);
	DKAddEvent("GLOBAL", "DKCef_OnLoadError", DKBrowser_OnEvent);
	DKAddEvent("GLOBAL", "DKCef_OnFullscreen", DKBrowser_OnEvent);
	DKAddEvent("GLOBAL", "DKCef_ContextMenu", DKBrowser_OnEvent);
	DKAddEvent("Tab0", "click", DKBrowser_OnEvent);
	DKAddEvent("Tab1", "click", DKBrowser_OnEvent);
	DKAddEvent("Tab2", "click", DKBrowser_OnEvent);
	DKAddEvent("Tab3", "click", DKBrowser_OnEvent);
	DKAddEvent("Tab4", "click", DKBrowser_OnEvent);
	DKAddEvent("Tab5", "click", DKBrowser_OnEvent);
	DKAddEvent("Tab0Close", "click", DKBrowser_OnEvent);
	DKAddEvent("Tab1Close", "click", DKBrowser_OnEvent);
	DKAddEvent("Tab2Close", "click", DKBrowser_OnEvent);
	DKAddEvent("Tab3Close", "click", DKBrowser_OnEvent);
	DKAddEvent("Tab4Close", "click", DKBrowser_OnEvent);
	DKAddEvent("Tab5Close", "click", DKBrowser_OnEvent);
	DKAddEvent("NewTab", "click", DKBrowser_OnEvent);
	DKAddEvent("BackButton", "click", DKBrowser_OnEvent);
	DKAddEvent("ForwardButton", "click", DKBrowser_OnEvent);
	DKAddEvent("StopButton", "click", DKBrowser_OnEvent);
	DKAddEvent("RefreshButton", "click", DKBrowser_OnEvent);
	DKAddEvent("HomeButton", "click", DKBrowser_OnEvent);
	DKAddEvent("Textbox", "focus", DKBrowser_OnEvent);
	DKAddEvent("Textbox", "contextmenu", DKBrowser_OnEvent);
	DKAddEvent("GoButton", "click", DKBrowser_OnEvent);
	DKAddEvent("Copy", "click", DKBrowser_OnEvent);
	DKAddEvent("Paste", "click", DKBrowser_OnEvent);
	DKAddEvent("SaveImage", "click", DKBrowser_OnEvent);
	DKAddEvent("CopyLink", "click", DKBrowser_OnEvent);
	DKAddEvent("Settings", "click", DKBrowser_OnEvent);
}

////////////////////////
function DKBrowser_End()
{
	DKRemoveEvent("GLOBAL", "keydown", DKBrowser_OnEvent);
	DKRemoveEvent("GLOBAL", "mousedown", DKBrowser_OnEvent);
	DKRemoveEvent("GLOBAL", "DKCef_OnLoadingStateChange", DKBrowser_OnEvent);
	DKRemoveEvent("GLOBAL", "DKCef_OnBeforePopup", DKBrowser_OnEvent);
	DKRemoveEvent("GLOBAL", "DKCef_OnQueueNewBrowser", DKBrowser_OnEvent);
	DKRemoveEvent("GLOBAL", "DKCef_OnLoadError", DKBrowser_OnEvent);
	DKRemoveEvent("GLOBAL", "DKCef_OnFullscreen", DKBrowser_OnEvent);
	DKRemoveEvent("GLOBAL", "DKCef_ContextMenu", DKBrowser_OnEvent);
	DKClose("DKBrowser/DKBrowser.html");
}

/////////////////////////////////
function DKBrowser_OnEvent(event)
{
	//DKLog("DKBrowser_OnEvent("+event+")", DKDEBUG);	
	if(DK_Type(event, "keydown")){
		DKBrowser_ProcessKey(DKWidget_GetValue(event));
	}
	//if(DK_Type(event, "mousedown")){
	//	if(DK_GetId(event) != "DKCefFrame"){
			//DKCef_RemoveFocus();
	//	}
	//}
	if(DK_Id(event, "Tab0")){
		DKBrowser_SelectTab(0);
	}
	if(DK_Id(event, "Tab1")){
		DKBrowser_SelectTab(1);
	}
	if(DK_Id(event, "Tab2")){
		DKBrowser_SelectTab(2);
	}
	if(DK_Id(event, "Tab3")){
		DKBrowser_SelectTab(3);
	}
	if(DK_Id(event, "Tab4")){
		DKBrowser_SelectTab(4);
	}
	if(DK_Id(event, "Tab5")){
		DKBrowser_SelectTab(5);
	}
	if(DK_Id(event, "Tab0Close")){
		DKBrowser_CloseTab(0);
	}
	if(DK_Id(event, "Tab1Close")){
		DKBrowser_CloseTab(1);
	}
	if(DK_Id(event, "Tab2Close")){
		DKBrowser_CloseTab(2);
	}
	if(DK_Id(event, "Tab3Close")){
		DKBrowser_CloseTab(3);
	}
	if(DK_Id(event, "Tab4Close")){
		DKBrowser_CloseTab(4);
	}
	if(DK_Id(event, "Tab5Close")){
		DKBrowser_CloseTab(5);
	}
	if(DK_Id(event, "NewTab")){
		DKBrowser_NewTab();
		DKCef_SetFocus("DKBrowser_cef");
	}
	if(DK_Id(event, "BackButton")){
		DKCef_GoBack("DKBrowser_cef", DKCef_GetCurrentBrowser("DKBrowser_cef"));
	}
	if(DK_Id(event, "ForwardButton")){
		DKCef_GoForward("DKBrowser_cef", DKCef_GetCurrentBrowser("DKBrowser_cef"));
	}
	if(DK_Id(event, "StopButton")){
		DKCef_Stop("DKBrowser_cef", DKCef_GetCurrentBrowser("DKBrowser_cef"));
	}
	if(DK_Id(event, "RefreshButton")){
		DKCef_Reload("DKBrowser_cef", DKCef_GetCurrentBrowser("DKBrowser_cef"));
	}
	if(DK_Id(event, "HomeButton")){
		DKCef_SetUrl("DKBrowser_cef", "http://www.google.com", DKCef_GetCurrentBrowser("DKBrowser_cef"));
	}
	if(DK_Id(event, "Textbox")){
		DKCef_RemoveFocus("DKBrowser_cef");
		//TODO: select all text
		if(DK_Type(event, "contextmenu")){
			DKCreate("DKBrowser/DKBrowserMenu.js");
		}
	}
	if(DK_Id(event, "GoButton")){
		var url = DKWidget_GetValue("Textbox");
		DKCef_SetUrl("DKBrowser_cef", url, DKCef_GetCurrentBrowser("DKBrowser_cef"));
	}
	if(DK_Type(event, "DKCef_OnLoadingStateChange")){
		var num = parseInt(DKWidget_GetValue(event));
		DKBrowser_SetUrlBar(DKCef_GetUrl("DKBrowser_cef", num), num); 
		return;
	}
	if(DK_Type(event, "DKCef_OnLoadError")){
		DKBrowser_OnLoadError(DKWidget_GetValue(event));
	}
	if(DK_Type(event, "DKCef_OnQueueNewBrowser")){
		DKLog("DKCef_OnQueueNewBrowser \n");
		DKBrowser_NewTab();
		DKCef_SetUrl("DKBrowser_cef", DKWidget_GetValue(event), DKCef_GetCurrentBrowser("DKBrowser_cef"));
		return;
	}
	if(DK_Type(event, "DKCef_ContextMenu")){
		DKLog("DKBrowser_OnEvent("+event+")\n", DKDEBUG);	
		var data = DKWidget_GetValue(event);
		var arry = data.split(",");
		selection = arry[0];
		source_url = arry[1];
		link_url = arry[2];
		DKCreate("DKBrowser/DKBrowserMenu.js");
	}
	if(DK_Type(event, "DKCef_OnFullscreen")){
		DKLog("DKCef_OnFullscreen");
		var value = DKWidget_GetValue(event);
		if(value == "true"){
			DKWidget_Hide("Tabs");
			DKWidget_Hide("Menu");
			DKWidget_SetProperty("DKBrowser_cef","top","0rem");
			DKWidget_SetProperty("DKBrowser_cef","z-index","100");
			DKWidget_AppendChild("body", "DKBrowser_cef");
			DKWindow_Fullscreen();
		}
		else{
			DKWidget_Show("Tabs");
			DKWidget_Show("Menu");
			DKWidget_SetProperty("DKBrowser_cef","top","44rem");
			DKWidget_RemoveProperty("DKBrowser_cef","z-index","100");
			DKWidget_AppendChild("body", "DKBrowser_cef");
			DKWindow_Windowed();
		}
	}
	if(DK_Id(event,"Settings")){
		DKCreate("DKBrowser/Settings.js");
		DKFrame_Widget("Settings.html");
	}
}

/////////////////////////////////////
function DKBrowser_OnLoadError(error)
{
	if(error == "-105"){
		var url = DKWidget_GetValue("Textbox");
		url = url.replace(" ", "%20");
		var search = "https://www.google.com/?gws_rd=ssl#q=" + url;
		DKCef_SetUrl("DKBrowser_cef", search, DKCef_GetCurrentBrowser("DKBrowser_cef"));
	}
}

//////////////////////////////////
function DKBrowser_ProcessKey(key)
{
	var focused = DKWidget_GetFocusElement();
	//DKLog("DKWidget_GetFocusElement(): focused="+focused+"\n");
	if(key == 13 && (focused == "Textbox")){
		var url = DKWidget_GetValue("Textbox");
		DKCef_SetUrl("DKBrowser_cef", url, DKCef_GetCurrentBrowser("DKBrowser_cef"));
	}
}

///////////////////////////
function DKBrowser_NewTab()
{
	DKCef_NewBrowser("DKBrowser_cef");
	var num = DKCef_GetBrowsers("DKBrowser_cef");
	DKBrowser_SelectTab(num-1);
}

///////////////////////////////
function DKBrowser_UpdateTabs()
{
	var num = DKCef_GetBrowsers("DKBrowser_cef");
	var current = DKCef_GetCurrentBrowser("DKBrowser_cef");
	for(var i=0; i<6; i++){
		if(i < num){
			DKWidget_SetProperty("Tab"+String(i),"display","inline-block");
			var url = DKCef_GetUrl("DKBrowser_cef", i);
			if(url){
				DKWidget_SetInnerHtml("Tab"+String(i)+"Text", url);
			}
			if(i == current){
				DKWidget_SetProperty("Tab"+String(i),"background-color","rgb(230,230,230)");
			}
			else{
				DKWidget_SetProperty("Tab"+String(i),"background-color","rgb(180,180,180)");
			}
		}
		else{
			DKWidget_SetProperty("Tab"+String(i),"display","none");
		}
	}
	
	//Set url 
	var url = DKWidget_GetInnerHtml("Tab"+current+"Text");
	DKWidget_SetValue("Textbox", url);
}

//////////////////////////////////////
function DKBrowser_SetUrlBar(url, num)
{
	DKWidget_SetInnerHtml("Tab"+num+"Text", url);
	if(DKCef_GetCurrentBrowser("DKBrowser_cef") != num){ return; }
	var focused = DKWidget_GetFocusElement();
	DKLog("DKWidget_GetFocusElement(): focused="+focused+"\n");
	if(focused != "Textbox"){
		DKWidget_SetValue("Textbox", url);
	}
}

/////////////////////////////////
function DKBrowser_SelectTab(num)
{
	DKCef_SelectBrowser("DKBrowser_cef", num);
	DKBrowser_UpdateTabs();
}

////////////////////////////////
function DKBrowser_CloseTab(num)
{
	if(DKCef_GetBrowsers("DKBrowser_cef") == 1){
		DKFrame_Close("DKBrowser.html");
		DKClose("DKBrowser/DKBrowser.html");
		DKClose("DKBrowser/DKBrowser.js");
		//DK_Exit(); 
		return;
	}
	DKCef_CloseBrowser("DKBrowser_cef", num);
	DKBrowser_SelectTab(0);
}