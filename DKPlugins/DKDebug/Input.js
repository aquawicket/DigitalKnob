/////////////////////
function Input_Init()
{
	//DKLog("Input_Init() \n");
	
	DKCreate("DKDebug/Input.html");
	DKAddEvent("Input_Text", "keydown", Input_OnEvent);
}

////////////////////
function Input_End()
{
	//DKLog("Input_End() \n");
	
	DKRemoveEvents(Input_OnEvent);
	DKClose("DKDebug/Input.html");
}

/////////////////////////////
function Input_OnEvent(event)
{
	//DKLog("Input_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+") \n");
	
	if(DK_Id(event, "Input_Text")){
		var key = DK_GetValue(event);
		//DKLog("Input_Text: key="+key+"\n");
		if(key != 13 /*&& key != 72*/){ return; }
		Input_Run(DKWidget_GetValue("Input_Text"))
	}
}

///////////////////////////
function Input_Run(command)
{
	//DKLog("Input_Run("+command+") \n");
	
	DK_RunJavascript(command);
}