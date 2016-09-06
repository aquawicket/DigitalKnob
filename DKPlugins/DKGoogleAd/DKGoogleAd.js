//////////////////////////
function DKGoogleAd_Init()
{

}

/////////////////////////
function DKGoogleAd_End()
{

}

//////////////////////////////////
function DKGoogleAd_OnEvent(event)
{

}

///////////////////////////////////////////////////
function DKGoogleAd_CreateAd(parent, width, height)
{
	DKLog("DKGoogleAd_CreateAd("+parent+","+width+","+height+")");
	DKLog("Browser = "+DK_GetBrowser()+"\n");
	
	// container is where you want the ad to be inserted
	var id = DKWidget_CreateElement(parent, "div", "DKAdd");
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