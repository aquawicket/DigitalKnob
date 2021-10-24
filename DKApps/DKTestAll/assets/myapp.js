
function MyApp(){}
const myapp = DKPlugin(MyApp);


myapp.loadFiles = function myapp_loadFiles() {
	DKPlugin("DK/DKTrace.js")
    //DKPlugin("DK/DKErrorHandler.js")
    DKPlugin("DK/DKPhp.js")
    DKPlugin("DK/DKJson.js")
    DKPlugin("DKFile/DKFile.js")
    //DKPlugin("DK/DKValidate.js")
    DKPlugin("DK/DKTime.js")
    //DKPlugin("DK/DKMqtt.js")
    //DKPlugin("DK/DKNotifications.js")
    DKPlugin("DKDebug/DKDebug.js")
    //DKPlugin("DKAudio/DKAudio.js")
    DKPlugin("DKGui/DKConsole.js")
    DKPlugin("DKGui/DKGui.js")
    DKPlugin("DKGui/DKFrame.js")
    //DKPlugin("DKGui/DKMenu.js")
    DKPlugin("DKGui/DKMessageBox.js")
    DKPlugin("DKGui/DKDrag.js")
    //DKPlugin("DKGui/DKResize.js")
    DKPlugin("DKGui/DKClipboard.js")
    DKPlugin("DKGui/DKTable.js")
    DKPlugin("DKDevTools/DKDevToolsButton.js")
    //DKPlugin("DKChart/DKChart.js")
    //DKPlugin("DKCodeMirror/DKCodeMirror.js")
}

myapp.loadApp = function myapp_loadApp() {
	//dk.errorCatcher(myapp, "myapp")
	//dk.errorhandler.create()
	//DKTime.prototype.create()
	//dk.audio.createSound("DKTasmota/PowerDown.mp3")
	//DKConsole.prototype.create(document.body, "", "0rem", "0rem", "0rem", "100%", "25%")
	//dk.time.createClock(document.body, "2rem")
	//DKDevToolsButton.prototype.create()
	
	/*
	DKPlugin("DKGui/TestApp.js", function() {
		TestApp.prototype.create()
	});
	*/
	
	/*
	DKPlugin("DKGui/DKMessageBox.js", function() {
		DKMessageBox.prototype.init()
		DKMessageBox.prototype.create()
	});
	*/
	
	/*
	dk.paint = DKPlugin("DKPaint/DKPaint.js", function() {
        dk.paint.init();
		const dkframe = DKFrame.prototype.create(byId("DKPaint/DKPaint.html"))
    });
	*/
	
	/*
	DKPlugin("DKColorPicker/DKColorPicker.js", function() {
        DKColorPicker.prototype.init();
        DKColorPicker.prototype.create();
    });
	*/
	
	DKPlugin("DKNotepad/DKNotepad.js", function() {
        DKNotepad.prototype.create();
    });
	
	/*
	DKPlugin("DKBuild/DKBuildGUI.js", function() {
        DKBuildGUI.prototype.init();
        DKBuildGUI.prototype.create();
    });
	*/
	
	/*
	DKPlugin("DKFile/filemanager.js", function() {
        DKFileManager.prototype.create();
    });
	*/
}

DUKTAPE && myapp.loadFiles();
DUKTAPE && myapp.loadApp();
