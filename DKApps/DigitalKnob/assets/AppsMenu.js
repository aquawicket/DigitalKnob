////////////////////////
function AppsMenu_Init()
{
	DKCreate("AppsMenu.html");
	DKAddEvent("GLOBAL", "mousedown", AppsMenu_OnEvent);
	DKAddEvent("DKFacebook", "click", AppsMenu_OnEvent);
	DKAddEvent("DKYoutube", "click", AppsMenu_OnEvent);
}

///////////////////////
function AppsMenu_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", AppsMenu_OnEvent);
	DKClose("AppsMenu.html");
}

////////////////////////////////
function AppsMenu_OnEvent(event)
{
	//TODO - Panel0_content needs it's own .js
	
	if(DK_Id(event, "DKFacebook")){
		DKWidget_SetInnerHtml("Panel0_content","");
		DKCreate("DKApp.js");
		//DKApp_UpdateApp("DKFacebook");
	}
	if(DK_Id(event, "DKYoutube")){
		DKWidget_SetInnerHtml("Panel0_content","");
		DKCreate("DKYoutube.js");
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "AppsMenu.html")){
			return;
		}
	}
	DKClose("DKOS/AppsMenu.js");
}