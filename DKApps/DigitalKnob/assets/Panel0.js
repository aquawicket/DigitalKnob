//////////////////////
function Panel0_Init()
{
	DKCreate("Panel0.html");
	//DKCreate("Content.html,Panel0_content");
	DKCreate("OsInfo.js");
	
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
	if(DK_Id(event, "AppsMenu")){
		DKLog("AppsMenu"); //TODO
	}
}