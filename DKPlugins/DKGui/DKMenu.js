
//////////////////////
function DKMenu_Init()
{
	DKLog("DKMenu_Init()\n", DKDEBUG);
}

/////////////////////
function DKMenu_End()
{
	DKLog("DKMenu_End()\n", DKDEBUG);
}

//////////////////////////////
function DKMenu_OnEvent(event)
{
	DKLog("DKMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
}

////////////////////////////////////
function DKMenu_ValidatePosition(id)
{
	DKLog("DKMenu_ValidatePosition("+id+")\n", DKDEBUG);
	//DKLog("DKWindow_GetMouseX() = "+DKWindow_GetMouseX()+"\n");
	//DKLog("DKWindow_GetMouseY() = "+DKWindow_GetMouseY()+"\n");
	//DKWidget_SetProperty(id,"top",DKWindow_GetMouseY()+"px");
	//DKWidget_SetProperty(id,"top",DKWindow_GetMouseY()+"rem");
	//DKWidget_SetProperty(id,"left",DKWindow_GetMouseX()+"px");
	//DKWidget_SetProperty(id,"left",DKWindow_GetMouseX()+"rem");
	
	//DKLog("DKWidget_GetMouseWindowX() = "+DKWidget_GetMouseWindowX()+"\n");
	//DKLog("DKWidget_GetMouseWindowY() = "+DKWidget_GetMouseWindowY()+"\n");
	DKWidget_SetProperty(id,"top",DKWidget_GetMouseWindowY()+"px");
	DKWidget_SetProperty(id,"top",DKWidget_GetMouseWindowY()+"rem");
	DKWidget_SetProperty(id,"left",DKWidget_GetMouseWindowX()+"px");
	DKWidget_SetProperty(id,"left",DKWidget_GetMouseWindowX()+"rem");
	DKWidget_RemoveProperty(id, "right");
	
	//make sure menu is within window
	var win_width = Number(DKWidget_GetClientWidth("body"));
	var win_height = Number(DKWidget_GetClientHeight("body"));
	var top = Number(DKWidget_GetOffsetTop(id));
	var left = Number(DKWidget_GetOffsetLeft(id));
	var width = Number(DKWidget_GetClientWidth(id));
	var height = Number(DKWidget_GetClientHeight(id));
	
	//DKLog("win_width = "+win_width+"\n");
	//DKLog("win_height = "+win_height+"\n");
	//DKLog("top = "+top+"\n");
	//DKLog("left = "+left+"\n");
	//DKLog("width = "+width+"\n");
	//DKLog("height = "+height+"\n");
	
	if(top + height > win_height){
		top = win_height - height;
		DKLog("new top = "+top+"\n");
		DKWidget_SetProperty(id, "top", top+"px");
	}
	if(left + width > win_width){
		DKLog("new left = "+left+"\n");
		left = win_width - width;
		DKWidget_SetProperty(id, "left", left+"px");
	}
}