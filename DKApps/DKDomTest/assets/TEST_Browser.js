console.log("\n////// TEST_Browser.js //////")

const window = new DKSdlWindow()
console.log("window = "+window);

const dkRmlInterface = new DKRmlInterface(window);
console.log("dkRmlInterface = "+dkRmlInterface);

const dkRmlEventListener = new DKRmlEventListener()
console.log("dkRmlEventListener = "+dkRmlEventListener);

const dkRmlLocation = new DKRmlLocation(dkRmlInterface, dkRmlEventListener)	
console.log("dkRmlLocation = "+dkRmlLocation);

const dkRmlDocument = new DKRmlDocument(dkRmlInterface, dkRmlEventListener);
console.log("dkRmlDocument = "+dkRmlDocument);

const document = dkRmlDocument.documentElement;
const location = dkRmlLocation;

///////////////////////////////////////////////////////////////////////////
const url = "DKWebTest/index.html"
location.href = url;