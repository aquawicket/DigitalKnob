////////////////////////////
function SendBugReport_Init()
{
	DKCreate("DKDebug/SendBugReport.css");
	DKCreate("DKDebug/SendBugReport.html");
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
	if(event.currentTarget.id == "SendBugReport_Button"){
		SendBugReport_CreateReport();
	}
}

/////////////////////////////////////
function SendBugReport_CreateReport()
{
	var str = DKWidget_GetValue("SendBugReport_Textarea");
	console.log(str+"\n");
	
	var assets = DKAssets_LocalAssets();
	var log = DKFile_FileToString(assets+"log.txt");
	DKFile_StringToFile(str+"\n\n"+log, assets+"log.txt");
	SendBugReport_SendReport();
	
	DKWidget_Hide("DKDebug/SendBugReport.html");
	//TODO: say thank you here
	DKCreate("DKMessage/DKMessage.js", function(){
		DKFrame_Widget("DKMessage/DKMessage.html");
		DKMessage_Message("Thank You :)");	
		DKFrame_Close("DKDebug/SendBugReport.html");
	});
}

///////////////////////////////////
function SendBugReport_SendReport()
{
	DKWidget_Show("SendBugReport_Image");
	DKWidget_Show("SendBugReport_Sending");
	DK_DoFrame();
	
	var num = Math.floor((Math.random() * 99999999) + 1);
	DKDebug_SendBugReport(num.toString());
}