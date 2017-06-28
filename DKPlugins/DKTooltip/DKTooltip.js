/////////////////////////
function DKTooltip_Init()
{
	//DKLog("DKTooltip_Init()\n");
	
	//DK_Sleep(1000);
	DKCreate("DKTooltip/DKTooltip.html");
	//DKAddEvent("DKTooltip/DKTooltip.html", "show_tooltip", DKTooltip_OnEvent);
	//DKAddEvent("DKTooltip/DKTooltip.html", "mouseover", DKTooltip_OnEvent);
	//DKAddEvent("GLOBAL", "mousedown", DKTooltip_OnEvent);
	DKAddEvent("GLOBAL", "mouseout", DKTooltip_OnEvent);
	
	DKWidget_SetProperty("DKTooltip/DKTooltip.html", "top", mouseX+"px");
	DKWidget_SetProperty("DKTooltip/DKTooltip.html", "left", mouseY+"px");
}

////////////////////////
function DKTooltip_End()
{
	//DKLog("DKTooltip_End()\n");
	
	DKRemoveEvents(DKTooltip_OnEvent);
	DKClose("DKTooltip/DKTooltip.html");
}

/////////////////////////////////
function DKTooltip_OnEvent(event)
{
	//DKLog("DKTooltip_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	DKClose("DKTooltip/DKTooltip.js");
}

//////////////////////////////////
function DKTooltip_SetText(string)
{
	DKWidget_SetInnerHtml("DKTooltip/DKTooltip.html", string);
}