
/////////////////////////////
function DKEditor_Menu_Init()
{
	DKCreate("DKEditor/DKEditor_Menu.html");
	DKWidget_SetProperty("DKEditor_Menu.html","top",DKWindow_GetMouseY()+"px");
	DKWidget_SetProperty("DKEditor_Menu.html","top",DKWindow_GetMouseY()+"rem");
	DKWidget_SetProperty("DKEditor_Menu.html","left",DKWindow_GetMouseX()+"px");
	DKWidget_SetProperty("DKEditor_Menu.html","left",DKWindow_GetMouseX()+"rem");
	DKAddEvent("GLOBAL", "mousedown", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Reload", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Assets", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_DevTools", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_ClearConsole", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_NewFrame", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Builder", "click", DKEditor_Menu_OnEvent);
}

////////////////////////////
function DKEditor_Menu_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKEditor_Menu_OnEvent);
	DKRemoveEvent("DKEditor_Menu_Reload", "click", DKEditor_Menu_OnEvent);
	DKRemoveEvent("DKEditor_Menu_Assets", "click", DKEditor_Menu_OnEvent);
	DKRemoveEvent("DKEditor_Menu_DevTools", "click", DKEditor_Menu_OnEvent);
	DKRemoveEvent("DKEditor_Menu_ClearConsole", "click", DKEditor_Menu_OnEvent);
	DKRemoveEvent("DKEditor_Menu_NewFrame", "click", DKEditor_Menu_OnEvent);
	DKRemoveEvent("DKEditor_Menu_Builder", "click", DKEditor_Menu_OnEvent);
	DKClose("DKEditor/DKEditor_Menu.html");
}

/////////////////////////////////////
function DKEditor_Menu_OnEvent(event)
{
	DKLog("DKEditor_Menu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKINFO);
	
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
		if(typeof DKCef_ShowDevTools == 'function'){
			DKCef_ShowDevTools("Cef", 0);
		}
	}
	if(DK_Id(event, "DKEditor_Menu_ClearConsole")){
		DKDebug_ClearConsole();
		if(DK_GetOS() == "Win32" || DK_GetOS() == "Win64"){
			DK_System("cls");
		}
		if(DK_GetOS() == "Mac" || DK_GetOS() == "Linux"){
			DK_System("clear");
		}
	}
	if(DK_Id(event, "DKEditor_Menu_NewFrame")){
		DKCreate("DKMessage/DKMessage.js", function(){
			DKFrame_Widget("DKMessage.html");
			DKMessageBox_GetValue("Enter name", function(rval){
				DKLog("DKMessageBox_GetValue() rval = "+rval+"\n", DKINFO);
				if(!rval){ return; }
				DKLog("Frame name: "+rval+"\n", DKINFO);
				//TODO
			});
		});
	}
	
	if(DK_Id(event, "DKEditor_Menu_Builder")){
		DKCreate("DKBuild/DKBuildGUI.js", function(){
			DKFrame_Widget("DKBuildGUI.html");
		});
	}

	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKEditor_Menu.html")){
			return;
		}
	}
	DKClose("DKEditor/DKEditor_Menu.js");
}