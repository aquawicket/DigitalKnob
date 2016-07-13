
////////////////////////////
function SendBugReport_Init()
{
	DKCreate("DKDebug/SendBugReport.html");
	DKAddEvent("SendBugReport_Button", "click", SendBugReport_OnEvent);
}

////////////////////////////
function SendBugReport_End()
{
	DKClose("DKDebug/SendBugReport.html");
}

/////////////////////////////////////
function SendBugReport_OnEvent(event)
{
	if(DK_Id(event, "SendBugReport_Button")){
		SendBugReport_CreateReport();
	}
}

/////////////////////////////////////
function SendBugReport_CreateReport()
{
	DKLog("SendBugReport_CreateReport() \n", DKDEBUG);
	var str = DKWidget_GetValue("SendBugReport_Textarea");
	DKLog(str+"\n", DKDEBUG);
	
	var local_assets = DKAssets_GetDataPath();
	var log = DKFile_FileToString(local_assets+"log.txt");
	DKFile_StringToFile(str+"\n\n"+log, local_assets+"log.txt");
	SendBugReport_SendReport();
	
	DKWidget_Hide("SendBugReport.html");
	//TODO: say thank you here
	DKCreate("DKMessage/DKMessage.js");
	DKFrame_Widget("DKMessage.html");
	DKMessageBox("", "ShowMessage", "Thank You :)");
	
	DKFrame_Close("SendBugReport.html");
	//DKClose("DKDebug/SendBugReport.js");
}

///////////////////////////////////
function SendBugReport_SendReport()
{
	DKLog("SendBugReport_SendReport() \n", DKDEBUG);
	var num = Math.floor((Math.random() * 99999999) + 1);
	DKDebug_SendBugReport(num.toString());
}