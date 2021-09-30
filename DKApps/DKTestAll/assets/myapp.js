
function MyApp(){}
const myapp = DKPlugin(MyApp);


myapp.loadFiles = function myapp_loadFiles() {
	DKPlugin("DKFile/DKFile.js")
	DKPlugin("DKGui/DKGui.js")
	DKPlugin("DKCodeRunner/DKCodeRunner.js")
	//dk.notepad = DKPlugin("DKNotepad/DKNotepad.js")
	DKPlugin("DKGui/DKConsole.js")
}

myapp.loadApp = function myapp_loadApp() {
	DKConsole.prototype.create(document.body, "", "0rem", "0rem", "0rem", "100%", "25%")
	console.log("**** DKSDLRmlUi ****")
}

CPP_DK_SendEvent = function(){} //just consume the message from CEF for now
DUKTAPE && myapp.loadFiles();
DUKTAPE && myapp.loadApp();