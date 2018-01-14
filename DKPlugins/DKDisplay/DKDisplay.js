/////////////////////////
function DKDisplay_Init()
{
	//DKLog("DKDisplay_Init()\n");
	
	DKCreate("DKDisplay/DKDisplay.html");
	DKAddEvent("DKDisplay_Button", "click", DKDisplay_OnEvent);
	//DKAddEvent("GLOBAL", "second", DKDisplay_OnEvent);
	
	//DKAddEvent("DKDisplay/DKDisplay.html", "click", DKDisplay_OnEvent);
}

////////////////////////
function DKDisplay_End()
{
	//DKLog("DKDisplay_End()\n");
	
	DKRemoveEvents(DKDisplay_OnEvent);
	DKClose("DKDisplay/DKDisplay.html");
}

/////////////////////////////////
function DKDisplay_OnEvent(event)
{
	//DKLog("DKDisplay_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event, "DKDisplay_Button")){
		DK_TurnOffMonitor();
	}
		
	//if(DK_Type(event, "second")){
	//	//tick
	//}
}