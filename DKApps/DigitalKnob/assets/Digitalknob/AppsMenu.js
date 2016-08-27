////////////////////////
function AppsMenu_Init()
{
	DKCreate("DigitalKnob/AppsMenu.html");
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
		DKWidget_SetInnerHtml("Panel0_content","");
		
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
	DKClose("AppsMenu.js");
}