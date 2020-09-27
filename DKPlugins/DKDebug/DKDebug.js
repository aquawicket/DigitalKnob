var key_history = [];

///////////////////////
function DKDebug_Init()
{
	DKDEBUGFUNC();
	console.log("DKDebug_Init()");
	window.addEventListener("keydown", DKDebug_OnEvent);
}

//////////////////////
function DKDebug_End()
{
	DKDEBUGFUNC();
	window.removeEventListener("keydown", DKDebug_OnEvent);
}

///////////////////////////////
function DKDebug_OnEvent(event)
{
	//DKDEBUGFUNC(event);
	//console.warn("DKDebug_OnEvent("+event+","+event.currentTarget.id+","+event.type+","+event.value+")");
	
	if(event.type == "keydown"){
		DKDebug_LogKey(event.code);
		DKDebug_CheckKeys();
	}
	
	if(event.type == "keydown" && event.code == "F12"){ //F12
		if(typeof DKCef_ShowDevTools == 'function'){
			DKCef_ShowDevTools(0);
		}
		if(typeof DKRml_DebuggerOn == 'function'){
			DKRml_DebuggerOn();
		}
	}
}

/////////////////////////////
function DKDebug_LogKey(code)
{
	DKDEBUGFUNC(code);
	console.log("DKDebug_LogKey("+code+")");
	//console.trace();
	if(key_history.length > 20){ key_history.shift(); }
	key_history[key_history.length] = code;
}

////////////////////////////
function DKDebug_CheckKeys()
{
	DKDEBUGFUNC();
	//translate keys to string
	var string;
	for(var i=0; i<key_history.length; i++){
		console.log(DKDebug_KeyToChar(key_history[i]));
		string += DKDebug_KeyToChar(key_history[i]);
	}
	
	//check for commands
	if(string.indexOf("dkrefresh") != -1){ 
		console.log("*** DKDebug_Refresh() ***");
		DKDebug_Refresh(); key_history = []; 
	}
	if(string.indexOf("dkpush") != -1){ 
		console.log("*** DKDebug_PushDKFiles() ***");
		DKDebug_PushDKFiles(); key_history = []; 
	}
	if(string.indexOf("dkclear") != -1){
		console.log("*** DKDebug_ClearConsole() ***");
		DKDebug_ClearConsole(); key_history = []; 
	}
	if(string.indexOf("dkinfo") != -1){ 
		console.log("*** DKDebug_PrintInfo() ***");
		DKDebug_PrintInfo(); key_history = []; 
	}
	if(string.indexOf("dkconsole") != -1){
		console.log("*** DKDebug_ShoeConsole() ***");
		DKDebug_ShowConsole(); key_history = []; 
	}
	if(string.indexOf("dksource") != -1){
		console.log("*** DKDebug_GetSource() ***");
		DKDebug_GetSource(); key_history = []; 
	}
	if(string.indexOf("dkcrash") != -1){ 
		console.log("*** DKDebug_Crash() ***");
		DKDebug_Crash(); key_history = []; 
	}	
	if(string.indexOf("dkeditor") != -1){
		console.log("*** DKDebug_Editor() ***");
		DKDebug_Editor(); key_history = []; 
	}
	if(string.indexOf("dkdebug") != -1){ 
		console.log("*** DKDebug_Debugger() ***");
		DKDebug_Debugger(); key_history = []; 
	}
}

///////////////////////////////
function DKDebug_KeyToChar(key)
{
	DKDEBUGFUNC(key);
	if(key == "KeyA"){ return "a"};
	if(key == "KeyB"){ return "b"};
	if(key == "KeyC"){ return "c"};
	if(key == "KeyD"){ return "d"};
	if(key == "KeyE"){ return "e"};
	if(key == "KeyF"){ return "f"};
	if(key == "KeyG"){ return "g"};
	if(key == "KeyH"){ return "h"};
	if(key == "KeyI"){ return "i"};
	if(key == "KeyJ"){ return "j"};
	if(key == "KeyK"){ return "k"};
	if(key == "KeyL"){ return "l"};
	if(key == "KeyM"){ return "m"};
	if(key == "KeyN"){ return "n"};
	if(key == "KeyO"){ return "o"};
	if(key == "KeyP"){ return "p"};
	if(key == "KeyQ"){ return "q"};
	if(key == "KeyR"){ return "r"};
	if(key == "KeyS"){ return "s"};
	if(key == "KeyT"){ return "t"};
	if(key == "KeyU"){ return "u"};
	if(key == "KeyV"){ return "v"};
	if(key == "KeyW"){ return "w"};
	if(key == "KeyX"){ return "x"};
	if(key == "KeyY"){ return "y"};
	if(key == "KeyZ"){ return "z"};
	return " ";
}

/////////////////////////
function DKDebug_Reload()
{
	DKDEBUGFUNC();
	//TODO
}

//////////////////////////
function DKDebug_Refresh()
{
	DKDEBUGFUNC();
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
	DKDEBUGFUNC();
	//Here, we push any altered DKPlugin files to the appropriate DKPlugin folder.
	var assets = DKAssets_LocalAssets();
	if(!assets){
		console.error("DKDebug_PushDKFiles() assets is invalid");
		return false;
	}
	console.log("assets = "+assets);
	
	var search = assets;
	while(!DKFile_Exists(search+"/DK/DKPlugins")){
		var n = search.lastIndexOf("/");
		if(n == -1){
			console.warn("could not locate a DKPlugins folder");
			return false;
		}
		search = search.substring(0, n);
		console.log(search+"");
	}
	
	DKPATH = search;
	
	if(!DKFile_Exists(DKPATH)){
		console.log("Could not find search");
		return;
	}
	//DKINFO("search = "+search+"\n");
	
	var temp = DKFile_DirectoryContents(DKPATH);
	if(!temp){
		console.log("DKDebug_PushDKFiles() variable temp is invalid");
		return false; 
	}
	var folders = temp.split(",");
	//console.log("folders = "+folders);
	
	var plugin_folders = [];
	plugin_folders.push(DKPATH+"/DK/DKPlugins");
	for(var i=0; i<folders.length; i++){
		//console.log("checking "+search+"/"+folders[i]+"/DKPlugins");
		if(DKFile_Exists(DKPATH+"/"+folders[i]+"/DKPlugins")){
			//console.log("adding "+DKPATH+"/"+folders[i]+"/DKPlugins");
			plugin_folders.push(DKPATH+"/"+folders[i]+"/DKPlugins");
		}
	}
	
	for(var i=0; i<plugin_folders.length; i++){
		plugin_folders[i] = DKFile_GetAbsolutePath(plugin_folders[i]);
	}
	//console.log("plugins_folders = "+plugin_folders);
	
	
	var temp = DKFile_DirectoryContents(assets);
	if(!temp){
		console.error("DKDebug_PushDKFiles() variable temp is invalid");
		return false; 
	}
	var folders = temp.split(",");
	for(i=0; i<folders.length; i++){
		//console.log(folders[i]); 
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
	DKDEBUGFUNC();
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

////////////////////////////
function DKDebug_PrintInfo()
{
	DKDEBUGFUNC();
	console.log("\n"); 
	console.log("**** DKOBJECTS ****"); 
	var objects = DK_GetObjects();
	var arry = objects.split(",");
	for(var i=0; i<arry.length; i++){
		if(!arry[i]){ continue; }
		console.log(arry[i]); 
	}
	console.log("\n"); 
	
	console.log("**** DKEVENTS ****"); 
	var events = DK_GetEvents();
	var arry = events.split(",");
	for(var i=0; i<arry.length; i++){
		if(!arry[i]){ continue; }
		console.log(arry[i]); 
	}
	console.log("\n"); 
	
	console.log("**** DKEVENTS ****"); 
	var events = DK_GetFunctions();
	var arry = events.split(",");
	for(var i=0; i<arry.length; i++){
		if(!arry[i]){ continue; }
		console.log(arry[i]); 
	}
	console.log("\n"); 
}

//////////////////////////////
function DKDebug_ShowConsole()
{
	DKDEBUGFUNC();
	DK_ShowConsole();
}

////////////////////////////
function DKDebug_GetSource()
{
	DKDEBUGFUNC();
	DKCreate("DKWidgetJS");
	var source = DKWidget_GetOuterHtml("html");
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
	DKDEBUGFUNC();
	DK_Crash();
}

/////////////////////////
function DKDebug_Editor()
{
	DKDEBUGFUNC();
	DKCreate("DKEditor/DKEditor.js", function(){});
}

///////////////////////////
function DKDebug_Debugger()
{
	DKDEBUGFUNC();
	if(DK_GetBrowser() == "RML" || DK_GetJSEngine() == "Duktape"){
		DKRml_DebuggerToggle();
	}
	if(DK_GetBrowser() == "CEF"){
		//DKCef_ShowDevTools(0);
	}
}