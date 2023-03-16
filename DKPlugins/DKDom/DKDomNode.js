// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Node
// [INTERFACE] https://dom.spec.whatwg.org/#interface-node


var Node = function Node(pointer) {
	
	////// Instance properties //////
    Object.defineProperty(this, "baseURI", {
        get: function baseURI() {
            return CPP_DKDomNode_baseURI(this.pointer)
        }
    })
    Object.defineProperty(this, "baseURIObject", {
        get: function baseURIObject() {
            return CPP_DKDomNode_baseURIObject(this.pointer)
        }
    })
    Object.defineProperty(this, "childNodes", {
        get: function childNodes() {
            var addressList = CPP_DKDomNode_childNodes(pointer)
            return new HTMLCollection(addressList)
            //TODO - switch htmlCollection over to NodeList	
        }
    })
    Object.defineProperty(this, "firstChild", {
        get: function firstChild() {
            var address = CPP_DKDomNode_firstChild(this.pointer)
            if (!address)
                return;
            return new HTMLElement(address)
        }
    })
    Object.defineProperty(this, "isConnected", {
        get: function isConnected() {
            return CPP_DKDomNode_isConnected(this.pointer)
        }
    })
    Object.defineProperty(this, "lastChild", {
        get: function lastChild() {
            var address = CPP_DKDomNode_lastChild(this.pointer)
            if (!address)
                return;
            return new HTMLElement(address)
        }
    })
    Object.defineProperty(this, "nextSibling", {
        get: function nextSibling() {
            var address = CPP_DKDomNode_nextSibling(this.pointer)
			if (!address)
                return;
            return new HTMLElement(address)
        }
    })
    Object.defineProperty(this, "nodeName", {
        get: function nodeName() {
            return CPP_DKDomNode_nodeName(this.pointer)
        }
    })
    Object.defineProperty(this, "nodePrincipal", {
        get: function nodePrincipal() {
            return CPP_DKDomNode_nodePrincipal(this.pointer)
        }
    })
    Object.defineProperty(this, "nodeType", {
        get: function nodeType() {
            return CPP_DKDomNode_nodeType(this.pointer)
        }
    })
    Object.defineProperty(this, "nodeValue", {
        get: function nodeValue() {
            return CPP_DKDomNode_nodeValue(this.pointer)
        },
        set: function(val) {
            return CPP_DKDomNode_nodeValue(this.pointer, val)
        }
    })
    Object.defineProperty(this, "ownerDocument", {
        get: function ownerDocument() {
            var address = CPP_DKDomNode_ownerDocument(this.pointer)
			if (!address)
                return;
            return new HTMLElement(address)
        }
    })
    Object.defineProperty(this, "parentNode", {
        get: function parentNode() {
            var address = CPP_DKDomNode_parentNode(this.pointer)
            if (!address)
                return;
            return new HTMLElement(address)
        }
    })
    Object.defineProperty(this, "parentElement", {
        get: function parentElement() {
			var address = CPP_DKDomNode_parentElement(this.pointer)
			if (!address)
                return;
            return new HTMLElement(address)
        }
    })
    Object.defineProperty(this, "previousSibling", {
        get: function previousSibling() {
			var address = CPP_DKDomNode_previousSibling(this.pointer)
			if (!address)
                return;
            return new HTMLElement(address)
        }
    })
    Object.defineProperty(this, "textContent", {
        get: function textContent() {
            return CPP_DKDomNode_textContent(this.pointer)
        },
        set: function textContent(val) {
            return CPP_DKDomNode_textContent(this.pointer, val)
        }
    })
    Object.defineProperty(this, "rootNode", {
        //Deprecated
        get: function rootNode() {
            return CPP_DKDomNode_rootNode(this.pointer)
        }
    })

    // Methods
    Node.prototype.appendChild = function appendChild(child) {
        var address = CPP_DKDomNode_appendChild(this.pointer, child.pointer)
        if (!address)
            return;
        return new HTMLElement(address)
    }
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
		//console.log("this.pointer = "+this.pointer)
		//console.log("child.pointer = "+child.pointer)
        var address = CPP_DKDomNode_removeChild(this.pointer, child.pointer)
        if (!address)
            return null;
        //var node = Node(pointer)
        //return node;
    }
    Node.prototype.replaceChild = function replaceChild() {
		//TODO
    }

	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object Node]"
		}
	}
	
    return EventTarget.call(this, pointer)
	//return this
};

// https://dom.spec.whatwg.org/#interface-node
//interface Node : EventTarget
Node.prototype = EventTarget.prototype;
