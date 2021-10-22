
function MyApp(){}
const myapp = DKPlugin(MyApp);


myapp.loadFiles = function myapp_loadFiles() {
	//DKPlugin("DK/DKTrace.js")
    //DKPlugin("DK/DKErrorHandler.js")
    DKPlugin("DK/DKPhp.js")
    DKPlugin("DK/DKJson.js")
    DKPlugin("DKFile/DKFile.js")
    //DKPlugin("DK/DKValidate.js")
    //DKPlugin("DK/DKTime.js")
    //DKPlugin("DK/DKMqtt.js")
    //DKPlugin("DK/DKNotifications.js")
    //DKPlugin("DKDebug/DKDebug.js")
    //DKPlugin("DKAudio/DKAudio.js")
    //DKPlugin("DKGui/DKConsole.js")
    DKPlugin("DKGui/DKGui.js")
    DKPlugin("DKGui/DKFrame.js")
    //DKPlugin("DKGui/DKMenu.js")
    DKPlugin("DKGui/DKMessageBox.js")
    DKPlugin("DKGui/DKDrag.js")
    //DKPlugin("DKGui/DKResize.js")
    //DKPlugin("DKGui/DKClipboard.js")
    //DKPlugin("DKGui/DKTable.js")
    //DKPlugin("DKDevTools/DKDevToolsButton.js")
    //DKPlugin("DKChart/DKChart.js")
    //DKPlugin("DKCodeMirror/DKCodeMirror.js")
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
