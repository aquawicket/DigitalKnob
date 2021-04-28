///////////////////////////
function DKAdminMenu_init()
{
	dk.create("DKAdmin/DKAdminMenu.html", function(){
		document.addEventListener("mousedown", DKAdminMenu_onevent);
		byId("OpenSource").addEventListener("click", DKAdminMenu_onevent);
		byId("OpenDebug").addEventListener("click", DKAdminMenu_onevent);
		byId("PushDKFiles").addEventListener("click", DKAdminMenu_onevent);
		byId("ClearConsole").addEventListener("click", DKAdminMenu_onevent);
		byId("Info").addEventListener("click", DKAdminMenu_onevent);
		byId("Refresh").addEventListener("click", DKAdminMenu_onevent);
		byId("CloseDKGui").addEventListener("click", DKAdminMenu_onevent);
		byId("FileExplorer").addEventListener("click", DKAdminMenu_onevent);
		byId("OpenStats").addEventListener("click", DKAdminMenu_onevent);
		byId("TestIframe").addEventListener("click", DKAdminMenu_onevent);
		byId("OpenNotepad").addEventListener("click", DKAdminMenu_onevent);
		byId("DKAdminMenu_Run").addEventListener("keydown", DKAdminMenu_onevent);
		byId("Git").addEventListener("click", DKAdminMenu_onevent);

		byId("DKAdminMenu_Run").focus();
	});
	
	dk.create("DKDebug/DKDebug.js", function(){});
	dk.create("DKGui/DKFrame.js", function(){});
	dk.create("DKGui/DKMenu.js", function(){});
}

//////////////////////////
function DKAdminMenu_end()
{
	document.removeEventListener("mousedown", DKAdminMenu_onevent);
	byId("OpenSource").removeEventListener("click", DKAdminMenu_onevent);
	byId("OpenDebug").removeEventListener("click", DKAdminMenu_onevent);
	byId("PushDKFiles").removeEventListener("click", DKAdminMenu_onevent);
	byId("ClearConsole").removeEventListener("click", DKAdminMenu_onevent);
	byId("Info").removeEventListener("click", DKAdminMenu_onevent);
	byId("Refresh").removeEventListener("click", DKAdminMenu_onevent);
	byId("CloseDKGui").removeEventListener("click", DKAdminMenu_onevent);
	byId("FileExplorer").removeEventListener("click", DKAdminMenu_onevent);
	byId("OpenStats").removeEventListener("click", DKAdminMenu_onevent);
	byId("TestIframe").removeEventListener("click", DKAdminMenu_onevent);
	byId("OpenNotepad").removeEventListener("click", DKAdminMenu_onevent);
	byId("DKAdminMenu_Run").removeEventListener("keydown", DKAdminMenu_onevent);
	byId("Git").removeEventListener("click", DKAdminMenu_onevent);
	dk.close("DKAdmin/DKAdminMenu.html");
}

///////////////////////////////////
function DKAdminMenu_OnEvent(event)
{
	console.log("DKAdminMenu_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	
	//selections
	if(event.currentTarget.id === "FileExplorer"){
		dk.create("DKFile/DKSolution.js", function(rval){
			if(!rval){ return; }
			dk.file.create("DKFile/DKSolution.html");
			DKFrame_SetTitle("DKFile/DKSolution.html", "File Explorer");
			DKSolution_UpdatePath(DKAssets_LocalAssets());
		});
	}
	if(event.currentTarget.id === "OpenNotepad"){
		dk.create("DKNotepad/DKNotepad.js", function(){
			dk.file.create("DKNotepad/DKNotepad.html");
		});
	}
	if(event.currentTarget.id === "OpenStats"){
		dk.create("DKStats/DKStats.js", function(){
			dk.file.create("DKStats/DKStats.html");
		});
	}
	if(event.currentTarget.id === "TestIframe"){
		dk.create("DKGui/DKFrame.js", function(){
			DKFrame_Iframe("iframe Test", "https://google.com", 640, 480);
		});
	}

	//bottom row selections
	if(event.currentTarget.id === "Git"){
		dk.create("DKGit/GitMenu.js", function(){
			DKMenu_ValidatePosition("DKGit/GitMenu.html");
			byId("DKGit/GitMenu.html").style.top = DKWindow_GetMouseY()-30+"px";
		});
	}
	if(event.currentTarget.id === "OpenSource"){
		//console.log("OpenSource\n");
		dk.create("DKWidgetJS");
		var source = document.body.outerHTML;
		var assets = DKAssets_LocalAssets();
		dk.file.stringToFile(source, assets+"source.html");
		dk.create("DKNotepad/DKNotepad.js", function(){
			dk.file.create("DKNotepad/DKNotepad.html");
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
		dk.close("DKAdminMenu.js")
		DK_Exit();
		return;
	}
	if(event.currentTarget.id === "DKAdminMenu_Run"){
		if(event.code !== "Enter"){ return; }
		DKAdminMenu_Run(byId("DKAdminMenu_Run").value);
	}
	
	if(event.currentTarget === document){
		if(byId("DKAdmin/DKAdminMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){
			return;
		}
	}
	dk.close("DKAdmin/DKAdminMenu.js");
}

/////////////////////////////////////
function DKAdminMenu_Add(title, code)
{
	//<div title="tooltip" id="FileExplorer" style="position:absolute;top:5rem;left:10rem;">File Explorer</div>
	var ele = DK_CreateElement(byId("DKAdmin/DKAdminMenu.html"), "div", "DKAdminMenu_item");
	ele.innerHTML = title;
}

/////////////////////////////////
function DKAdminMenu_Run(command)
{
	if(command.indexOf("http://") === 0 || command.indexOf("https://") === 0 || command.indexOf("file://") === 0 || command.indexOf("chrome://") === 0){
		dk.create("DKGui/DKFrame.js", function(){
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