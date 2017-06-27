/////////////////////////
function BugReport_Init()
{
	//DKLog("BugReport_Init()\n");
	
	DKCreate("DKDebug/BugReport.html");
	DKAddEvent("BugReport_Image", "click", BugReport_OnEvent);
	DKAddEvent("BugReport_Text", "click", BugReport_OnEvent);
}

////////////////////////
function BugReport_End()
{
	//DKLog("BugReport_End()\n");
	
	DKRemoveEvents(BugReport_OnEvent);
	DKClose("DKDebug/BugReport.html");
}

/////////////////////////////////
function BugReport_OnEvent(event)
{
	//DKLog("BugReport_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "click")){
		BugReport_SendBugReport();
	}
}

//////////////////////////////////
function BugReport_SendBugReport()
{
	//DKLog("BugReport_SendBugReport()\n");
	
	DKCreate("DKDebug/SendBugReport.js", function(){});
		DKFrame_Widget("DKDebug/SendBugReport.html");
	});
}