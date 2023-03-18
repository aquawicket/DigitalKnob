// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList
// [INTERFACE] https://dom.spec.whatwg.org/#interface-domtokenlist

var DOMTokenList = function DOMTokenList() {
	
	////// Instance properties //////
	// [DOMTokenList.length](Read only) https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/length
    Object.defineProperty(this, "length", {
        get: function length() {
            return CPP_DKDomDOMTokenList_length()
        }
    })
	// [DOMTokenList.value](Read only) https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/value
    Object.defineProperty(this, "value", {
        get: function value() {
            return CPP_DKDomDOMTokenList_value()
        }
    })
	
	///// Instance methods //////
	// [DOMTokenList.item()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/item
    DOMTokenList.prototype.item = function item(index) {
        return CPP_DKDomDOMTokenList_item(index)
    }
	// [DOMTokenList.contains()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/contains
    DOMTokenList.prototype.contains = function contains(token) {
        return CPP_DKDomDOMTokenList_contains(token)
    }
	// [DOMTokenList.add()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/add
    DOMTokenList.prototype.add = function add(tokenN) {
        return CPP_DKDomDOMTokenList_add(tokenN)
    }
	// [DOMTokenList.remove()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/remove
    DOMTokenList.prototype.remove = function remove(tokenN) {
        return CPP_DKDomDOMTokenList_remove(tokenN)
    }
	// [DOMTokenList.replace()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/replace
    DOMTokenList.prototype.replace = function replace(oldToken, newToken) {
        return CPP_DKDomDOMTokenList_replace(oldToken, newToken)
    }
	// [DOMTokenList.supports()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/supports
    DOMTokenList.prototype.supports = function supports(token) {
         return CPP_DKDomDOMTokenList_supports(token)
    }
	// [DOMTokenList.toggle()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/toggle
    DOMTokenList.prototype.toggle = function toggle(token, force) {
         return CPP_DKDomDOMTokenList_toggle(token, force)
    }
	// [DOMTokenList.entries()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/entries
    DOMTokenList.prototype.entries = function entries() {
         return CPP_DKDomDOMTokenList_entries()
    }
	// [DOMTokenList.forEach()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/forEach
    DOMTokenList.prototype.forEach = function forEach(callback, thisArg) {
         return CPP_DKDomDOMTokenList_forEach(callback, thisArg)
    }
	// [DOMTokenList.keys()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/keys
    DOMTokenList.prototype.keys = function keys() {
         return CPP_DKDomDOMTokenList_keys()
    }
	// [DOMTokenList.values()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/values
    DOMTokenList.prototype.values = function values() {
         return CPP_DKDomDOMTokenList_values()
    }
	
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object DOMTokenList]"
		}
	}
	
    return this;
}
DOMTokenList.prototype = [];