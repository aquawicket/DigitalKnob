// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLBodyElement
console.log("\n////// TEST_HTMLBodyElement.js //////")


function printHTMLBodyElementProperties(htmlBodyElement){
		
	// [HTMLConstructor] constructor();
	console.log("htmlBodyElement = "						+htmlBodyElement);

	// attribute EventHandler onorientationchange;
	console.log("htmlBodyElement.onorientationchange = "	+htmlBodyElement.onorientationchange);
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString text;
	console.log("htmlBodyElement.text = "					+htmlBodyElement.text);
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString link;
	console.log("htmlBodyElement.link = "					+htmlBodyElement.link);
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString vLink;
	console.log("htmlBodyElement.vLink = "					+htmlBodyElement.vLink);
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString aLink;
	console.log("htmlBodyElement.aLink = "					+htmlBodyElement.aLink);
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString bgColor;
	console.log("htmlBodyElement.bgColor = "				+htmlBodyElement.bgColor);
	
	// [CEReactions] attribute DOMString background;
	console.log("htmlBodyElement.background = "				+htmlBodyElement.background);
  
	
	printHTMLElementProperties(htmlBodyElement);
}


var htmlBodyElement = new HTMLBodyElement();
printHTMLBodyElementProperties(htmlBodyElement);