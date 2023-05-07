console.log("////// TEST_DKRmlLocation.js //////")


function printRmlLocationProperties(rmlLocation){
	////// Instance properties //////
	// TODO
}


/////////////////////////////////////////
const myRmlLocation = new DKRmlLocation()
printRmlLocationProperties(myRmlLocation)
printLocationProperties(myRmlLocation)		//requires TEST_Location.js

const myRmlLocation = new DKRmlLocation()
console.log("myRmlLocation.href = " +myRmlLocation.href)
const url = CPP_DKAssets_LocalAssets()+"index.html"
console.log("url = "+url)
myRmlLocation.href = url;
