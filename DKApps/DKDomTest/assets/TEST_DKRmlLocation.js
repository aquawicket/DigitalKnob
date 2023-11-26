console.log("\n////// TEST_DKRmlLocation.js //////")


function printRmlLocationProperties(dkRmlLocation){
	
	console.log("dkRmlLocation = "		+dkRmlLocation);
	
	printLocationProperties(dkRmlLocation)		//requires TEST_Location.js
}


const dkRmlLocation = new DKRmlLocation(dkRmlInterface, dkRmlEventListener)		// requires TEST_DKRmlInterface.js and TEST_DKRmlEventListener.js
printRmlLocationProperties(dkRmlLocation)


console.log("dkRmlLocation.href = " +dkRmlLocation.href)
//const url = CPP_DKAssets_LocalAssets()+"DKWebTest/index.html"
const url = "DKWebTest/index.html"
console.log("url = "+url)
dkRmlLocation.href = url;
