//////////////////////
function Digitalknob_Init()
{
	DKCreate("Digitalknob/Digitalknob.html");
	DKCreate("Digitalknob/Home.js");
	DKCreate("Digitalknob/OsInfo.js");
	
	DKAddEvent("Image", "click", Digitalknob_OnEvent);
	DKAddEvent("AppsMenu", "click", Digitalknob_OnEvent);
}

//////////////////////////
function Digitalknob_End()
{
	DKClose("Digitalknob/Digitalknob.html");
}

//////////////////////////////
function Digitalknob_OnEvent(event)
{
	//DKLog("Digitalknob_OnEvent("+event+") \n", DKDEBUG);
	if(DK_Id(event, "Image")){
		DKWidget_SetInnerHtml("Digitalknob_content","");
		DKClose("Digitalknob/Home.js");
		DKCreate("Digitalknob/Home.js");
	}
	if(DK_Id(event, "AppsMenu")){
		DKCreate("Digitalknob/AppsMenu.js");
	}
}