///////////////////////
function DKHooks_Init()
{
	DKCreate("DKHook/DKHooks.html");
	DKCreate("DKHookJS");
	DKAddEvent("getvalue", "click", DKHooks_OnEvent);
	DKAddEvent("setvalue", "click", DKHooks_OnEvent);
	DKAddEvent("doclick", "click", DKHooks_OnEvent);
	DKAddEvent("Prev", "click", DKHooks_OnEvent);
	DKAddEvent("Next", "click", DKHooks_OnEvent);
	DKAddEvent("Highlight", "click", DKHooks_OnEvent);
	DKHooks_UpdateWindowList();
}

//////////////////////
function DKHooks_End()
{
	DKClose("DKHooks.html");
}

///////////////////////////////
function DKHooks_OnEvent(event)
{
	if(DK_Id(event, "getvalue")){
		var value = DKHook_GetValue();
		DKWidget_SetValue("GetValueBox", value);
    }
	if(DK_Id(event, "setvalue")){
		var value = DKWidget_GetValue("SetValueBox");
		DKHook_SetValue(value);
    }
	if(DK_Id(event, "doclick")){
		DKHook_Click();
    }
	if(DK_Id(event, "Prev")){
		DKHook_PrevHandle();
	}
	if(DK_Id(event, "Next")){
		DKHook_NextHandle();
	}
	if(DK_Id(event, "Highlight")){
		DKHook_ToggleHighlight();
	}
	if(DK_IdLike(event, "wintitle")){
		DKHook_SetWindowHandle(DKWidget_GetValue(event));
	}

	DKWidget_SetValue("currentHandle", DKHook_CurrentHandle());
}

///////////////////////////////////
function DKHooks_UpdateWindowList()
{
	var str = DKHook_GetWindows();
	if(!str){ return; }
	DKLog("WINDOW LIST: "+str+"\n", DKDEBUG);
	var arry = str.split(",");
	
	//RemoveDuplicates(arry);
	for(var i=0; i<arry.length; i++){
		var element = DKWidget_CreateElement("windows", "option", "wintitle");
		DKWidget_SetAttribute(element, "value", arry[i]);
		DKWidget_SetProperty(element, "white-space", "nowrap");
		DKAddEvent(element, "click", DKHooks_OnEvent);
		DKWidget_SetInnerHtml(element,arry[i]);
	}
}