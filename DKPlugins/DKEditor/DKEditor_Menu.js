/////////////////////////////
function DKEditor_Menu_Init()
{
	DKCreate("DKEditor/DKEditor_Menu.html");
	window.addEventListener("mousedown", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Refresh").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Reload").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Notes").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Assets").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_TestBrowserApp").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_DevTools").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_ClearConsole").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_ShowConsole").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_HideConsole").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_PushFiles").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_GitUpdate").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_GitCommit").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_NewFrame").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Builder").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Info").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_RefreshIcons").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Report").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Web").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Web").addEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Command_Input").addEventListener("change", DKEditor_Menu_OnEvent);
	
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
	window.removeEventListener("mousedown", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Refresh").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Reload").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Notes").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Assets").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_TestBrowserApp").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_DevTools").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_ClearConsole").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_ShowConsole").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_HideConsole").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_PushFiles").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_GitUpdate").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_GitCommit").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_NewFrame").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Builder").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Info").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_RefreshIcons").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Report").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Web").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Web").removeEventListener("click", DKEditor_Menu_OnEvent);
	byId("DKEditor_Menu_Command_Input").removeEventListener("change", DKEditor_Menu_OnEvent);
	DKClose("DKEditor/DKEditor_Menu.html");
}

/////////////////////////////////////
function DKEditor_Menu_OnEvent(event)
{
	console.debug("DKEditor_Menu_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");	
	if(event.currentTarget.id == "DKEditor_Menu_Command_Input"){
		//TODO
		console.log("TODO\n");
	}
	if(event.currentTarget.id == "DKEditor_Menu_Reload"){
		DKDebug_Reload();
	}
	if(event.currentTarget.id == "DKEditor_Menu_Refresh"){
		DKDebug_Refresh();
	}
	if(event.currentTarget.id == "DKEditor_Menu_Notes"){
		DKCreate("DKNotepad/DKNotepad.js", function(rval){
			if(!rval){ return; }
			DKFrame_Widget("DKNotepad/DKNotepad.html");
			DKNotepad_Open(DKAssets_LocalAssets()+"/notes.txt");
		});
	}
	if(event.currentTarget.id == "DKEditor_Menu_Assets"){
		DKCreate("DKFile/DKSolution.js", function(rval){
			if(!rval){ return; }
			DKFrame_Widget("DKFile/DKSolution.html");
			DKFrame_SetTitle("DKFile/DKSolution.html", "File Explorer");
			DKSolution_UpdatePath(DKAssets_LocalAssets());
		});
	}
	if(event.currentTarget.id == "DKEditor_Menu_TestBrowserApp"){
		DKCreate("DKEditor/DKEditor_BrowserMenu.js", function(){
			DKMenu_ValidatePosition("DKEditor/DKEditor_BrowserMenu.html");
		});
		return;
	}
	if(event.currentTarget.id == "DKEditor_Menu_DevTools"){
		if(typeof DKCef_ShowDevTools == 'function'){
			DKCef_ShowDevTools(0);
		}
		if(typeof DKRocket_ToggleDebugger == 'function'){
			DKRocket_ToggleDebugger();
		}
	}
	if(event.currentTarget.id == "DKEditor_Menu_ClearConsole"){
		DKDebug_ClearConsole();
		if(DK_GetOS() == "Win32" || DK_GetOS() == "Win64"){
			DK_System("cls");
		}
		if(DK_GetOS() == "Mac" || DK_GetOS() == "Linux"){
			DK_System("clear");
		}
	}
	if(event.currentTarget.id == "DKEditor_Menu_ShowConsole"){
		DK_ShowConsole();
	}
	if(event.currentTarget.id == "DKEditor_Menu_HideConsole"){
		DK_HideConsole();
	}
	if(event.currentTarget.id == "DKEditor_Menu_NewFrame"){
		DKCreate("DKMessage/DKMessage.js", function(rval){
			if(!rval){ return; }
			DKFrame_Widget("DKMessage/DKMessage.html");
			DKMessageBox_GetValue("Enter name", function(rval){
				//console.log("DKMessageBox_GetValue() rval = "+rval+"\n");
				if(!rval){ return; }
				//console.log("Frame name: "+rval+"\n");
			});
		});
	}
	if(event.currentTarget.id == "DKEditor_Menu_Builder"){
		DKCreate("DKBuild/DKBuildGUI.js", function(rval){
			if(!rval){ return; }
			DKFrame_Widget("DKBuild/DKBuildGUI.html");
		});
	}
	if(event.currentTarget.id == "DKEditor_Menu_Info"){
		DKDebug_PrintInfo();
	}
	if(event.currentTarget.id == "DKEditor_Menu_PushFiles"){
		DKDebug_PushDKFiles();
	}
	if(event.currentTarget.id == "DKEditor_Menu_GitUpdate"){
		DKCreate("DKBuild/DKBuild.js", function(){
			DKBuild_GitUpdate();
		});
	}
	if(event.currentTarget.id == "DKEditor_Menu_GitCommit"){
		DKCreate("DKBuild/DKBuild.js", function(){
			DKBuild_GitCommit();
		});
	}
	if(event.currentTarget.id == "DKEditor_Menu_RefreshIcons"){
		//FIXME - not working
		//DK_Execute("C:/Windows/System32/ie4uinit.exe -ClearIconCache");
		
		//https://stackoverflow.com/questions/8837059/why-shellexecute-can-not-find-a-file
		DK_Run("C:/Windows/System32/ie4uinit.exe","-ClearIconCache");
		//NOTE: For Windows 10, use: "ie4uinit.exe -show"
	}
	if(event.currentTarget.id == "DKEditor_Menu_Report"){
		DKCreate("DKDebug/SendBugReport.js", function(){
			DKFrame_Widget("DKDebug/SendBugReport.html");
		});
	}
	if(event.currentTarget.id == "DKEditor_Menu_Web"){
		console.log("DKEditor_Menu_Web()\n");
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

	if(event.currentTarget == window){
		if(byId("DKEditor/DKEditor_Menu.html").contains(DKWidget_GetHoverElement())){	
			return;
		}
	}
	
	DKClose("DKEditor/DKEditor_Menu.js");
}