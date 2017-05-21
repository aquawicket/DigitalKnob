
/////////////////////////////
function DKEditor_Menu_Init()
{
	DKCreate("DKEditor/DKEditor_Menu.html");
	DKWidget_SetProperty("DKEditor_Menu.html","top",DKWindow_GetMouseY()+"rem");
	DKWidget_SetProperty("DKEditor_Menu.html","left",DKWindow_GetMouseX()+"rem");
	DKAddEvent("GLOBAL", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("GLOBAL", "contextmenu", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Reload", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Assets", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_DevTools", "click", DKEditor_Menu_OnEvent);
}

////////////////////////////
function DKEditor_Menu_End()
{
	DKRemoveEvent("GLOBAL", "click", DKEditor_Menu_OnEvent);
	DKRemoveEvent("GLOBAL", "contextmenu", DKEditor_Menu_OnEvent);
	DKRemoveEvent("DKEditor_Menu_Reload", "click", DKEditor_Menu_OnEvent);
	DKRemoveEvent("DKEditor_Menu_Assets", "click", DKEditor_Menu_OnEvent);
	DKRemoveEvent("DKEditor_Menu_DevTools", "click", DKEditor_Menu_OnEvent);
	DKClose("DKEditor/DKEditor_Menu.html");
}

/////////////////////////////////////
function DKEditor_Menu_OnEvent(event)
{
	//DKLog("DKEditor_Menu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKINFO);
	
	if(DK_Id(event, "DKEditor_Menu_Reload")){
		DKDebug_RestartApp();
	}
	
	if(DK_Id(event, "DKEditor_Menu_Assets")){
		DKCreate("DKBuild/DKSolution.js", function(){
			var frame = DKFrame_Widget("DKSolution.html");
			DKSolution_UpdatePath(DKAssets_LocalAssets());
			DKWidget_SetProperty("DKSolution.html", "height", "300rem");
		});
	}
	
	if(DK_Id(event, "DKEditor_Menu_DevTools")){
		//DKCef_ShowDevTools("Cef", 0);
	}

	DKClose("DKEditor/DKEditor_Menu.js");
}