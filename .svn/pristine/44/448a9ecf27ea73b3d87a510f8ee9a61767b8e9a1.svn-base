/////////////////////////////
function DKBrowserMenu_Init()
{
	DKCreate("DKBrowser/DKBrowserMenu.html");
	DKWidget_SetProperty("DKBrowserMenu.html","top",DKWindow_GetMouseY()+"px");
	DKWidget_SetProperty("DKBrowserMenu.html","left",DKWindow_GetMouseX()+"px");
	DKAddEvent("GLOBAL", "mousedown", DKBrowserMenu_OnEvent);
	DKAddEvent("DKBrowserMenu_Cut", "click", DKBrowserMenu_OnEvent);
	DKAddEvent("DKBrowserMenu_Copy", "click", DKBrowserMenu_OnEvent);
	DKAddEvent("DKBrowserMenu_Paste", "click", DKBrowserMenu_OnEvent);
	DKAddEvent("DKBrowserMenu_SaveImage", "click", DKBrowserMenu_OnEvent);
	DKAddEvent("DKBrowserMenu_CopyLink", "click", DKBrowserMenu_OnEvent);
}

////////////////////////////
function DKBrowserMenu_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKBrowserMenu_OnEvent);
	DKClose("DKBrowser/DKBrowserMenu.html");
}

/////////////////////////////////////
function DKBrowserMenu_OnEvent(event)
{
	if(DK_Id(event,"DKBrowserMenu_Cut")){
		DKBrowserMenu_Cut();
	}
	if(DK_Id(event,"DKBrowserMenu_Copy")){
		DKBrowserMenu_Copy();
	}
	if(DK_Id(event,"DKBrowserMenu_Paste")){
		DKBrowserMenu_Paste();
	}
	if(DK_Id(event,"DKBrowserMenu_SaveImage")){
		DKBrowserMenu_SaveImage();
	}
	if(DK_Id(event,"DKBrowserMenu_CopyLink")){
		DKBrowserMenu_CopyLink();
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKBrowserMenu.html")){
			return;
		}
	}
	DKClose("DKBrowser/DKBrowserMenu.js");
}

////////////////////////////
function DKBrowserMenu_Cut()
{
	DKLog("DKBrowserMenu_Cut() \n");
	if(DKCef_Focused()){
		if(selection){
			DK_SetClipboard(selection);
		}
	}
	else{
		DKWidget_Cut("Textbox");
	}
}

/////////////////////////////
function DKBrowserMenu_Copy()
{
	DKLog("DKBrowserMenu_Copy() \n");
	DKLog("DKBrowserMenu_Cut() \n");
	if(DKCef_Focused()){
		if(selection){
			DK_SetClipboard(selection);
		}
	}
	else{
		DKWidget_Copy("Textbox");
	}
}

//////////////////////////////
function DKBrowserMenu_Paste()
{
	DKLog("DKBrowserMenu_Paste() \n");
	if(DKCef_Focused()){
		DKCef_Paste();
	}
	else{
		DKWidget_Paste("Textbox");
	}
}

//////////////////////////////////
function DKBrowserMenu_SaveImage()
{
	DKLog("DKBrowserMenu_SaveImage() \n");
	if(source_url){
		DKCef_DownloadUrl(source_url);
	}
}

/////////////////////////////////
function DKBrowserMenu_CopyLink()
{
	DKLog("DKBrowserMenu_CopyLink() \n");
	if(link_url){
		DK_SetClipboard(link_url);
	}
}
