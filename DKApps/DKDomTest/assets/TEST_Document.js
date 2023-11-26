// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document
console.log("\n////// TEST_Document.js //////")


function printDocumentProperties(document){
	
	// constructor();
	console.log("document = "								+document);
		
	// [SameObject] readonly attribute DOMImplementation implementation;
	console.log("document.implementation = "				+document.implementation);
	
	// readonly attribute USVString URL;
	console.log("document.URL = "							+document.URL);
	
	// readonly attribute USVString documentURI;
	console.log("document.documentURI = "					+document.documentURI);
	
	// readonly attribute DOMString compatMode;
	console.log("document.compatMode = "					+document.compatMode);

	// readonly attribute DOMString characterSet;
	console.log("document.characterSet = "					+document.characterSet);
	
	// readonly attribute DOMString charset; // legacy alias of .characterSet
	console.log("document.charset = "						+document.charset);
	
	// readonly attribute DOMString inputEncoding; // legacy alias of .characterSet
	console.log("document.inputEncoding = "					+document.inputEncoding);
	
	// readonly attribute DOMString contentType;
	console.log("document.contentType = "					+document.contentType);
	
	// readonly attribute DocumentType? doctype;
	console.log("document.doctype = "						+document.doctype);
	
	// readonly attribute Element? documentElement;
	console.log("document.documentElement = "				+document.documentElement);
	
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	console.log("document.getElementsByTagName = "			+document.getElementsByTagName);
		
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	console.log("document.getElementsByTagNameNS = "		+document.getElementsByTagNameNS);
		
	// HTMLCollection getElementsByClassName(DOMString classNames);
	console.log("document.getElementsByClassName = "		+document.getElementsByClassName);
		
	// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
	console.log("document.createElement = "					+document.createElement);
		
	// [CEReactions, NewObject] Element createElementNS(DOMString? namespace, DOMString qualifiedName, optional (DOMString or ElementCreationOptions) options = {});
	console.log("document.createElementNS = "				+document.createElementNS);
		
	// [NewObject] DocumentFragment createDocumentFragment();
	console.log("document.createDocumentFragment = "		+document.createDocumentFragment);
		
	// [NewObject] Text createTextNode(DOMString data);
	console.log("document.createTextNode = "				+document.createTextNode);
		
	// [NewObject] CDATASection createCDATASection(DOMString data);
	console.log("document.createCDATASection = "			+document.createCDATASection);
		
	// [NewObject] Comment createComment(DOMString data);
	console.log("document.createComment = "					+document.createComment);
		
	// [NewObject] ProcessingInstruction createProcessingInstruction(DOMString target, DOMString data);
	console.log("document.createProcessingInstruction = "	+document.createProcessingInstruction);
		
	// [CEReactions, NewObject] Node importNode(Node node, optional boolean deep = false);
	console.log("document.importNode = "					+document.importNode);
		
	// [CEReactions] Node adoptNode(Node node);
	console.log("document.adoptNode = "						+document.adoptNode);
		
	// [NewObject] Attr createAttribute(DOMString localName);
	console.log("document.createAttribute = "				+document.createAttribute);
		
	// [NewObject] Attr createAttributeNS(DOMString? namespace, DOMString qualifiedName);
	console.log("document.createAttributeNS = "				+document.createAttributeNS);
		
	// [NewObject] Event createEvent(DOMString interface); // legacy
	console.log("document.createEvent = "					+document.createEvent);
		
	// [NewObject] Range createRange();
	console.log("document.createRange = "					+document.createRange);
		
	// NodeFilter.SHOW_ALL = 0xFFFFFFFF
	// TODO 
		
	// [NewObject] NodeIterator createNodeIterator(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	console.log("document.createNodeIterator = "			+document.createNodeIterator);
		
	// [NewObject] TreeWalker createTreeWalker(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	console.log("document.createTreeWalker = "				+document.createTreeWalker);
		
// };
	
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// Document includes NonElementParentNode;

	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// Document includes DocumentOrShadowRoot;

	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// Document includes ParentNode;

	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// Document includes XPathEvaluatorBase;
		
	// Source: Font Metrics API Level 1 (https://drafts.css-houdini.org/font-metrics-api-1/)
	// partial interface Document {
	//		FontMetrics measureElement(Element element);
			console.log("document.measureElement = "			+document.measureElement);
	//
	//		FontMetrics measureText(DOMString text, StylePropertyMapReadOnly styleMap);
			console.log("document.measureText = "				+document.measureText);
	//};
		
	// Source: Fullscreen API Standard (https://fullscreen.spec.whatwg.org/)
	// partial interface Document {
	//		[LegacyLenientSetter] readonly attribute boolean fullscreenEnabled;
			console.log("document.fullscreenEnabled = "			+document.fullscreenEnabled);
	//		
	//		[LegacyLenientSetter, Unscopable] readonly attribute boolean fullscreen; // historical
			console.log("document.fullscreen = "				+document.fullscreen);
	//
	//		Promise<undefined> exitFullscreen();
			console.log("document.exitFullscreen = "			+document.exitFullscreen);
	//
	//		attribute EventHandler onfullscreenchange;
			console.log("document.onfullscreenchange = "		+document.onfullscreenchange);
	//
	//		attribute EventHandler onfullscreenerror;
			console.log("document.onfullscreenerror = "			+document.onfullscreenerror);
	//};
		
	
	printNodeProperties(document);
}


var document = new Document();
printDocumentProperties(document);