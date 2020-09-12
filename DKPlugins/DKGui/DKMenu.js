
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
	console.log("DKMenu_ValidatePosition("+id+")");
	//DKINFO("DKWindow_GetMouseX() = "+DKWindow_GetMouseX()+"\n");
	//DKINFO("DKWindow_GetMouseY() = "+DKWindow_GetMouseY()+"\n");
	//DKWidget_SetProperty(id,"top",DKWindow_GetMouseY()+"px");
	//DKWidget_SetProperty(id,"top",DKWindow_GetMouseY()+"rem");
	//DKWidget_SetProperty(id,"left",DKWindow_GetMouseX()+"px");
	//DKWidget_SetProperty(id,"left",DKWindow_GetMouseX()+"rem");
	
	//DKINFO("DKWidget_GetMouseWindowX() = "+DKWidget_GetMouseWindowX()+"\n");
	//DKINFO("DKWidget_GetMouseWindowY() = "+DKWidget_GetMouseWindowY()+"\n");
	byId(id).style.top = "100px";//DKWidget_GetMouseWindowY()+"px";
	byId(id).style.top = "100rem";//DKWidget_GetMouseWindowY()+"rem";
	byId(id).style.left = "100px";//DKWidget_GetMouseWindowX()+"px";
	byId(id).style.left = "100rem";//DKWidget_GetMouseWindowX()+"rem";
	DKWidget_RemoveProperty(id, "right");
	
	//make sure menu is within window
	var win_width = Number(document.body.clientWidth);
	var win_height = Number(document.body.clientHeight);
	//var top = Number(DKWidget_GetOffsetTop(id));
	var top = Number(byId(id).offsetTop);
	var left = Number(byId(id).offsetLeft);
	var width = Number(byId(id).clientWidth);
	var height = Number(byId(id).clientHeight);
	
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