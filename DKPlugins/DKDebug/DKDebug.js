var key_history = [];

///////////////////////
function DKDebug_Init()
{
	DKLog("DKDebug_Init()\n", DKDEBUG);
	DKAddEvent("GLOBAL", "keypress", DKDebug_OnEvent);
	DKAddEvent("GLOBAL", "keydown", DKDebug_OnEvent);
}

//////////////////////
function DKDebug_End()
{
	DKLog("DKDebug_End()\n", DKDEBUG);
	DKRemoveEvents(DKDebug_OnEvent);
}

///////////////////////////////
function DKDebug_OnEvent(event)
{
	DKLog("DKDebug_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	if(DK_Type(event, "keypress")){
		//DKLog("Unicode CHARACTER code: "+DK_GetValue(event)+"\n"); 
		DKDebug_LogKey(DK_GetValue(event));
		DKDebug_CheckKeys();
	}
	
	if(DK_Type(event, "keydown") && DK_GetValue(event) == 123){ //F12
		if(typeof DKCef_ShowDevTools == 'function'){
			DKCef_ShowDevTools(DKCef_GetCurrentBrowser());
		}
		if(typeof DKRocket_ToggleDebugger == 'function'){
			//DKRocket_ToggleDebugger();
		}
	}
}

////////////////////////////
function DKDebug_LogKey(key)
{
	DKLog("DKDebug_LogKey("+key+")\n", DKDEBUG);
	if(key_history.length > 20){ key_history.shift(); }
	key_history[key_history.length] = key;
}

////////////////////////////
function DKDebug_CheckKeys()
{
	DKLog("DKDebug_CheckKeys()\n", DKDEBUG);
	//translate keys to string
	var string;
	for(var i=0; i<key_history.length; i++){
		string += DKDebug_KeyToChar(key_history[i]);
	}
	
	//check for commands
	if(string.indexOf("dkrefresh") != -1){ DKDebug_Refresh(); key_history = []; }
	if(string.indexOf("dkpush") != -1){ DKDebug_PushDKFiles(); key_history = []; }
	if(string.indexOf("dkclear") != -1){ DKDebug_ClearConsole(); key_history = []; }
	if(string.indexOf("dkinfo") != -1){ DKDebug_PrintInfo(); key_history = []; }
	if(string.indexOf("dkfuncs") != -1){ DK_PrintFunctions(); key_history = []; }
	if(string.indexOf("dkconsole") != -1){ DKDebug_ShowConsole(); key_history = []; }
	if(string.indexOf("dksource") != -1){ DKDebug_GetSource(); key_history = []; }
	if(string.indexOf("dkcrash") != -1){ DKDebug_Crash(); key_history = []; }	
	if(string.indexOf("dkeditor") != -1){ DKDebug_Editor(); key_history = []; }
}

///////////////////////////////
function DKDebug_KeyToChar(key)
{
	DKLog("DKDebug_KeyToChar("+key+")\n", DKDEBUG);
	if(key == 97){ return "a"};
	if(key == 98){ return "b"};
	if(key == 99){ return "c"};
	if(key == 100){ return "d"};
	if(key == 101){ return "e"};
	if(key == 102){ return "f"};
	if(key == 103){ return "g"};
	if(key == 104){ return "h"};
	if(key == 105){ return "i"};
	if(key == 106){ return "j"};
	if(key == 107){ return "k"};
	if(key == 108){ return "l"};
	if(key == 109){ return "m"};
	if(key == 110){ return "n"};
	if(key == 111){ return "o"};
	if(key == 112){ return "p"};
	if(key == 113){ return "q"};
	if(key == 114){ return "r"};
	if(key == 115){ return "s"};
	if(key == 116){ return "t"};
	if(key == 117){ return "u"};
	if(key == 118){ return "v"};
	if(key == 119){ return "w"};
	if(key == 120){ return "x"};
	if(key == 121){ return "y"};
	if(key == 122){ return "z"};
	return " ";
}

/////////////////////////
function DKDebug_Reload()
{
	DKLog("DKDebug_Reload(): TODO\n", DKDEBUG);
	//TODO
}

//////////////////////////
function DKDebug_Refresh()
{
	DKLog("DKDebug_Refresh()\n", DKDEBUG);
	//TODO - make this work for all variations 
	if(DK_GetBrowser() != "Rocket"){
		DK_Refresh(); //Call DK.js
	}
	if(DK_GetBrowser() == "Rocket" && !USE_CEF){
		DK_Reload(); //Call DKDuktape.cpp
	}
}

//////////////////////////////
function DKDebug_PushDKFiles()
{
	DKLog("DKMenuRightApp_PushDKFiles()\n", DKDEBUG); 
	//Here, we push any altered DKPlugin files to the appropriate DKPlugin folder.
	var assets = DKAssets_LocalAssets();
	if(!assets){
		DKLog("DKDebug_PushDKFiles() assets is invalid", DKERROR);
		return false;
	}
	DKLog("assets = "+assets+"\n");
	
	var search = assets;
	while(!DKFile_Exists(search+"/DK/DKPlugins")){
		var n = search.lastIndexOf("/");
		if(n == -1){
			DKLog("could not locate a DKPlugins folder\n", DKWARN);
			return false;
		}
		search = search.substring(0, n);
		DKLog(search+"\n", DKINFO);
	}
	
	DKPATH = search;
	
	if(!DKFile_Exists(DKPATH)){
		DKLog("Could not find search\n");
		return;
	}
	//DKLog("search = "+search+"\n");
	
	var temp = DKFile_DirectoryContents(DKPATH);
	if(!temp){
		DKLog("DKDebug_PushDKFiles() variable temp is invalid", DKERROR);
		return false; 
	}
	var folders = temp.split(",");
	//DKLog("folders = "+folders+"\n");
	
	var plugin_folders = [];
	plugin_folders.push(DKPATH+"/DK/DKPlugins");
	for(var i=0; i<folders.length; i++){
		//DKLog("checking "+search+"/"+folders[i]+"/DKPlugins"+"\n");
		if(DKFile_Exists(DKPATH+"/"+folders[i]+"/DKPlugins")){
			//DKLog("adding "+DKPATH+"/"+folders[i]+"/DKPlugins");
			plugin_folders.push(DKPATH+"/"+folders[i]+"/DKPlugins");
		}
	}
	
	for(var i=0; i<plugin_folders.length; i++){
		plugin_folders[i] = DKFile_GetAbsolutePath(plugin_folders[i]);
	}
	//DKLog("plugins_folders = "+plugin_folders+"\n");
	
	
	var temp = DKFile_DirectoryContents(assets);
	if(!temp){
		DKLog("DKDebug_PushDKFiles() variable temp is invalid", DKERROR);
		return false; 
	}
	var folders = temp.split(",");
	for(i=0; i<folders.length; i++){
		//DKLog(folders[i]+"\n"); 
		for(var b=0; b<plugin_folders.length; b++){
			if(DKFile_Exists(plugin_folders[b]+"/"+folders[i])){
				DKFile_CopyFolder(assets+"/"+folders[i], plugin_folders[b]+"/"+folders[i], true, true);
			}
		}
	}
}

///////////////////////////////
function DKDebug_ClearConsole()
{
	DKLog("DKDebug_ClearConsole()\n", DKDEBUG);
	if(DK_GetBrowser() == "Rocket"){
		if(DK_GetOS() == "Win32" || DK_GetOS() == "Win64"){
			DK_System("cls");
		}
		if(DK_GetOS() == "Mac" || DK_GetOS() == "Linux"){
			DK_System("clear");
		}
	}
	else{
		var api;
		if(typeof console === 'undefined'){ return; }
		if(typeof console._commandLineAPI !== 'undefined'){
			api = console._commandLineAPI; //chrome
		}
		else if(typeof console._inspectorCommandLineAPI !== 'undefined'){
			api = console._inspectorCommandLineAPI; //Safari
		} 
		else if(typeof console.clear !== 'undefined'){
			api = console;
		}
		api.clear();
	}
}

////////////////////////////
function DKDebug_PrintInfo()
{
	DKLog("DKDebug_PrintInfo()\n", DKDEBUG);
	DKLog("\n"); 
	DKLog("\n**** DKOBJECTS ****\n"); 
	var objects = DK_GetObjects();
	var arry = objects.split(",");
	for(var i=0; i<arry.length; i++){
		if(!arry[i]){ continue; }
		DKLog(arry[i]+"\n"); 
	}
	
	DKLog("\n"); 
	DKLog("**** DKEVENTS ****\n"); 
	var events = DK_GetEvents();
	var arry = events.split(",");
	for(var i=0; i<arry.length; i++){
		if(!arry[i]){ continue; }
		DKLog(arry[i]+"\n"); 
	}
	
	DKLog("\n"); 
}

//////////////////////////////
function DKDebug_ShowConsole()
{
	DKLog("DKDebug_ShowConsole()\n", DKDEBUG);
	DK_ShowConsole();
}

////////////////////////////
function DKDebug_GetSource()
{
	DKLog("DKDebug_GetSource()\n", DKDEBUG);
	DKCreate("DKWidgetJS");
	var source = DKWidget_GetOuterHtml("body");
	var assets = DKAssets_LocalAssets();
	
	if(DK_GetBrowser() == "Rocket"){
		DKFile_StringToFile(source, assets+"Rocket_Source.html");
	}
	else{
		DKFile_StringToFile(source, assets+"Browser_Source.html");
	}
}

////////////////////////
function DKDebug_Crash()
{
	DKLog("DKDebug_Crash()\n", DKDEBUG);
	DK_Crash();
}

/////////////////////////
function DKDebug_Editor()
{
	DKLog("DKDebug_Editor()\n", DKDEBUG);
	DKCreate("DKEditor/DKEditor.js", function(){});
}
