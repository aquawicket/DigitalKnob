// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlimageelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement
console.log("\n////// TEST_HTMLImageElement.js //////")


function printHTMLImageElementProperties(htmlImageElement){
		
	// [HTMLConstructor] constructor();
	console.log("htmlImageElement = "				+htmlImageElement);
	
	// [CEReactions] attribute DOMString alt;
	console.log("htmlImageElement.alt = "			+htmlImageElement.alt);
	
	// [CEReactions] attribute USVString src;
	console.log("htmlImageElement.src = "			+htmlImageElement.src);
		
	// [CEReactions] attribute USVString srcset;
	console.log("htmlImageElement.srcset = "		+htmlImageElement.srcset);
		
	// [CEReactions] attribute DOMString sizes;
	console.log("htmlImageElement.sizes = "			+htmlImageElement.sizes);
		
	// [CEReactions] attribute DOMString? crossOrigin;
	console.log("htmlImageElement.crossOrigin = "	+htmlImageElement.crossOrigin);
		
	// [CEReactions] attribute DOMString useMap;
	console.log("htmlImageElement.useMap = "		+htmlImageElement.useMap);
		
	// [CEReactions] attribute boolean isMap;
	console.log("htmlImageElement.isMap = "			+htmlImageElement.isMap);
		
	// [CEReactions] attribute unsigned long width;
	console.log("htmlImageElement.width = "			+htmlImageElement.width);
		
	// [CEReactions] attribute unsigned long height;
	console.log("htmlImageElement.height = "		+htmlImageElement.height);
		
	// readonly attribute unsigned long naturalWidth;
	console.log("htmlImageElement.naturalWidth = "	+htmlImageElement.naturalWidth);
		
	// readonly attribute unsigned long naturalHeight;
	console.log("htmlImageElement.naturalHeight = "	+htmlImageElement.naturalHeight);
		
	// readonly attribute boolean complete;
	console.log("htmlImageElement.complete = "		+htmlImageElement.complete);
	
	// readonly attribute USVString currentSrc;
	console.log("htmlImageElement.currentSrc = "	+htmlImageElement.currentSrc);
		
	// [CEReactions] attribute DOMString referrerPolicy;
	console.log("htmlImageElement.referrerPolicy = "+htmlImageElement.referrerPolicy);
		
	// [CEReactions] attribute DOMString decoding;
	console.log("htmlImageElement.decoding = "		+htmlImageElement.decoding);
		
	// [CEReactions] attribute DOMString loading;
	console.log("htmlImageElement.loading = "		+htmlImageElement.loading);
		
	// [CEReactions] attribute DOMString fetchPriority;
	console.log("htmlImageElement.fetchPriority = "	+htmlImageElement.fetchPriority);
		
	// Promise<undefined> decode();
	console.log("htmlImageElement.decode = "		+htmlImageElement.decode);
	
	
	printHTMLElementProperties(htmlImageElement);
}


var htmlImageElement = new HTMLImageElement();
printHTMLImageElementProperties(htmlImageElement);