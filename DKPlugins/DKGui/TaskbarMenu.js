//TODO - Give this DKTtaskbarMenu the ability start with a blank slate.
// All elements will be added dynamically via DKTaskbarMenu functions.   I.E.  DKTaskbarMenu_AddApp(); 
// Start with a blank DKTaskbarMenu that forms to the number of elements in it.

///////////////////////////
function TaskbarMenu_Init()
{
	//DKCreate("DKGui/TaskbarMenu.html,DKGui/DKOS.html", function(){
	DKCreate("DKGui/TaskbarMenu.html", function(){
		DKAddEvent("GLOBAL", "mousedown", TaskbarMenu_OnEvent);
		DKAddEvent("OpenSource", "click", TaskbarMenu_OnEvent);
		DKAddEvent("OpenDebug", "click", TaskbarMenu_OnEvent);
		DKAddEvent("PushDKFiles", "click", TaskbarMenu_OnEvent);
		DKAddEvent("ClearConsole", "click", TaskbarMenu_OnEvent);
		DKAddEvent("Info", "click", TaskbarMenu_OnEvent);
		DKAddEvent("Refresh", "click", TaskbarMenu_OnEvent);
		DKAddEvent("CloseDKGui", "click", TaskbarMenu_OnEvent);
		DKAddEvent("FileExplorer", "click", TaskbarMenu_OnEvent);
		DKAddEvent("OpenBuilder", "click", TaskbarMenu_OnEvent);
		DKAddEvent("OpenNotepad", "click", TaskbarMenu_OnEvent);
		DKAddEvent("InputTest", "click", TaskbarMenu_OnEvent);
		DKAddEvent("OpenMessage", "click", TaskbarMenu_OnEvent);
		DKAddEvent("OpenTetris", "click", TaskbarMenu_OnEvent);
		DKAddEvent("TaskbarMenu_Run", "keydown", TaskbarMenu_OnEvent);
		DKAddEvent("Git", "click", TaskbarMenu_OnEvent);
		
		DKWidget_SetFocus("TaskbarMenu_Run");
	});
}

//////////////////////////
function TaskbarMenu_End()
{
	DKRemoveEvents(TaskbarMenu_OnEvent);
	DKClose("DKGui/TaskbarMenu.html");
}

///////////////////////////////////
function TaskbarMenu_OnEvent(event)
{
	//DKLog("TaskbarMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event, "FileExplorer")){
		DKCreate("DKFile/DKSolution.js", function(rval){
			if(!rval){ return; }
			DKFrame_Widget("DKFile/DKSolution.html");
			DKFrame_SetTitle("DKFile/DKSolution.html", "File Explorer");
			DKSolution_UpdatePath(DKAssets_LocalAssets());
		});
	}
	if(DK_Id(event, "OpenBuilder")){
		DKCreate("DKBuild/DKBuildGUI.js", function(rval){
			if(!rval){ return; }
			DKFrame_Widget("DKBuild/DKBuildGUI.html");
		});
	}
	if(DK_Id(event, "OpenNotepad")){
		DKCreate("DKFile/DKFileAssociation.js", function(){
			DKFileAssociation_Open("DKNotepad/DKNotepad.js");
		});
	}
	if(DK_Id(event, "InputTest")){
		DKCreate("DKFile/DKFileAssociation.js", function(){
			DKFileAssociation_Open("DKInputTest/DKInput.js");
		});
	}
	if(DK_Id(event, "OpenMessage")){
		DKCreate("DKMessage/DKMessage.js", function(){
			DKFrame_Widget("DKMessage/DKMessage.html");
			//DKMessage("", "ShowMessage", "test message");
		});
	}
	if(DK_Id(event, "OpenTetris")){
		DKFrame_Iframe("Tetris","http://www.lutanho.net/play/tetris.html",440,560);
		/*
		var div = DKWidget_CreateElement("body", "div", "DKIframe.html");
		DKWidget_SetProperty(div, "position", "absolute");
		DKWidget_SetProperty(div, "width", "100%");
		DKWidget_SetProperty(div, "height", "100%");
		var iframe = DKWidget_CreateElement(div, "iframe", "iframe");
		DKWidget_SetAttribute(iframe, "src", "http://www.lutanho.net/play/tetris.html");
		DKWidget_SetAttribute(iframe, "width", "100%");
		DKWidget_SetAttribute(iframe, "height", "100%");
		DKWidget_SetProperty(iframe, "border-width", "0px");
		DKFrame_Widget(div);
		*/
	}
	
	if(DK_Id(event,"Git")){
		DKCreate("DKBuild/GitMenu.js", function(){
			DKMenu_ValidatePosition("DKBuild/GitMenu.html");
			DKWidget_SetProperty("DKBuild/GitMenu.html","top",DKWindow_GetMouseY()-30+"px");
		});
	}
	if(DK_Id(event, "OpenSource")){
		//DKLog("OpenSource\n");
		DKCreate("DKWidgetJS");
		var source = DKWidget_GetOuterHtml("body");
		var assets = DKAssets_LocalAssets();
		DKFile_StringToFile(source, assets+"source.html");
		DKCreate("DKNotepad/DKNotepad.js", function(){
			DKFrame_Widget("DKNotepad/DKNotepad.html");
			DKNotepad_Open(assets+"source.html");
			//DKLog(source+"\n");
		});
	}
	if(DK_Id(event, "OpenDebug")){
		//DKRocket_ToggleDebugger();
		DKCef_ShowDevTools();
	}
	if(DK_Id(event, "PushDKFiles")){
		DKDebug_PushDKFiles();
	}
	if(DK_Id(event, "ClearConsole")){
		DK_System("cls");
	}
	if(DK_Id(event, "Info")){
		DKLog("\n**** DKOBJECTS ****\n");
		var objects = DK_GetObjects();
		var arry = objects.split(",");
		for(var i=0; i<arry.length; i++){
			if(!arry[i]){ continue; }
			DKLog(arry[i]+"\n");
		}
		
		DKLog("**** DKEVENTS ****\n");
		var events = DK_GetEvents();
		var arry = events.split(",");
		for(var i=0; i<arry.length; i++){
			if(!arry[i]){ continue; }
			DKLog(arry[i]+"\n");
		}
	}
	if(DK_Id(event, "Refresh")){
		DKFrame_CloseAll();
		DK_Refresh();
	}
	if(DK_Id(event, "CloseDKGui")){
		DKClose("TaskbarMenu.js")
		DK_Exit();
		return;
	}
	if(DK_Id(event, "TaskbarMenu_Run")){
		var key = DK_GetValue(event);
		//DKLog("TaskbarMenu_Run: key="+key+"\n");
		if(key != 13){ return; }
		TaskbarMenu_Run(DKWidget_GetValue("TaskbarMenu_Run"));
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKGui/TaskbarMenu.html")){
			return;
		}
	}
	DKClose("DKGui/TaskbarMenu.js");
}

/////////////////////////////////
function TaskbarMenu_Run(command)
{
	DKLog("TaskbarMenu_Run("+command+")\n", DKINFO);
	if(command.indexOf("http://") == 0){
		DKFrame_Iframe(command,command,"100%","100%");
		return true;
	}
	if(command.indexOf("https://") == 0){
		DKFrame_Iframe(command,command,"100%","100%");
		return true;
	}
	if(command.indexOf("file://") == 0){
		DKFrame_Iframe(command,command,"100%","100%");
		return true;
	}
	DK_RunJavascript(command);
}