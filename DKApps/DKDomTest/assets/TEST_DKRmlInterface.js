console.log("\n////// TEST_DKRmlInterface.js //////")


function printDKRmlInterfaceProperties(dkRmlInterface){
	
	console.log("dkRmlInterface = "		+dkRmlInterface);
}


const dkRmlInterface = new DKRmlInterface(dkSdlWindow)		// requires TEST_DKSDLWindow.js
printDKRmlInterfaceProperties(dkRmlInterface)

