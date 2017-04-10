var USE_ROCKET = 1;
var USE_CEF = 1;
var USE_Webview = 1;
var DKApp_url = "file:///"+DKAssets_LocalAssets()+"/index.html";
//var DKApp_url = "http://digitalknob.com/DKIDE/index.html";


if(DK_GetOS() == "Android" || DK_GetOS() == "iOS"){
	USE_CEF = 0; //not available for mobile devices
}
else{
	USE_Webview = 0; //not available for Desktop devices
}


if(DK_GetJavascript() == "Duktape"){
	DKCreate("DKWindow");
	if(USE_ROCKET){
		DKCreate("DKRocket");
		DKCreate("DKWidget");
	}
	DKCreate("DKTray/DKTray.js", function(){});
}
DKCreate("DKDebug/DKDebug.js", function(){});


////////////////////////////
function User_OnEvent(event)  //Duktape
{
	DKLog("User_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Type(event, "DKCef_OnQueueNewBrowser")){
		var currentBrowser = DKCef_GetCurrentBrowser("DKCef_frame");
		DKCef_SetUrl("DKCef_frame", DKWidget_GetValue(event), currentBrowser);
	}
	if(DK_Type(event, "keydown")){
		if(DKWidget_GetValue(event) == "4"){ //Exit for ANDROID
		    DK_Exit();
		}
	}
}

if(DK_GetJavascript() == "Duktape" && USE_CEF){
	var assets = DKAssets_LocalAssets();
	var iframe = DKWidget_CreateElement("body", "iframe", "DKCef_frame");
	DKWidget_SetAttribute(iframe, "src", DKApp_url);
	DKWidget_SetProperty(iframe, "position", "absolute");
	DKWidget_SetProperty(iframe, "top", "0rem");
	DKWidget_SetProperty(iframe, "left", "0rem");
	DKWidget_SetProperty(iframe, "width", "100%");
	DKWidget_SetProperty(iframe, "bottom", "0rem");
	var currentBrowser = DKCef_GetCurrentBrowser(iframe);
	DKCef_SetUrl(iframe, DKApp_url, currentBrowser);
	DKCef_SetFocus(iframe);
	
	DKAddEvent("GLOBAL", "DKCef_OnQueueNewBrowser", User_OnEvent);
	/*
	DKCreate("DKGoogleAd/DKGoogleAd.js", function(){
		var id = DKGoogleAd_CreateAd("body", "100%", "100rem");
	});
	*/
}
else if(DK_GetJavascript() == "Duktape" && USE_Webview){ //Duktape
	DKAddEvent("GLOBAL", "keydown", User_OnEvent);
}
else{  //Duktape or V8 or Webview
	DKWidget_SetProperty("body","background-color","grey");
	DKCreate("DKScale/DKScale.js", function(){});
	DKCreate("DKBuild/DKBuild.js", function(){
		DKCreate("DKDev/DKDev.js", function(){});
		DKCreate("DKDev/DKMenuRight.js", function(){
			DKWidget_RemoveProperty("DKMenuRight.html","left");
			DKWidget_RemoveProperty("DKMenuRight.html","height");
			DKWidget_SetProperty("DKMenuRight.html","top","41rem");
			DKWidget_SetProperty("DKMenuRight.html","right","0rem");
			DKWidget_SetProperty("DKMenuRight.html","bottom","24rem");
		});
		DKCreate("DKDebug/Input.js", function(){});
		DKCreate("DKBuild/DKSolution.js", function(){
			DKCreate("DKFrame/DKFrame.js", function(){
				var frame = DKFrame_Widget("DKSolution.html");
				DKWidget_SetProperty(frame, "top", "40rem");
				DKWidget_SetProperty(frame,"left","0rem");
				DKWidget_SetProperty(frame,"bottom","23rem");
				DKWidget_SetProperty(frame,"width","160rem");
				DKWidget_RemoveProperty(frame,"height");
				DKWidget_SetProperty("DKSolution.html","bottom","0rem");
			});
		});
	});

	
	/*
	if(DK_GetBrowser() != "CEF"){ 
		DKCreate("DKGoogleAd/DKGoogleAd.js", function(){
			var id = DKGoogleAd_CreateAd("body", "100%", "100rem");
		});
	}
	*/
}
//DKCreate("DKUpdate");