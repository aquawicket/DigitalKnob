// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList
// [INTERFACE] https://dom.spec.whatwg.org/#interface-domtokenlist

var DOMTokenList = function DOMTokenList() {
	
	////// Instance properties //////
	// [DOMTokenList.length](Read only) https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/length
    Object.defineProperty(this, "length", {
        get: function length() {
            return 0 //TODO
        }
    })
	// [DOMTokenList.value](Read only) https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/value
    Object.defineProperty(this, "value", {
        get: function value() {
            return 0 //TODO
        }
    })
	
	///// Instance methods //////
	// [DOMTokenList.item()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/item
    DOMTokenList.prototype.item = function item() {
        return 0 //TODO
    }
	// [DOMTokenList.contains()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/contains
    DOMTokenList.prototype.contains = function contains() {
        return 0 //TODO
    }
	// [DOMTokenList.add()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/add
    DOMTokenList.prototype.add = function add() {
        return 0 //TODO
    }
	// [DOMTokenList.remove()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/remove
    DOMTokenList.prototype.remove = function remove() {
        return 0 //TODO
    }
	// [DOMTokenList.replace()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/replace
    DOMTokenList.prototype.replace = function replace() {
        return 0 //TODO
    }
	// [DOMTokenList.supports()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/supports
    DOMTokenList.prototype.supports = function supports() {
        return 0 //TODO
    }
	// [DOMTokenList.toggle()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/toggle
    DOMTokenList.prototype.toggle = function toggle() {
        return 0 //TODO
    }
	// [DOMTokenList.entries()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/entries
    DOMTokenList.prototype.entries = function entries() {
        return 0 //TODO
    }
	// [DOMTokenList.forEach()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/forEach
    DOMTokenList.prototype.forEach = function forEach() {
        return 0 //TODO
    }
	// [DOMTokenList.keys()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/keys
    DOMTokenList.prototype.keys = function keys() {
        return 0 //TODO
    }
	// [DOMTokenList.values()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/values
    DOMTokenList.prototype.values = function values() {
        return 0 //TODO
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