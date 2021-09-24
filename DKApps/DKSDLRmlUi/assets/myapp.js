
const MyApp = function() {};
const myapp = new MyApp;

myapp.loadFiles = function myapp_loadFiles() {
	//!DUKTAPE &&	DKPlugin("DKGui/DKConsole.js")
	//!DUKTAPE && DKPlugin("DKGui/DKGui.js")
	
	DKPlugin("DKCodeRunner/DKCodeRunner.js")
	
	//DKPlugin("DKNotepad/DKNotepad.js")
}

myapp.loadApp = function myapp_loadApp() {
	//!DUKTAPE && DKConsole.prototype.create(document.body, "", "0rem", "0rem", "0rem", "100%", "25%")
	console.debug("**** DKSDLRmlUi ****")
}

DUKTAPE && myapp.loadFiles();
DUKTAPE && myapp.loadApp();