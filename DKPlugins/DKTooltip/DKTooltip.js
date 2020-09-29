/////////////////////////
function DKTooltip_Init()
{

}

////////////////////////
function DKTooltip_End()
{
	DKRemoveEvents(DKTooltip_OnEvent);
	DKClose("DKTooltip/DKTooltip.html");
}

/////////////////////////////////
function DKTooltip_OnEvent(event)
{
	if(event.type == "mouseenter"){
		DKTooltip_Show(DK_GetId(event));
		return;
	}
	
	DKClose("DKTooltip/DKTooltip.html");
}

//////////////////////////////////
function DKTooltip_Add(id, string)
{
	DKWidget_SetAttribute(id, "tooltip", string);
	DKAddEvent(id, "mouseenter", DKTooltip_OnEvent);
	DKAddEvent(id, "mouseout", DKTooltip_OnEvent);
	DKAddEvent("window", "mousedown", DKTooltip_OnEvent);
}

///////////////////////////
function DKTooltip_Show(id)
{
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