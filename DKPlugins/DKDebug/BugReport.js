/////////////////////////
function BugReport_Init()
{
	DK_Create("DKDebug/BugReport.html");
	byId("BugReport_Image").addEventListener("click", BugReport_OnEvent);
	byId("BugReport_Text").addEventListener("click", BugReport_OnEvent);
}

////////////////////////
function BugReport_End()
{
	byId("BugReport_Image").removeEventListener("click", BugReport_OnEvent);
	byId("BugReport_Text").removeEventListener("click", BugReport_OnEvent);
	DKClose("DKDebug/BugReport.html");
}

/////////////////////////////////
function BugReport_OnEvent(event)
{
	console.debug("BugReport_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")");
	if(event.type === "click"){
		BugReport_SendBugReport();
	}
}

//////////////////////////////////
function BugReport_SendBugReport()
{
	DK_Create("DKDebug/SendBugReport.js", function(){
		DKFrame_Widget("DKDebug/SendBugReport.html");
	});
}