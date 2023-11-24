// [IDL] https://w3c.github.io/csswg-drafts/cssom-view/#the-screen-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Screen
console.log("\n////// TEST_Screen.js //////");


function printScreenProperties(screen){
	
	console.log("screen = "				+screen);
	
	// readonly attribute long availWidth;
	console.log("screen.availWidth = "	+screen.availWidth);
	
	// readonly attribute long availHeight;
	console.log("screen.availHeight = "	+screen.availHeight);
	
	// readonly attribute long width;
	console.log("screen.width = "		+screen.width);
	
	// readonly attribute long height;
	console.log("screen.height = "		+screen.height);
	
	// readonly attribute unsigned long colorDepth;
	console.log("screen.colorDepth = "	+screen.colorDepth);
	
	// readonly attribute unsigned long pixelDepth;
	console.log("screen.pixelDepth = "	+screen.pixelDepth);
}

var screen = new Screen();
printScreenProperties(screen);