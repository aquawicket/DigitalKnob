/////////////////////////
function DKHandles_Init()
{
	DKCreate("DKHandles");
	DKCreate("DKHandles/DKHandles.html");
	window.addEventListener("click", DKHandles_OnEvent);
	window.addEventListener("DKHandles_WindowChanged", DKHandles_OnEvent);
	byId("refresh").addEventListener("click", DKHandles_OnEvent);
	byId("parent").addEventListener("click", DKHandles_OnEvent);
	byId("search").addEventListener("mousedown", DKHandles_OnEvent);
	byId("setvalue").addEventListener("click", DKHandles_OnEvent);
	byId("doclick").addEventListener("click", DKHandles_OnEvent);
	byId("Prev").addEventListener("click", DKHandles_OnEvent);
	byId("Next").addEventListener("click", DKHandles_OnEvent);
	byId("Highlight").addEventListener("click", DKHandles_OnEvent);
	DKHandles_UpdateWindowList();
	
	document.getElementById("search").ondragstart = function() { return false; };
}

////////////////////////
function DKHandles_End()
{
	window.removeEventListener("click", DKHandles_OnEvent);
	window.removeEventListener("DKHandles_WindowChanged", DKHandles_OnEvent);
	byId("refresh").removeEventListener("click", DKHandles_OnEvent);
	byId("parent").removeEventListener("click", DKHandles_OnEvent);
	byId("search").removeEventListener("mousedown", DKHandles_OnEvent);
	byId("setvalue").removeEventListener("click", DKHandles_OnEvent);
	byId("doclick").removeEventListener("click", DKHandles_OnEvent);
	byId("Prev").removeEventListener("click", DKHandles_OnEvent);
	byId("Next").removeEventListener("click", DKHandles_OnEvent);
	byId("Highlight").removeEventListener("click", DKHandles_OnEvent);
	DKClose("DKHandles/DKHandles.html");
}

/////////////////////////////////
function DKHandles_OnEvent(event)
{
	if(event.currentTarget === window){
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
		byId("search").src = "DKHandles/win2.bmp";
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
		byId("search").src = "DKHandles/win1.bmp";
		var handle = DK_GetValue(event);
		DKHandles_UpdateProperties(handle);
	}
}

/////////////////////////////////////
function DKHandles_UpdateWindowList()
{
	DKWidget_SetInnerHtml("windows", "");
	var str = DKHandles_GetWindows();
	if(!str){ return; }
	//console.log("WINDOW LIST: "+str+"\n");
	var arry = str.split(",");
	arry.sort();
	
	//RemoveDuplicates(arry);
	for(var i=0; i<arry.length; i++){
		var element = DKWidget_CreateElement("windows", "option", "wintitle");
		byId(element).value = arry[i];
		DKWidget_SetProperty(element, "white-space", "nowrap");
		byId(element, "click", DKHandles_OnEvent);
		DKWidget_SetInnerHtml(element,arry[i]);
	}
}

///////////////////////////////////////////
function DKHandles_UpdateProperties(handle)
{
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