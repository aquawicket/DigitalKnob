/////////////////////////
function BugReport_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKDebug/BugReport.html");
	DKAddEvent("BugReport_Image", "click", BugReport_OnEvent);
	DKAddEvent("BugReport_Text", "click", BugReport_OnEvent);
}

////////////////////////
function BugReport_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(BugReport_OnEvent);
	DKClose("DKDebug/BugReport.html");
}

/////////////////////////////////
function BugReport_OnEvent(event)
{
	DKDEBUGFUNC(event);
	DKDEBUG("BugReport_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	if(DK_Type(event, "click")){
		BugReport_SendBugReport();
	}
}

//////////////////////////////////
function BugReport_SendBugReport()
{
	DKDEBUGFUNC();
	DKCreate("DKDebug/SendBugReport.js", function(){
		DKFrame_Widget("DKDebug/SendBugReport.html");
	});
}