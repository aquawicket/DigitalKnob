console.log("////// TEST_DKSdlWindow.js //////")

function printSdlWindowProperties(consolewindow){
	////// Instance properties //////
	// TODO
}


/////////////////////////////////////
const mySdlWindow = new DKSdlWindow()
printWindowProperties(mySdlWindow)		//requires TEST_Window.js
printSdlWindowProperties(mySdlWindow)
mySdlWindow.outerHeight = 300;
printWindowProperties(mySdlWindow)		//requires TEST_Window.js
printSdlWindowProperties(mySdlWindow)