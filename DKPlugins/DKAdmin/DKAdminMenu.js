///////////////////////////
function DKAdminMenu_Init()
{
	DKCreate("DKAdmin/DKAdminMenu.html", function(){
		window.addEventListener("mousedown", DKAdminMenu_OnEvent);
		byId("OpenSource").addEventListener("click", DKAdminMenu_OnEvent);
		byId("OpenDebug").addEventListener("click", DKAdminMenu_OnEvent);
		byId("PushDKFiles").addEventListener("click", DKAdminMenu_OnEvent);
		byId("ClearConsole").addEventListener("click", DKAdminMenu_OnEvent);
		byId("Info").addEventListener("click", DKAdminMenu_OnEvent);
		byId("Refresh").addEventListener("click", DKAdminMenu_OnEvent);
		byId("CloseDKGui").addEventListener("click", DKAdminMenu_OnEvent);
		byId("FileExplorer").addEventListener("click", DKAdminMenu_OnEvent);
		byId("OpenStats").addEventListener("click", DKAdminMenu_OnEvent);
		byId("TestIframe").addEventListener("click", DKAdminMenu_OnEvent);
		byId("OpenNotepad").addEventListener("click", DKAdminMenu_OnEvent);
		byId("DKAdminMenu_Run").addEventListener("keydown", DKAdminMenu_OnEvent);
		byId("Git").addEventListener("click", DKAdminMenu_OnEvent);

		DKWidget_SetFocus("DKAdminMenu_Run");
	});
	
	DKCreate("DKDebug/DKDebug.js", function(){});
	DKCreate("DKGui/DKFrame.js", function(){});
	DKCreate("DKGui/DKMenu.js", function(){});
}

//////////////////////////
function DKAdminMenu_End()
{
	window.removeEventListener("mousedown", DKAdminMenu_OnEvent);
	byId("OpenSource").removeEventListener("click", DKAdminMenu_OnEvent);
	byId("OpenDebug").removeEventListener("click", DKAdminMenu_OnEvent);
	byId("PushDKFiles").removeEventListener("click", DKAdminMenu_OnEvent);
	byId("ClearConsole").removeEventListener("click", DKAdminMenu_OnEvent);
	byId("Info").removeEventListener("click", DKAdminMenu_OnEvent);
	byId("Refresh").removeEventListener("click", DKAdminMenu_OnEvent);
	byId("CloseDKGui").removeEventListener("click", DKAdminMenu_OnEvent);
	byId("FileExplorer").removeEventListener("click", DKAdminMenu_OnEvent);
	byId("OpenStats").removeEventListener("click", DKAdminMenu_OnEvent);
	byId("TestIframe").removeEventListener("click", DKAdminMenu_OnEvent);
	byId("OpenNotepad").removeEventListener("click", DKAdminMenu_OnEvent);
	byId("DKAdminMenu_Run").removeEventListener("keydown", DKAdminMenu_OnEvent);
	byId("Git").removeEventListener("click", DKAdminMenu_OnEvent);
	DKClose("DKAdmin/DKAdminMenu.html");
}

///////////////////////////////////
function DKAdminMenu_OnEvent(event)
{
	console.log("DKAdminMenu_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	
	//selections
	if(event.currentTarget.id === "FileExplorer"){
		DKCreate("DKFile/DKSolution.js", function(rval){
			if(!rval){ return; }
			DKFrame_Widget("DKFile/DKSolution.html");
			DKFrame_SetTitle("DKFile/DKSolution.html", "File Explorer");
			DKSolution_UpdatePath(DKAssets_LocalAssets());
		});
	}
	if(event.currentTarget.id === "OpenNotepad"){
		DKCreate("DKNotepad/DKNotepad.js", function(){
			DKFrame_Widget("DKNotepad/DKNotepad.html");
		});
	}
	if(event.currentTarget.id === "OpenStats"){
		DKCreate("DKStats/DKStats.js", function(){
			DKFrame_Widget("DKStats/DKStats.html");
		});
	}
	if(event.currentTarget.id === "TestIframe"){
		DKCreate("DKGui/DKFrame.js", function(){
			DKFrame_Iframe("iframe Test", "https://google.com", 640, 480);
		});
	}

	//bottom row selections
	if(event.currentTarget.id === "Git"){
		DKCreate("DKGit/GitMenu.js", function(){
			DKMenu_ValidatePosition("DKGit/GitMenu.html");
			document.getElementById("DKGit/GitMenu.html").style.top = DKWindow_GetMouseY()-30+"px";
		});
	}
	if(event.currentTarget.id === "OpenSource"){
		//console.lof("OpenSource\n");
		DKCreate("DKWidgetJS");
		var source = DKWidget_GetOuterHtml("body");
		var assets = DKAssets_LocalAssets();
		DKFile_StringToFile(source, assets+"source.html");
		DKCreate("DKNotepad/DKNotepad.js", function(){
			DKFrame_Widget("DKNotepad/DKNotepad.html");
			DKNotepad_Open(assets+"source.html");
			//console.lof(source+"\n");
		});
	}
	if(event.currentTarget.id === "OpenDebug"){
		//DKRocket_ToggleDebugger();
		DKCef_ShowDevTools(0);
	}
	if(event.currentTarget.id === "PushDKFiles"){
		DKDebug_PushDKFiles();
	}
	if(event.currentTarget.id === "ClearConsole"){
		DK_System("cls");
	}
	if(event.currentTarget.id === "Info"){
		console.lof("\n**** DKOBJECTS ****\n");
		var objects = DK_GetObjects();
		var arry = objects.split(",");
		for(var i=0; i<arry.length; i++){
			if(!arry[i]){ continue; }
			console.lof(arry[i]+"\n");
		}
		
		console.lof("**** DKEVENTS ****\n");
		var events = DK_GetEvents();
		var arry = events.split(",");
		for(var i=0; i<arry.length; i++){
			if(!arry[i]){ continue; }
			console.lof(arry[i]+"\n");
		}
	}
	if(event.currentTarget.id === "Refresh"){
		DKFrame_CloseAll();
		DK_Refresh();
	}
	if(event.currentTarget.id === "CloseDKGui"){
		DKClose("DKAdminMenu.js")
		DK_Exit();
		return;
	}
	if(event.currentTarget.id === "DKAdminMenu_Run"){
		var key = DK_GetValue(event);
		//console.lof("DKAdminMenu_Run: key="+key+"\n");
		if(DK_GetBrowser() === "RML"){
			if(key != 72){ return; } //FIXME: why is this key code not 13?
		}
		else{
			if(key != 13){ return; }
		}
		DKAdminMenu_Run(DKWidget_GetValue("DKAdminMenu_Run"));
	}
	
	if(event.currentTarget === window){
		if(byId("DKAdmin/DKAdminMenu.html").contains(DKWidget_GetHoverElement())){
			return;
		}
	}
	DKClose("DKAdmin/DKAdminMenu.js");
}

/////////////////////////////////////
function DKAdminMenu_Add(title, code)
{
	//<div title="tooltip" id="FileExplorer" style="position:absolute;top:5rem;left:10rem;">File Explorer</div>
	var ele = DKWidget_CreateElement(byId("DKAdmin/DKAdminMenu.html"), "div", "DKAdminMenu_item");
	byId(ele).innerHTML = title;
}

/////////////////////////////////
function DKAdminMenu_Run(command)
{
	if(command.indexOf("http://") === 0 || command.indexOf("https://") === 0 || command.indexOf("file://") === 0 || command.indexOf("chrome://") === 0){
		DKCreate("DKGui/DKFrame.js", function(){
			DKFrame_Iframe(command, command, 640, 480);
		});
		return;
	}
	
	if(DK_GetBrowser() === "RML"){
		DK_RunDuktape(command);
	}
	else{
		DKCef_RunJavascript(0,command);
	}
}