
/////////////////////////
function BugReport_Init()
{
	DKCreate("DKDebug/BugReport.html");
	DKAddEvent("BugReport_Image", "click", BugReport_OnEvent);
	DKAddEvent("BugReport_Text", "click", BugReport_OnEvent);
}

////////////////////////
function BugReport_End()
{
	DKClose("BugReport.html");
}

/////////////////////////////////
function BugReport_OnEvent(event)
{
	DKLog("BugReport_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Type(event, "click")){
		BugReport_SendBugReport();
	}
}

//////////////////////////////////
function BugReport_SendBugReport()
{
	//DKLog("BugReport_SendBugReport() \n", DKDEBUG);
	DKCreate("DKDebug/SendBugReport.js");
	DKFrame_Widget("SendBugReport.html")
}