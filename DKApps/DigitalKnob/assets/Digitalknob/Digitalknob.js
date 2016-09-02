//////////////////////
function Digitalknob_Init()
{
	DKCreate("DKFrame/DKFrame.js", function(){});
	DKCreate("Digitalknob/Digitalknob.html");
	DKCreate("Digitalknob/Home.js", function(){});
	DKCreate("Digitalknob/OsInfo.js", function(){});
	
	DKAddEvent("Image", "click", Digitalknob_OnEvent);
	DKAddEvent("AppsMenu", "click", Digitalknob_OnEvent);
	DKAddEvent("Digitalknob_login", "click", Digitalknob_OnEvent);
	
	var width = DKWindow_GetWidth();
	var id = Digitalknob_GoogleAd("100%", "100rem");
	DKWidget_SetProperty(id, "bottom", "0rem");
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

////////////////////////////////////////////
function Digitalknob_GoogleAd(width, height)
{
	// container is where you want the ad to be inserted
	var id = DKWidget_CreateElement("Digitalknob.html", "div", "DKAdd");
	DKWidget_SetProperty(id, "position", "absolute");
	DKWidget_SetProperty(id, "width", width);
	DKWidget_SetProperty(id, "height", height);
	DKWidget_SetProperty(id, "text-align", "center");
	
	var px_width = document.getElementById(id).clientWidth;
	var px_height = document.getElementById(id).clientHeight;
	
	px_width = Math.min(px_width, 1200);
	px_height = Math.min(px_height, 1200);
	window.google_ad_client = "ca-pub-4839505278360003";
	window.google_ad_slot = "8269654670";
	window.google_ad_width = px_width;
	window.google_ad_height = px_height;

	var container = document.getElementById(id);
	var w = document.write;
	document.write = function (content) {
		container.innerHTML = content;
		document.write = w;	
	};

	var script = document.createElement('script');
	script.type = 'text/javascript';
	script.src = 'http://pagead2.googlesyndication.com/pagead/show_ads.js';
	document.body.appendChild(script);

	return id;
}