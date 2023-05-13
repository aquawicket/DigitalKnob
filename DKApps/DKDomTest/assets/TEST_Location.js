// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Location.idl
// [SOURCE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location
console.log("\n////// TEST_Location.js //////")

function printLocationProperties(location){
	console.log("location.href = "	+location.href)	
}

const myLocation = new Location();
printLocationProperties(myLocation)
