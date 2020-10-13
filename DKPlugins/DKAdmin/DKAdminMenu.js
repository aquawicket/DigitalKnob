///////////////////////////
function DKAdminMenu_Init()
{
	DK_Create("DKAdmin/DKAdminMenu.html", function(){
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

		byId("DKAdminMenu_Run").focus();
	});
	
	DK_Create("DKDebug/DKDebug.js", function(){});
	DK_Create("DKGui/DKFrame.js", function(){});
	DK_Create("DKGui/DKMenu.js", function(){});
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
	DK_Close("DKAdmin/DKAdminMenu.html");
}

///////////////////////////////////
function DKAdminMenu_OnEvent(event)
{
	console.log("DKAdminMenu_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	
	//selections
	if(event.currentTarget.id === "FileExplorer"){
		DK_Create("DKFile/DKSolution.js", function(rval){
			if(!rval){ return; }
			DKFrame_Html("DKFile/DKSolution.html");
			DKFrame_SetTitle("DKFile/DKSolution.html", "File Explorer");
			DKSolution_UpdatePath(DKAssets_LocalAssets());
		});
	}
	if(event.currentTarget.id === "OpenNotepad"){
		DK_Create("DKNotepad/DKNotepad.js", function(){
			DKFrame_Html("DKNotepad/DKNotepad.html");
		});
	}
	if(event.currentTarget.id === "OpenStats"){
		DK_Create("DKStats/DKStats.js", function(){
			DKFrame_Html("DKStats/DKStats.html");
		});
	}
	if(event.currentTarget.id === "TestIframe"){
		DK_Create("DKGui/DKFrame.js", function(){
			DKFrame_Iframe("iframe Test", "https://google.com", 640, 480);
		});
	}

	//bottom row selections
	if(event.currentTarget.id === "Git"){
		DK_Create("DKGit/GitMenu.js", function(){
			DKMenu_ValidatePosition("DKGit/GitMenu.html");
			byId("DKGit/GitMenu.html").style.top = DKWindow_GetMouseY()-30+"px";
		});
	}
	if(event.currentTarget.id === "OpenSource"){
		//console.log("OpenSource\n");
		DK_Create("DKWidgetJS");
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
		console.log("\n**** DKOBJECTS ****\n");
		var objects = DK_GetObjects();
		var arry = objects.split(",");
		for(var i=0; i<arry.length; i++){
			if(!arry[i]){ continue; }
			console.log(arry[i]+"\n");
		}
		
		console.log("**** DKEVENTS ****\n");
		var events = DK_GetEvents();
		var arry = events.split(",");
		for(var i=0; i<arry.length; i++){
			if(!arry[i]){ continue; }
			console.log(arry[i]+"\n");
		}
	}
	if(event.currentTarget.id === "Refresh"){
		DKFrame_CloseAll();
		window.location.reload(true);
	}
	if(event.currentTarget.id === "CloseDKGui"){
		DK_Close("DKAdminMenu.js")
		DK_Exit();
		return;
	}
	if(event.currentTarget.id === "DKAdminMenu_Run"){
		var key = DK_GetValue(event);
		//console.log("DKAdminMenu_Run: key="+key+"\n");
		if(DK_GetBrowser() === "RML"){
			if(key !== 72){ return; } //FIXME: why is this key code not 13?
		}
		else{
			if(key !== 13){ return; }
		}
		DKAdminMenu_Run(DKWidget_GetValue("DKAdminMenu_Run"));
	}
	
	if(event.currentTarget === window){
		if(byId("DKAdmin/DKAdminMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){
			return;
		}
	}
	DK_Close("DKAdmin/DKAdminMenu.js");
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
		DK_Create("DKGui/DKFrame.js", function(){
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