var key_history = [];

///////////////////////
function DKDebug_Init()
{
	//DKCreate("DKFrame/DKFrame.js", function(){});
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
		DKDebug_LogKey(DKWidget_GetValue(event));
	}
}

////////////////////////////
function DKDebug_LogKey(key)
{
	key_history[key_history.length] = key;
}

/////////////////////////////
function DKDebug_RestartApp()
{
	//DKFrame_CloseAll();
	DK_Reload();
}
