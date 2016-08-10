//////////////////////
function OsInfo_Init()
{
	DKCreate("OsInfo.html,Panel0_content");
	DKWidget_SetInnerHtml("OsInfo_OS", "OS: "+DK_GetOS());
	DKWidget_SetInnerHtml("OsInfo_width", "width: "+DKWindow_GetWidth());
	DKWidget_SetInnerHtml("OsInfo_height", "height: "+DKWindow_GetHeight());
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