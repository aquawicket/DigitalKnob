// [IDL] https://dom.spec.whatwg.org/#interface-element
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Element

// [Exposed=Window]
// interface Element : Node {
var Element = function Element(address) {
	console.log("Element("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKElementDUK_constructor();

	// readonly attribute DOMString? namespaceURI;
	Object.defineProperty(this, "namespaceURI", {
        get: function namespaceURI()					{ return CPP_DKElementDUK_namespaceURI(this.address) },
		//set: function namespaceURI(data)				{ return CPP_DKElementDUK_namespaceURI(this.address, data) },
		//configurable: true,
    })

	// readonly attribute DOMString? prefix;
	Object.defineProperty(this, "prefix", {
        get: function prefix()							{ return CPP_DKElementDUK_prefix(this.address) },
		//set: function prefix(data)					{ return CPP_DKElementDUK_prefix(this.address, data) },
		//configurable: true,
    })
	
	// readonly attribute DOMString localName;
	Object.defineProperty(this, "localName", {
        get: function localName()						{ return CPP_DKElementDUK_localName(this.address) },
		//set: function localName(data)					{ return CPP_DKElementDUK_localName(this.address, data) },
		//configurable: true,
    })
	
	// readonly attribute DOMString tagName;
	Object.defineProperty(this, "tagName", {
        get: function tagName()							{ return CPP_DKElementDUK_tagName(this.address) },
		//set: function tagName(data)					{ return CPP_DKElementDUK_tagName(this.address, data) },
		//configurable: true,
    })
	
	// [CEReactions] attribute DOMString id;
	Object.defineProperty(this, "id", {
        get: function id()								{ return CPP_DKElementDUK_id(this.address) },
		set: function id(data)							{ return CPP_DKElementDUK_id(this.address, data) },
		//configurable: true,
    })
	
	// [CEReactions] attribute DOMString className;
	Object.defineProperty(this, "className", {
        get: function className()						{ return CPP_DKElementDUK_className(this.address) },
		set: function className(data)					{ return CPP_DKElementDUK_className(this.address, data) },
		//configurable: true,
    })
	
	// [SameObject, PutForwards=value] readonly attribute DOMTokenList classList;
	Object.defineProperty(this, "classList", {
        get: function classList()						{ return CPP_DKElementDUK_classList(this.address) },
		//set: function classList(data)					{ return CPP_DKElementDUK_classList(this.address, data) },
		//configurable: true,
    })

	//[CEReactions, Unscopable] attribute DOMString slot;
	Object.defineProperty(this, "slot", {
        get: function slot()							{ return CPP_DKElementDUK_slot(this.address) },
		set: function slot(data)						{ return CPP_DKElementDUK_slot(this.address, data) },
		//configurable: true,
    })
	
	// boolean hasAttributes();
	Element.prototype.hasAttributes = function hasAttributes() {
        return CPP_DKElementDUK_hasAttributes(this.address);
    }
	
	// [SameObject] readonly attribute NamedNodeMap attributes;
	Object.defineProperty(this, "attributes", {
        get: function attributes()						{ return CPP_DKElementDUK_attributes(this.address) },
		//set: function attributes(data)				{ return CPP_DKElementDUK_attributes(this.address, data) },
		//configurable: true,
    })
	
	// sequence<DOMString> getAttributeNames();
	Element.prototype.getAttributeNames = function getAttributeNames() {
        return CPP_DKElementDUK_getAttributeNames(this.address);
    }
	
	// DOMString? getAttribute(DOMString qualifiedName);
	Element.prototype.getAttribute = function getAttribute() {
        return CPP_DKElementDUK_getAttribute(this.address);
    }
	
	// DOMString? getAttributeNS(DOMString? namespace, DOMString localName);
	Element.prototype.getAttributeNS = function getAttributeNS(namespace, localName) {
        return CPP_DKElementDUK_getAttributeNS(this.address, namespace, localName);
    }
	
	// [CEReactions] undefined setAttribute(DOMString qualifiedName, DOMString value);
	Element.prototype.setAttribute = function setAttribute(qualifiedName, value) {
        CPP_DKElementDUK_setAttribute(this.address, qualifiedName, value);
    }
	
	// [CEReactions] undefined setAttributeNS(DOMString? namespace, DOMString qualifiedName, DOMString value);
	Element.prototype.setAttributeNS = function setAttributeNS(namespace, qualifiedName, value) {
        CPP_DKElementDUK_setAttributeNS(this.address, namespace, qualifiedName, value);
    }
	
	// [CEReactions] undefined removeAttribute(DOMString qualifiedName);
	Element.prototype.removeAttribute = function removeAttribute(qualifiedName) {
        CPP_DKElementDUK_removeAttribute(this.address, qualifiedName);
    }
	
	// [CEReactions] undefined removeAttributeNS(DOMString? namespace, DOMString localName);
	Element.prototype.removeAttributeNS = function removeAttributeNS(namespace, localName) {
        CPP_DKElementDUK_removeAttributeNS(this.address, namespace, localName);
    }
	
	// [CEReactions] boolean toggleAttribute(DOMString qualifiedName, optional boolean force);
	Element.prototype.toggleAttribute = function toggleAttribute(qualifiedName, force) {
        return CPP_DKElementDUK_toggleAttribute(this.address, qualifiedName, force);
    }
	
	// boolean hasAttribute(DOMString qualifiedName);
	Element.prototype.hasAttribute = function hasAttribute(qualifiedName) {
        return CPP_DKElementDUK_hasAttribute(this.address, qualifiedName);
    }
	
	// boolean hasAttributeNS(DOMString? namespace, DOMString localName);
	Element.prototype.hasAttributeNS = function hasAttributeNS(namespace, localName) {
        return CPP_DKElementDUK_hasAttributeNS(this.address, namespace, localName);
    }
	
	// Attr? getAttributeNode(DOMString qualifiedName);
	Element.prototype.getAttributeNode = function getAttributeNode(qualifiedName) {
        return CPP_DKElementDUK_getAttributeNode(this.address, qualifiedName);
    }
	
	// Attr? getAttributeNodeNS(DOMString? namespace, DOMString localName);
	Element.prototype.getAttributeNodeNS = function getAttributeNodeNS(namespace, localName) {
        return CPP_DKElementDUK_getAttributeNodeNS(this.address, namespace, localName);
    }
	
	// [CEReactions] Attr? setAttributeNode(Attr attr);
	Element.prototype.setAttributeNode = function setAttributeNode(attr) {
        return CPP_DKElementDUK_setAttributeNode(this.address, attr);
    }
	
	// [CEReactions] Attr? setAttributeNodeNS(Attr attr);
	Element.prototype.setAttributeNodeNS = function setAttributeNodeNS(attr) {
        return CPP_DKElementDUK_setAttributeNodeNS(this.address, attr);
    }
	
	// [CEReactions] Attr removeAttributeNode(Attr attr);
	Element.prototype.removeAttributeNode = function removeAttributeNode(attr) {
        return CPP_DKElementDUK_removeAttributeNode(this.address, attr);
    }
	
	// ShadowRoot attachShadow(ShadowRootInit init);
	Element.prototype.attachShadow = function attachShadow(init) {
        return CPP_DKElementDUK_attachShadow(this.address, init);
    }
	
	// readonly attribute ShadowRoot? shadowRoot;
	Object.defineProperty(this, "shadowRoot", {
        get: function shadowRoot()						{ return CPP_DKElementDUK_shadowRoot(this.address) },
		//set: function shadowRoot(data)				{ return CPP_DKElementDUK_shadowRoot(this.address, data) },
		//configurable: true,
    })
	
	// Element? closest(DOMString selectors);
	Element.prototype.closest = function closest(selectors) {
        return new Element(CPP_DKElementDUK_closest(this.address, selectors));
    }
	
	// boolean matches(DOMString selectors);
	Element.prototype.matches = function matches(selectors) {
        return CPP_DKElementDUK_matches(this.address, selectors);
    }
	
	// boolean webkitMatchesSelector(DOMString selectors); // legacy alias of .matches
	Element.prototype.webkitMatchesSelector = function webkitMatchesSelector(selectors) {
        return CPP_DKElementDUK_webkitMatchesSelector(this.address, selectors);
    }
	
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	Element.prototype.getElementsByTagName = function getElementsByTagName(qualifiedName) {
        return new HTMLCollection(CPP_DKElementDUK_getElementsByTagName(this.address, qualifiedName));
    }
	
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	Element.prototype.getElementsByTagNameNS = function getElementsByTagNameNS(namespace, localName) {
        return new HTMLCollection(CPP_DKElementDUK_getElementsByTagNameNS(this.address, namespace, localName));
    }
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	Element.prototype.getElementsByClassName = function getElementsByClassName(classNames) {
        return new HTMLCollection(CPP_DKElementDUK_getElementsByClassName(this.address, classNames));
    }
	
	// [CEReactions] Element? insertAdjacentElement(DOMString where, Element element); // legacy
	Element.prototype.insertAdjacentElement = function insertAdjacentElement(where, element) {
        return new Element(CPP_DKElementDUK_insertAdjacentElement(this.address, where, element));
    }
	
	// undefined insertAdjacentText(DOMString where, DOMString data); // legacy
	Element.prototype.insertAdjacentText = function insertAdjacentText(where, data) {
        return CPP_DKElementDUK_insertAdjacentText(this.address, where, data);
    }
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Element]" }
	
	return Node.call(this, this.address);
}
Element.prototype = Node.prototype
