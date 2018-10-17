///////////////////////////
function DKAdminMenu_Init()
{
	DKLog("DKAdminMenu_Init()\n", DKDEBUG);
	
	DKCreate("DKAdmin/DKAdminMenu.html", function(){
		DKAddEvent("GLOBAL", "mousedown", DKAdminMenu_OnEvent);
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
	DKLog("DKAdminMenu_Init()\n", DKDEBUG);
	
	DKRemoveEvents(DKAdminMenu_OnEvent);
	DKClose("DKAdmin/DKAdminMenu.html");
}

///////////////////////////////////
function DKAdminMenu_OnEvent(event)
{
	DKLog("DKAdminMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	
	//selections
	if(DK_Id(event, "FileExplorer")){
		DKCreate("DKFile/DKSolution.js", function(rval){
			if(!rval){ return; }
			DKFrame_Widget("DKFile/DKSolution.html");
			DKFrame_SetTitle("DKFile/DKSolution.html", "File Explorer");
			DKSolution_UpdatePath(DKAssets_LocalAssets());
		});
	}
	if(DK_Id(event, "OpenNotepad")){
		DKCreate("DKNotepad/DKNotepad.js", function(){
			DKFrame_Widget("DKNotepad/DKNotepad.html");
		});
	}
	if(DK_Id(event, "OpenStats")){
		DKCreate("DKStats/DKStats.js", function(){
			DKFrame_Widget("DKStats/DKStats.html");
		});
	}
	if(DK_Id(event, "TestIframe")){
		DKCreate("DKGui/DKFrame.js", function(){
			DKFrame_Iframe("iframe Test", "https://google.com", 640, 480);
		});
	}

	//bottom row selections
	if(DK_Id(event,"Git")){
		DKCreate("DKGit/GitMenu.js", function(){
			DKMenu_ValidatePosition("DKGit/GitMenu.html");
			DKWidget_SetProperty("DKGit/GitMenu.html","top",DKWindow_GetMouseY()-30+"px");
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
		DKCef_ShowDevTools(0);
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
		DKClose("DKAdminMenu.js")
		DK_Exit();
		return;
	}
	if(DK_Id(event, "DKAdminMenu_Run")){
		var key = DK_GetValue(event);
		//DKLog("DKAdminMenu_Run: key="+key+"\n");
		if(DK_GetBrowser() == "Rocket"){
			if(key != 72){ return; } //FIXME: why is this key code not 13?
		}
		else{
			if(key != 13){ return; }
		}
		DKAdminMenu_Run(DKWidget_GetValue("DKAdminMenu_Run"));
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKAdmin/DKAdminMenu.html")){
			return;
		}
	}
	DKClose("DKAdmin/DKAdminMenu.js");
}

/////////////////////////////////////
function DKAdminMenu_Add(title, code)
{
	DKLog("DKAdminMenu_Add("+title+", "+code+")\n", DKDEBUG);
	
	//<div title="tooltip" id="FileExplorer" style="position:absolute;top:5rem;left:10rem;">File Explorer</div>
	var ele = DKWidget_CreateElement("DKAdmin/DKAdminMenu.html", "div", "DKAdminMenu_item");
	DKWidget_SetInnerHtml(ele, title);
}

/////////////////////////////////
function DKAdminMenu_Run(command)
{
	DKLog("DKAdminMenu_Run("+command+")\n", DKDEBUG);
	if(command.indexOf("http://") == 0 || command.indexOf("https://") == 0 || command.indexOf("file://") == 0){
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