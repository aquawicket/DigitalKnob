/////////////////////////
function DKDisplay_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKDisplay/DKDisplay.html");
	DKAddEvent("DKDisplay_Button", "click", DKDisplay_OnEvent);
	//DKAddEvent("window", "second", DKDisplay_OnEvent);
	
	//DKAddEvent("DKDisplay/DKDisplay.html", "click", DKDisplay_OnEvent);
}

////////////////////////
function DKDisplay_End()
{
	DKDEBUGFUNC();	
	DKRemoveEvents(DKDisplay_OnEvent);
	DKClose("DKDisplay/DKDisplay.html");
}

/////////////////////////////////
function DKDisplay_OnEvent(event)
{
	DKDEBUGFUNC();
	DKDEBUG("DKDisplay_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	if(DK_Id(event, "DKDisplay_Button")){
		DK_TurnOffMonitor();
	}
		
	//if(DK_Type(event, "second")){
	//	//tick
	//}
}