///////////////////////////
function TaskbarMenu_Init()
{
	DKCreate("DKOS/TaskbarMenu.html,DKOS/DKOS.html", function(){
	DKAddEvent("GLOBAL", "mousedown", TaskbarMenu_OnEvent);
	DKAddEvent("OpenSource", "click", TaskbarMenu_OnEvent);
	DKAddEvent("OpenDebug", "click", TaskbarMenu_OnEvent);
	DKAddEvent("PushDKFiles", "click", TaskbarMenu_OnEvent);
	DKAddEvent("ClearConsole", "click", TaskbarMenu_OnEvent);
	DKAddEvent("Info", "click", TaskbarMenu_OnEvent);
	DKAddEvent("Reload", "click", TaskbarMenu_OnEvent);
	DKAddEvent("CloseDKOS", "click", TaskbarMenu_OnEvent);
	DKAddEvent("FileExplorer", "click", TaskbarMenu_OnEvent);
	DKAddEvent("OpenConsole", "click", TaskbarMenu_OnEvent);
	DKAddEvent("OpenBuilder", "click", TaskbarMenu_OnEvent);
	DKAddEvent("OpenDev", "click", TaskbarMenu_OnEvent);
	DKAddEvent("OpenNotepad", "click", TaskbarMenu_OnEvent);
	DKAddEvent("InputTest", "click", TaskbarMenu_OnEvent);
	DKAddEvent("OpenBrowser", "click", TaskbarMenu_OnEvent);
	DKAddEvent("OpenMessage", "click", TaskbarMenu_OnEvent);
	DKAddEvent("OpenTetris", "click", TaskbarMenu_OnEvent);
	DKAddEvent("OpenSuperball", "click", TaskbarMenu_OnEvent);
	DKAddEvent("TestSound", "click", TaskbarMenu_OnEvent);
	DKAddEvent("TestVideo", "click", TaskbarMenu_OnEvent);
	DKAddEvent("TaskbarMenu_Run", "keydown", TaskbarMenu_OnEvent);
	});
	//DKWidget_SetFocus("TaskbarMenu_Run");
}

//////////////////////////
function TaskbarMenu_End()
{
	DKRemoveEvents(TaskbarMenu_OnEvent);
	DKClose("DKOS/TaskbarMenu.html");
}

///////////////////////////////////
function TaskbarMenu_OnEvent(event)
{
	DKLog("TaskbarMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event, "FileExplorer")){
		DKCreate("DKFile/DKSolution.js", function(rval){
			if(!rval){ return; }
			DKFrame_Widget("DKFile/DKSolution.html");
			DKFrame_SetTitle("DKFile/DKSolution.html", "File Explorer");
			DKSolution_UpdatePath(DKAssets_LocalAssets());
		});
	}
	if(DK_Id(event, "OpenConsole")){
		DKCreate("DKConsole/DKConsole.js", function(){});
	}
	if(DK_Id(event, "OpenBuilder")){
		DKCreate("DKBuild/DKBuildGUI.js", function(rval){
			if(!rval){ return; }
			DKFrame_Widget("DKBuild/DKBuildGUI.html");
		});
	}
	if(DK_Id(event, "OpenDev")){
		DKCreate("DKFile/DKFileAssociation.js", function(){
			DKFileAssociation_Open("DKDev/DKMenuRight.js");
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
	if(DK_Id(event, "OpenBrowser")){
		DKCreate("DKFile/DKFileAssociation.js", function(){
			DKFileAssociation_Open("DKBrowser/DKBrowser.js");
		});
	}
	if(DK_Id(event, "OpenMessage")){
		DKCreate("DKMessage/DKMessage.js", function(){
			DKFrame_Widget("DKMessage/DKMessage.html");
			DKMessageBox("", "ShowMessage", "test message");
		});
	}
	if(DK_Id(event, "OpenTetris")){
		//DKFrame_Iframe("Tetris","http://www.lutanho.net/play/tetris.html",440,560);
		var div = DKWidget_CreateElement("body", "div", "DKIframe.html");
		DKWidget_SetProperty(div, "position", "absolute");
		DKWidget_SetProperty(div, "width", "100%");
		DKWidget_SetProperty(div, "height", "100%");
		
		var iframe = DKWidget_CreateElement(div, "iframe", "iframe");
		DKWidget_SetAttribute(iframe, "src", "http://www.lutanho.net/play/tetris.html");
		DKWidget_SetAttribute(iframe, "width", "100%");
		DKWidget_SetAttribute(iframe, "height", "100%");
		DKWidget_SetProperty(iframe, "border-width", "0px");
		//DKWidget_SetProperty(iframe, "overflow-x", "auto");
		//DKWidget_SetProperty(iframe, "overflow-y", "auto");
		
		DKFrame_Widget(div);
	}
	if(DK_Id(event, "OpenSuperball")){
		//DKFrame_Iframe("Superball","http://wiredtron.com/games/games/3dsuperball.swf",800,600);
		var div = DKWidget_CreateElement("body", "div", "DKIframe.html");
		DKWidget_SetProperty(div, "position", "absolute");
		DKWidget_SetProperty(div, "width", "100%");
		DKWidget_SetProperty(div, "height", "100%");
		
		var iframe = DKWidget_CreateElement(div, "iframe", "iframe");
		DKWidget_SetAttribute(iframe, "src", "http://wiredtron.com/games/games/3dsuperball.swf");
		DKWidget_SetAttribute(iframe, "width", "100%");
		DKWidget_SetAttribute(iframe, "height", "100%");
		DKWidget_SetProperty(iframe, "border-width", "0px");
		//DKWidget_SetProperty(iframe, "overflow-x", "auto");
		//DKWidget_SetProperty(iframe, "overflow-y", "auto");
		
		DKFrame_Widget(div);
	}
	if(DK_Id(event, "TestSound")){
		DKCreate("DKAudio/DKAudio.js", function(){
			var assets = DKAssets_LocalAssets();
			DKAudio_PlaySound(assets+"DKAudio/test.wav");
		});
	}
	if(DK_Id(event, "TestVideo")){
		DKCreate("DKVideo/DKVideo.js", function(){
			var assets = DKAssets_LocalAssets();
			DKVideo_Play(assets+"DKVideo/test.avi");
		});
	}
	if(DK_Id(event, "OpenSource")){
		DKLog("OpenSource\n");
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
		DKRocket_ToggleDebugger();
	}
	if(DK_Id(event, "PushDKFiles")){
		TaskbarMenu_PushDKFiles();
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
	if(DK_Id(event, "Reload")){
		DKFrame_CloseAll();
		DK_Refresh();
	}
	if(DK_Id(event, "CloseDKOS")){
		DKClose("TaskbarMenu.js")
		DK_Exit();
		return;
	}
	if(DK_Id(event, "TaskbarMenu_Run")){
		var key = DK_GetValue(event);
		DKLog("TaskbarMenu_Run: key="+key+"\n");
		if(key != 72){ return; }
		TaskbarMenu_Run(DKWidget_GetValue("TaskbarMenu_Run"))
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKOS/TaskbarMenu.html")){
			return;
		}
	}
	DKClose("DKOS/TaskbarMenu.js");
}

//////////////////////////////////
function TaskbarMenu_PushDKFiles()
{
	//Here, we push any altered DKPulgin files to the appropriate DKPlugin folder.
	
	//DKLog("DKMenuRightApp_PushDKFiles()\n");
	var assets = DKAssets_LocalAssets();
	
	var DKPlugins = assets+"/../../../DKPlugins";
	var DKPlugins2 = assets+"/../../../../DKPlugins";
	
	if(DKFile_Exists(DKPlugins)){
		DKPlugins = DKFile_GetAbsolutePath(DKPlugins);
	}
	if(DKFile_Exists(DKPlugins2)){
		DKPlugins2 = DKFile_GetAbsolutePath(DKPlugins2);
	}
	
	var temp = DKFile_DirectoryContents(assets);
	var folders = temp.split(",");
	
	for(i=0; i<folders.length; i++){
		//DKLog(folders[i]+"\n");
		if(DKFile_Exists(DKPlugins+"/"+folders[i])){
			DKLog("Pushing to: "+DKPlugins+"/"+folders[i]+"\n");
			DKFile_CopyFolder(assets+"/"+folders[i], DKPlugins+"/"+folders[i], true, true);
		}
		if(DKFile_Exists(DKPlugins2+"/"+folders[i])){
			DKLog("Pushing to: "+DKPlugins2+"/"+folders[i]+"\n");
			DKFile_CopyFolder(assets+"/"+folders[i], DKPlugins2+"/"+folders[i], true, true);
		}
	}
}

/////////////////////////////////
function TaskbarMenu_Run(command)
{
	if(command.indexOf("http://") > -1){
		DKFrame_Iframe(command,command,800,600);
		return;
	}
	if(command.indexOf("https://") > -1){
		DKFrame_Iframe(command,command,800,600);
		return;
	}
	if(command.indexOf("file://") > -1){
		DKFrame_Iframe(command,command,800,600);
		return;
	}
	DK_RunJavascript(command);
}