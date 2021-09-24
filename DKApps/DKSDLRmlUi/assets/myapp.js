
const MyApp = function() {};
const myapp = new MyApp;

myapp.loadFiles = function myapp_loadFiles() {
	//DKPlugin("DKFile/DKFile.js")
	DKPlugin("DKGui/DKGui.js")
	DKPlugin("DKCodeRunner/DKCodeRunner.js")
	
	//dk.notepad = DKPlugin("DKNotepad/DKNotepad.js")
	
	
	DKPlugin("DKGui/DKConsole.js")
}

myapp.loadApp = function myapp_loadApp() {
	DKConsole.prototype.create(document.body, "", "0rem", "0rem", "0rem", "100%", "25%")
	console.log("**** DKSDLRmlUi ****")
	console.log(dk.console.log)
}

DUKTAPE && myapp.loadFiles();
DUKTAPE && myapp.loadApp();