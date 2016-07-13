
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
	DKClose("DKDebug/BugReport.html");
}

/////////////////////////////////
function BugReport_OnEvent(event)
{
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