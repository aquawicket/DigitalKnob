//https://developer.mozilla.org/en-US/docs/Web/API/Element

// https://dom.spec.whatwg.org/#interface-element
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
var Element = function Element(pointer) {
=======
var Element = function Element(pointer){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js

    this.pointer = pointer

    // Properties
    Object.defineProperty(this, "attributes", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function attributes() {
=======
        get: function attributes(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_attributes(pointer)
        }
    })
    Object.defineProperty(this, "classList", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function classList() {
=======
        get: function classList(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_classList(pointer)
        }
    })
    Object.defineProperty(this, "className", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function className() {
            return CPP_DKDomElement_className(pointer)
        },
        set: function className(val) {
=======
        get: function className(){
            return CPP_DKDomElement_className(pointer)
        },
        set: function className(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_className(pointer, val)
        }
    })
    Object.defineProperty(this, "clientHeight", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function clientHeight() {
=======
        get: function clientHeight(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_clientHeight(pointer)
        }
    })
    Object.defineProperty(this, "clientLeft", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function clientLeft() {
=======
        get: function clientLeft(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_clientLeft(pointer)
        }
    })
    Object.defineProperty(this, "clientTop", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function clientTop() {
=======
        get: function clientTop(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_clientTop(pointer)
        }
    })
    Object.defineProperty(this, "clientWidth", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function clientWidth() {
=======
        get: function clientWidth(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_clientWidth(pointer)
        }
    })
    Object.defineProperty(this, "computedName", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function computedName() {
=======
        get: function computedName(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_computedName(pointer)
        }
    })
    Object.defineProperty(this, "computedRole", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function computedRole() {
=======
        get: function computedRole(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_computedRole(pointer)
        }
    })
    Object.defineProperty(this, "id", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function id() {
            return CPP_DKDomElement_getAttribute(pointer, "id")
        },
        set: function id(val) {
=======
        get: function id(){
            return CPP_DKDomElement_getAttribute(pointer, "id")
        },
        set: function id(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_setAttribute(pointer, "id", val)
        }
    })
    Object.defineProperty(this, "innerHTML", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function innerHTML() {
            return CPP_DKDomElement_innerHTML(pointer)
        },
        set: function innerHTML(val) {
=======
        get: function innerHTML(){
            return CPP_DKDomElement_innerHTML(pointer)
        },
        set: function innerHTML(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_innerHTML(pointer, val)
        }
    })
    Object.defineProperty(this, "localName", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function localName() {
=======
        get: function localName(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_localName(pointer)
        }
    })
    Object.defineProperty(this, "namespaceURI", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function namespaceURI() {
=======
        get: function namespaceURI(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_namespaceURI(pointer)
        }
    })
    Object.defineProperty(this, "nextElementSibling", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function nextElementSibling() {
=======
        get: function nextElementSibling(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_nextElementSibling(pointer)
        }
    })
    Object.defineProperty(this, "outerHTML", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function outerHTML() {
            return CPP_DKDomElement_outerHTML(pointer)
        },
        set: function outerHTML(val) {
=======
        get: function outerHTML(){
            return CPP_DKDomElement_outerHTML(pointer)
        },
        set: function outerHTML(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_outerHTML(pointer, val)
        }
    })
    Object.defineProperty(this, "prefix", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function prefix() {
=======
        get: function prefix(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_prefix(pointer)
        }
    })
    Object.defineProperty(this, "previousElementSibling", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function previousElementSibling() {
=======
        get: function previousElementSibling(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_previousElementSibling(pointer)
        }
    })
    Object.defineProperty(this, "scrollHeight", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function scrollHeight() {
=======
        get: function scrollHeight(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_scrollHeight(pointer)
        }
    })
    Object.defineProperty(this, "scrollLeft", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function scrollLeft() {
            return CPP_DKDomElement_scrollLeft(pointer)
        },
        set: function scrollLeft(val) {
=======
        get: function scrollLeft(){
            return CPP_DKDomElement_scrollLeft(pointer)
        },
        set: function scrollLeft(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_scrollLeft(pointer, val)
        }
    })
    Object.defineProperty(this, "scrollLeftMax", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function scrollLeftMax() {
=======
        get: function scrollLeftMax(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_scrollLeftMax(pointer)
        }
    })
    Object.defineProperty(this, "scrollTop", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function scrollTop() {
            return CPP_DKDomElement_scrollTop(pointer)
        },
        set: function scrollTop(val) {
=======
        get: function scrollTop(){
            return CPP_DKDomElement_scrollTop(pointer)
        },
        set: function scrollTop(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_scrollTop(pointer, val)
        }
    })
    Object.defineProperty(this, "scrollTopMax", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function scrollTopMax() {
=======
        get: function scrollTopMax(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_scrollTopMax(pointer)
        }
    })
    Object.defineProperty(this, "scrollWidth", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function scrollWidth() {
=======
        get: function scrollWidth(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_scrollWidth(pointer)
        }
    })
    Object.defineProperty(this, "shadowRoot", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function shadowRoot() {
=======
        get: function shadowRoot(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_shadowRoot(pointer)
        }
    })
    Object.defineProperty(this, "openOrClosedShadowRoot", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function openOrClosedShadowRoot() {
=======
        get: function openOrClosedShadowRoot(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_openOrClosedShadowRoot(pointer)
        }
    })
    Object.defineProperty(this, "slot", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function slot() {
            return CPP_DKDomElement_slot(pointer)
        },
        set: function slot(val) {
=======
        get: function slot(){
            return CPP_DKDomElement_slot(pointer)
        },
        set: function slot(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_slot(pointer, val)
        }
    })
    Object.defineProperty(this, "tabStop", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function tabStop() {
            return CPP_DKDomElement_tabStop(pointer)
        },
        set: function tabStop(val) {
=======
        get: function tabStop(){
            return CPP_DKDomElement_tabStop(pointer)
        },
        set: function tabStop(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_tabStop(pointer, val)
        }
    })
    Object.defineProperty(this, "tagName", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function tagName() {
=======
        get: function tagName(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_tagName(pointer)
        }
    })
    Object.defineProperty(this, "undoManager", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function undoManager() {
=======
        get: function undoManager(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_undoManager(pointer)
        }
    })
    Object.defineProperty(this, "undoScope", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function undoScope() {
=======
        get: function undoScope(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_undoScope(pointer)
        }
    })
    Object.defineProperty(this, "onfullscreenchange", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function onfullscreenchange() {
            return this.fullscreenchange;
        },
        set: function onfullscreenchange(func) {
=======
        get: function onfullscreenchange(){
            return this.fullscreenchange;
        },
        set: function onfullscreenchange(func){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            this.addEventListener("fullscreenchange", func)
            this.fullscreenchange = func
        }
    })
    Object.defineProperty(this, "onfullscreenerror", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function onfullscreenerror() {
            return this.fullscreenerror;
        },
        set: function onfullscreenerror(func) {
=======
        get: function onfullscreenerror(){
            return this.fullscreenerror;
        },
        set: function onfullscreenerror(func){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            this.addEventListener("fullscreenerror", func)
            this.fullscreenerror = func
        }
    })
    Object.defineProperty(this, "value", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
        get: function value() {
            return CPP_DKDomElement_getAttribute(pointer, "value")
        },
        set: function value(val) {
=======
        get: function value(){
            return CPP_DKDomElement_getAttribute(pointer, "value")
        },
        set: function value(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
            return CPP_DKDomElement_setAttribute(pointer, "value", val)
        }
    })

    // Methods
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
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
=======
    Element.prototype.attachShadow = function attachShadow(){//TODO
    }
    Element.prototype.animate = function animate(){//TODO
    }
    Element.prototype.closest = function closest(){//TODO
    }
    Element.prototype.createShadowRoot = function createShadowRoot(){//TODO, Deprecated
    }
    Element.prototype.computedStyleMap = function computedStyleMap(){//TODO
    }
    Element.prototype.getAnimations = function getAnimations(){//TODO
    }
    Element.prototype.getAttribute = function getAttribute(attribute){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
        this[attribute] = CPP_DKDomElement_getAttribute(this.pointer, attribute)
        if (!this[attribute])
            return undefined;
        return this[attribute];
    }
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
    Element.prototype.getAttributeNames = function getAttributeNames() {//TODO
    }
    Element.prototype.getAttributeNS = function getAttributeNS() {//TODO
    }
    Element.prototype.getBoundingClientRect = function getBoundingClientRect() {//TODO
    }
    Element.prototype.getClientRects = function getClientRects() {//TODO
    }
    Element.prototype.getElementsByClassName = function getElementsByClassName(name) {
=======
    Element.prototype.getAttributeNames = function getAttributeNames(){//TODO
    }
    Element.prototype.getAttributeNS = function getAttributeNS(){//TODO
    }
    Element.prototype.getBoundingClientRect = function getBoundingClientRect(){//TODO
    }
    Element.prototype.getClientRects = function getClientRects(){//TODO
    }
    Element.prototype.getElementsByClassName = function getElementsByClassName(name){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
        var addresses = CPP_DKDomElement_getElementsByClassName(this.pointer, name)
        if (!addresses)
            return;
        return new HTMLCollection(addresses)
    }
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
    Element.prototype.getElementsByTagName = function getElementsByTagName(tag) {
=======
    Element.prototype.getElementsByTagName = function getElementsByTagName(tag){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
        var addresses = CPP_DKDomElement_getElementsByTagName(this.pointer, tag)
        if (!addresses)
            return;
        return new HTMLCollection(addresses)
    }
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
    Element.prototype.getElementsByTagNameNS = function getElementsByTagNameNS() {//TODO
    }
    Element.prototype.hasAttribute = function hasAttribute(attribute) {
=======
    Element.prototype.getElementsByTagNameNS = function getElementsByTagNameNS(){//TODO
    }
    Element.prototype.hasAttribute = function hasAttribute(attribute){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
        if (CPP_DKDomElement_hasAttribute(this.pointer, attribute))
            return true
        return false
    }
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
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
=======
    Element.prototype.hasAttributeNS = function hasAttributeNS(){//TODO
    }
    Element.prototype.hasAttributes = function hasAttributes(){//TODO
    }
    Element.prototype.insertAdjacentElement = function insertAdjacentElement(){//TODO
    }
    Element.prototype.insertAdjacentHTML = function insertAdjacentHTML(){//TODO
    }
    Element.prototype.insertAdjacentText = function insertAdjacentText(){//TODO
    }
    Element.prototype.matches = function matches(){//TODO
    }
    Element.prototype.querySelector = function querySelector(selectors){//TODO
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
		var address = CPP_DKDomElement_querySelector(this.pointer, selectors)
        if (!address)
            return;
        return new HTMLElement(address)
    }
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
    Element.prototype.querySelectorAll = function querySelectorAll(selectors) {//TODO
=======
    Element.prototype.querySelectorAll = function querySelectorAll(selectors){//TODO
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
		var addresses = CPP_DKDomElement_querySelectorAll(this.pointer, selectors)
        if (!addresses)
            return;
        return new HTMLCollection(addresses)
    }
<<<<<<< HEAD:DKPlugins/DKDom/DKDomElement.js
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
=======
    Element.prototype.releasePointerCapture = function releasePointerCapture(){//TODO
    }
    Element.prototype.remove = function remove(){//TODO
    }
    Element.prototype.removeAttribute = function removeAttribute(){
        CPP_DKDomElement_removeAttribute(this.pointer, attribute)
        //returns undefined
    }
    Element.prototype.removeAttributeNS = function removeAttributeNS(){//TODO
    }
    Element.prototype.requestFullscreen = function requestFullscreen(){//TODO
    }
    Element.prototype.requestPointerLock = function requestPointerLock(){//TODO
    }
    Element.prototype.scrollIntoView = function scrollIntoView(){//TODO
    }
    Element.prototype.setAttribute = function setAttribute(attribute, value){
        CPP_DKDomElement_setAttribute(this.pointer, attribute, value)
        this[attribute] = value;
    }
    Element.prototype.setAttributeNS = function setAttributeNS(){//TODO
    }
    Element.prototype.setCapture = function setCapture(){//TODO
    }
    Element.prototype.setPointerCapture = function setPointerCapture(){//TODO
    }
    Element.prototype.toggleAttribute = function toggleAttribute(){//TODO
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomElement.js
    }

    //GlobalEventHandlers
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

// https://dom.spec.whatwg.org/#interface-element
// interface Element : Node
Element.prototype = Node.prototype;
