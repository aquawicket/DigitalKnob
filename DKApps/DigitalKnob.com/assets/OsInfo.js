//////////////////////
function OsInfo_Init()
{
	DKCreate("OsInfo.html,Panel0_content");
	DKWidget_SetInnerHtml("OsInfo_OS", "OS: "+DK_GetOS());
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