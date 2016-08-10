//////////////////////
function OsInfo_Init()
{
	DKCreate("OsInfo.html,Panel0_content");
	DKWidget_SetInnerHtml("OsInfo_OS", "OS: "+DK_GetOS());
	DKWidget_SetInnerHtml("OsInfo_width", "width: "+DKWindow_GetWidth());
	DKWidget_SetInnerHtml("OsInfo_height", "height: "+DKWindow_GetHeight());
	DKWidget_SetInnerHtml("OsInfo_pixelratio", "pixel_ratio: "+DKWindow_GetPixelRatio());
	
	if((parseInt(DKWindow_GetHeight()) > parseInt(DKWindow_GetWidth())) && (parseInt(DKWindow_GetPixelRatio()) == 2)){
		DKWidget_SetProperty("html", "font-size", DKWindow_GetPixelRatio()+"px");
	}
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

}