console.log("\n////// TEST_DKSdlWindow.js //////")

function printSdlWindowProperties(consolewindow){
	// TODO
}


const mySdlWindow = new DKSdlWindow()
printWindowProperties(mySdlWindow)		//requires TEST_Window.js
printSdlWindowProperties(mySdlWindow)
mySdlWindow.outerHeight = 300;
printWindowProperties(mySdlWindow)		//requires TEST_Window.js
printSdlWindowProperties(mySdlWindow)