// [IDL] https://dom.spec.whatwg.org/#interface-element
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Element
console.log("\n////// TEST_Element.js //////")


function printElementProperties(element){
	
	// readonly attribute DOMString? namespaceURI;
	console.log("element.namespaceURI = "	+element.namespaceURI);
	
	// readonly attribute DOMString? prefix;
	console.log("element.prefix = "			+element.prefix);
	
	// readonly attribute DOMString localName;
	console.log("element.localName = "		+element.localName);
	
	// readonly attribute DOMString tagName;
	console.log("element.tagName = "		+element.tagName);
	
	// [CEReactions] attribute DOMString id;
	console.log("element.id = "				+element.id);
	
	// [CEReactions] attribute DOMString className;
	console.log("element.className = "		+element.className);
	
	// [SameObject, PutForwards=value] readonly attribute DOMTokenList classList;
	console.log("element.classList = "		+element.classList);
	
	//[CEReactions, Unscopable] attribute DOMString slot;
	console.log("element.slot = "			+element.slot);
	
	// boolean hasAttributes();
	// function
	
	// [SameObject] readonly attribute NamedNodeMap attributes;
	console.log("element.attributes = "		+element.attributes);
	
	// sequence<DOMString> getAttributeNames();
	// function
		
	// DOMString? getAttribute(DOMString qualifiedName);
	// function
		
	// DOMString? getAttributeNS(DOMString? namespace, DOMString localName);
	// function
		
	// [CEReactions] undefined setAttribute(DOMString qualifiedName, DOMString value);
	// function
		
	// [CEReactions] undefined setAttributeNS(DOMString? namespace, DOMString qualifiedName, DOMString value);
	// function
		
	// [CEReactions] undefined removeAttribute(DOMString qualifiedName);
	// function
		
	// [CEReactions] undefined removeAttributeNS(DOMString? namespace, DOMString localName);
	// function
		
	// [CEReactions] boolean toggleAttribute(DOMString qualifiedName, optional boolean force);
	// function
		
	// boolean hasAttribute(DOMString qualifiedName);
	// function
		
	// boolean hasAttributeNS(DOMString? namespace, DOMString localName);
	// function
		
	// Attr? getAttributeNode(DOMString qualifiedName);
	// function
		
	// Attr? getAttributeNodeNS(DOMString? namespace, DOMString localName);
	// function
		
	// [CEReactions] Attr? setAttributeNode(Attr attr);
	// function
		
	// [CEReactions] Attr? setAttributeNodeNS(Attr attr);
	// function
		
	// [CEReactions] Attr removeAttributeNode(Attr attr);
	// function
		
	// ShadowRoot attachShadow(ShadowRootInit init);
	// function
	
	// readonly attribute ShadowRoot? shadowRoot;
	console.log("element.shadowRoot = "		+element.shadowRoot);
	
	// Element? closest(DOMString selectors);
	// function
		
	// boolean matches(DOMString selectors);
	// function
		
	// boolean webkitMatchesSelector(DOMString selectors); // legacy alias of .matches
	// function
		
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	// function
		
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	// function
		
	// HTMLCollection getElementsByClassName(DOMString classNames);
	// function
		
	// [CEReactions] Element? insertAdjacentElement(DOMString where, Element element); // legacy
	// function
		
	// undefined insertAdjacentText(DOMString where, DOMString data); // legacy
	// function
	
	
	printNodeProperties(element);
}


var element = new Element();
printElementProperties(element);