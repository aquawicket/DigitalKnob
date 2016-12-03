var key_history = [];

///////////////////////
function DKDebug_Init()
{
	DKCreate("DKFrame/DKFrame.js", function(){});
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
	if(DK_Type(event, "keypress")){
		//DKLog("Unicode CHARACTER code: "+DKWidget_GetValue(event)+"\n");
		DKDebug_LogKey(DKWidget_GetValue(event));
		DKDebug_CheckKeys();
	}
}

////////////////////////////
function DKDebug_LogKey(key)
{
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
	//DKFrame_CloseAll();
	DKWidget_SetInnerHtml("body", "");
	DK_Reload();
	
}

//////////////////////////////
function DKDebug_PushDKFiles()
{
	//Here, we push any altered DKPulgin files to the appropriate DKPlugin folder.
	
	//DKLog("DKMenuRightApp_PushDKFiles() \n");
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
	DKLog("DKDebug_ClearConsole()\n", DKDEBUG);
	DKLog("DK_GetBrowser() = "+DK_GetBrowser()+"\n", DKDEBUG);
	if(DK_GetBrowser() == "Rocket"){
		DK_System("cls");
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
