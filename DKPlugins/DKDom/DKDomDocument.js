// https://developer.mozilla.org/en-US/docs/Web/API/Document

// https://dom.spec.whatwg.org/#interface-document
var Document = function(pointer) {
    // Properties
    Object.defineProperty(this, "body", {
        get: function() {
            var address = CPP_DKDomDocument_body();
            if (!address) {
                return;
            }
            return new HTMLElement(address);
        },
        set: function() {
            if (!address) {
                return;
            }
            return CPP_DKDomDocument_body(address);
            //TODO
        }
    });
    Object.defineProperty(this, "documentElement", {
        get: function() {
            var address = CPP_DKDomDocument_documentElement();
            if (!address) {
                return;
            }
            return new HTMLElement(address);
        }
    });

    // Methods
    Document.prototype.createElement = function(tag) {
        var address = CPP_DKDomDocument_createElement(tag);
        if (!address) {
            return;
        }
        return new HTMLElement(address);
    }
    Document.prototype.getElementById = function(id) {
        var address = CPP_DKDomDocument_getElementById(id);
        if (!address) {
            return;
        }
        return new HTMLElement(address);
    }

    Document.prototype.getElementsByTagName = function(tag) {
        var addresses = CPP_DKDomDocument_getElementsByTagName(tag);
        if (!addresses) {
            return;
        }
        return new HTMLCollection(addresses);
    }

    //return Node.call(this, pointer);
    return HTMLElement.call(this, pointer);
    //we have to call HTMKElement instead of Node for .style to work
}
Document.prototype = Node.prototype;
Object.assign(Document.prototype, DocumentOrShadowRoot);
//mixin
Object.assign(Document.prototype, GlobalEventHandlers);
//mixin
//var document = new Document("0xaddress"); //Created in cpp from DKRml
