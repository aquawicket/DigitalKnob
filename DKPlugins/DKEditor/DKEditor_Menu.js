/////////////////////////////
function DKEditor_Menu_Init()
{
	//DKLog("DKEditor_Menu_Init() \n");
	
	DKCreate("DKEditor/DKEditor_Menu.html");
	DKAddEvent("GLOBAL", "mousedown", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Notes", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Reload", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Assets", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_DevTools", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_ClearConsole", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_ShowConsole", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_HideConsole", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_NewFrame", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Builder", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_PushFiles", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_GitUpdate", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_GitCommit", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Info", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Report", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Web", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_TestBrowserApp", "click", DKEditor_Menu_OnEvent);	
}

////////////////////////////
function DKEditor_Menu_End()
{
	//DKLog("DKEditor_Menu_End() \n");
	
	DKRemoveEvents(DKEditor_Menu_OnEvent);
	DKClose("DKEditor/DKEditor_Menu.html");
}

/////////////////////////////////////
function DKEditor_Menu_OnEvent(event)
{
	//DKLog("DKEditor_Menu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+") \n");
	
	if(DK_Id(event, "DKEditor_Menu_Reload")){
		DKDebug_RestartApp();
	}
	if(DK_Id(event, "DKEditor_Menu_Notes")){
		DKCreate("DKNotepad/DKNotepad.js", function(){
			DKFrame_Widget("DKNotepad/DKNotepad.html");
			DKNotepad_Open(DKAssets_LocalAssets()+"/notes.txt");
		});
	}
	if(DK_Id(event, "DKEditor_Menu_Assets")){
		DKCreate("DKFile/DKSolution.js", function(){
			DKFrame_Widget("DKFile/DKSolution.html");
			DKSolution_UpdatePath(DKAssets_LocalAssets());
		});
	}
	if(DK_Id(event, "DKEditor_Menu_TestBrowserApp")){
		DKCreate("DKEditor/DKEditor_BrowserMenu.js", function(){
			DKMenu_ValidatePosition("DKEditor/DKEditor_BrowserMenu.html");
		});
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_DevTools")){
		if(typeof DKCef_ShowDevTools == 'function'){
			DKCef_ShowDevTools("Cef", 0);
		}
		if(typeof DKRocket_ToggleDebugger == 'function'){
			DKRocket_ToggleDebugger();
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
	if(DK_Id(event, "DKEditor_Menu_ShowConsole")){
		DK_ShowConsole();
	}
	if(DK_Id(event, "DKEditor_Menu_HideConsole")){
		DK_HideConsole();
	}
	if(DK_Id(event, "DKEditor_Menu_NewFrame")){
		DKCreate("DKMessage/DKMessage.js", function(){
			DKFrame_Widget("DKMessage/DKMessage.html");
			DKMessageBox_GetValue("Enter name", function(rval){
				//DKLog("DKMessageBox_GetValue() rval = "+rval+"\n");
				if(!rval){ return; }
				//DKLog("Frame name: "+rval+"\n");
			});
		});
	}
	if(DK_Id(event, "DKEditor_Menu_Builder")){
		DKCreate("DKBuild/DKBuildGUI.js", function(){
			DKFrame_Widget("DKBuild/DKBuildGUI.html");
		});
	}
	if(DK_Id(event, "DKEditor_Menu_Info")){
		DKDebug_PrintInfo();
	}
	if(DK_Id(event, "DKEditor_Menu_PushFiles")){
		DKDebug_PushDKFiles();
	}
	if(DK_Id(event, "DKEditor_Menu_GitUpdate")){
		DKCreate("DKBuild/DKBuild.js", function(){
			DKBuild_GitUpdate();
		});
	}
	if(DK_Id(event, "DKEditor_Menu_GitCommit")){
		DKCreate("DKBuild/DKBuild.js", function(){
			DKBuild_GitCommit();
		});
	}
	if(DK_Id(event, "DKEditor_Menu_Report")){
		DKCreate("DKDebug/SendBugReport.js", function(){
			DKFrame_Widget("DKDebug/SendBugReport.html");
		});
	}
	if(DK_Id(event, "DKEditor_Menu_Web")){
		DKLog("DKEditor_Menu_Web()\n");
		//TODO - Create an iFrame and display digitalknob.com
	}

	///////////////////////////
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKEditor/DKEditor_Menu.html")){
			return;
		}
	}
	
	DKClose("DKEditor/DKEditor_Menu.js");
}