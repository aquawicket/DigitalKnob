///////////////////////////
function Digitalknob_Init()
{
	DKCreate("DKFrame/DKFrame.js", function(){});
	DKCreate("Digitalknob/Digitalknob.html");
	DKCreate("Digitalknob/Home.js", function(){});
	DKCreate("Digitalknob/OsInfo.js", function(){});
	
	DKAddEvent("Image", "click", Digitalknob_OnEvent);
	DKAddEvent("AppsMenu", "click", Digitalknob_OnEvent);
	DKAddEvent("Digitalknob_login", "click", Digitalknob_OnEvent);
	
	DKCreate("DKGoogleAd/DKGoogleAd.js", function(){
		var width = DKWindow_GetWidth();
		var id = DKGoogleAd_CreateAd("Digitalknob.html", "100%", "100rem");
		DKWidget_SetProperty(id, "bottom", "0rem");
	});
}

//////////////////////////
function Digitalknob_End()
{
	DKClose("Digitalknob/Digitalknob.html");
}

///////////////////////////////////
function Digitalknob_OnEvent(event)
{
	//DKLog("Digitalknob_OnEvent("+event+") \n", DKDEBUG);
	if(DK_Id(event, "Image")){
		DKWidget_SetInnerHtml("Digitalknob_content","");
		DKClose("Digitalknob/Home.js");
		DKCreate("Digitalknob/Home.js", function(){});
	}
	if(DK_Id(event, "AppsMenu")){
		DKCreate("Digitalknob/AppsMenu.js", function(){});
	}
	if(DK_Id(event, "Digitalknob_login")){
		DKCreate("DKLogin/DKLogin.js", function(){
			DKFrame_Widget("DKLogin.html");
		});
	}
}