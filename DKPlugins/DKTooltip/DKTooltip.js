/////////////////////////
function DKTooltip_Init()
{

}

////////////////////////
function DKTooltip_End()
{
	D//KRemoveEvents(DKTooltip_OnEvent);
	DK_Close("DKTooltip/DKTooltip.html");
}

/////////////////////////////////
function DKTooltip_OnEvent(event)
{
	if(event.type === "mouseenter"){
		DKTooltip_Show(DK_GetId(event));
		return;
	}
	
	DK_Close("DKTooltip/DKTooltip.html");
}

//////////////////////////////////
function DKTooltip_Add(id, string)
{
	byId(id).tooltip = string;
	window.addEventListener("mousedown", DKTooltip_OnEvent);
	byId(id).addEventListener("mouseenter", DKTooltip_OnEvent);
	byId(id).addEventListener("mouseout", DKTooltip_OnEvent);
}

///////////////////////////
function DKTooltip_Show(id)
{
	setTimeout(function(){
		var hover = document.elementFromPoint(window.mouseX, window.mouseY);
		if(hover !== id){
			DK_Close("DKTooltip/DKTooltip.html");
			return;
		}
		DK_Create("DKTooltip/DKTooltip.html");
		byId("DKTooltip/DKTooltip.html").innerHTML = byId(id).tooltip;
		byId("DKTooltip/DKTooltip.html").style.top = mouseX+"px";
		byId("DKTooltip/DKTooltip.html").style.left = mouseY+"px";
	}, 1000); 
}