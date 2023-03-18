// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList
// [INTERFACE] https://dom.spec.whatwg.org/#interface-domtokenlist

var DOMTokenList = function DOMTokenList(pointer) {
	
	domTokenList = CPP_DKDomElement_classList(pointer)
	console.log("domTokenList = "+domTokenList)
	
	var arry = domTokenList.split(",");
	for(var i=0; i<arry.length; i++)
		this.push(arry[i])
	
	////// Instance properties //////
	/*
	// [DOMTokenList.length](Read only) https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/length
    Object.defineProperty(this, "length", {
        get: function length() {
            return this.length 
			//return CPP_DKDomDOMTokenList_length()
        }
    })
	*/
	// [DOMTokenList.value](Read only) https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/value
    Object.defineProperty(this, "value", {
        get: function value() {
			var _value = "";
			for (var i = 0; i < this.length; i++) {
				_value += this[i];
				if(i < this.length)
					_value += "";
			}
            //return CPP_DKDomDOMTokenList_value()
        }
    })
	
	///// Instance methods //////
	// [DOMTokenList.item()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/item
    DOMTokenList.prototype.item = function item(index) {
        return this[index];
		// return CPP_DKDomDOMTokenList_item(token)
    }
	// [DOMTokenList.contains()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/contains
    DOMTokenList.prototype.contains = function contains(token) {
		const index = this.indexOf(token);
		if(index === -1)
			return false;
		return true;
        //return CPP_DKDomDOMTokenList_contains(token)
    }
	// [DOMTokenList.add()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/add
    DOMTokenList.prototype.add = function add(tokenN) {
		this.push(tokenN)
        //return CPP_DKDomDOMTokenList_add(tokenN)
    }
	// [DOMTokenList.remove()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/remove
    DOMTokenList.prototype.remove = function remove(tokenN) {
		const index = this.indexOf(tokenN);
		this.splice(index, 1);
        //return CPP_DKDomDOMTokenList_remove(tokenN)
    }
	// [DOMTokenList.replace()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/replace
    DOMTokenList.prototype.replace = function replace(oldToken, newToken) {
		const index = this.indexOf(tokenN);
		if(index !== -1)
			this[index] = newToken;
        //return CPP_DKDomDOMTokenList_replace(oldToken, newToken)
    }
	// [DOMTokenList.supports()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/supports
    DOMTokenList.prototype.supports = function supports(token) {
         // TODO
		 return CPP_DKDomDOMTokenList_supports(token)
    }
	// [DOMTokenList.toggle()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/toggle
    DOMTokenList.prototype.toggle = function toggle(token, force) {
		console.log("toggle("+token+")")
		//TODO:  force
		const index = this.indexOf(token);
		if(index === -1){
			this.push(token)
			return true;
		}
		this.splice(index, 1);
		return false;
         //return CPP_DKDomDOMTokenList_toggle(token, force)
    }
	// [DOMTokenList.entries()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/entries
    DOMTokenList.prototype.entries = function entries() {
		// TODO
         return CPP_DKDomDOMTokenList_entries()
    }
	// [DOMTokenList.forEach()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/forEach
    DOMTokenList.prototype.forEach = function forEach(callback, thisArg) {
		// TODO
         return CPP_DKDomDOMTokenList_forEach(callback, thisArg)
    }
	// [DOMTokenList.keys()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/keys
    DOMTokenList.prototype.keys = function keys() {
		// TODO
         return CPP_DKDomDOMTokenList_keys()
    }
	// [DOMTokenList.values()] https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/values
    DOMTokenList.prototype.values = function values() {
		// TODO
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