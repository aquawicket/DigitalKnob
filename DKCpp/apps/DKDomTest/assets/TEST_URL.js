// [IDL] https://url.spec.whatwg.org/#url-class
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/URL
console.log("\n////// TEST_URL.js //////")


function printURLProperties(url){
	
	console.log("url = "					+url);
	
	// constructor(USVString url, optional USVString base);
	
	// static boolean canParse(USVString url, optional USVString base);
	console.log("url.canParse = "			+url.canParse);
	
	// stringifier attribute USVString href;
	console.log("url.href = "				+url.href);
	
	// readonly attribute USVString origin;
	console.log("url.origin = "				+url.origin);
	
	// attribute USVString protocol;
	console.log("url.protocol = "			+url.protocol);
	
	// attribute USVString username;
	console.log("url.username = "			+url.username);
	
	// attribute USVString password;
	console.log("url.password = "			+url.password);
	
	// attribute USVString host;
	console.log("url.host = "				+url.host);
	
	// attribute USVString hostname;
	console.log("url.hostname = "			+url.hostname);
	
	// attribute USVString port;
	console.log("url.port = "				+url.port);
	
	// attribute USVString pathname;
	console.log("url.pathname = "			+url.pathname);
	
	// attribute USVString search;
	console.log("url.search = "				+url.search);
	
	// [SameObject] readonly attribute URLSearchParams searchParams;
	console.log("url.searchParams = "		+url.searchParams);
	
	// attribute USVString hash;
	console.log("url.hash = "				+url.hash);
	
	// USVString toJSON();
	console.log("url.toJSON = "				+url.toJSON);
	
	// };
	
	// Source: File API (https://www.w3.org/TR/FileAPI/)
	// [Exposed=(Window,DedicatedWorker,SharedWorker)]
	// partial interface URL {
	// static DOMString createObjectURL((Blob or MediaSource) obj);
	console.log("url.createObjectURL = "	+url.createObjectURL);
	
	// static undefined revokeObjectURL(DOMString url);
	console.log("url.revokeObjectURL = "	+url.revokeObjectURL);
	
	//};
}


var url = new URL();
printURLProperties(url);
