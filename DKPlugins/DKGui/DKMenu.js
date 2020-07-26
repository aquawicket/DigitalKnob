
//////////////////////
function DKMenu_Init()
{
	DKDEBUGFUNC();
}

/////////////////////
function DKMenu_End()
{
	DKDEBUGFUNC();
}

//////////////////////////////
function DKMenu_OnEvent(event)
{
	DKDEBUGFUNC(event);
}

////////////////////////////////////
function DKMenu_ValidatePosition(id)
{
	DKDEBUGFUNC(id);
	//DKINFO("DKWindow_GetMouseX() = "+DKWindow_GetMouseX()+"\n");
	//DKINFO("DKWindow_GetMouseY() = "+DKWindow_GetMouseY()+"\n");
	//DKWidget_SetProperty(id,"top",DKWindow_GetMouseY()+"px");
	//DKWidget_SetProperty(id,"top",DKWindow_GetMouseY()+"rem");
	//DKWidget_SetProperty(id,"left",DKWindow_GetMouseX()+"px");
	//DKWidget_SetProperty(id,"left",DKWindow_GetMouseX()+"rem");
	
	//DKINFO("DKWidget_GetMouseWindowX() = "+DKWidget_GetMouseWindowX()+"\n");
	//DKINFO("DKWidget_GetMouseWindowY() = "+DKWidget_GetMouseWindowY()+"\n");
	document.getElementById(id).style.top = "100px";//DKWidget_GetMouseWindowY()+"px";
	document.getElementById(id).style.top = "100rem";//DKWidget_GetMouseWindowY()+"rem";
	document.getElementById(id).style.left = "100px";//DKWidget_GetMouseWindowX()+"px";
	document.getElementById(id).style.left = "100rem";//DKWidget_GetMouseWindowX()+"rem";
	DKWidget_RemoveProperty(id, "right");
	
	//make sure menu is within window
	var win_width = Number(DKWidget_GetClientWidth("body"));
	var win_height = Number(DKWidget_GetClientHeight("body"));
	var top = Number(DKWidget_GetOffsetTop(id));
	var left = Number(DKWidget_GetOffsetLeft(id));
	var width = Number(DKWidget_GetClientWidth(id));
	var height = Number(DKWidget_GetClientHeight(id));
	
	//DKINFO("win_width = "+win_width+"\n");
	//DKINFO("win_height = "+win_height+"\n");
	//DKINFO("top = "+top+"\n");
	//DKINFO("left = "+left+"\n");
	//DKINFO("width = "+width+"\n");
	//DKINFO("height = "+height+"\n");
	
	if(top + height > win_height){
		top = win_height - height;
		DKINFO("new top = "+top+"\n");
		DKWidget_SetProperty(id, "top", top+"px");
	}
	if(left + width > win_width){
		DKINFO("new left = "+left+"\n");
		left = win_width - width;
		DKWidget_SetProperty(id, "left", left+"px");
	}
}