///////////////////////////
function DKAdminMenu_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKAdmin/DKAdminMenu.html", function(){
		DKAddEvent("window", "mousedown", DKAdminMenu_OnEvent);
		DKAddEvent("OpenSource", "click", DKAdminMenu_OnEvent);
		DKAddEvent("OpenDebug", "click", DKAdminMenu_OnEvent);
		DKAddEvent("PushDKFiles", "click", DKAdminMenu_OnEvent);
		DKAddEvent("ClearConsole", "click", DKAdminMenu_OnEvent);
		DKAddEvent("Info", "click", DKAdminMenu_OnEvent);
		DKAddEvent("Refresh", "click", DKAdminMenu_OnEvent);
		DKAddEvent("CloseDKGui", "click", DKAdminMenu_OnEvent);
		DKAddEvent("FileExplorer", "click", DKAdminMenu_OnEvent);
		DKAddEvent("OpenStats", "click", DKAdminMenu_OnEvent);
		DKAddEvent("TestIframe", "click", DKAdminMenu_OnEvent);
		DKAddEvent("OpenNotepad", "click", DKAdminMenu_OnEvent);
		DKAddEvent("DKAdminMenu_Run", "keydown", DKAdminMenu_OnEvent);
		DKAddEvent("Git", "click", DKAdminMenu_OnEvent);
		
		DKWidget_SetFocus("DKAdminMenu_Run");
	});
	
	DKCreate("DKDebug/DKDebug.js", function(){});
	DKCreate("DKGui/DKFrame.js", function(){});
	DKCreate("DKGui/DKMenu.js", function(){});
}

//////////////////////////
function DKAdminMenu_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKAdminMenu_OnEvent);
	DKClose("DKAdmin/DKAdminMenu.html");
}

///////////////////////////////////
function DKAdminMenu_OnEvent(event)
{
	DKDEBUGFUNC(event);
	DKINFO("DKAdminMenu_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	
	//selections
	if(event.currentTarget.id == "FileExplorer"){
		DKCreate("DKFile/DKSolution.js", function(rval){
			if(!rval){ return; }
			DKFrame_Widget("DKFile/DKSolution.html");
			DKFrame_SetTitle("DKFile/DKSolution.html", "File Explorer");
			DKSolution_UpdatePath(DKAssets_LocalAssets());
		});
	}
	if(event.currentTarget.id == "OpenNotepad"){
		DKCreate("DKNotepad/DKNotepad.js", function(){
			DKFrame_Widget("DKNotepad/DKNotepad.html");
		});
	}
	if(event.currentTarget.id == "OpenStats"){
		DKCreate("DKStats/DKStats.js", function(){
			DKFrame_Widget("DKStats/DKStats.html");
		});
	}
	if(event.currentTarget.id == "TestIframe"){
		DKCreate("DKGui/DKFrame.js", function(){
			DKFrame_Iframe("iframe Test", "https://google.com", 640, 480);
		});
	}

	//bottom row selections
	if(event.currentTarget.id == "Git"){
		DKCreate("DKGit/GitMenu.js", function(){
			DKMenu_ValidatePosition("DKGit/GitMenu.html");
			document.getElementById("DKGit/GitMenu.html").style.top = DKWindow_GetMouseY()-30+"px";
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
		//DKRocket_ToggleDebugger();
		DKCef_ShowDevTools(0);
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
		
		DKINFO("**** DKEVENTS ****\n");
		var events = DK_GetEvents();
		var arry = events.split(",");
		for(var i=0; i<arry.length; i++){
			if(!arry[i]){ continue; }
			DKINFO(arry[i]+"\n");
		}
	}
	if(event.currentTarget.id == "Refresh"){
		DKFrame_CloseAll();
		DK_Refresh();
	}
	if(event.currentTarget.id == "CloseDKGui"){
		DKClose("DKAdminMenu.js")
		DK_Exit();
		return;
	}
	if(event.currentTarget.id == "DKAdminMenu_Run"){
		var key = DK_GetValue(event);
		//DKINFO("DKAdminMenu_Run: key="+key+"\n");
		if(DK_GetBrowser() == "Rocket"){
			if(key != 72){ return; } //FIXME: why is this key code not 13?
		}
		else{
			if(key != 13){ return; }
		}
		DKAdminMenu_Run(DKWidget_GetValue("DKAdminMenu_Run"));
	}
	
	if(event.currentTarget == window){
		if(byId("DKAdmin/DKAdminMenu.html").contains()){
			return;
		}
	}
	DKClose("DKAdmin/DKAdminMenu.js");
}

/////////////////////////////////////
function DKAdminMenu_Add(title, code)
{
	DKDEBUGFUNC(title, code);
	//<div title="tooltip" id="FileExplorer" style="position:absolute;top:5rem;left:10rem;">File Explorer</div>
	var ele = DKWidget_CreateElement("DKAdmin/DKAdminMenu.html", "div", "DKAdminMenu_item");
	DKWidget_SetInnerHtml(ele, title);
}

/////////////////////////////////
function DKAdminMenu_Run(command)
{
	DKDEBUGFUNC(command);
	if(command.indexOf("http://") == 0 || command.indexOf("https://") == 0 || command.indexOf("file://") == 0 || command.indexOf("chrome://") == 0){
		DKCreate("DKGui/DKFrame.js", function(){
			DKFrame_Iframe(command, command, 640, 480);
		});
		return;
	}
	
	if(DK_GetBrowser() == "Rocket"){
		DK_RunDuktape(command);
	}
	else{
		DKCef_RunJavascript(0,command);
	}
}