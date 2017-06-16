
//////////////////////
function DKMenu_Init()
{
	DKLog("DKMenu_Init()\n");
}

//////////////////////
function DKMenu_End()
{
	DKLog("DKMenu_End()\n");
}

///////////////////////////////
function DKMenu_OnEvent(event)
{
	DKLog("DKMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
}