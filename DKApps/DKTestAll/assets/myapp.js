
function MyApp(){}
const myapp = DKPlugin(MyApp);


myapp.loadFiles = function myapp_loadFiles() {
	//DKPlugin("DK/DKTrace.js")
	DKPlugin("DK/DKPhp.js")
	DKPlugin("DKFile/DKFile.js")
	DKPlugin("DKGui/DKGui.js")
	DKPlugin("DKGui/DKFrame.js")

	//DKPlugin("DKCodeRunner/DKCodeRunner.js")
	//dk.notepad = DKPlugin("DKNotepad/DKNotepad.js")
	//DKPlugin("DKGui/DKConsole.js")
	
	DKPlugin("DKGui/TestApp.js")
}

myapp.loadApp = function myapp_loadApp() {
	//DKConsole.prototype.create(document.body, "", "0rem", "0rem", "0rem", "100%", "25%")
	console.log("**** DKTestAll ****")
	
	DKPlugin("DKGui/TestApp.js", function() {
		TestApp.prototype.create(function(instance) {
            //if (instance) {
                //console.log("instance: %c" + instance, "color:orange;")
            //    instance.html && (instance.html.style.backgroundColor = "red")
            //}
        })
    })
}

CPP_DK_SendEvent = function(){} //just consume the message from CEF for now
DUKTAPE && myapp.loadFiles();
DUKTAPE && myapp.loadApp();