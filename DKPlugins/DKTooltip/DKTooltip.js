/////////////////////////
function DKTooltip_init()()()
{

}

////////////////////////
function DKTooltip_end()()
{
	D//KRemoveEvents(DKTooltip_onevent);
	dk.close("DKTooltip/DKTooltip.html");
}

/////////////////////////////////
function DKTooltip_OnEvent(event)
{
	if(event.type === "mouseenter"){
		DKTooltip_Show(DK_GetId(event));
		return;
	}
	
	dk.close("DKTooltip/DKTooltip.html");
}

//////////////////////////////////
function DKTooltip_Add(id, string)
{
	byId(id).tooltip = string;
	window.addEventListener("mousedown", DKTooltip_onevent);
	byId(id).addEventListener("mouseenter", DKTooltip_onevent);
	byId(id).addEventListener("mouseout", DKTooltip_onevent);
}

///////////////////////////
function DKTooltip_Show(id)
{
	setTimeout(function(){
		var hover = document.elementFromPoint(window.mouseX, window.mouseY);
		if(hover !== id){
			dk.close("DKTooltip/DKTooltip.html");
			return;
		}
		dk.create("DKTooltip/DKTooltip.html");
		byId("DKTooltip/DKTooltip.html").innerHTML = byId(id).tooltip;
		byId("DKTooltip/DKTooltip.html").style.top = mouseX+"px";
		byId("DKTooltip/DKTooltip.html").style.left = mouseY+"px";
	}, 1000); 
}