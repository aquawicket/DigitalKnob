var app = "";
var icon = "";
var os = DK_GetOS();
var win32_download = "";
var win64_download = "";
var mac_download = "";
var linux_download = "";
var ios_download = "";
var android_download = "";


/////////////////////
function DKApp_Init()
{
	DKCreate("DKApp.html,Panel0_content");
	DKAddEvent("DKApp_download", "click", DKApp_OnEvent);
	
	DKApp_UpdateApp("DKFacebook");
}

////////////////////
function DKApp_End()
{
	DKClose("DKApp.html");
}

/////////////////////////////
function DKApp_OnEvent(event)
{
	if(DK_Id(event, "DKApp_download")){
		window.location = android_download;  //FIXME - We need a DKWindow command for this
	}
}

//////////////////////////////
function DKApp_UpdateApp(name)
{
	DKLog("DKApp_UpdateApp("+name+") \n");
	app = name;
	icon = app+"_icon.png";
	//os = DK_GetOS();
	win32_download = "";
	win64_download = "";
	mac_download = "";
	linux_download = "";
	ios_download = "";
	android_download = "http://digitalknob.com/Download/"+app+".apk";
	
	//Adjust icon
	DKWidget_SetAttribute("DKApp_icon", "src", icon);
	
	//Adjust title
	DKWidget_SetInnerHtml("DKApp_title", app);
	
	//Adjust Download Link
	if(os.indexOf("Win32") != -1 && win32_download){
		DKWidget_SetInnerHtml("DKApp_download", "Download for Windows 32");
	}
	else if(os.indexOf("Win64") != -1 && win32_download){
		DKWidget_SetInnerHtml("DKApp_download", "Download for Windows 64");
	}
	else if(os.indexOf("Mac") != -1 && mac_download){
		DKWidget_SetInnerHtml("DKApp_download", "Download for Mac");
	}
	else if(os.indexOf("Linux") != -1 && linux_download){
		DKWidget_SetInnerHtml("DKApp_download", "Download for Linux");
	}
	else if(os.indexOf("Android") != -1 && android_download){
		DKWidget_SetInnerHtml("DKApp_download", "Download for Android");
	}
	else if(os.indexOf("iOS") != -1 && ios_download){
		DKWidget_SetInnerHtml("DKApp_download", "Download for iOS");
	}
	else{
		DKWidget_RemoveElement("DKApp_download");
		var id = DKWidget_CreateElement("DKApp.html","div","notavailable");
		DKWidget_SetProperty(id, "position", "absolute");
		DKWidget_SetProperty(id, "top", "90rem");
		DKWidget_SetProperty(id, "left", "170rem");
		DKWidget_SetProperty(id, "width", "250rem");
		DKWidget_SetProperty(id, "color", "red");
		DKWidget_SetProperty(id, "font-size", "20rem");
		DKWidget_SetInnerHtml(id, "Not available for "+os);
	}
}
