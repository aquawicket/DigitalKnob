// [IDL] https://w3c.github.io/csswg-drafts/cssom-view/#the-screen-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Screen
console.log("\n////// TEST_Screen.js //////")


function printScreenProperties(screen){
	console.log("screen.availWidth = "	+screen.availWidth	+"\n");
	console.log("screen.availHeight = "	+screen.availHeight	+"\n");
	console.log("screen.width = "		+screen.width		+"\n");
	console.log("screen.height = "		+screen.height		+"\n");
	console.log("screen.colorDepth = "	+screen.colorDepth	+"\n");
	console.log("screen.pixelDepth = "	+screen.pixelDepth	+"\n");
}

const screen = new Screen()
printScreenProperties(screen)