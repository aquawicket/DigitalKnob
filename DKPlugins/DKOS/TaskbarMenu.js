///////////////////////////
function TaskbarMenu_Init()
{
	DKCreate("DKOS/TaskbarMenu.html");
	DKAddEvent("GLOBAL", "mousedown", TaskbarMenu_OnEvent);
	//DKAddEvent("GLOBAL", "OpenFile", TaskbarMenu_OnEvent);
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
	//DKWidget_SetFocus("TaskbarMenu_Run");
}

//////////////////////////
function TaskbarMenu_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", TaskbarMenu_OnEvent);
	//DKRemoveEvent("GLOBAL", "OpenFile", TaskbarMenu_OnEvent);
	DKRemoveEvent("PushDKFiles", "click", TaskbarMenu_OnEvent);
	DKRemoveEvent("ClearConsole", "click", TaskbarMenu_OnEvent);
	DKRemoveEvent("Info", "click", TaskbarMenu_OnEvent);
	DKRemoveEvent("Reload", "click", TaskbarMenu_OnEvent);
	DKRemoveEvent("CloseDKOS", "click", TaskbarMenu_OnEvent);
	DKRemoveEvent("FileExplorer", "click", TaskbarMenu_OnEvent);
	DKRemoveEvent("OpenConsole", "click", TaskbarMenu_OnEvent);
	DKRemoveEvent("OpenBuilder", "click", TaskbarMenu_OnEvent);
	DKRemoveEvent("OpenDev", "click", TaskbarMenu_OnEvent);
	DKRemoveEvent("OpenNotepad", "click", TaskbarMenu_OnEvent);
	DKRemoveEvent("InputTest", "click", TaskbarMenu_OnEvent);
	DKRemoveEvent("OpenBrowser", "click", TaskbarMenu_OnEvent);
	DKRemoveEvent("OpenMessage", "click", TaskbarMenu_OnEvent);
	DKRemoveEvent("OpenSupertball", "click", TaskbarMenu_OnEvent);
	DKClose("DKOS/TaskbarMenu.html");
}

///////////////////////////////////
function TaskbarMenu_OnEvent(event)
{
	//DKLog("TaskbarMenu_OnEvent("+event+") \n", DKDEBUG);
	//DKLog("TaskbarMenu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+") \n", DKDEBUG);
	
	if(DK_Id(event, "FileExplorer")){
		TaskbarMenu_OpenFileInFrame("DKFile/DKFileDialog.js");
		//DKFrame_Widget("DKFileDialog.html");
		var local_assets = DKAssets_GetDataPath();
		DKAddEvent("TaskbarMenu", "OpenFile", TaskbarMenu_OnEvent);
		DKSendEvent("DKFileDialog.html", "GetFile", "TaskbarMenu,OpenFile,"+local_assets+",relative"); // To -> DKFileDialog
		//return;
	}
	if(DK_Type(event, "OpenFile")){
		DKLog("OpenFile: "+event+"\n");
		
		var file = DKWidget_GetValue(event);
		if(file.indexOf(".js") > -1){
			TaskbarMenu_OpenFileInFrame(file);
		}
		else if(file.indexOf(".html") > -1){
			TaskbarMenu_OpenFileInFrame(file);
		}
		else{
			TaskbarMenu_OpenFileInFrame("DKNotepad/DKNotepad.js");		
			var local_assets = DKAssets_GetDataPath();			
			DKSendEvent("DKNotepad.html", "SetFile", local_assets+file);
		}
		
		DKRemoveEvent("TaskbarMenu", "OpenFile", TaskbarMenu_OnEvent);
	}
	if(DK_Id(event, "OpenConsole")){
		DKCreate("DKConsole/DKConsole.js");
	}
	if(DK_Id(event, "OpenBuilder")){
		DKCreate("DKBuild/DKBuild.js");
		var frame = DKFrame_Widget("DKBuildGUI.html");
		DKWidget_SetProperty(frame, "top", "20px");
		DKWidget_SetProperty(frame, "left", "20px");
	}
	if(DK_Id(event, "OpenDev")){
		TaskbarMenu_OpenFileInFrame("DKDev/DKMenuRight.js");
	}
	if(DK_Id(event, "OpenNotepad")){
		TaskbarMenu_OpenFileInFrame("DKNotepad/DKNotepad.js");
	}
	if(DK_Id(event, "InputTest")){
		TaskbarMenu_OpenFileInFrame("DKInputTest/DKInput.js");
	}
	if(DK_Id(event, "OpenBrowser")){
		TaskbarMenu_OpenFileInFrame("DKBrowser/DKBrowser.js");
	}
	if(DK_Id(event, "OpenMessage")){
		//TaskbarMenu_OpenFileInFrame("DKMessage/DKMessage.js");
		DKCreate("DKMessage/DKMessage.js");
		DKFrame_Widget("DKMessage.html");
		DKMessageBox("", "ShowMessage", "test message");
	}
	if(DK_Id(event, "OpenTetris")){
		//TaskbarMenu_OpenFileInFrame("DKTetris/DKTetris.js");
		//DKCreate("DKTetris/DKTetris.js");
		//DKFrame_Widget("DKTetris.html");
		DKFrame_Iframe("Tetris","http://www.lutanho.net/play/tetris.html",440,560);
	}
	if(DK_Id(event, "OpenSuperball")){
		DKFrame_Iframe("Superball","http://wiredtron.com/games/games/3dsuperball.swf",800,600);
	}
	if(DK_Id(event, "TestSound")){
		DKCreate("DKAudio");
		DKAudio_PlaySound("tada.wav");
	}
	if(DK_Id(event, "TestVideo")){
		DKCreate("DKVideo");
		DKVideo_Play("test.avi");
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
		var list = objects.replace(/,/g, '\n');
		list += "\n\n";
		DKLog(list);
		
		DKLog("**** DKEVENTS ****\n");
		var events = DK_GetEvents();
		var list2 = events.replace(/,/g, '\n');
		DKLog(list2);
	}
	if(DK_Id(event, "Reload")){
		DKFrame_CloseAll();
		DK_Reload();
	}
	if(DK_Id(event, "CloseDKOS")){
		DKClose("DKOS/TaskbarMenu.js")
		DK_Exit();
		return;
	}
	if(DK_Id(event, "TaskbarMenu_Run")){
		var key = DKWidget_GetValue(event);
		DKLog("TaskbarMenu_Run: key="+key+"\n");
		if(key != 72){ return; }
		TaskbarMenu_Run(DKWidget_GetValue("TaskbarMenu_Run"))
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "TaskbarMenu.html")){
			return;
		}
	}
	DKClose("DKOS/TaskbarMenu.js");
}

//////////////////////////////////
function TaskbarMenu_PushDKFiles()
{
	//Here, we push any altered DKPulgin files to the appropriate DKPlugin folder.
	
	//DKLog("DKMenuRightApp_PushDKFiles() \n");
	var dkpath = DKAssets_GetDataPath();
	
	var DKPlugins = DKAssets_GetDataPath()+"/../../../DKPlugins";
	var DKPlugins2 = DKAssets_GetDataPath()+"/../../../../DKPlugins";
	
	if(DKFile_Exists(DKPlugins)){
		DKPlugins = DKFile_GetAbsolutePath(DKPlugins);
	}
	if(DKFile_Exists(DKPlugins2)){
		DKPlugins2 = DKFile_GetAbsolutePath(DKPlugins2);
	}
	
	var temp = DKFile_DirectoryContents(dkpath);
	var folders = temp.split(",");
	
	for(i=0; i<folders.length; i++){
		//DKLog(folders[i]+"\n");
		if(DKFile_Exists(DKPlugins+"/"+folders[i])){
			DKLog("Pushing to: "+DKPlugins+"/"+folders[i]+"\n");
			DKFile_CopyFolder(dkpath+"/"+folders[i], DKPlugins+"/"+folders[i], true, true);
		}
		if(DKFile_Exists(DKPlugins2+"/"+folders[i])){
			DKLog("Pushing to: "+DKPlugins2+"/"+folders[i]+"\n");
			DKFile_CopyFolder(dkpath+"/"+folders[i], DKPlugins2+"/"+folders[i], true, true);
		}
	}
}

//////////////////////////////////////////
function TaskbarMenu_OpenFileInFrame(file)
{
	DKLog("TaskbarMenu_OpenFileInFrame("+file+") \n");
	if(file.indexOf(".js") > -1){
		DKCreate(file);
		var file = file.replace(".js",".html");
		file = DKFile_GetFilename(file);
		DKFrame_Widget(file);
		return;
	}
	if(file.indexOf(".html") > -1){
		DKCreate(file);
		file = DKFile_GetFilename(file);
		DKFrame_Widget(file);
		return;
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
	DK_RunJavascript(command);
}