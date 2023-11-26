// https://developer.mozilla.org/en-US/docs/Web/API/Document

// https://dom.spec.whatwg.org/#interface-document
var Document = function Document(pointer) 
{
    this.pointer = pointer;
    // Properties
    //TODO
    Object.defineProperty(this, "activeElement", {
        get: function activeElement() {
            var address = CPP_DKDomDocument_activeElement()
            if (!address)
                return;
            return new Element(address)
        },
    })
    Object.defineProperty(this, "body", {
        get: function body() {
            var address = CPP_DKDomDocument_body()
            if (!address)
                return;
            return new HTMLElement(address)
        },
        set: function body() {
            if (!address)
                return;
            return CPP_DKDomDocument_body(address)
            //TODO
        }
    })
    //TODO
    Object.defineProperty(this, "characterSet", {
        get: function characterSet() {
            var address = CPP_DKDomDocument_characterSet()
            if (!address)
                return;
            return new Element(address)
        },
    })
    //TODO
    Object.defineProperty(this, "childElementCount", {
        get: function childElementCount() {
            var address = CPP_DKDomDocument_childElementCount()
            if (!address)
                return;
            return new Element(address)
        },
    })
    //TODO
    Object.defineProperty(this, "children", {
        get: function children() {
            var address = CPP_DKDomDocument_children()
            if (!address)
                return;
            return new Element(address)
        },
    })
    //TODO
    Object.defineProperty(this, "capatMode", {
        get: function capatMode() {
            var address = CPP_DKDomDocument_capatMode()
            if (!address)
                return;
            return new Element(address)
        },
    })
    //TODO
    //contentType 
    //doctype
    Object.defineProperty(this, "documentElement", {
        get: function documentElement() {
            var address = CPP_DKDomDocument_documentElement()
            if (!address)
                return;
            return new HTMLElement(address)
        }
    })
    /*
    //TODO
    Document.documentURI
    Document.embeds
    Document.firstElementChild
    Document.fonts
    Document.forms
    Document.fullscreenElement
    Document.head
    Document.hidden
    Document.images
    Document.implementation
    Document.lastElementChild
    Document.links
    Document.mozSyntheticDocument
    Document.pictureInPictureElement
    Document.pictureInPictureEnabled
    Document.plugins
    Document.pointerLockElement
    Document.featurePolicy
    Document.scriptsRead
    Document.scrollingElement
    Document.styleSheets
    Document.timeline
    Document.visibilityState
     */  

    // Methods
    Document.prototype.createElement = function createElement(tag) {
        var address = CPP_DKDomDocument_createElement(tag)
        if (!address)
            return undefined;
		if (tag == "img")
			return new HTMLImageElement(address)
		if (tag == "script")
			return new HTMLScriptElement(address)
		if (tag == "span")
			return new HTMLSpanElement(address)
        return new HTMLElement(address)
    }
    Document.prototype.getElementById = function getElementById(id) {
        var address = CPP_DKDomDocument_getElementById(id)
        if (!address)
            return undefined;
        var element = new HTMLElement(address)
		if(element.tag === "img")
			return new HTMLImageElement(address)
		if(element.tag === "script")
			return new HTMLScriptElement(address)
		if(element.tag == "span")
			return new HTMLSpanElement(address)
		return new HTMLElement(address)
    }
    Document.prototype.getElementsByTagName = function getElementsByTagName(tag) {
        var addresses = CPP_DKDomDocument_getElementsByTagName(tag)
        if (!addresses)
            return;
        return new HTMLCollection(addresses)
    }
    //return Node.call(this, pointer)
    return HTMLElement.call(this, pointer)
    //we have to call HTMLElement instead of Node for .style to work
}

// https://dom.spec.whatwg.org/#interface-document
//interface Document : Node
Document.prototype = Node.prototype;
//mixin
Object.assign(Document.prototype, DocumentOrShadowRoot)
//mixin
Object.assign(Document.prototype, GlobalEventHandlers)

//var document = new Document(CPP_DKDomDocument_documentElement()) //Created in cpp from DKRml
//window.document = document
