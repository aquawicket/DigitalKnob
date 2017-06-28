/////////////////////////
function DKTooltip_Init()
{
	//DKLog("DKTooltip_Init()\n");
	
	DKCreate("DKTooltip/DKTooltip.html");
	DKAddEvent("DKTooltip/DKTooltip.html", "show_tooltip", DKTooltip_OnEvent);
	//DKAddEvent("DKTooltip/DKTooltip.html", "mouseover", DKTooltip_OnEvent);
	DKAddEvent("DKTooltip/DKTooltip.html", "mouseout", DKTooltip_OnEvent);
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
	
	if(DK_Type(event, "mouseout")){
		DKClose("DKTooltip/DKTooltip.js");
	}
	if(DK_Type(event, "show_tooltip")){
		//Get mouse x, y
		DKWidget_SetProperty("DKTooltip/DKTooltip.html", "top", mouseX + "px");
		DKWidget_SetProperty("DKTooltip/DKTooltip.html", "left", mouseY + "px");
		DKWidget_SetInnerHtml("DKTooltip/DKTooltip.html", DK_GetValue(event));
	}
}