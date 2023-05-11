// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=Window]
// interface Document : Node {
// constructor();
var Document = function Document(address) {
	//console.log("Document("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKDocumentDUK();

	
	// [SameObject] readonly attribute DOMImplementation implementation;
	Object.defineProperty(this, "implementation", {
        get: function implementation()			{ return CPP_DKDocumentDUK_implementation(this.address) },
		//set: function implementation(data)	{ return CPP_DKDocumentDUK_implementation(this.address, data) },
    })
	
	// readonly attribute USVString URL;
	Object.defineProperty(this, "URL", {
        get: function URL()						{ return CPP_DKDocumentDUK_URL(this.address) },
		//set: function URL(data)				{ return CPP_DKDocumentDUK_URL(this.address, data) },
    })
	
	// readonly attribute USVString documentURI;
	Object.defineProperty(this, "documentURI", {
        get: function documentURI()				{ return CPP_DKDocumentDUK_documentURI(this.address) },
		//set: function documentURI(data)		{ return CPP_DKDocumentDUK_documentURI(this.address, data) },
    })
	
	// readonly attribute DOMString compatMode;
	Object.defineProperty(this, "compatMode", {
        get: function compatMode()				{ return CPP_DKDocumentDUK_compatMode(this.address) },
		//set: function compatMode(data)		{ return CPP_DKDocumentDUK_compatMode(this.address, data) },
    })
	
	// readonly attribute DOMString characterSet;
	Object.defineProperty(this, "characterSet", {
        get: function characterSet()			{ return CPP_DKDocumentDUK_characterSet(this.address) },
		//set: function characterSet(data)		{ return CPP_DKDocumentDUK_characterSet(this.address, data) },
    })
	
	// readonly attribute DOMString charset; // legacy alias of .characterSet
	Object.defineProperty(this, "charset", {
        get: function charset()					{ return CPP_DKDocumentDUK_charset(this.address) },
		//set: function charset(data)			{ return CPP_DKDocumentDUK_charset(this.address, data) },
    })
	
	// readonly attribute DOMString inputEncoding; // legacy alias of .characterSet
	Object.defineProperty(this, "inputEncoding", {
        get: function inputEncoding()			{ return CPP_DKDocumentDUK_inputEncoding(this.address) },
		//set: function inputEncoding(data)		{ return CPP_DKDocumentDUK_inputEncoding(this.address, data) },
    })
	
	// readonly attribute DOMString contentType;
	Object.defineProperty(this, "contentType", {
        get: function contentType()				{ return CPP_DKDocumentDUK_contentType(this.address) },
		//set: function contentType(data)		{ return CPP_DKDocumentDUK_contentType(this.address, data) },
    })
	
	// readonly attribute DocumentType? doctype;
	Object.defineProperty(this, "doctype", {
        get: function doctype()					{ return CPP_DKDocumentDUK_doctype(this.address) },
		//set: function doctype(data)			{ return CPP_DKDocumentDUK_doctype(this.address, data) },
    })
	
	// readonly attribute Element? documentElement;
	Object.defineProperty(this, "documentElement", {
        get: function documentElement()			{ return CPP_DKDocumentDUK_documentElement(this.address) },
		//set: function documentElement(data)	{ return CPP_DKDocumentDUK_documentElement(this.address, data) },
    })
	
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	Document.prototype.getElementsByTagName = function getElementsByTagName(qualifiedName) {
		CPP_DKDocumentDUK_getElementsByTagName(this.address, qualifiedName);
		// TODO
    }
	
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	Document.prototype.getElementsByTagNameNS = function getElementsByTagNameNS(namespace, localName) {
		CPP_DKDocumentDUK_getElementsByTagNameNS(this.address, namespace, localName);
		// TODO
    }
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	Document.prototype.getElementsByClassName = function getElementsByClassName(classNames) {
		CPP_DKDocumentDUK_getElementsByClassName(this.address, classNames);
		// TODO
    }
	
	// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
	Document.prototype.createElement = function createElement(localName, options) {
		CPP_DKDocumentDUK_createElement(this.address, localName, options);
		// TODO
    }
	
	// [CEReactions, NewObject] Element createElementNS(DOMString? namespace, DOMString qualifiedName, optional (DOMString or ElementCreationOptions) options = {});
	Document.prototype.createElementNS = function createElementNS(namespace, qualifiedName, options) {
		CPP_DKDocumentDUK_createElementNS(this.address, namespace, qualifiedName, options);
		// TODO
    }
	
	// [NewObject] DocumentFragment createDocumentFragment();
	Document.prototype.createDocumentFragment = function createDocumentFragment() {
		CPP_DKDocumentDUK_createDocumentFragment(this.address);
		// TODO
    }
	
	// [NewObject] Text createTextNode(DOMString data);
	Document.prototype.createTextNode = function createTextNode(data) {
		CPP_DKDocumentDUK_createTextNode(this.address, data);
		// TODO
    }
	
	// [NewObject] CDATASection createCDATASection(DOMString data);
	Document.prototype.createCDATASection = function createCDATASection(data) {
		CPP_DKDocumentDUK_createCDATASection(this.address, data);
		// TODO
    }
	
	// [NewObject] Comment createComment(DOMString data);
	Document.prototype.createComment = function createComment(data) {
		CPP_DKDocumentDUK_createComment(this.address, data);
		// TODO
    }
	
	// [NewObject] ProcessingInstruction createProcessingInstruction(DOMString target, DOMString data);
	Document.prototype.createProcessingInstruction = function createProcessingInstruction(target, data) {
		CPP_DKDocumentDUK_createProcessingInstruction(this.address, target, data);
		// TODO
    }
	
	// [CEReactions, NewObject] Node importNode(Node node, optional boolean deep = false);
	Document.prototype.importNode = function importNode(node, deep) {
		CPP_DKDocumentDUK_importNode(this.address, node, deep);
		// TODO
    }
	
	// [CEReactions] Node adoptNode(Node node);
	Document.prototype.adoptNode = function adoptNode(node) {
		CPP_DKDocumentDUK_adoptNode(this.address, node);
		// TODO
    }
	
	// [NewObject] Attr createAttribute(DOMString localName);
	Document.prototype.createAttribute = function createAttribute(localName) {
		CPP_DKDocumentDUK_createAttribute(this.address, localName);
		// TODO
    }
	
	// [NewObject] Attr createAttributeNS(DOMString? namespace, DOMString qualifiedName);
	Document.prototype.createAttributeNS = function createAttributeNS(namespace, qualifiedName) {
		CPP_DKDocumentDUK_createAttributeNS(this.address, namespace, qualifiedName);
		// TODO
    }
	
	// [NewObject] Event createEvent(DOMString interface); // legacy
	Document.prototype.createEvent = function createEvent(interface) {
		CPP_DKDocumentDUK_createEvent(this.address, interface);
		// TODO
    }
	
	// [NewObject] Range createRange();
	Document.prototype.createRange = function createRange() {
		CPP_DKDocumentDUK_createRange(this.address);
		// TODO
    }
	
	// NodeFilter.SHOW_ALL = 0xFFFFFFFF
	// TODO 
	
	// [NewObject] NodeIterator createNodeIterator(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	Document.prototype.createNodeIterator = function createNodeIterator(root, whatToShow, filter) {
		CPP_DKDocumentDUK_createNodeIterator(this.address, root, whatToShow, filter);
		// TODO
    }
	
	// [NewObject] TreeWalker createTreeWalker(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	Document.prototype.createTreeWalker = function createTreeWalker(root, whatToShow, filter) {
		CPP_DKDocumentDUK_createTreeWalker(this.address, root, whatToShow, filter);
		// TODO
    }
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
			Document.prototype.measureElement = function measureElement(element) {
				CPP_DKDocumentDUK_measureElement(this.address, element);
				// TODO
			}
	//
	//		FontMetrics measureText(DOMString text, StylePropertyMapReadOnly styleMap);
			Document.prototype.measureText = function measureText(text, styleMap) {
				CPP_DKDocumentDUK_measureText(this.address, text, styleMap);
				// TODO
			}
	//};
	
	// Source: Fullscreen API Standard (https://fullscreen.spec.whatwg.org/)
	// partial interface Document {
	//		[LegacyLenientSetter] readonly attribute boolean fullscreenEnabled;
			Object.defineProperty(this, "fullscreenEnabled", {
				get: function fullscreenEnabled()			{ return CPP_DKDocumentDUK_fullscreenEnabled(this.address) },
				//set: function fullscreenEnabled(data)		{ return CPP_DKDocumentDUK_fullscreenEnabled(this.address, data) },
			})
	//		
	//		[LegacyLenientSetter, Unscopable] readonly attribute boolean fullscreen; // historical
			Object.defineProperty(this, "fullscreen", {
				get: function fullscreen()					{ return CPP_DKDocumentDUK_fullscreen(this.address) },
				//set: function fullscreen(data)			{ return CPP_DKDocumentDUK_fullscreen(this.address, data) },
			})
	//
	//		Promise<undefined> exitFullscreen();
			Document.prototype.exitFullscreen = function exitFullscreen() {
				CPP_DKDocumentDUK_exitFullscreen(this.address);
				// TODO
			}
	//
	//		attribute EventHandler onfullscreenchange;
			Object.defineProperty(this, "onfullscreenchange", {
				get: function onfullscreenchange()			{ return CPP_DKDocumentDUK_onfullscreenchange(this.address) },
				set: function onfullscreenchange(data)		{ return CPP_DKDocumentDUK_onfullscreenchange(this.address, data) },
			})
	//
	//		attribute EventHandler onfullscreenerror;
			Object.defineProperty(this, "onfullscreenerror", {
				get: function onfullscreenerror()			{ return CPP_DKDocumentDUK_onfullscreenerror(this.address) },
				set: function onfullscreenerror(data)		{ return CPP_DKDocumentDUK_onfullscreenerror(this.address, data) },
			})
	//};
		
		
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Document]" }
	
	return Node.call(this, this.address)
}
Document.prototype = Node.prototype
