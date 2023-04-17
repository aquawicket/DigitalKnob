console.log("////// TEST_Screen.js //////")

////// Screen //////
function printScreenProperties(screen){
	////// Instance properties //////
	console.log("screen.availTop = "		+screen.availTop)		// [Screen.availTop](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/availTop
	console.log("screen.availLeft = "		+screen.availLeft)		// [Screen.availLeft](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/availLeft
	console.log("screen.availHeight = "		+screen.availHeight)	// [Screen.availHeight] https://developer.mozilla.org/en-US/docs/Web/API/Screen/availHeight
	console.log("screen.availWidth = "		+screen.availWidth)		// [Screen.availWidth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/availWidth
	console.log("screen.colorDepth = "		+screen.colorDepth)		// [Screen.colorDepth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/colorDepth
	console.log("screen.height = "			+screen.height)			// [Screen.height] https://developer.mozilla.org/en-US/docs/Web/API/Screen/height
	console.log("screen.left = "			+screen.left)			// [Screen.left](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/left
	console.log("screen.orientation = "		+screen.orientation)	// [Screen.orientation] https://developer.mozilla.org/en-US/docs/Web/API/Screen/orientation
	console.log("screen.pixelDepth = "		+screen.pixelDepth)		// [Screen.pixelDepth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/pixelDepth
	console.log("screen.top = "				+screen.top)			// [Screen.top](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/top
	console.log("screen.width = "			+screen.width)			// [Screen.width] https://developer.mozilla.org/en-US/docs/Web/API/Screen/width
	console.log("screen.mozEnabled = "		+screen.mozEnabled)		// [Screen.mozEnabled](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/mozEnabled
	console.log("screen.mozBrightness = "	+screen.mozBrightness)	// [Screen.mozBrightness](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/mozBrightness
}


const screen = new Screen()
printScreenProperties(screen)