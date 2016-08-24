var app = "";
var icon = "";
var os = DK_GetOS();
var win32_download = "";
var win64_download = "";
var mac_download = "";
var linux_download = "";
var ios_download = "";
var android_download = "";

var download_link = "";


/////////////////////
function DKApp_Init()
{
	DKCreate("DKApp.html,Panel0_content");
	DKAddEvent("DKApp_download", "click", DKApp_OnEvent);
	
	var id = DKWidget_CreateElement("Panel0_content","div","loading");
	DKWidget_SetProperty(id, "position", "absolute");
	DKWidget_SetProperty(id, "top", "25rem");
	DKWidget_SetProperty(id, "width", "100%");
	DKWidget_SetProperty(id, "text-align", "center");
	DKWidget_SetProperty(id, "font-size", "20rem");
	DKWidget_SetInnerHtml(id, "Loading...");
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
		window.location = download_link;  //FIXME - We need a DKWindow command for this
	}
}

//////////////////////////////
function DKApp_UpdateApp(name)
{
	DKLog("DKApp_UpdateApp("+name+") \n");
	app = name;
	icon = app+"_icon.png";
	//os = DK_GetOS();
	win32_download = "http://digitalknob.com/Download/"+app+".exe";
	win64_download = "http://digitalknob.com/Download/"+app+"_64.exe";
	mac_download = "http://digitalknob.com/Download/"+app+"_mac64.zip";
	linux_download = "http://digitalknob.com/Download/"+app+"_linux64.zip";
	ios_download = "http://digitalknob.com/Download/"+app+"_ios.zip";
	android_download = "http://digitalknob.com/Download/"+app+".apk";
	
	//Adjust icon
	DKWidget_SetAttribute("DKApp_icon", "src", icon);
	
	//Adjust title
	DKWidget_SetInnerHtml("DKApp_title", app);
	
	//Adjust Download Link
	if(os.indexOf("Win32") != -1){
		DKFile_Exists(win32_download, function(rval){
			if(rval){DKApp_SetDownload("Win32");}
			else{DKApp_SetDownload("none");}
		});
	}
	else if(os.indexOf("Win64") != -1){
		DKFile_Exists(win64_download, function(rval){
			if(rval){DKApp_SetDownload("Win64");}
			else{DKApp_SetDownload("none");}
		});
	}
	else if(os.indexOf("Mac") != -1){
		DKFile_Exists(mac_download, function(rval){
			if(rval){DKApp_SetDownload("Mac");}
			else{DKApp_SetDownload("none");}
		});
	}
	else if(os.indexOf("Linux") != -1){
		DKFile_Exists(linux_download, function(rval){
			if(rval){DKApp_SetDownload("Linux");}
			else{DKApp_SetDownload("none");}
		});
	}
	else if(os.indexOf("Android") != -1){
		DKFile_Exists(android_download, function(rval){
			if(rval){DKApp_SetDownload("Android");}
			else{DKApp_SetDownload("none");}
		});
	}
	else if(os.indexOf("iOS") != -1){
		DKFile_Exists(ios_download, function(rval){
			if(rval){DKApp_SetDownload("iOS");}
			else{DKApp_SetDownload("none");}
		});
	}
	
	DKWidget_RemoveElement("loading");
	DKWidget_SetProperty("DKApp.html", "visibility", "visible");
}

////////////////////////////////
function DKApp_SetDownload(name)
{
	if(name.indexOf("Win32") != -1){
		DKWidget_SetInnerHtml("DKApp_download", "Download for Windows 32");
		download_link = win32_download;
	}
	else if(name.indexOf("Win64") != -1){
		DKWidget_SetInnerHtml("DKApp_download", "Download for Windows 64");
		download_link = win64_download;
	}
	else if(name.indexOf("Mac") != -1){
		DKWidget_SetInnerHtml("DKApp_download", "Download for Mac");
		download_link = mac_download;
	}
	else if(name.indexOf("Linux") != -1){
		DKWidget_SetInnerHtml("DKApp_download", "Download for Linux");
		download_link = linux_download;
	}
	else if(name.indexOf("Android") != -1){
		DKWidget_SetInnerHtml("DKApp_download", "Download for Android");
		download_link = android_download;
	}
	else if(name.indexOf("iOS") != -1){
		DKWidget_SetInnerHtml("DKApp_download", "Download for iOS");
		download_link = ios_download;
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
