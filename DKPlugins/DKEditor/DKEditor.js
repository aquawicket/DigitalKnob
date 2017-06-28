////////////////////////
function DKEditor_Init()
{
	//DKLog("DKEditor_Init()\n");
	
	DKCreate("DKEditor/DKEditor.html");
	DKAddEvent("DKEditor_edit", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_edit", "contextmenu", DKEditor_OnEvent);
	DKAddEvent("DKEditor_edit", "mouseover", DKEditor_OnEvent);
	
	if(DK_GetBrowser() != "Rocket"){
		DKWidget_AddDragHandle("DKEditor/DKEditor.html", "DKEditor/DKEditor.html"); //FIXME - eats click events in Rocket
	}
}

///////////////////////
function DKEditor_End()
{
	//DKLog("DKEditor_End()\n");
	
	DKClose("DKEditor/DKEditor.html");
}

////////////////////////////////
function DKEditor_OnEvent(event)
{
	//DKLog("DKEditor_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event, "DKEditor_edit") && DK_Type(event, "mouseover")){
		//DKLog("DKEditor_edit: mouseover\n");
		//DKCreate("DKTooltip/DKTooltip.js", function(){
		//	DKTooltip_SetText("Admin tools");
		//});
	}
	if(DK_Id(event, "DKEditor_edit") && !DK_Type(event, "mouseover")){
		DKCreate("DKEditor/DKEditor_Menu.js", function(){
			DKMenu_ValidatePosition("DKEditor/DKEditor_Menu.html");
		});
	}
}