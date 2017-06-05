var key_history = [];

///////////////////////
function DKDebug_Init()
{
	//DKLog("DKDebug_Init()\n");
	DKAddEvent("GLOBAL", "keypress", DKDebug_OnEvent);
}

//////////////////////
function DKDebug_End()
{
	DKRemoveEvent("GLOBAL", "keypress", DKDebug_OnEvent);
}

///////////////////////////////
function DKDebug_OnEvent(event)
{
	//DKLog("DKDebug_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "keypress")){
		//DKLog("Unicode CHARACTER code: "+DK_GetValue(event)+"\n"); 
		DKDebug_LogKey(DK_GetValue(event));
		DKDebug_CheckKeys();
	}
}

////////////////////////////
function DKDebug_LogKey(key)
{
	//DKLog("DKDebug_LogKey("+key+")\n");
	if(key_history.length > 20){ key_history.shift(); }
	key_history[key_history.length] = key;
}

////////////////////////////
function DKDebug_CheckKeys()
{
	//translate keys to string
	var string;
	for(var i=0; i<key_history.length; i++){
		string += DKDebug_KeyToChar(key_history[i]);
	}
	
	//check for commands
	if(string.indexOf("dkreload") != -1){ DKDebug_RestartApp(); key_history = []; }
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

/////////////////////////////
function DKDebug_RestartApp()
{
	//TODO - make this work for all variations 
	if(DK_GetBrowser() != "Rocket"){
		DK_Reload(); //Call DK.js
	}
	if(DK_GetBrowser() == "Rocket" && !USE_CEF){
		DK_Reload(); //Call DKDuktape.cpp
	}
}

//////////////////////////////
function DKDebug_PushDKFiles()
{
	//Here, we push any altered DKPulgin files to the appropriate DKPlugin folder.
	
	//DKLog("DKMenuRightApp_PushDKFiles()\n"); 
	
	var assets = DKAssets_LocalAssets();
	if(!assets){
		DKLog("DKDebug_PushDKFiles() assets is invalid", DKERROR);
		return false;
	}
	
	var DKPlugins = assets+"/../../../DKPlugins";
	var DKPlugins2 = assets+"/../../../../DKPlugins";
	
	if(DKFile_Exists(DKPlugins)){
		DKPlugins = DKFile_GetAbsolutePath(DKPlugins);
	}
	if(DKFile_Exists(DKPlugins2)){
		DKPlugins2 = DKFile_GetAbsolutePath(DKPlugins2);
	}
	
	DKLog("Calling: DKFile_DirectoryContents("+assets+")\n");
	var temp = DKFile_DirectoryContents(assets);
	if(!temp){
		DKLog("DKDebug_PushDKFiles() variable temp is invalid", DKERROR);
		return false; 
	}
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

///////////////////////////////
function DKDebug_ClearConsole()
{
	//DKLog("DKDebug_ClearConsole()\n");
	//DKLog("DK_GetBrowser() = "+DK_GetBrowser()+"\n");
	if(DK_GetBrowser() == "Rocket"){
		if(DK_GetOS() == "Win32" || DK_GetOS() == "Win64"){
			DK_System("cls");
		}
		if(DK_GetOS() == "Mac" || DK_GetOS() == "Linux"){
			DK_System("clear");
		}
	}
	else{
		console.API;
		if(typeof console._commandLineAPI !== 'undefined'){
			console.API = console._commandLineAPI; //chrome
		}
		else if(typeof console._inspectorCommandLineAPI !== 'undefined'){
			console.API = console._inspectorCommandLineAPI; //Safari
		} 
		else if(typeof console.clear !== 'undefined'){
			console.API = console;
		}
		console.API.clear();
	}
}

////////////////////////////
function DKDebug_PrintInfo()
{
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
	DKLog("DKDebug_ShowConsole()\n");
	DK_ShowConsole();
}

////////////////////////////
function DKDebug_GetSource()
{
	DKLog("DKDebug_GetSource()\n");
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
	DK_Crash();
}

/////////////////////////
function DKDebug_Editor()
{
	DKCreate("DKEditor/DKEditor.js", function(){});
}
