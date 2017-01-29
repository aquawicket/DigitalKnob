
////////////////////////////
function SendBugReport_Init()
{
	DKCreate("DKDebug/SendBugReport.html");
	DKAddEvent("SendBugReport_Button", "click", SendBugReport_OnEvent);
}

////////////////////////////
function SendBugReport_End()
{
	DKRemoveEvent("SendBugReport_Button", "click", SendBugReport_OnEvent);
	DKClose("SendBugReport.html");
}

/////////////////////////////////////
function SendBugReport_OnEvent(event)
{
	DKLog("SendBugReport_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
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
	
	var assets = DKAssets_LocalAssets();
	var log = DKFile_FileToString(assets+"log.txt");
	DKFile_StringToFile(str+"\n\n"+log, assets+"log.txt");
	SendBugReport_SendReport();
	
	DKWidget_Hide("SendBugReport.html");
	//TODO: say thank you here
	DKCreate("DKMessage/DKMessage.js", function(){
		DKFrame_Widget("DKMessage.html");
		DKMessageBox("", "ShowMessage", "Thank You :)");	
		DKFrame_Close("SendBugReport.html");
	});
}

///////////////////////////////////
function SendBugReport_SendReport()
{
	DKLog("SendBugReport_SendReport() \n", DKDEBUG);
	DKWidget_Show("SendBugReport_Image");
	DKWidget_Show("SendBugReport_Sending");
	DK_DoFrame();
	
	var num = Math.floor((Math.random() * 99999999) + 1);
	DKDebug_SendBugReport(num.toString());
}