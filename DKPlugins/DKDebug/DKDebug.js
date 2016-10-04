///////////////////////
function DKDebug_Init()
{
	DKAddEvent("GLOBAL", "keypress", DKDebug_OnEvent);
}

//////////////////////
function DKDebug_End()
{
	DKRemoveEvent("GLOBAL", "keypress", DKDebug_OnEvent);
}

///////////////////////////////
function DKDebug_OnEvent(event)
{
	if(DK_Type(event, "keypress")){
		DKLog("Unicode CHARACTER code: "+DKWidget_GetValue(event)+"\n");
	}
}
