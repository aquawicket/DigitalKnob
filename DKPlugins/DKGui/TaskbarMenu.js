//TODO - Give this DKTtaskbarMenu the ability start with a blank slate.
// All elements will be added dynamically via DKTaskbarMenu functions.   I.E.  DKTaskbarMenu_AddApp(); 
// Start with a blank DKTaskbarMenu that forms to the number of elements in it.

///////////////////////////
function TaskbarMenu_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKGui/TaskbarMenu.html", function(){
		DKAddEvent("GLOBAL", "mousedown", TaskbarMenu_OnEvent);
		DKAddEvent("OpenSource", "click", TaskbarMenu_OnEvent);
		DKAddEvent("OpenDebug", "click", TaskbarMenu_OnEvent);
		DKAddEvent("PushDKFiles", "click", TaskbarMenu_OnEvent);
		DKAddEvent("ClearConsole", "click", TaskbarMenu_OnEvent);
		DKAddEvent("Info", "click", TaskbarMenu_OnEvent);
		DKAddEvent("Reload", "click", TaskbarMenu_OnEvent);
		DKAddEvent("CloseDKGui", "click", TaskbarMenu_OnEvent);
		DKAddEvent("FileExplorer", "click", TaskbarMenu_OnEvent);
		DKAddEvent("OpenBuilder", "click", TaskbarMenu_OnEvent);
		DKAddEvent("OpenNotepad", "click", TaskbarMenu_OnEvent);
		DKAddEvent("InputTest", "click", TaskbarMenu_OnEvent);
		DKAddEvent("OpenMessage", "click", TaskbarMenu_OnEvent);
		DKAddEvent("OpenTetris", "click", TaskbarMenu_OnEvent);
		DKAddEvent("OpenGoogle", "click", TaskbarMenu_OnEvent);
		DKAddEvent("TaskbarMenu_Run", "keydown", TaskbarMenu_OnEvent);
		DKAddEvent("Git", "click", TaskbarMenu_OnEvent);
		
		DKWidget_SetFocus("TaskbarMenu_Run");
	});
}

//////////////////////////
function TaskbarMenu_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(TaskbarMenu_OnEvent);
	DKClose("DKGui/TaskbarMenu.html");
}

///////////////////////////////////
function TaskbarMenu_OnEvent(event)
{
	DKDEBUGFUNC(event);
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
		DKCreate("DKGui/DKFrame.js", function(){
			DKFrame_Iframe("Tetris","http://www.lutanho.net/play/tetris.html",440,560);
		});
	}
	if(DK_Id(event, "OpenGoogle")){
		DKCreate("DKGui/DKFrame.js", function(){
			DKFrame_Iframe("Google","https://google.com",640,480);
		});
	}
	
	if(DK_Id(event,"Git")){
		DKCreate("DKGit/GitMenu.js", function(){
			DKMenu_ValidatePosition("DKGit/GitMenu.html");
			DKWidget_SetProperty("DKGit/GitMenu.html","top",DKWindow_GetMouseY()-30+"px");
		});
	}
	if(DK_Id(event, "OpenSource")){
		//DKINFO("OpenSource\n");
		DKCreate("DKWidgetJS");
		var source = DKWidget_GetOuterHtml("body");
		var assets = DKAssets_LocalAssets();
		DKFile_StringToFile(source, assets+"source.html");
		DKCreate("DKNotepad/DKNotepad.js", function(){
			DKFrame_Widget("DKNotepad/DKNotepad.html");
			DKNotepad_Open(assets+"source.html");
			//DKINFO(source+"\n");
		});
	}
	if(DK_Id(event, "OpenDebug")){
		if(DK_GetBrowser() == "Rocket"){
			DKRocket_ToggleDebugger();
		}
		if(DK_GetBrowser() == "CEF"){
			DKCef_ShowDevTools(0);
		}
	}
	if(DK_Id(event, "PushDKFiles")){
		DKDebug_PushDKFiles();
	}
	if(DK_Id(event, "ClearConsole")){
		DK_System("cls");
	}
	if(DK_Id(event, "Info")){
		DKINFO("\n**** DKOBJECTS ****\n");
		var objects = DK_GetObjects();
		var arry = objects.split(",");
		for(var i=0; i<arry.length; i++){
			if(!arry[i]){ continue; }
			DKINFO(arry[i]+"\n");
		}
		DKINFO("\n");
		
		DKINFO("**** DKEVENTS ****\n");
		var events = DK_GetEvents();
		var arry = events.split(",");
		for(var i=0; i<arry.length; i++){
			if(!arry[i]){ continue; }
			DKINFO(arry[i]+"\n");
		}
		DKINFO("\n");
		
		DKINFO("**** DKFUNCTIONS ****\n");
		var events = DK_GetFunctions();
		var arry = events.split(",");
		for(var i=0; i<arry.length; i++){
			if(!arry[i]){ continue; }
			DKINFO(arry[i]+"\n");
		}
		DKINFO("\n");
	}
	if(DK_Id(event, "Reload")){
		DKFrame_CloseAll();
		DK_Reload();
	}
	if(DK_Id(event, "CloseDKGui")){
		DKClose("TaskbarMenu.js")
		DK_Exit();
		return;
	}
	if(DK_Id(event, "TaskbarMenu_Run")){
		var key = DK_GetValue(event);
		//DKINFO("DKAdminMenu_Run: key="+key+"\n");
		if(DK_GetBrowser() == "Rocket"){
			if(key != 72){ return; } //FIXME: why is this key code not 13?
		}
		else{
			if(key != 13){ return; }
		}
		TaskbarMenu_Run(DKWidget_GetValue("TaskbarMenu_Run"));
	}
	
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKGui/TaskbarMenu.html")){
			return;
		}
	}
	DKClose("DKGui/TaskbarMenu.js");
}

/////////////////////////////////////
function TaskbarMenu_Add(title, code)
{
	DKDEBUGFUNC(title, code);
	//<div title="tooltip" id="FileExplorer" style="position:absolute;top:5rem;left:10rem;">File Explorer</div>
	var ele = DKWidget_CreateElement("DKGui/TaskbarMenu.html", "div", "TaskbarMenu_item");
	DKWidget_SetInnerHtml(ele, title);
}

/////////////////////////////////
function TaskbarMenu_Run(command)
{
	DKDEBUGFUNC(command);
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
	DK_RunDuktape(command);
}