///////////////////////
function Desktop_Init()
{
	DKCreate("DKOS/Desktop.html");
	DKAddEvent("Background", "contextmenu", Desktop_OnEvent);
	
	DKCreate("DKGoogleAd/DKGoogleAd.js", function(){
		var width = DKWindow_GetWidth();
		var id = DKGoogleAd_CreateAd("Desktop.html", "100%", "100rem");
	});
}

//////////////////////
function Desktop_End()
{
	DKClose("DKOS/Desktop.html");
}

///////////////////////////////
function Desktop_OnEvent(event)
{
	if(DK_Id(event, "Background") && DK_Type(event, "contextmenu")){
		DKCreate("DKOS/DesktopMenu.js");
	}
}