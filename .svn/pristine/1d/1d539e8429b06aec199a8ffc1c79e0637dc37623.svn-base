/////////////////////////
function DKTooltip_Init()
{
	DKCreate("DKTooltip/DKTooltip.html");
	DKAddEvent("DKTooltip.html", "show_tooltip", DKTooltip_OnEvent);
	//DKAddEvent("DKTooltip.html", "mouseover", DKTooltip_OnEvent);
	DKAddEvent("DKTooltip.html", "mouseout", DKTooltip_OnEvent);
}

////////////////////////
function DKTooltip_End()
{
	DKClose("DKTooltip/DKTooltip.html");
}

/////////////////////////////////
function DKTooltip_OnEvent(event)
{
	if(DK_Type(event, "mouseout")){
		DKClose("DKTooltip/DKTooltip.js");
	}
	if(DK_Type(event, "show_tooltip")){
		//Get mouse x, y
		DKWidget_SetProperty("DKTooltip.html", "top", mouseX + "px");
		DKWidget_SetProperty("DKTooltip.html", "left", mouseY + "px");
		DKWidget_SetInnerHtml("DKTooltipText", DKWidget_GetValue(event));
	}
}
