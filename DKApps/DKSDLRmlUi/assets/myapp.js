
function MyApp(){}
const myapp = DKPlugin(MyApp);


myapp.loadFiles = function myapp_loadFiles() {
	//DKPlugin("DKFile/DKFile.js")
	//DKPlugin("DKGui/DKGui.js")
	//DKPlugin("DKCodeRunner/DKCodeRunner.js")
	//dk.notepad = DKPlugin("DKNotepad/DKNotepad.js")
	//DKPlugin("DKGui/DKMessageBox.js")
	//DKPlugin("DKGui/DKConsole.js")
	
	DKPlugin("DKGui/DKMessageBox.js")
}

myapp.loadApp = function myapp_loadApp() {
	//DKConsole.prototype.create(document.body, "", "0rem", "0rem", "0rem", "100%", "25%")
	console.log("**** DKSDLRmlUi ****")
	
	DKPlugin("DKGui/DKMessageBox.js", function() {
		DKMessageBox.prototype.createMessage("this is a message", function(instance, okclicked) {
            //if (instance) {
                //console.log("instance: %c" + instance, "color:orange;")
            //    instance.html && (instance.html.style.backgroundColor = "red")
            //}
        })
    })
}


DUKTAPE && myapp.loadFiles();
DUKTAPE && myapp.loadApp();