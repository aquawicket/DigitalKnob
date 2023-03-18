// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Element
// [INTERFACE] https://dom.spec.whatwg.org/#interface-element


var Element = function Element(pointer) {

    this.pointer = pointer

    ////// Instance properties //////
	// [Element.assignedSlot](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/assignedSlot
    Object.defineProperty(this, "assignedSlot", {
        get: function assignedSlot() {
            return CPP_DKDomElement_assignedSlot(pointer)
        }
    })
	// [Element.attributes](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/attributes
    Object.defineProperty(this, "attributes", {
        get: function attributes() {
            return CPP_DKDomElement_attributes(pointer)
        }
    })
	/*
	// [Element.childElementCount](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/childElementCount
    Object.defineProperty(this, "childElementCount", {
        get: function childElementCount() {
            return CPP_DKDomElement_childElementCount(pointer)
        }
    })
	// [Element.children](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/children
    Object.defineProperty(this, "children", {
        get: function children() {
            return CPP_DKDomElement_children(pointer)
        }
    })
	*/
	// [Element.classList](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/classList
    Object.defineProperty(this, "classList", {
        get: function classList() {
            //domTokenList = CPP_DKDomElement_classList(pointer)
			//console.log("domTokenList = "+domTokenList)
			return new DOMTokenList(pointer)
        }
    })
	// [Element.className] https://developer.mozilla.org/en-US/docs/Web/API/Element/className
	Object.defineProperty(this, "className", {
        get: function className() {
            return CPP_DKDomElement_className(pointer)
        },
        set: function className(val) {
            return CPP_DKDomElement_className(pointer, val)
        }
    })
	// [Element.clientHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientHeight
	Object.defineProperty(this, "clientHeight", {
        get: function clientHeight() {
            return CPP_DKDomElement_clientHeight(pointer)
        }
    })
	// [Element.clientLeft](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientLeft
	Object.defineProperty(this, "clientLeft", {
        get: function clientLeft() {
            return CPP_DKDomElement_clientLeft(pointer)
        }
    })
	// [Element.clientTop](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientTop
	Object.defineProperty(this, "clientTop", {
        get: function clientTop() {
            return CPP_DKDomElement_clientTop(pointer)
        }
    })
	// [Element.clientWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientWidth
    Object.defineProperty(this, "clientWidth", {
        get: function clientWidth() {
            return CPP_DKDomElement_clientWidth(pointer)
        }
    })
	// [Element.elementTiming](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Element/elementTiming
	Object.defineProperty(this, "elementTiming", {
        get: function elementTiming() {
            return CPP_DKDomElement_elementTiming(pointer)
        }
    })
	// [Element.firstElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/firstElementChild
	Object.defineProperty(this, "firstElementChild", {
        get: function firstElementChild() {
            return CPP_DKDomElement_firstElementChild(pointer)
        }
    })
	// [Element.id] https://developer.mozilla.org/en-US/docs/Web/API/Element/id
	Object.defineProperty(this, "id", {
        get: function id() {
            return CPP_DKDomElement_getAttribute(pointer, "id")
        },
        set: function id(val) {
            return CPP_DKDomElement_setAttribute(pointer, "id", val)
        }
    })
	// [Element.innerHTML] https://developer.mozilla.org/en-US/docs/Web/API/Element/innerHTML
	Object.defineProperty(this, "innerHTML", {
        get: function innerHTML() {
            return CPP_DKDomElement_innerHTML(pointer)
        },
        set: function innerHTML(val) {
            return CPP_DKDomElement_innerHTML(pointer, val)
        }
    })
	// [Element.lastElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/lastElementChild
	Object.defineProperty(this, "lastElementChild", {
        get: function lastElementChild() {
            return CPP_DKDomElement_lastElementChild(pointer)
        }
    })
	// [Element.localName](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/localName
	Object.defineProperty(this, "localName", {
        get: function localName() {
            return CPP_DKDomElement_localName(pointer)
        }
    })
	// [Element.namespaceURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/namespaceURI
	Object.defineProperty(this, "namespaceURI", {
        get: function namespaceURI() {
            return CPP_DKDomElement_namespaceURI(pointer)
        }
    })
	// [Element.nextElementSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/nextElementSibling
	Object.defineProperty(this, "nextElementSibling", {
        get: function nextElementSibling() {
            return CPP_DKDomElement_nextElementSibling(pointer)
        }
    })
	// [Element.outerHTML] https://developer.mozilla.org/en-US/docs/Web/API/Element/outerHTML
	Object.defineProperty(this, "outerHTML", {
        get: function outerHTML() {
            return CPP_DKDomElement_outerHTML(pointer)
        },
        set: function outerHTML(val) {
            return CPP_DKDomElement_outerHTML(pointer, val)
        }
    })
	// [Element.part] https://developer.mozilla.org/en-US/docs/Web/API/Element/part
	Object.defineProperty(this, "part", {
        get: function part() {
            return CPP_DKDomElement_part(pointer)
        }
    })
	// [Element.prefix](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/prefix
	Object.defineProperty(this, "prefix", {
        get: function prefix() {
            return CPP_DKDomElement_prefix(pointer)
        }
    })
	// [Element.previousElementSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/previousElementSibling
	Object.defineProperty(this, "previousElementSibling", {
        get: function previousElementSibling() {
            return CPP_DKDomElement_previousElementSibling(pointer)
        }
    })
	// [Element.scrollHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollHeight
	Object.defineProperty(this, "scrollHeight", {
        get: function scrollHeight() {
            return CPP_DKDomElement_scrollHeight(pointer)
        }
    })
	// [Element.scrollLeft] https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollLeft
	Object.defineProperty(this, "scrollLeft", {
        get: function scrollLeft() {
            return CPP_DKDomElement_scrollLeft(pointer)
        },
        set: function scrollLeft(val) {
            return CPP_DKDomElement_scrollLeft(pointer, val)
        }
    })
	// [Element.scrollLeftMax](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollLeftMax
	Object.defineProperty(this, "scrollLeftMax", {
        get: function scrollLeftMax() {
            return CPP_DKDomElement_scrollLeftMax(pointer)
        }
    })
	// [Element.scrollTop] https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollTop
	Object.defineProperty(this, "scrollTop", {
        get: function scrollTop() {
            return CPP_DKDomElement_scrollTop(pointer)
        },
        set: function scrollTop(val) {
            return CPP_DKDomElement_scrollTop(pointer, val)
        }
    })
	// [Element.scrollTopMax](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollTopMax
	Object.defineProperty(this, "scrollTopMax", {
        get: function scrollTopMax() {
            return CPP_DKDomElement_scrollTopMax(pointer)
        }
    })
	// [Element.scrollWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollWidth
	Object.defineProperty(this, "scrollWidth", {
        get: function scrollWidth() {
            return CPP_DKDomElement_scrollWidth(pointer)
        }
    })
	// [Element.shadowRoot](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/shadowRoot
	Object.defineProperty(this, "shadowRoot", {
        get: function shadowRoot() {
            return CPP_DKDomElement_shadowRoot(pointer)
        }
    })
	// [Element.slot] https://developer.mozilla.org/en-US/docs/Web/API/Element/slot
	Object.defineProperty(this, "slot", {
        get: function slot() {
            return CPP_DKDomElement_slot(pointer)
        },
        set: function slot(val) {
            return CPP_DKDomElement_slot(pointer, val)
        }
    })
	// [Element.tagName](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/tagName
	Object.defineProperty(this, "tagName", {
        get: function tagName() {
            return CPP_DKDomElement_tagName(pointer)
        }
    })
	
	
	////// Instance properties included from ARIA //////
	// TODO
	
	
	////// Instance methods //////
	// [Element.after()]
	// [Element.attachShadow()]
	// [Element.animate()]
	// [Element.append()]
	// [Element.before()]
	// [Element.closest()]
	// [Element.computedStyleMap()]
	// [Element.getAnimations()]
	// [Element.getAttribute()]
	// [Element.getAttributeNames()]
	// [Element.getAttributeNode()]
	// [Element.getAttributeNodeNS()]
	// [Element.getAttributeNS()]
	// [Element.getBoundingClientRect()]
	// [Element.getBoxQuads()](Experimental)
	// [Element.getClientRects()]
	// [Element.getElementsByClassName()]
	// [Element.getElementsByTagName()]
	// [Element.getElementsByTagNameNS()]
	// [Element.hasAttribute()]
	// [Element.hasAttributeNS()]
	// [Element.hasAttributes()]
	// [Element.hasPointerCapture()]
	// [Element.insertAdjacentElement()]
	// [Element.insertAdjacentHTML()]
	// [Element.insertAdjacentText()]
	// [Element.matches()]
	// [Element.prepend()]
	// [Element.querySelector()]
	// [Element.querySelectorAll()]
	// [Element.releasePointerCapture()]
	// [Element.remove()]
	// [Element.removeAttribute()]
	// [Element.removeAttributeNode()]
	// [Element.removeAttributeNS()]
	// [Element.replaceChildren()]
	// [Element.replaceWith()]
	// [Element.requestFullscreen()]
	// [Element.requestPointerLock()]
	// [Element.scroll()]
	// [Element.scrollBy()]
	// [Element.scrollIntoView()]
	// [Element.scrollIntoViewIfNeeded()](Non-standard)
	// [Element.scrollTo()]
	// [Element.setAttribute()]
	// [Element.setAttributeNode()]
	// [Element.setAttributeNodeNS()]
	// [Element.setAttributeNS()]
	// [Element.setCapture()](Non-standard)(Deprecated)
	// [Element.setHTML()](Experimental)
	// [Element.setPointerCapture()]
	// [Element.toggleAttribute()]

	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    Object.defineProperty(this, "computedName", {
        get: function computedName() {
            return CPP_DKDomElement_computedName(pointer)
        }
    })
    Object.defineProperty(this, "computedRole", {
        get: function computedRole() {
            return CPP_DKDomElement_computedRole(pointer)
        }
    })
    
    Object.defineProperty(this, "openOrClosedShadowRoot", {
        get: function openOrClosedShadowRoot() {
            return CPP_DKDomElement_openOrClosedShadowRoot(pointer)
        }
    })
    Object.defineProperty(this, "tabStop", {
        get: function tabStop() {
            return CPP_DKDomElement_tabStop(pointer)
        },
        set: function tabStop(val) {
            return CPP_DKDomElement_tabStop(pointer, val)
        }
    })
    Object.defineProperty(this, "undoManager", {
        get: function undoManager() {
            return CPP_DKDomElement_undoManager(pointer)
        }
    })
    Object.defineProperty(this, "undoScope", {
        get: function undoScope() {
            return CPP_DKDomElement_undoScope(pointer)
        }
    })
    Object.defineProperty(this, "onfullscreenchange", {
        get: function onfullscreenchange() {
            return this.fullscreenchange;
        },
        set: function onfullscreenchange(func) {
            this.addEventListener("fullscreenchange", func)
            this.fullscreenchange = func
        }
    })
    Object.defineProperty(this, "onfullscreenerror", {
        get: function onfullscreenerror() {
            return this.fullscreenerror;
        },
        set: function onfullscreenerror(func) {
            this.addEventListener("fullscreenerror", func)
            this.fullscreenerror = func
        }
    })
    Object.defineProperty(this, "value", {
        get: function value() {
            return CPP_DKDomElement_getAttribute(pointer, "value")
        },
        set: function value(val) {
            return CPP_DKDomElement_setAttribute(pointer, "value", val)
        }
    })

    // Methods
    Element.prototype.attachShadow = function attachShadow() {//TODO
    }
    Element.prototype.animate = function animate() {//TODO
    }
    Element.prototype.closest = function closest() {//TODO
    }
    Element.prototype.createShadowRoot = function createShadowRoot() {//TODO, Deprecated
    }
    Element.prototype.computedStyleMap = function computedStyleMap() {//TODO
    }
    Element.prototype.getAnimations = function getAnimations() {//TODO
    }
    Element.prototype.getAttribute = function getAttribute(attribute) {
        this[attribute] = CPP_DKDomElement_getAttribute(this.pointer, attribute)
        if (!this[attribute])
            return undefined;
        return this[attribute];
    }
    Element.prototype.getAttributeNames = function getAttributeNames() {//TODO
    }
    Element.prototype.getAttributeNS = function getAttributeNS() {//TODO
    }
    Element.prototype.getBoundingClientRect = function getBoundingClientRect() {//TODO
    }
    Element.prototype.getClientRects = function getClientRects() {//TODO
    }
    Element.prototype.getElementsByClassName = function getElementsByClassName(name) {
        var addresses = CPP_DKDomElement_getElementsByClassName(this.pointer, name)
        if (!addresses)
            return;
        return new HTMLCollection(addresses)
    }
    Element.prototype.getElementsByTagName = function getElementsByTagName(tag) {
        var addresses = CPP_DKDomElement_getElementsByTagName(this.pointer, tag)
        if (!addresses)
            return;
        return new HTMLCollection(addresses)
    }
    Element.prototype.getElementsByTagNameNS = function getElementsByTagNameNS() {//TODO
    }
    Element.prototype.hasAttribute = function hasAttribute(attribute) {
        if (CPP_DKDomElement_hasAttribute(this.pointer, attribute))
            return true
        return false
    }
    Element.prototype.hasAttributeNS = function hasAttributeNS() {//TODO
    }
    Element.prototype.hasAttributes = function hasAttributes() {//TODO
    }
    Element.prototype.insertAdjacentElement = function insertAdjacentElement() {//TODO
    }
    Element.prototype.insertAdjacentHTML = function insertAdjacentHTML() {//TODO
    }
    Element.prototype.insertAdjacentText = function insertAdjacentText() {//TODO
    }
    Element.prototype.matches = function matches() {//TODO
    }
    Element.prototype.querySelector = function querySelector(selectors) {//TODO
		var address = CPP_DKDomElement_querySelector(this.pointer, selectors)
        if (!address)
            return;
        return new HTMLElement(address)
    }
    Element.prototype.querySelectorAll = function querySelectorAll(selectors) {//TODO
		var addresses = CPP_DKDomElement_querySelectorAll(this.pointer, selectors)
        if (!addresses)
            return;
        return new HTMLCollection(addresses)
    }
    Element.prototype.releasePointerCapture = function releasePointerCapture() {//TODO
    }
    Element.prototype.remove = function remove() {//TODO
    }
    Element.prototype.removeAttribute = function removeAttribute() {
        CPP_DKDomElement_removeAttribute(this.pointer, attribute)
        //returns undefined
    }
    Element.prototype.removeAttributeNS = function removeAttributeNS() {//TODO
    }
    Element.prototype.requestFullscreen = function requestFullscreen() {//TODO
    }
    Element.prototype.requestPointerLock = function requestPointerLock() {//TODO
    }
    Element.prototype.scrollIntoView = function scrollIntoView() {//TODO
    }
    Element.prototype.setAttribute = function setAttribute(attribute, value) {
        CPP_DKDomElement_setAttribute(this.pointer, attribute, value)
        this[attribute] = value;
    }
    Element.prototype.setAttributeNS = function setAttributeNS() {//TODO
    }
    Element.prototype.setCapture = function setCapture() {//TODO
    }
    Element.prototype.setPointerCapture = function setPointerCapture() {//TODO
    }
    Element.prototype.toggleAttribute = function toggleAttribute() {//TODO
    }

	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object Element]"
		}
	}
	
    return Node.call(this, pointer)

    /*
	return new Proxy(this, {
	//const proxy = new Proxy(this, {
		has: function Proxy(target, key){
			//console.log("Element:has("+key+")")
			return key in target;
		},
		get: function Proxy(target, key, recv){
			//console.log("Element:get("+key+")")
			if(typeof target[key] === "function" || key === "pointer" || key === "style" || key === "listeners" || key === "create"){ 
				//console.log("tyoeof target[key] === "+typeof target[key])
				return target[key]; 
			}
			else{
				target[key] = CPP_DKDomElement_getAttribute(target["pointer"], key)
			}
			return target[key];
		},
		set: function Proxy(target, key, val, recv){
			//console.log("Element:set("+key+")")
			if(typeof target[key] === "function" || key === "pointer" || key === "style" || key === "listeners" || key === "create"){ 
				//console.warn("tyoeof target[key] === "+typeof target[key])
				return true; 
			}
			else{
				console.log("CPP_DKDomElement_setAttribute(target[pointer], "+key+", "+val+")")
				CPP_DKDomElement_setAttribute(target["pointer"], key, val)
			}
			target[key] = val;
			return true;
		},
		deleteProperty: function Proxy(target, key){
			//console.log("Element:deleteProperty("+key+")")
			delete target[key];
			return true;
		}
	})
	*/
}
Element.prototype = Node.prototype;
