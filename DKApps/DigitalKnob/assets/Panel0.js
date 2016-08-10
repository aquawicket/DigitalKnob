//////////////////////
function Panel0_Init()
{
	DKCreate("Panel0.html");
	//DKCreate("Content.html,Panel0_content");
	DKCreate("Home.js");
	DKCreate("OsInfo.js");
	
	DKAddEvent("Image", "click", Panel0_OnEvent);
	DKAddEvent("AppsMenu", "click", Panel0_OnEvent);
}

/////////////////////
function Panel0_End()
{
	DKClose("Panel0.html");
}

//////////////////////////////
function Panel0_OnEvent(event)
{
	//DKLog("Panel0_OnEvent("+event+") \n", DKDEBUG);
	if(DK_Id(event, "Image")){
		DKWidget_SetInnerHtml("Panel0_content","");
		DKCreate("Home.js");
	}
	if(DK_Id(event, "AppsMenu")){
		DKCreate("AppsMenu.js");
	}
}