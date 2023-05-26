console.log("\n////// TEST_DKRmlLocation.js //////")


function printRmlLocationProperties(rmlLocation){
	// TODO
}


const myRmlLocation = new DKRmlLocation()
printRmlLocationProperties(myRmlLocation)
printLocationProperties(myRmlLocation)		//requires TEST_Location.js

console.log("myRmlLocation.href = " +myRmlLocation.href)
//const url = CPP_DKAssets_LocalAssets()+"DKWebTest/index.html"
const url = "DKWebTest/index.html"
console.log("url = "+url)
myRmlLocation.href = url;
