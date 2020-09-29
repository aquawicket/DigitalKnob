/////////////////////////
function DKHandles_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKHandles");
	DKCreate("DKHandles/DKHandles.html");
	DKAddEvent("refresh", "click", DKHandles_OnEvent);
	DKAddEvent("window", "click", DKHandles_OnEvent);
	DKAddEvent("parent", "click", DKHandles_OnEvent);
	DKAddEvent("search", "mousedown", DKHandles_OnEvent);
	DKAddEvent("setvalue", "click", DKHandles_OnEvent);
	DKAddEvent("doclick", "click", DKHandles_OnEvent);
	DKAddEvent("Prev", "click", DKHandles_OnEvent);
	DKAddEvent("Next", "click", DKHandles_OnEvent);
	DKAddEvent("Highlight", "click", DKHandles_OnEvent);
	DKAddEvent("window", "DKHandles_WindowChanged", DKHandles_OnEvent);
	DKHandles_UpdateWindowList();
	
	document.getElementById("search").ondragstart = function() { return false; };
}

////////////////////////
function DKHandles_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKHandles_OnEvent);
	DKClose("DKHandles/DKHandles.html");
}

/////////////////////////////////
function DKHandles_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(event.currentTarget.id == "window"){
		var handle = DKWidget_GetInnerHtml("window");
		DKHandles_UpdateProperties(handle);
    }
	if(event.currentTarget.id == "parent"){
		var handle = DKWidget_GetInnerHtml("parent");
		DKHandles_UpdateProperties(handle);
    }
	if(event.currentTarget.id == "refresh"){
		DKHandles_UpdateWindowList();
    }
	if(event.currentTarget.id == "search"){
		//console.log("search\n");
		DKWidget_SetAttribute("search", "src", "DKHandles/win2.bmp");
		DKHandles_StartSearch();
    }
	if(event.currentTarget.id == "setvalue"){
		var value = DKWidget_GetValue("SetValueBox");
		var currentHandle = DKHandles_CurrentHandle();
		DKHandles_SetValue(currentHandle, value);
    }
	if(event.currentTarget.id == "doclick"){
		var currentHandle = DKHandles_CurrentHandle();
		DKHandles_Click(currentHandle);
    }
	if(event.currentTarget.id == "Prev"){
		var currentHandle = DKHandles_CurrentHandle();
		var handle = DKHandles_PrevHandle(currentHandle);
		DKHandles_UpdateProperties(handle);
	}
	if(event.currentTarget.id == "Next"){
		var currentHandle = DKHandles_CurrentHandle();
		var handle = DKHandles_NextHandle(currentHandle);
		DKHandles_UpdateProperties(handle);
	}
	if(event.currentTarget.id == "Highlight"){
		DKHandles_ToggleHighlight();
	}
	if(event.currentTarget.id == "wintitle"){
		var handle = DKHandles_SetWindowHandle(DKWidget_GetValue(DK_GetId(event)));
		DKHandles_UpdateProperties(handle);
	}
	if(event.type == "DKHandles_WindowChanged"){
		//console.log("DKHandles_WindowChanged\n");
		DKWidget_SetAttribute("search", "src", "DKHandles/win1.bmp");
		var handle = DK_GetValue(event);
		DKHandles_UpdateProperties(handle);
	}
}

/////////////////////////////////////
function DKHandles_UpdateWindowList()
{
	DKDEBUGFUNC();
	DKWidget_SetInnerHtml("windows", "");
	var str = DKHandles_GetWindows();
	if(!str){ return; }
	//console.log("WINDOW LIST: "+str+"\n");
	var arry = str.split(",");
	arry.sort();
	
	//RemoveDuplicates(arry);
	for(var i=0; i<arry.length; i++){
		var element = DKWidget_CreateElement("windows", "option", "wintitle");
		DKWidget_SetAttribute(element, "value", arry[i]);
		DKWidget_SetProperty(element, "white-space", "nowrap");
		DKAddEvent(element, "click", DKHandles_OnEvent);
		DKWidget_SetInnerHtml(element,arry[i]);
	}
}

///////////////////////////////////////////
function DKHandles_UpdateProperties(handle)
{
	DKDEBUGFUNC(handle);
	DKWidget_SetValue("currentHandle", "Handle: "+handle);
	var win = DKHandles_GetWindow(handle);
	DKWidget_SetValue("window", win);
	var value = DKHandles_GetValue(handle);
	DKWidget_SetValue("value", value);
	var clas = DKHandles_GetClass(handle);
	DKWidget_SetValue("class", clas);
	var par = DKHandles_GetParent(handle);
	if(!par){
		DKWidget_SetValue("parent", "");
	}
	else{
		DKWidget_SetValue("parent", par);
	}
	var index = DKHandles_GetIndex(handle);
	DKWidget_SetValue("index", index);
	var windowindex = DKHandles_GetWindowIndex(handle);
	DKWidget_SetValue("windowindex", windowindex);
	
	var top = DKHandles_GetTop(handle);
	DKWidget_SetInnerHtml("Handle_top", "Top: "+top);
	var left = DKHandles_GetLeft(handle);
	DKWidget_SetInnerHtml("Handle_left", "Left: "+left);
	var right = DKHandles_GetRight(handle);
	DKWidget_SetInnerHtml("Handle_right", "Right: "+right);
	var bottom = DKHandles_GetBottom(handle);
	DKWidget_SetInnerHtml("Handle_bottom", "Bottom: "+bottom);
}