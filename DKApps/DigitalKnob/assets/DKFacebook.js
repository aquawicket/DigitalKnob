//////////////////////////
function DKFacebook_Init()
{
	DKCreate("DKFacebook.html,Panel0_content");
	//DKAddEvent("GLOBAL", "mousedown", DKFacebook_OnEvent);
	DKAddEvent("DKFacebook_download", "click", DKFacebook_OnEvent);
}

/////////////////////////
function DKFacebook_End()
{
	//DKRemoveEvent("GLOBAL", "mousedown", DKFacebook_OnEvent);
	DKClose("DKFacebook.html");
}

//////////////////////////////////
function DKFacebook_OnEvent(event)
{
	if(DK_Id(event, "DKFacebook_download")){
		DKLog("Download.... TODO \n");
		window.location = "http://Digitalknob.com/Download/FacebookLite.apk";  //FIXME - We need a DKWindow command for this
	}
}