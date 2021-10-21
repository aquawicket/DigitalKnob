
function MyApp(){}
const myapp = DKPlugin(MyApp);


myapp.loadFiles = function myapp_loadFiles() {	
	DKPlugin("DKFile/DKFile.js")
	DKPlugin("DKGui/DKGui.js")
	DKPlugin("DKGui/DKFrame.js")
	DKPlugin("DKGui/DKDrag.js")
	//DKPlugin("DKGui/DKResize.js")
	//DKPlugin("DKCodeRunner/DKCodeRunner.js")
	//dk.notepad = DKPlugin("DKNotepad/DKNotepad.js")
	//DKPlugin("DKGui/DKMessageBox.js")
	//DKPlugin("DKGui/DKConsole.js")
	
	DKPlugin("DKGui/TestApp.js")
}

myapp.loadApp = function myapp_loadApp() {
	//DKConsole.prototype.create(document.body, "", "0rem", "0rem", "0rem", "100%", "25%")
	console.log("**** DKSDLRmlUi ****")
	
	DKPlugin("DKGui/TestApp.js", function() {
		TestApp.prototype.create(function(instance) {
            //if (instance) {
                //console.log("instance: %c" + instance, "color:orange;")
            //    instance.html && (instance.html.style.backgroundColor = "red")
            //}
        })
    })
}


DUKTAPE && myapp.loadFiles();
DUKTAPE && myapp.loadApp();