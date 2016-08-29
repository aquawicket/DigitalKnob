////////////////////////
function AppsMenu_Init()
{
	DKCreate("Digitalknob/AppsMenu.html");
	DKAddEvent("GLOBAL", "mousedown", AppsMenu_OnEvent);
	
	AppsMenu_AddApp("DKDatabase");
	AppsMenu_AddApp("DKFacebook");
	AppsMenu_AddApp("DKYoutube");
}

///////////////////////
function AppsMenu_End()
{
	DKLog("AppsMenu_End():\n");
	DKRemoveEvent("GLOBAL", "mousedown", AppsMenu_OnEvent);
	DKClose("Digitalknob/AppsMenu.html");
}

//////////////////////////////
function AppsMenu_AddApp(name)
{
	var id = DKWidget_CreateElement("AppsMenu.html", "div", name)
	DKWidget_SetAttribute(id, "class", "option");
	DKWidget_SetProperty(id, "height", "40rem");
	DKWidget_SetProperty(id, "font-size", "30rem");
	DKWidget_SetInnerHtml(id, name);
	DKAddEvent(name, "click", AppsMenu_OnEvent);
}

////////////////////////////////
function AppsMenu_OnEvent(event)
{
	DKLog("AppsMenu_OnEvent("+event+"):\n");
	DKLog("AppsMenu_OnEvent("+DK_GetId(event)+"):\n");
	
	if(DK_Id(event, "DKFacebook")){
		DKLog("AppsMenu_OnEvent(): DKFacebook \n");
		DKWidget_SetInnerHtml("Digitalknob_content","");
		
		DKClose("Digitalknob/DKApp.js");
		DKCreate("Digitalknob/DKApp.js", function(){
			DKApp_UpdateApp("DKFacebook");
			DKApp_UpdateDescription("If you want to use facebook on your phone, but don't want all of the extra stuff that comes with it, give this a try. It fast, free and simple. <br /> \
* Super fast <br /> \
* No notifications <br /> \
* No data sharing <br /> \
* No location sharing <br /> \
* No running processes <br /> \
* Small, Fast, simple and free <br /><br />");
		});
	}

	if(DK_Id(event, "DKYoutube")){
		DKWidget_SetInnerHtml("Digitalknob_content","");
		
		DKClose("Digitalknob/DKApp.js");
		DKCreate("Digitalknob/DKApp.js", function(){ 
			DKApp_UpdateApp("DKYoutube");
			DKApp_UpdateDescription("Introducing, DKYoutube for Android. <br /> \
Don't you just hate how youtube music stops playing when you turn off your screen. You want to listen to music on youtube, but you want to turn my screen off to save battery!. Try DKYoutube. <br /> \
* Super small file size <br /> \
* Faster speeds than the youtube app <br /> \
* More secure with less data and location sharing <br /> \
* Turn off your screen, and the music keeps playing <br /> \
* Small, Fast, simple and free <br /><br />");
		});
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "AppsMenu.html")){
			return;
		}
	}
	DKClose("Digitalknob/AppsMenu.js");
}