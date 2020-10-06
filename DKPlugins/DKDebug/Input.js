/////////////////////
function Input_Init()
{
	DK_Create("DKDebug/Input.html");
	byId("Input_Text").addEventListener("keydown", Input_OnEvent);
}

////////////////////
function Input_End()
{
	byId("Input_Text").removeEventListener("keydown", Input_OnEvent);
	DK_Close("DKDebug/Input.html");
}

/////////////////////////////
function Input_OnEvent(event)
{
	DKDEBUG("Input_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	if(event.currentTarget.id === "Input_Text"){
		var key = DK_GetValue(event);
		//console.log("Input_Text: key="+key+"\n");
		if(key !== 13 /*&& key !== 72*/){ return; }
		Input_Run(DKWidget_GetValue("Input_Text"))
	}
}

///////////////////////////
function Input_Run(command)
{
	DK_RunDuktape(command);
}