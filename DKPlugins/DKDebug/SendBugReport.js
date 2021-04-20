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
	DK_Close("DKDebug/SendBugReport.html");
	DK_Close("DKDebug/SendBugReport.css");
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
	var str = byId("SendBugReport_Textarea").value;
	console.log(str+"\n");
	
	var assets = CPP_DKAssets_LocalAssets();
	var log = CPP_DKFile_FileToString(assets+"log.txt");
	CPP_DKFile_StringToFile(str+"\n\n"+log, assets+"log.txt");
	SendBugReport_SendReport();
	
	byId("DKDebug/SendBugReport.html").style.display = "none";
	//TODO: say thank you here
	DK_Create("DKGui/DKMessageBox.js", function(){
		DKFrame_Html("DKGui/DKMessageBox.html");
		DKMessageBox_Message("Thank You :)");	
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
	CPP_DK_DoFrame();
	
	var num = Math.floor((Math.random() * 99999999) + 1);
	CPP_DKDebug_SendBugReport(num.toString());
}