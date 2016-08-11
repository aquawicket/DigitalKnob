//////////////////////////
function DKYoutube_Init()
{
	DKCreate("DKYoutube.html,Panel0_content");
	//DKAddEvent("GLOBAL", "mousedown", DKYoutube_OnEvent);
	DKAddEvent("DKYoutube_download", "click", DKYoutube_OnEvent);
}

/////////////////////////
function DKYoutube_End()
{
	//DKRemoveEvent("GLOBAL", "mousedown", DKYoutube_OnEvent);
	DKClose("DKYoutube.html");
}

//////////////////////////////////
function DKYoutube_OnEvent(event)
{
	if(DK_Id(event, "DKYoutube_download")){
		window.location = "http://Digitalknob.com/Download/DKYoutube.apk";  //FIXME - We need a DKWindow command for this
	}
}