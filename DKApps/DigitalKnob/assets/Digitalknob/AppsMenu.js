////////////////////////
function AppsMenu_Init()
{
	DKCreate("Digitalknob/AppsMenu.html");
	DKAddEvent("GLOBAL", "mousedown", AppsMenu_OnEvent);
	
	AppsMenu_GetApps();
}

///////////////////////////
function AppsMenu_GetApps()
{
	var AppList = ["DKDatabase", "DKFacebook", "DKSDLOS", "DKYoutube"];
	for(var i=0; i<AppList.length; i++){
		AppsMenu_AddApp(AppList[i]);
	}
}

//////////////////////////////////////
function AppsMenu_GetDescription(name)
{
	if(name == "DKDatabase"){
		return "A simple MySql database client. <br />";
	}
	
	if(name == "DKFacebook"){
		return "If you want to use facebook on your phone, but don't want all of the extra stuff that comes with it, give this a try. It fast, free and simple. <br /> \
* Super fast <br /> \
* No notifications <br /> \
* No data sharing <br /> \
* No location sharing <br /> \
* No running processes <br /> \
* Small, Fast, simple and free <br /><br />";
	}
	
	if(name == "DKSDLOS"){
		return "Experimental OS";
	}
	
	if(name == "DKYoutube"){
		return "Introducing, DKYoutube for Android. <br /> \
Don't you just hate how youtube music stops playing when you turn off your screen. You want to listen to music on youtube, but you want to turn my screen off to save battery!. Try DKYoutube. <br /> \
* Super small file size <br /> \
* Faster speeds than the youtube app <br /> \
* More secure with less data and location sharing <br /> \
* Turn off your screen, and the music keeps playing <br /> \
* Small, Fast, simple and free <br /><br />";
	}
}

///////////////////////
function AppsMenu_End()
{
	//DKLog("AppsMenu_End():\n");
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
	//DKLog("AppsMenu_OnEvent("+event+") \n");
	//DKLog("AppsMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+") \n");
	
	DKWidget_SetInnerHtml("Digitalknob_content",""); //clear the content
	
	if(DK_Type(event, "click")){
		var id = DK_GetId(event);
		DKClose("Digitalknob/DKApp.js");
		DKCreate("Digitalknob/DKApp.js", function(){
			DKApp_UpdateApp(id);
			DKApp_UpdateDescription(AppsMenu_GetDescription(id));
		});		
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "AppsMenu.html")){
			return;
		}
	}
	DKClose("Digitalknob/AppsMenu.js");
}