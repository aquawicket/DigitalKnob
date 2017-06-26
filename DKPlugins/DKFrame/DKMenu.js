
//////////////////////
function DKMenu_Init()
{
	//DKLog("DKMenu_Init()\n");
}

//////////////////////
function DKMenu_End()
{
	//DKLog("DKMenu_End()\n");
}

///////////////////////////////
function DKMenu_OnEvent(event)
{
	//DKLog("DKMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
}

////////////////////////////////////
function DKMenu_ValidatePosition(id)
{
	//set position to mouse
	DKWidget_SetProperty(id,"top",DKWindow_GetMouseY()+"px");
	DKWidget_SetProperty(id,"top",DKWindow_GetMouseY()+"rem");
	DKWidget_SetProperty(id,"left",DKWindow_GetMouseX()+"px");
	DKWidget_SetProperty(id,"left",DKWindow_GetMouseX()+"rem");
	
	//make sure menu is within window
	var win_width = DKWidget_GetClientWidth("body");
	var win_height = DKWidget_GetClientHeight("body");
	var top = DKWidget_GetOffsetTop(id);
	var left = DKWidget_GetOffsetLeft(id);
	var width = DKWidget_GetClientWidth(id);
	var height = DKWidget_GetClientHeight(id);
	if(top + height > win_height){
		top = win_height - height;
		DKWidget_SetProperty(id, "top", top+"px");
	}
	if(left + width > win_width){
		left = win_width - width;
		DKWidget_SetProperty(id, "left", left+"px");
	}
}