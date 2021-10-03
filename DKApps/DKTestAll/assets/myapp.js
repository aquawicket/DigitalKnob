
function MyApp(){}
const myapp = DKPlugin(MyApp);


myapp.loadFiles = function myapp_loadFiles() {
	DKPlugin("DK/DKTrace.js")
	DKPlugin("DK/DKPhp.js")
	DKPlugin("DKFile/DKFile.js")
	DKPlugin("DKGui/DKGui.js")

	DKPlugin("DKCodeRunner/DKCodeRunner.js")
	//dk.notepad = DKPlugin("DKNotepad/DKNotepad.js")
	DKPlugin("DKGui/DKConsole.js")
}

myapp.loadApp = function myapp_loadApp() {
	DKConsole.prototype.create(document.body, "", "0rem", "0rem", "0rem", "100%", "25%")
	console.log("**** DKSDLRmlUi ****")
	
	const debugg = document.createElement("img")
	//debugg.src = "DKCodeRunner/Debugger.png"
	debugg.setAttribute("src", "DKCodeRunner/Debugger.png") //https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement
	debugg.style.position = "absolute"
	debugg.style.top = "3rem"
	debugg.style.right = "10rem"
	debugg.style.width = "35rem"
	debugg.style.height = "30rem"
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