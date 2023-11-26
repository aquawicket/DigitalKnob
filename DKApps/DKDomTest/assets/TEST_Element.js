// [IDL] https://dom.spec.whatwg.org/#interface-element
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Element
console.log("\n////// TEST_Element.js //////")


function printElementProperties(element){

	console.log("element = "						+element);
	
	// readonly attribute DOMString? namespaceURI;
	console.log("element.namespaceURI = "			+element.namespaceURI);
	
	// readonly attribute DOMString? prefix;
	console.log("element.prefix = "					+element.prefix);
	
	// readonly attribute DOMString localName;
	console.log("element.localName = "				+element.localName);
	
	// readonly attribute DOMString tagName;
	console.log("element.tagName = "				+element.tagName);
	
	// [CEReactions] attribute DOMString id;
	console.log("element.id = "						+element.id);
	
	// [CEReactions] attribute DOMString className;
	console.log("element.className = "				+element.className);
	
	// [SameObject, PutForwards=value] readonly attribute DOMTokenList classList;
	console.log("element.classList = "				+element.classList);
	
	//[CEReactions, Unscopable] attribute DOMString slot;
	console.log("element.slot = "					+element.slot);
	
	// boolean hasAttributes();
	console.log("element.hasAttributes = "			+element.hasAttributes);
	
	// [SameObject] readonly attribute NamedNodeMap attributes;
	console.log("element.attributes = "				+element.attributes);
	
	// sequence<DOMString> getAttributeNames();
	console.log("element.getAttributeNames = "		+element.getAttributeNames);
		
	// DOMString? getAttribute(DOMString qualifiedName);
	console.log("element.getAttribute = "			+element.getAttribute);
		
	// DOMString? getAttributeNS(DOMString? namespace, DOMString localName);
	console.log("element.getAttributeNS = "			+element.getAttributeNS);
		
	// [CEReactions] undefined setAttribute(DOMString qualifiedName, DOMString value);
	console.log("element.setAttribute = "			+element.setAttribute);
		
	// [CEReactions] undefined setAttributeNS(DOMString? namespace, DOMString qualifiedName, DOMString value);
	console.log("element.setAttributeNS = "			+element.setAttributeNS);
		
	// [CEReactions] undefined removeAttribute(DOMString qualifiedName);
	console.log("element.removeAttribute = "		+element.removeAttribute);
		
	// [CEReactions] undefined removeAttributeNS(DOMString? namespace, DOMString localName);
	console.log("element.removeAttributeNS = "		+element.removeAttributeNS);
		
	// [CEReactions] boolean toggleAttribute(DOMString qualifiedName, optional boolean force);
	console.log("element.toggleAttribute = "		+element.toggleAttribute);
		
	// boolean hasAttribute(DOMString qualifiedName);
	console.log("element.hasAttribute = "			+element.hasAttribute);
		
	// boolean hasAttributeNS(DOMString? namespace, DOMString localName);
	console.log("element.hasAttributeNS = "			+element.hasAttributeNS);
		
	// Attr? getAttributeNode(DOMString qualifiedName);
	console.log("element.getAttributeNode = "		+element.getAttributeNode);
		
	// Attr? getAttributeNodeNS(DOMString? namespace, DOMString localName);
	console.log("element.getAttributeNodeNS = "		+element.getAttributeNodeNS);
		
	// [CEReactions] Attr? setAttributeNode(Attr attr);
	console.log("element.setAttributeNode = "		+element.setAttributeNode);
		
	// [CEReactions] Attr? setAttributeNodeNS(Attr attr);
	console.log("element.setAttributeNodeNS = "		+element.setAttributeNodeNS);
		
	// [CEReactions] Attr removeAttributeNode(Attr attr);
	console.log("element.removeAttributeNode = "	+element.removeAttributeNode);
		
	// ShadowRoot attachShadow(ShadowRootInit init);
	console.log("element.attachShadow = "			+element.attachShadow);
	
	// readonly attribute ShadowRoot? shadowRoot;
	console.log("element.shadowRoot = "				+element.shadowRoot);
	
	// Element? closest(DOMString selectors);
	console.log("element.closest = "				+element.closest);
		
	// boolean matches(DOMString selectors);
	console.log("element.matches = "				+element.matches);
		
	// boolean webkitMatchesSelector(DOMString selectors); // legacy alias of .matches
	console.log("element.webkitMatchesSelector = "	+element.webkitMatchesSelector);
		
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	console.log("element.getElementsByTagName = "	+element.getElementsByTagName);
		
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	console.log("element.getElementsByTagNameNS = "	+element.getElementsByTagNameNS);
		
	// HTMLCollection getElementsByClassName(DOMString classNames);
	console.log("element.getElementsByClassName = "	+element.getElementsByClassName);
		
	// [CEReactions] Element? insertAdjacentElement(DOMString where, Element element); // legacy
	console.log("element.insertAdjacentElement = "	+element.insertAdjacentElement);
		
	// undefined insertAdjacentText(DOMString where, DOMString data); // legacy
	console.log("element.insertAdjacentText = "		+element.insertAdjacentText);
	
	printNodeProperties(element);
}


var element = new Element();
printElementProperties(element);