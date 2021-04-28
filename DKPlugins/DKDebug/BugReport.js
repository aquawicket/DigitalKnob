/////////////////////////
function BugReport_init()
{
	dk.create("DKDebug/BugReport.html");
	byId("BugReport_Image").addEventListener("click", BugReport_onevent);
	byId("BugReport_Text").addEventListener("click", BugReport_onevent);
}

////////////////////////
function BugReport_end()
{
	byId("BugReport_Image").removeEventListener("click", BugReport_onevent);
	byId("BugReport_Text").removeEventListener("click", BugReport_onevent);
	dk.close("DKDebug/BugReport.html");
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
	dk.create("DKDebug/SendBugReport.js", function(){
		DKFrame_Html("DKDebug/SendBugReport.html");
	});
}