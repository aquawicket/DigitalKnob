//TODO - Give this DKTtaskbarMenu the ability start with a blank slate.
// All elements will be added dynamically via DKTaskbarMenu functions.   I.E.  DKTaskbarMenu_AddApp(); 
// Start with a blank DKTaskbarMenu that forms to the number of elements in it.

///////////////////////////
function TaskbarMenu_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKOS/TaskbarMenu.html", function(){
		//DKAddEvent("window", "mousedown", TaskbarMenu_OnEvent);
		window.addEventListener("mousedown", TaskbarMenu_OnEvent);
		//DKAddEvent("OpenSource", "click", TaskbarMenu_OnEvent);
		byId("OpenSource").addEventListener("click", TaskbarMenu_OnEvent);
		//DKAddEvent("OpenDebug", "click", TaskbarMenu_OnEvent);
		byId("OpenDebug").addEventListener("click", TaskbarMenu_OnEvent);
		//DKAddEvent("PushDKFiles", "click", TaskbarMenu_OnEvent);
		byId("PushDKFiles").addEventListener("click", TaskbarMenu_OnEvent);
		//DKAddEvent("ClearConsole", "click", TaskbarMenu_OnEvent);
		byId("ClearConsole").addEventListener("click", TaskbarMenu_OnEvent);
		//DKAddEvent("Info", "click", TaskbarMenu_OnEvent);
		byId("Info").addEventListener("click", TaskbarMenu_OnEvent);
		//DKAddEvent("Reload", "click", TaskbarMenu_OnEvent);
		byId("Reload").addEventListener("click", TaskbarMenu_OnEvent);
		//DKAddEvent("CloseDKGui", "click", TaskbarMenu_OnEvent);
		byId("CloseDKGui").addEventListener("click", TaskbarMenu_OnEvent);
		//DKAddEvent("FileExplorer", "click", TaskbarMenu_OnEvent);
		byId("FileExplorer").addEventListener("click", TaskbarMenu_OnEvent);
		//DKAddEvent("OpenBuilder", "click", TaskbarMenu_OnEvent);
		byId("OpenBuilder").addEventListener("click", TaskbarMenu_OnEvent);
		//DKAddEvent("OpenNotepad", "click", TaskbarMenu_OnEvent);
		byId("OpenNotepad").addEventListener("click", TaskbarMenu_OnEvent);
		//DKAddEvent("InputTest", "click", TaskbarMenu_OnEvent);
		byId("InputTest").addEventListener("click", TaskbarMenu_OnEvent);
		//DKAddEvent("OpenMessage", "click", TaskbarMenu_OnEvent);
		byId("OpenMessage").addEventListener("click", TaskbarMenu_OnEvent);
		//DKAddEvent("OpenTetris", "click", TaskbarMenu_OnEvent);
		byId("OpenTetris").addEventListener("click", TaskbarMenu_OnEvent);
		//DKAddEvent("OpenGoogle", "click", TaskbarMenu_OnEvent);
		byId("OpenGoogle").addEventListener("click", TaskbarMenu_OnEvent);
		//DKAddEvent("TaskbarMenu_Run", "keydown", TaskbarMenu_OnEvent);
		byId("TaskbarMenu_Run").addEventListener("keydown", TaskbarMenu_OnEvent);
		//DKAddEvent("Git", "click", TaskbarMenu_OnEvent);
		byId("Git").addEventListener("click", TaskbarMenu_OnEvent);
		
		DKWidget_SetFocus("TaskbarMenu_Run");
	});
}

//////////////////////////
function TaskbarMenu_End()
{
	DKDEBUGFUNC();
	window.removeEventListener("mousedown", TaskbarMenu_OnEvent);
	//DKRemoveEvents(TaskbarMenu_OnEvent);
	DKClose("DKOS/TaskbarMenu.html");
}

///////////////////////////////////
function TaskbarMenu_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(event.currentTarget.id == "FileExplorer"){
		DKCreate("DKFile/DKSolution.js", function(rval){
			if(!rval){ return; }
			DKFrame_Widget("DKFile/DKSolution.html");
			DKFrame_SetTitle("DKFile/DKSolution.html", "File Explorer");
			DKSolution_UpdatePath(DKAssets_LocalAssets());
		});
	}
	if(event.currentTarget.id == "OpenBuilder"){
		DKCreate("DKBuild/DKBuildGUI.js", function(rval){
			if(!rval){ return; }
			DKFrame_Widget("DKBuild/DKBuildGUI.html");
		});
	}
	if(event.currentTarget.id == "OpenNotepad"){
		DKCreate("DKFile/DKFileAssociation.js", function(){
			DKFileAssociation_Open("DKNotepad/DKNotepad.js");
		});
	}
	if(event.currentTarget.id == "InputTest"){
		DKCreate("DKFile/DKFileAssociation.js", function(){
			DKFileAssociation_Open("DKInputTest/DKInput.js");
		});
	}
	if(event.currentTarget.id == "OpenMessage"){
		DKCreate("DKMessage/DKMessage.js", function(){
			DKFrame_Widget("DKMessage/DKMessage.html");
			//DKMessage("", "ShowMessage", "test message");
		});
	}
	if(event.currentTarget.id == "OpenTetris"){
		DKCreate("DKGui/DKFrame.js", function(){
			DKFrame_Iframe("Tetris","http://www.lutanho.net/play/tetris.html",440,560);
		});
	}
	if(event.currentTarget.id == "OpenGoogle"){
		DKCreate("DKGui/DKFrame.js", function(){
			DKFrame_Iframe("Google","https://google.com",640,480);
		});
	}
	
	if(event.currentTarget.id == "Git"){
		DKCreate("DKGui/DKMenu.js", function(){
		DKCreate("DKGit/GitMenu.js", function(){
			//DKMenu_ValidatePosition("DKGit/GitMenu.html")
			if(!window.mouseX){ window.mouseX = "10", window.mouseY = "10"; }
			byId("DKGit/GitMenu.html").style.left = window.mouseX+"px";
			byId("DKGit/GitMenu.html").style.top = window.mouseY+"px";
		});
		});
	}
	if(event.currentTarget.id == "OpenSource"){
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
	if(event.currentTarget.id == "OpenDebug"){
		if(DK_GetBrowser() == "RML"){
			DKRml_DebuggerOn(); //FIXME
		}
		if(DK_GetBrowser() == "CEF"){
			DKCef_ShowDevTools(0);
		}
	}
	if(event.currentTarget.id == "PushDKFiles"){
		DKDebug_PushDKFiles();
	}
	if(event.currentTarget.id == "ClearConsole"){
		DK_System("cls");
	}
	if(event.currentTarget.id == "Info"){
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
	if(event.currentTarget.id == "Reload"){
		DKFrame_CloseAll();
		DK_Reload();
	}
	if(event.currentTarget.id == "CloseDKGui"){
		DKClose("TaskbarMenu.js")
		DK_Exit();
		return;
	}
	if(event.currentTarget.id == "TaskbarMenu_Run"){
		var key = DK_GetValue(event);
		//DKINFO("DKAdminMenu_Run: key="+key+"\n");
		if(DK_GetBrowser() == "RML"){
			if(key != 72){ return; } //FIXME: why is this key code not 13?
		}
		else{
			if(key != 13){ return; }
		}
		TaskbarMenu_Run(DKWidget_GetValue("TaskbarMenu_Run"));
	}
	
	if(event.currentTarget == window){
		if(byId("DKOS/TaskbarMenu.html").contains(DKWidget_GetHoverElement())){
			return;
		}
	}
	DKClose("DKOS/TaskbarMenu.js");
}

/////////////////////////////////////
function TaskbarMenu_Add(title, code)
{
	DKDEBUGFUNC(title, code);
	//<div title="tooltip" id="FileExplorer" style="position:absolute;top:5rem;left:10rem;">File Explorer</div>
	var ele = DKWidget_CreateElement("DKOS/TaskbarMenu.html", "div", "TaskbarMenu_item");
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