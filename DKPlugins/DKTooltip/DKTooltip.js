/////////////////////////
function DKTooltip_Init()
{
	//DKLog("DKTooltip_Init()\n");
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
	
	if(DK_Type(event, "mouseenter")){
		DKTooltip_Show(DK_GetId(event));
		return;
	}
	
	DKClose("DKTooltip/DKTooltip.js");
}

//////////////////////////////////
function DKTooltip_Add(id, string)
{
	//DKLog("DKTooltip_Add("+id+","+string+")\n");
	DKWidget_SetAttribute(id, "tooltip", string);
	DKAddEvent(id, "mouseenter", DKTooltip_OnEvent);
	DKAddEvent("GLOBAL", "mousedown", DKTooltip_OnEvent);
	DKAddEvent("GLOBAL", "mouseout", DKTooltip_OnEvent);
}

///////////////////////////
function DKTooltip_Show(id)
{
	//DKLog("DKTooltip_Show("+id+")\n");
	
	setTimeout(function(){
		var hover = DKWidget_GetHoverElement();
		if(hover != id){
			DKClose("DKTooltip/DKTooltip.js");
			return;
		}
		DKCreate("DKTooltip/DKTooltip.html");
		DKWidget_SetInnerHtml("DKTooltip/DKTooltip.html", DKWidget_GetAttribute(id, "tooltip"));
		DKWidget_SetProperty("DKTooltip/DKTooltip.html", "top", mouseX+"px");
		DKWidget_SetProperty("DKTooltip/DKTooltip.html", "left", mouseY+"px");
	}, 1000); 
}