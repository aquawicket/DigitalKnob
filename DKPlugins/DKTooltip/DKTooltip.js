/////////////////////////
function DKTooltip_Init()
{
	DKDEBUGFUNC();
}

////////////////////////
function DKTooltip_End()
{
	DKDEBUGFUNC();	
	DKRemoveEvents(DKTooltip_OnEvent);
	DKClose("DKTooltip/DKTooltip.html");
}

/////////////////////////////////
function DKTooltip_OnEvent(event)
{
	DKDEBUGFUNC(event);	
	if(DK_Type(event, "mouseenter")){
		DKTooltip_Show(DK_GetId(event));
		return;
	}
	
	DKClose("DKTooltip/DKTooltip.html");
}

//////////////////////////////////
function DKTooltip_Add(id, string)
{
	DKDEBUGFUNC(id, string);	
	DKWidget_SetAttribute(id, "tooltip", string);
	DKAddEvent(id, "mouseenter", DKTooltip_OnEvent);
	DKAddEvent(id, "mouseout", DKTooltip_OnEvent);
	DKAddEvent("GLOBAL", "mousedown", DKTooltip_OnEvent);
}

///////////////////////////
function DKTooltip_Show(id)
{
	DKDEBUGFUNC(id);	
	setTimeout(function(){
		var hover = DKWidget_GetHoverElement();
		if(hover != id){
			DKClose("DKTooltip/DKTooltip.html");
			return;
		}
		DKCreate("DKTooltip/DKTooltip.html");
		DKWidget_SetInnerHtml("DKTooltip/DKTooltip.html", DKWidget_GetAttribute(id, "tooltip"));
		DKWidget_SetProperty("DKTooltip/DKTooltip.html", "top", mouseX+"px");
		DKWidget_SetProperty("DKTooltip/DKTooltip.html", "left", mouseY+"px");
	}, 1000); 
}