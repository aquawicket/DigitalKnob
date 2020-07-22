/////////////////////////////
function DKEditor_Menu_Init()
{
	DKDEBUGFUNC();	
	DKCreate("DKEditor/DKEditor_Menu.html");
	DKAddEvent("window", "mousedown", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Refresh", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Reload", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Notes", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Assets", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_TestBrowserApp", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_DevTools", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_ClearConsole", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_ShowConsole", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_HideConsole", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_PushFiles", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_GitUpdate", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_GitCommit", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_NewFrame", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Builder", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Info", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_RefreshIcons", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Report", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Web", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Web", "click", DKEditor_Menu_OnEvent);
	DKAddEvent("DKEditor_Menu_Command_Input", "change", DKEditor_Menu_OnEvent);
	
	/*
	DKCreate("DKTooltip/DKTooltip.js", function(){});
	DKTooltip_Add("DKEditor_Menu_Notes", "notes...");
	DKTooltip_Add("DKEditor_Menu_Reload", "refresh the page");
	DKTooltip_Add("DKEditor_Menu_Assets", "view DKTemplate asset files");
	DKTooltip_Add("DKEditor_Menu_DevTools", "open dev tools");
	*/
}

////////////////////////////
function DKEditor_Menu_End()
{
	DKDEBUGFUNC();	
	DKRemoveEvents(DKEditor_Menu_OnEvent);
	DKClose("DKEditor/DKEditor_Menu.html");
}

/////////////////////////////////////
function DKEditor_Menu_OnEvent(event)
{
	DKDEBUGFUNC(event);
	DKDEBUG("DKEditor_Menu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");	
	if(DK_Id(event, "DKEditor_Menu_Command_Input")){
		//TODO
		DKINFO("TODO\n");
	}
	if(DK_Id(event, "DKEditor_Menu_Reload")){
		DKDebug_Reload();
	}
	if(DK_Id(event, "DKEditor_Menu_Refresh")){
		DKDebug_Refresh();
	}
	if(DK_Id(event, "DKEditor_Menu_Notes")){
		DKCreate("DKNotepad/DKNotepad.js", function(rval){
			if(!rval){ return; }
			DKFrame_Widget("DKNotepad/DKNotepad.html");
			DKNotepad_Open(DKAssets_LocalAssets()+"/notes.txt");
		});
	}
	if(DK_Id(event, "DKEditor_Menu_Assets")){
		DKCreate("DKFile/DKSolution.js", function(rval){
			if(!rval){ return; }
			DKFrame_Widget("DKFile/DKSolution.html");
			DKFrame_SetTitle("DKFile/DKSolution.html", "File Explorer");
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
			DKCef_ShowDevTools(0);
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
		DKCreate("DKMessage/DKMessage.js", function(rval){
			if(!rval){ return; }
			DKFrame_Widget("DKMessage/DKMessage.html");
			DKMessageBox_GetValue("Enter name", function(rval){
				//DKINFO("DKMessageBox_GetValue() rval = "+rval+"\n");
				if(!rval){ return; }
				//DKINFO("Frame name: "+rval+"\n");
			});
		});
	}
	if(DK_Id(event, "DKEditor_Menu_Builder")){
		DKCreate("DKBuild/DKBuildGUI.js", function(rval){
			if(!rval){ return; }
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
	if(DK_Id(event, "DKEditor_Menu_RefreshIcons")){
		//FIXME - not working
		//DK_Execute("C:/Windows/System32/ie4uinit.exe -ClearIconCache");
		
		//https://stackoverflow.com/questions/8837059/why-shellexecute-can-not-find-a-file
		DK_Run("C:/Windows/System32/ie4uinit.exe","-ClearIconCache");
		//NOTE: For Windows 10, use: "ie4uinit.exe -show"
	}
	if(DK_Id(event, "DKEditor_Menu_Report")){
		DKCreate("DKDebug/SendBugReport.js", function(){
			DKFrame_Widget("DKDebug/SendBugReport.html");
		});
	}
	if(DK_Id(event, "DKEditor_Menu_Web")){
		DKINFO("DKEditor_Menu_Web()\n");
		//TODO - Create an iFrame and display digitalknob.com
		var div = DKWidget_CreateElement("body", "div", "DKIframe.html");
		document.getElementById(div).style.position = "absolute";
		document.getElementById(div).style.width = "100%";
		document.getElementById(div).style.height = "100%";
		
		var iframe = DKWidget_CreateElement(div, "iframe", "iframe");
		DKWidget_SetAttribute(iframe, "src", "http://digitalknob.com");
		DKWidget_SetAttribute(iframe, "width", "100%");
		DKWidget_SetAttribute(iframe, "height", "100%");
		document.getElementById(iframe).style.borderWidth = "0px";
		document.getElementById(iframe).style.overflow = "auto";
		
		DKFrame_Widget(div);
	}

	///////////////////////////
	if(DK_Id(event, "window")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKEditor/DKEditor_Menu.html")){
			return;
		}
	}
	
	DKClose("DKEditor/DKEditor_Menu.js");
}