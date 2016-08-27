//////////////////////
function Panel0_Init()
{
	//DKWidget_SetProperty("body", "font-size", "1px");
	DKCreate("Digitalknob/Panel0.html");
	DKCreate("Digitalknob/Home.js");
	DKCreate("Digitalknob/OsInfo.js");
	
	DKAddEvent("Image", "click", Panel0_OnEvent);
	DKAddEvent("AppsMenu", "click", Panel0_OnEvent);
}

/////////////////////
function Panel0_End()
{
	DKClose("Digitalknob/Panel0.html");
}

//////////////////////////////
function Panel0_OnEvent(event)
{
	//DKLog("Panel0_OnEvent("+event+") \n", DKDEBUG);
	if(DK_Id(event, "Image")){
		DKWidget_SetInnerHtml("Panel0_content","");
		DKCreate("Digitalknob/Home.js");
	}
	if(DK_Id(event, "AppsMenu")){
		DKCreate("Digitalknob/AppsMenu.js");
	}
}