console.log("////// TEST_DKRmlDocument.js //////")


function printRmlDocumentProperties(rmlDocument){
	////// Instance properties //////
	// TODO
}


/////////////////////////////////////////
const myRmlDocument = new DKRmlDocument()
printRmlDocumentProperties(myRmlDocument)
printDocumentProperties(myRmlDocument)		//requires TEST_Document.js

console.log("myRmlDocument.href = " +myRmlDocument.href)
const url = CPP_DKAssets_LocalAssets()+"index.html"
myRmlDocument.href = url
