// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location
console.log("\n////// TEST_Location.js //////")


function printLocationProperties(location){
	
	console.log("location = "					+location);
	
	// [LegacyUnforgeable] stringifier attribute USVString href;
	console.log("location.href = "				+location.href);
	
	// [LegacyUnforgeable] readonly attribute USVString origin;
	console.log("location.origin = "			+location.origin);
	
	// [LegacyUnforgeable] attribute USVString protocol;
	console.log("location.protocol = "			+location.protocol);
	
	// [LegacyUnforgeable] attribute USVString host;
	console.log("location.host = "				+location.host);
	
	// [LegacyUnforgeable] attribute USVString hostname;
	console.log("location.hostname = "			+location.hostname);
	
	// [LegacyUnforgeable] attribute USVString port;
	console.log("location.port = "				+location.port);
	
	// [LegacyUnforgeable] attribute USVString pathname;
	console.log("location.pathname = "			+location.pathname);
	
	// [LegacyUnforgeable] attribute USVString search;
	console.log("location.search = "			+location.search);
	
	// [LegacyUnforgeable] attribute USVString hash;
	console.log("location.hash = "				+location.hash);
	
	// [LegacyUnforgeable] undefined assign(USVString url);
	console.log("location.assign = "			+location.assign);
		
	// [LegacyUnforgeable] undefined replace(USVString url);
	console.log("location.replace = "			+location.replace);
		
	// [LegacyUnforgeable] undefined reload();
	console.log("location.reload = "			+location.reload);
	
	// [LegacyUnforgeable, SameObject] readonly attribute DOMStringList ancestorOrigins;
	console.log("location.ancestorOrigins = "	+location.ancestorOrigins);
}


var location = new Location();
printLocationProperties(location);
