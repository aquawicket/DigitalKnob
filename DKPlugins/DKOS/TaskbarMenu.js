//TODO - Give this DKTtaskbarMenu the ability start with a blank slate.
// All elements will be added dynamically via DKTaskbarMenu functions.   I.E.  DKTaskbarMenu_AddApp(); 
// Start with a blank DKTaskbarMenu that forms to the number of elements in it.

///////////////////////////
function TaskbarMenu_Init()
{
	DK_Create("DKOS/TaskbarMenu.html", function(){
		document.addEventListener("mousedown", TaskbarMenu_OnEvent);
		byId("OpenSource").addEventListener("click", TaskbarMenu_OnEvent);
		byId("OpenDebug").addEventListener("click", TaskbarMenu_OnEvent);
		byId("PushDKFiles").addEventListener("click", TaskbarMenu_OnEvent);
		byId("ClearConsole").addEventListener("click", TaskbarMenu_OnEvent);
		byId("Info").addEventListener("click", TaskbarMenu_OnEvent);
		byId("Reload").addEventListener("click", TaskbarMenu_OnEvent);
		byId("CloseDKGui").addEventListener("click", TaskbarMenu_OnEvent);
		byId("FileExplorer").addEventListener("click", TaskbarMenu_OnEvent);
		byId("OpenBuilder").addEventListener("click", TaskbarMenu_OnEvent);
		byId("OpenNotepad").addEventListener("click", TaskbarMenu_OnEvent);
		byId("InputTest").addEventListener("click", TaskbarMenu_OnEvent);
		byId("OpenMessage").addEventListener("click", TaskbarMenu_OnEvent);
		byId("OpenTetris").addEventListener("click", TaskbarMenu_OnEvent);
		byId("OpenGoogle").addEventListener("click", TaskbarMenu_OnEvent);
		byId("TaskbarMenu_Run").addEventListener("keydown", TaskbarMenu_OnEvent);
		byId("Git").addEventListener("click", TaskbarMenu_OnEvent);
		byId("TaskbarMenu_Run").focus();
	});
}

//////////////////////////
function TaskbarMenu_End()
{
	document.removeEventListener("mousedown", TaskbarMenu_OnEvent);
	byId("OpenSource").removeEventListener("click", TaskbarMenu_OnEvent);
	byId("OpenDebug").removeEventListener("click", TaskbarMenu_OnEvent);
	byId("PushDKFiles").removeEventListener("click", TaskbarMenu_OnEvent);
	byId("ClearConsole").removeEventListener("click", TaskbarMenu_OnEvent);
	byId("Info").removeEventListener("click", TaskbarMenu_OnEvent);
	byId("Reload").removeEventListener("click", TaskbarMenu_OnEvent);
	byId("CloseDKGui").removeEventListener("click", TaskbarMenu_OnEvent);
	byId("FileExplorer").removeEventListener("click", TaskbarMenu_OnEvent);
	byId("OpenBuilder").removeEventListener("click", TaskbarMenu_OnEvent);
	byId("OpenNotepad").removeEventListener("click", TaskbarMenu_OnEvent);
	byId("InputTest").removeEventListener("click", TaskbarMenu_OnEvent);
	byId("OpenMessage").removeEventListener("click", TaskbarMenu_OnEvent);
	byId("OpenTetris").removeEventListener("click", TaskbarMenu_OnEvent);
	byId("OpenGoogle").removeEventListener("click", TaskbarMenu_OnEvent);
	byId("TaskbarMenu_Run").removeEventListener("keydown", TaskbarMenu_OnEvent);
	byId("Git").removeEventListener("click", TaskbarMenu_OnEvent);
	DK_Close("DKOS/TaskbarMenu.html");
}

///////////////////////////////////
function TaskbarMenu_OnEvent(event)
{
	if(event.currentTarget.id === "FileExplorer"){
		DK_Create("DKFile/DKSolution.js", function(rval){
			if(!rval){ return; }
			DKFrame_Html("DKFile/DKSolution.html");
			DKFrame_SetTitle("DKFile/DKSolution.html", "File Explorer");
			DKSolution_UpdatePath(DKAssets_LocalAssets());
		});
	}
	if(event.currentTarget.id === "OpenBuilder"){
		DK_Create("DKBuild/DKBuildGUI.js", function(rval){
			if(!rval){ return; }
			DKFrame_Html("DKBuild/DKBuildGUI.html");
		});
	}
	if(event.currentTarget.id === "OpenNotepad"){
		DK_Create("DKFile/DKFileAssociation.js", function(){
			DKFileAssociation_Open("DKNotepad/DKNotepad.js");
		});
	}
	if(event.currentTarget.id === "InputTest"){
		DK_Create("DKFile/DKFileAssociation.js", function(){
			DKFileAssociation_Open("DKInputTest/DKInput.js");
		});
	}
	if(event.currentTarget.id === "OpenMessage"){
		DK_Create("DKGui/DKMessageBox.js", function(){
			DKFrame_Html("DKGui/DKMessageBox.html");
			DKMessageBox_Message("Test DKGui/DKMussageBox");
		});
	}
	if(event.currentTarget.id === "OpenTetris"){
		DK_Create("DKGui/DKFrame.js", function(){
			DKFrame_Iframe("Tetris","http://www.lutanho.net/play/tetris.html",440,560);
		});
	}
	if(event.currentTarget.id === "OpenGoogle"){
		DK_Create("DKGui/DKFrame.js", function(){
			DKFrame_Iframe("Google","https://google.com",640,480);
		});
	}
	
	if(event.currentTarget.id === "Git"){
		DK_Create("DKGui/DKMenu.js", function(){
		DK_Create("DKGit/GitMenu.js", function(){
			//DKMenu_ValidatePosition("DKGit/GitMenu.html")
			if(!window.mouseX){ window.mouseX = "10", window.mouseY = "10"; }
			byId("DKGit/GitMenu.html").style.left = window.mouseX+"px";
			byId("DKGit/GitMenu.html").style.top = window.mouseY+"px";
		});
		});
	}
	if(event.currentTarget.id === "OpenSource"){
		//console.log("OpenSource\n");
		DK_Create("DKWidgetJS");
		//var source = DKWidget_GetOuterHtml("body");
		var source = document.body.outerHTML;
		var assets = DKAssets_LocalAssets();
		DKFile_StringToFile(source, assets+"source.html");
		DK_Create("DKNotepad/DKNotepad.js", function(){
			DKFrame_Html("DKNotepad/DKNotepad.html");
			DKNotepad_Open(assets+"source.html");
			//console.log(source+"\n");
		});
	}
	if(event.currentTarget.id === "OpenDebug"){
		if(DK_GetBrowser() === "RML"){
			DKRml_DebuggerOn(); //FIXME
		}
		if(DK_GetBrowser() === "CEF"){
			DKCef_ShowDevTools(0);
		}
	}
	if(event.currentTarget.id === "PushDKFiles"){
		DKDebug_PushDKFiles();
	}
	if(event.currentTarget.id === "ClearConsole"){
		console.clear();
	}
	if(event.currentTarget.id === "Info"){
		console.log("\n**** DKOBJECTS ****\n");
		var objects = DK_GetObjects();
		var arry = objects.split(",");
		for(var i=0; i<arry.length; i++){
			if(!arry[i]){ continue; }
			console.log(arry[i]+"\n");
		}
		console.log("\n");
		
		console.log("**** DKEVENTS ****\n");
		var events = DK_GetEvents();
		var arry = events.split(",");
		for(var i=0; i<arry.length; i++){
			if(!arry[i]){ continue; }
			console.log(arry[i]+"\n");
		}
		console.log("\n");
		
		console.log("**** DKFUNCTIONS ****\n");
		var events = DK_GetFunctions();
		var arry = events.split(",");
		for(var i=0; i<arry.length; i++){
			if(!arry[i]){ continue; }
			console.log(arry[i]+"\n");
		}
		console.log("\n");
	}
	if(event.currentTarget.id === "Reload"){
		DKFrame_CloseAll();
		//CPP_DKDuktape_Reload();
		location.reload();
	}
	if(event.currentTarget.id === "CloseDKGui"){
		DK_Close("TaskbarMenu.js")
		CPP_DKDuktape_Exit();
		return;
	}
	if(event.currentTarget.id === "TaskbarMenu_Run"){
		var key = DK_GetValue(event);
		//console.log("DKAdminMenu_Run: key="+key+"\n");
		if(DK_GetBrowser() === "RML"){
			if(key !== 72){ return; } //FIXME: why is this key code not 13?
		}
		else{
			if(key !== 13){ return; }
		}
		TaskbarMenu_Run(DKWidget_GetValue("TaskbarMenu_Run"));
	}
	
	if(event.currentTarget === document){
		if(byId("DKOS/TaskbarMenu.html").contains(DKWidget_GetHoverElement())){
			return;
		}
	}
	DK_Close("DKOS/TaskbarMenu.js");
}

/////////////////////////////////////
function TaskbarMenu_Add(title, code)
{
	//<div title="tooltip" id="FileExplorer" style="position:absolute;top:5rem;left:10rem;">File Explorer</div>
	var ele = DKWidget_CreateElement(byId("DKOS/TaskbarMenu.html"), "div", "TaskbarMenu_item");
	byId(ele).innerHTML = title;
}

/////////////////////////////////
function TaskbarMenu_Run(command)
{
	if(command.indexOf("http://") === 0){
		DKFrame_Iframe(command,command,"100%","100%");
		return true;
	}
	if(command.indexOf("https://") === 0){
		DKFrame_Iframe(command,command,"100%","100%");
		return true;
	}
	if(command.indexOf("file://") === 0){
		DKFrame_Iframe(command,command,"100%","100%");
		return true;
	}
	DK_RunDuktape(command);
}