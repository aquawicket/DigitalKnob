///////////////////////
function DKStats_Init()
{
	//DKLog("DKStats_Init()\n");
	
	DKCreate("DKPaint/DKStats.html");
}

//////////////////////
function DKPaint_End()
{
	//DKLog("DKStats_End()\n");
	
	DKRemoveEvents(DKStats_OnEvent);
	DKClose("DKStats/DKStats.html");
}

///////////////////////////////
function DKStats_OnEvent(event)
{
	DKLog("DKStats_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
}