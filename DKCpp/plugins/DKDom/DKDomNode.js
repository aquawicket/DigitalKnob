// https://developer.mozilla.org/en-US/docs/Web/API/Node

// https://dom.spec.whatwg.org/#interface-node
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
var Node = function Node(pointer) {
    Object.defineProperty(this, "baseURI", {
        get: function baseURI() {
=======
var Node = function Node(pointer){
    Object.defineProperty(this, "baseURI", {
        get: function baseURI(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
            return CPP_DKDomNode_baseURI(this.pointer)
        }
    })
    Object.defineProperty(this, "baseURIObject", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
        get: function baseURIObject() {
=======
        get: function baseURIObject(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
            return CPP_DKDomNode_baseURIObject(this.pointer)
        }
    })
    Object.defineProperty(this, "childNodes", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
        get: function childNodes() {
=======
        get: function childNodes(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
            var addressList = CPP_DKDomNode_childNodes(pointer)
            return new HTMLCollection(addressList)
            //TODO - switch htmlCollection over to NodeList	
        }
    })
    Object.defineProperty(this, "firstChild", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
        get: function firstChild() {
=======
        get: function firstChild(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
            var address = CPP_DKDomNode_firstChild(this.pointer)
            if (!address)
                return;
            return new HTMLElement(address)
        }
    })
    Object.defineProperty(this, "isConnected", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
        get: function isConnected() {
=======
        get: function isConnected(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
            return CPP_DKDomNode_isConnected(this.pointer)
        }
    })
    Object.defineProperty(this, "lastChild", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
        get: function lastChild() {
=======
        get: function lastChild(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
            var address = CPP_DKDomNode_lastChild(this.pointer)
            if (!address)
                return;
            return new HTMLElement(address)
        }
    })
    Object.defineProperty(this, "nextSibling", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
        get: function nextSibling() {
=======
        get: function nextSibling(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
            var address = CPP_DKDomNode_nextSibling(this.pointer)
			if (!address)
                return;
            return new HTMLElement(address)
        }
    })
    Object.defineProperty(this, "nodeName", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
        get: function nodeName() {
=======
        get: function nodeName(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
            return CPP_DKDomNode_nodeName(this.pointer)
        }
    })
    Object.defineProperty(this, "nodePrincipal", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
        get: function nodePrincipal() {
=======
        get: function nodePrincipal(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
            return CPP_DKDomNode_nodePrincipal(this.pointer)
        }
    })
    Object.defineProperty(this, "nodeType", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
        get: function nodeType() {
=======
        get: function nodeType(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
            return CPP_DKDomNode_nodeType(this.pointer)
        }
    })
    Object.defineProperty(this, "nodeValue", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
        get: function nodeValue() {
=======
        get: function nodeValue(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
            return CPP_DKDomNode_nodeValue(this.pointer)
        },
        set: function(val){
            return CPP_DKDomNode_nodeValue(this.pointer, val)
        }
    })
    Object.defineProperty(this, "ownerDocument", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
        get: function ownerDocument() {
=======
        get: function ownerDocument(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
            var address = CPP_DKDomNode_ownerDocument(this.pointer)
			if (!address)
                return;
            return new HTMLElement(address)
        }
    })
    Object.defineProperty(this, "parentNode", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
        get: function parentNode() {
=======
        get: function parentNode(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
            var address = CPP_DKDomNode_parentNode(this.pointer)
            if (!address)
                return;
            return new HTMLElement(address)
        }
    })
    Object.defineProperty(this, "parentElement", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
        get: function parentElement() {
=======
        get: function parentElement(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
            return CPP_DKDomNode_parentElement(this.pointer)
        }
    })
    Object.defineProperty(this, "previousSibling", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
        get: function previousSibling() {
=======
        get: function previousSibling(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
			var address = CPP_DKDomNode_previousSibling(this.pointer)
			if (!address)
                return;
            return new HTMLElement(address)
        }
    })
    Object.defineProperty(this, "textContent", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
        get: function textContent() {
            return CPP_DKDomNode_textContent(this.pointer)
        },
        set: function textContent(val) {
=======
        get: function textContent(){
            return CPP_DKDomNode_textContent(this.pointer)
        },
        set: function textContent(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
            return CPP_DKDomNode_textContent(this.pointer, val)
        }
    })
    Object.defineProperty(this, "rootNode", {
        //Deprecated
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
        get: function rootNode() {
=======
        get: function rootNode(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
            return CPP_DKDomNode_rootNode(this.pointer)
        }
    })

    // Methods
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
    Node.prototype.appendChild = function appendChild(child) {
=======
    Node.prototype.appendChild = function appendChild(child){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
        var address = CPP_DKDomNode_appendChild(this.pointer, child.pointer)
        if (!address)
            return;
        return new HTMLElement(address)
    }
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
    Node.prototype.cloneNode = function cloneNode() {
		//TODO
    }
    Node.prototype.compareDocumentPosition = function compareDocumentPosition() {
		//TODO
    }
    Node.prototype.contains = function contains(node) {
        var contains = CPP_DKDomNode_contains(this.pointer, node.pointer)
        return contains;
    }
    Node.prototype.getRootNode = function getRootNode() {
		//TODO
    }
    Node.prototype.hasChildNodes = function hasChildNodes() {
		//TODO
    }
    Node.prototype.insertBefore = function insertBefore() {
		//TODO
    }
    Node.prototype.isDefaultNamespace = function isDefaultNamespace() {
		//TODO
    }
    Node.prototype.isEqualNode = function isEqualNode() {
		//TODO
    }
    Node.prototype.isSameNode = function isSameNode() {
		//TODO
    }
    Node.prototype.lookupPrefix = function lookupPrefix() {
		//TODO
    }
    Node.prototype.lookupNamespaceURI = function lookupNamespaceURI() {
		//TODO
    }
    Node.prototype.normalize = function normalize() {
		//TODO
    }
    Node.prototype.removeChild = function removeChild(child) {
=======
    Node.prototype.cloneNode = function cloneNode(){
		//TODO
    }
    Node.prototype.compareDocumentPosition = function compareDocumentPosition(){
		//TODO
    }
    Node.prototype.contains = function contains(node){
        var contains = CPP_DKDomNode_contains(this.pointer, node.pointer)
        return contains;
    }
    Node.prototype.getRootNode = function getRootNode(){
		//TODO
    }
    Node.prototype.hasChildNodes = function hasChildNodes(){
		//TODO
    }
    Node.prototype.insertBefore = function insertBefore(){
		//TODO
    }
    Node.prototype.isDefaultNamespace = function isDefaultNamespace(){
		//TODO
    }
    Node.prototype.isEqualNode = function isEqualNode(){
		//TODO
    }
    Node.prototype.isSameNode = function isSameNode(){
		//TODO
    }
    Node.prototype.lookupPrefix = function lookupPrefix(){
		//TODO
    }
    Node.prototype.lookupNamespaceURI = function lookupNamespaceURI(){
		//TODO
    }
    Node.prototype.normalize = function normalize(){
		//TODO
    }
    Node.prototype.removeChild = function removeChild(child){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
		//console.log("this.pointer = "+this.pointer)
		//console.log("child.pointer = "+child.pointer)
        var address = CPP_DKDomNode_removeChild(this.pointer, child.pointer)
        if (!address)
            return null;
        //var node = Node(pointer)
        //return node;
    }
<<<<<<< HEAD:DKPlugins/DKDom/DKDomNode.js
    Node.prototype.replaceChild = function replaceChild() {
=======
    Node.prototype.replaceChild = function replaceChild(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomNode.js
		//TODO
    }

    return EventTarget.call(this, pointer)
};

// https://dom.spec.whatwg.org/#interface-node
//interface Node : EventTarget
Node.prototype = EventTarget.prototype;
