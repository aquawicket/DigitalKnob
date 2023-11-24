// [IDL] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
console.log("\n////// TEST_HTMLElement.js //////")


function printHTMLElementProperties(htmlElement){
		
	// [HTMLConstructor] constructor();
	console.log("htmlElement = "				+htmlElement);
		
	// metadata attributes
	// [CEReactions] attribute DOMString title;
	console.log("htmlElement.title = "			+htmlElement.title);
		
	// [CEReactions] attribute DOMString lang;
	console.log("htmlElement.lang = "			+htmlElement.lang);
		
	// [CEReactions] attribute boolean translate;
	console.log("htmlElement.translate = "		+htmlElement.translate);
		
	// [CEReactions] attribute DOMString dir;
	console.log("htmlElement.dir = "			+htmlElement.dir);
		
	// user interaction
	// [CEReactions] attribute (boolean or unrestricted double or DOMString)? hidden;
	console.log("htmlElement.hidden = "			+htmlElement.hidden);
		
	// [CEReactions] attribute boolean inert;
	console.log("htmlElement.inert = "			+htmlElement.inert);
		
	// undefined click();
	console.log("htmlElement.click = "			+htmlElement.click);
		
	// [CEReactions] attribute DOMString accessKey;
	console.log("htmlElement.accessKey = "		+htmlElement.accessKey);
		
	// readonly attribute DOMString accessKeyLabel;
	console.log("htmlElement.accessKeyLabel = "	+htmlElement.accessKeyLabel);
		
	// [CEReactions] attribute boolean draggable;
	console.log("htmlElement.draggable = "		+htmlElement.draggable);
		
	// [CEReactions] attribute boolean spellcheck;
	console.log("htmlElement.spellcheck = "		+htmlElement.spellcheck);
		
	// [CEReactions] attribute DOMString autocapitalize;
	console.log("htmlElement.autocapitalize = "	+htmlElement.autocapitalize);
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerText;
	console.log("htmlElement.innerText = "		+htmlElement.innerText);
		
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString outerText;
	console.log("htmlElement.outerText = "		+htmlElement.outerText);
		
	// ElementInternals attachInternals();
	console.log("htmlElement.attachInternals = "+htmlElement.attachInternals);
		
	// The popover API
	// undefined showPopover();
	console.log("htmlElement.showPopover = "	+htmlElement.showPopover);
		
	// undefined hidePopover();
	console.log("htmlElement.hidePopover = "	+htmlElement.hidePopover);
		
	// undefined togglePopover(optional boolean force);
	console.log("htmlElement.togglePopover = "	+htmlElement.togglePopover);
	
	// [CEReactions] attribute DOMString? popover;
	console.log("htmlElement.popover = "		+htmlElement.popover);
	
//};

	// HTMLElement includes GlobalEventHandlers;
	// HTMLElement includes ElementContentEditable;
	// HTMLElement includes HTMLOrSVGElement;
	
	// [Exposed=Window]
	// interface HTMLUnknownElement : HTMLElement {
		// Note: intentionally no [HTMLConstructor]
	// };
	
	printElementProperties(htmlElement);
}


var htmlElement = new HTMLElement();
printHTMLElementProperties(htmlElement);