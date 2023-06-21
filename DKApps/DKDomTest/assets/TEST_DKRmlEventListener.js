console.log("\n////// TEST_DKRmlEventListener.js //////")


function printDKRmlEventListenerProperties(dkRmlEventListener){
	
	console.log("dkRmlEventListener = "		+dkRmlEventListener);
	
	printEventListenerProperties(dkRmlEventListener)		//requires TEST_EventListener.js
}


const dkRmlEventListener = new DKRmlEventListener(dkRmlInterface, dkRmlEventListener)		// requires TEST_DKRmlInterface.js and TEST_DKRmlEventListener.js
printRmlLocationProperties(dkRmlEventListener)
