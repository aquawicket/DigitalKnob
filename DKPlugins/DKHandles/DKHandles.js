/////////////////////////
function DKHandles_Init()
{
	DKCreate("DKHandles");
	DKCreate("DKHandles/DKHandles.html");
	DKAddEvent("refresh", "click", DKHandles_OnEvent);
	DKAddEvent("search", "mousedown", DKHandles_OnEvent);
	DKAddEvent("setvalue", "click", DKHandles_OnEvent);
	DKAddEvent("doclick", "click", DKHandles_OnEvent);
	DKAddEvent("Prev", "click", DKHandles_OnEvent);
	DKAddEvent("Next", "click", DKHandles_OnEvent);
	DKAddEvent("Highlight", "click", DKHandles_OnEvent);
	DKAddEvent("GLOBAL", "DKHandles_WindowChanged", DKHandles_OnEvent);
	DKHandles_UpdateWindowList();
	
	document.getElementById("search").ondragstart = function() { return false; };
}

////////////////////////
function DKHandles_End()
{
	DKRemoveEvents(DKHandles_OnEvent);
	DKClose("DKHandles/DKHandles.html");
}

/////////////////////////////////
function DKHandles_OnEvent(event)
{
	DKLog("DKHandles_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event, "refresh")){
		DKHandles_UpdateWindowList();
    }
	if(DK_Id(event, "search")){
		DKLog("search\n", DKINFO);
		DKWidget_SetAttribute("search", "src", "DKHandles/win2.bmp");
		DKHandles_StartSearch();
    }
	if(DK_Id(event, "setvalue")){
		var value = DKWidget_GetValue("SetValueBox");
		DKHandles_SetValue(value);
    }
	if(DK_Id(event, "doclick")){
		DKHandles_Click();
    }
	if(DK_Id(event, "Prev")){
		DKHandles_PrevHandle();
		var value = DKHandles_GetValue();
		DKWidget_SetValue("value", value);
		var clas = DKHandles_GetClass();
		DKWidget_SetValue("class", clas);
		var par = DKHandles_GetParent();
		DKWidget_SetValue("parent", par);
	}
	if(DK_Id(event, "Next")){
		DKHandles_NextHandle();
		var value = DKHandles_GetValue();
		DKWidget_SetValue("value", value);
		var clas = DKHandles_GetClass();
		DKWidget_SetValue("class", clas);
		var par = DKHandles_GetParent();
		DKWidget_SetValue("parent", par);
	}
	if(DK_Id(event, "Highlight")){
		DKHandles_ToggleHighlight();
	}
	if(DK_IdLike(event, "wintitle")){
		//DKLog("DKHandles_OnEvent("+event+")\n");
		//DKLog("DKHandles_OnEvent(): id = "+DK_GetId(event)+"\n");
		//DKLog("DKHandles_OnEvent(): value = "+DKWidget_GetValue(DK_GetId(event))+"\n");
		var handle = DKHandles_SetWindowHandle(DKWidget_GetValue(DK_GetId(event)));
		DKWidget_SetValue("currentHandle", "Handle: "+handle);
		var win = DKWidget_GetValue(DK_GetId(event));
		DKWidget_SetValue("window", win);
		var value = DKHandles_GetValue(handle);
		DKWidget_SetValue("value", value);
		var clas = DKHandles_GetClass(handle);
		DKWidget_SetValue("class", clas);
		var par = DKHandles_GetParent(handle);
		DKWidget_SetValue("parent", par);
	}
	if(DK_Type(event, "DKHandles_WindowChanged")){
		DKLog("DKHandles_WindowChanged\n", DKINFO);
		var handle = DK_GetValue(event);
		DKWidget_SetValue("currentHandle", "Handle: "+handle);
		var value = DKHandles_GetValue(handle);
		DKWidget_SetValue("value", value);
		var clas = DKHandles_GetClass(handle);
		DKWidget_SetValue("class", clas);
		var par = DKHandles_GetParent(handle);
		DKWidget_SetValue("parent", par);
	}
}

/////////////////////////////////////
function DKHandles_UpdateWindowList()
{
	DKWidget_SetInnerHtml("windows", "");
	var str = DKHandles_GetWindows();
	if(!str){ return; }
	//DKLog("WINDOW LIST: "+str+"\n");
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