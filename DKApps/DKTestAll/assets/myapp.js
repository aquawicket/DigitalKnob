
function MyApp(){}
const myapp = DKPlugin(MyApp);


myapp.loadFiles = function myapp_loadFiles() {
	DKPlugin("DK/DKPhp.js")
	DKPlugin("DKFile/DKFile.js")
	DKPlugin("DKGui/DKGui.js")
	//DKPlugin("DKGui/DKConsole.js")
	DKPlugin("DKGui/DKFrame.js")
	DKPlugin("DKGui/DKDrag.js")
	//DKPlugin("DKGui/DKResize.js")
	DKPlugin("DKGui/TestApp.js")
	//DKPlugin("DKGui/DKMessageBox.js")
	//dk.notepad = DKPlugin("DKNotepad/DKNotepad.js")
	//DKPlugin("DKCodeRunner/DKCodeRunner.js")
	//DKPlugin("DKFile/filemanager.js")
	
}

myapp.loadApp = function myapp_loadApp() {
	//DKConsole.prototype.create(document.body, "", "0rem", "0rem", "0rem", "100%", "25%")	
	//TestApp.prototype.create(function(instance){})
	
	DKPlugin("DKFile/filemanager.js", function() {
        DKFileManager.prototype.init();
        DKFileManager.prototype.create();
    });
}


DUKTAPE && myapp.loadFiles();
DUKTAPE && myapp.loadApp();