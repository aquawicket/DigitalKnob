////////////////////////////
function SendBugReport_Init()
{
	DK_Create("DKDebug/SendBugReport.css");
	DK_Create("DKDebug/SendBugReport.html");
	byId("SendBugReport_Button").addEventListener("click", SendBugReport_OnEvent);
}

////////////////////////////
function SendBugReport_End()
{
	byId("SendBugReport_Button").removeEventListener("click", SendBugReport_OnEvent);
	DKClose("DKDebug/SendBugReport.html");
	DKClose("DKDebug/SendBugReport.css");
}

/////////////////////////////////////
function SendBugReport_OnEvent(event)
{
	console.log("SendBugReport_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")");
	if(event.currentTarget.id === "SendBugReport_Button"){
		SendBugReport_CreateReport();
	}
}

/////////////////////////////////////
function SendBugReport_CreateReport()
{
	var str = DKWidget_GetValue("SendBugReport_Textarea");
	console.log(str+"\n");
	
	var assets = DKCPP_DKAssets_LocalAssets();
	var log = DKCPP_DKFile_FileToString(assets+"log.txt");
	DKCPP_DKFile_StringToFile(str+"\n\n"+log, assets+"log.txt");
	SendBugReport_SendReport();
	
	byId("DKDebug/SendBugReport.html").style.display = "none";
	//TODO: say thank you here
	DK_Create("DKMessage/DKMessage.js", function(){
		DKFrame_Widget("DKMessage/DKMessage.html");
		DKMessage_Message("Thank You :)");	
		DKFrame_Close("DKDebug/SendBugReport.html");
	});
}

///////////////////////////////////
function SendBugReport_SendReport()
{
	byId("SendBugReport_Image").style.display = "block";
	byId("SendBugReport_Image").style.visibility = "visible";
	byId("SendBugReport_Sending").style.display = "block";
	byId("SendBugReport_Sending").style.visibility = "visible";
	DKCPP_DKDuktape_DoFrame();
	
	var num = Math.floor((Math.random() * 99999999) + 1);
	DKCPP_DKDebug_SendBugReport(num.toString());
}