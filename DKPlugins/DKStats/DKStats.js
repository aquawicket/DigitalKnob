///////////////////////
function DKStats_Init()
{
	//DKLog("DKStats_Init()\n");
	
	DKCreate("DKStats/DKStats.html");
	DKAddEvent("GLOBAL", "second", DKStats_OnEvent);
	DKAddEvent("DKStats/DKStats.html", "click", DKStats_OnEvent);
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
	//DKLog("DKStats_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "second")){
		//DKLog("tick\n");
		DKStats_Update();
	}
}

/////////////////////////
function DKStats_Update()
{
	//CPU%
	var cpu = DK_CpuUsedByApp();
	DKWidget_SetInnerHtml("DKStats_cpu", "CPU: "+cpu+"%");
}