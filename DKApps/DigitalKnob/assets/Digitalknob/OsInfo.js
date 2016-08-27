//////////////////////
function OsInfo_Init()
{
	DKCreate("OsInfo.html,Panel0.html");
	DKAddEvent("GLOBAL", "resize", OsInfo_OnEvent);
	
	OsInfo_Resize();
}

/////////////////////
function OsInfo_End()
{
	DKClose("OsInfo.html");
}

//////////////////////////////
function OsInfo_OnEvent(event)
{
	//DKLog("OsInfo_OnEvent("+event+") \n", DKDEBUG);
	if(DK_Type(event, "resize")){
		OsInfo_Resize();
	}
}

////////////////////////
function OsInfo_Resize()
{
	DKWidget_SetInnerHtml("OsInfo_OS", "OS: "+DK_GetOS());
	DKWidget_SetInnerHtml("OsInfo_Browser", "Browser: "+DK_GetBrowser());
	DKWidget_SetInnerHtml("OsInfo_width", "width: "+DKWindow_GetWidth());
	DKWidget_SetInnerHtml("OsInfo_height", "height: "+DKWindow_GetHeight());
	DKWidget_SetInnerHtml("OsInfo_pixelratio", "pixel_ratio: "+DKWindow_GetPixelRatio());
	
	if((parseInt(DKWindow_GetHeight()) > parseInt(DKWindow_GetWidth())) && (parseFloat(DKWindow_GetPixelRatio()) > 1)){
		var pixel_ratio = DKWindow_GetPixelRatio();
		pixel_ratio = Math.min(2, pixel_ratio);
		DKWidget_SetProperty("html", "font-size", pixel_ratio+"px");
		DKWidget_SetInnerHtml("OsInfo_scale", "scale: "+pixel_ratio+"px");
	}
	else{
		DKWidget_SetProperty("html", "font-size", "1px");
		DKWidget_SetInnerHtml("OsInfo_scale", "scale: 1px");
	}
}