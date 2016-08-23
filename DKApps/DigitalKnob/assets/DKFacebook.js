var os = DK_GetOS();
var win32_download = "http://digitalknob.com/Download/DKFacebook.exe";
var win64_download = "http://digitalknob.com/Download/DKFacebook_64.exe";
var mac_download = "";
var linux_download = "";
var ios_download = "";
var android_download = "http://digitalknob.com/Download/DKFacebook.apk";

//////////////////////////
function DKFacebook_Init()
{
	DKCreate("DKFacebook.html,Panel0_content");
	//DKAddEvent("GLOBAL", "mousedown", DKFacebook_OnEvent);
	DKAddEvent("DKFacebook_download", "click", DKFacebook_OnEvent);
	
	//Adjust Download Link
	if(os.indexOf("Win32") != -1 && win32_download){
		DKWidget_SetInnerHtml("DKFacebook_download", "Download for Windows 32");
	}
	else if(os.indexOf("Win64") != -1 && win32_download){
		DKWidget_SetInnerHtml("DKFacebook_download", "Download for Windows 64");
	}
	else if(os.indexOf("Mac") != -1 && mac_download){
		DKWidget_SetInnerHtml("DKFacebook_download", "Download for Mac");
	}
	else if(os.indexOf("Linux") != -1 && linux_download){
		DKWidget_SetInnerHtml("DKFacebook_download", "Download for Linux");
	}
	else if(os.indexOf("Android") != -1 && android_download){
		DKWidget_SetInnerHtml("DKFacebook_download", "Download for Android");
	}
	else if(os.indexOf("iOS") != -1 && ios_download){
		DKWidget_SetInnerHtml("DKFacebook_download", "Download for iOS");
	}
	else{
		DKWidget_RemoveElement("DKFacebook_download");
		var id = DKWidget_CreateElement("DKFacebook.html","div","notavailable");
		DKWidget_SetProperty(id, "position", "absolute");
		DKWidget_SetProperty(id, "top", "90rem");
		DKWidget_SetProperty(id, "left", "170rem");
		DKWidget_SetProperty(id, "width", "250rem");
		DKWidget_SetProperty(id, "color", "red");
		DKWidget_SetProperty(id, "font-size", "20rem");
		DKWidget_SetInnerHtml(id, "Not available for "+os);
	}
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
		window.location = "http://digitalknob.com/Download/DKFacebook.apk";  //FIXME - We need a DKWindow command for this
	}
}