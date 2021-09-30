
function MyApp(){}
const myapp = DKPlugin(MyApp);


myapp.loadFiles = function myapp_loadFiles() {
	DKPlugin("DKFile/DKFile.js")
	DKPlugin("DKGui/DKGui.js")
	dk.create("DKGui/DKConsole.css")
	DKPlugin("DKCodeRunner/DKCodeRunner.js")
	//dk.notepad = DKPlugin("DKNotepad/DKNotepad.js")
	DKPlugin("DKGui/DKConsole.js")
}

myapp.loadApp = function myapp_loadApp() {
	DKConsole.prototype.create(document.body, "", "0rem", "0rem", "0rem", "100%", "25%")
	console.log("**** DKSDLRmlUi ****")
	
	const debugg = document.createElement("img")
	debugg.src = "DKCodeRunner/Debugger.png"
	debugg.style.position = "absolute"
	debugg.style.top = "0rem"
	debugg.style.right = "0rem"
	//debugg.style.left = "0rem"
	//debugg.style.bottom = ""
	debugg.style.width = "50px"
	debugg.style.height = "50px"
	debugg.onclick = function(event) {
		console.log("debugger");
		if(dk.getBrowser() === "Rml")
			CPP_DKRml_DebuggerToggle()
	}
	document.body.appendChild(debugg)
}

CPP_DK_SendEvent = function(){} //just consume the message from CEF for now
DUKTAPE && myapp.loadFiles();
DUKTAPE && myapp.loadApp();