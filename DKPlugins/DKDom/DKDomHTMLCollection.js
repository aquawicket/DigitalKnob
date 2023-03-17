// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection
// [INTERFACE] https://dom.spec.whatwg.org/#interface-htmlcollection

var HTMLCollection = function HTMLCollection(pointers) {
    var arry = pointers.split(",");
    for (var i = 0; i < arry.length; i++) {
        this.push(new HTMLElement(arry[i]));
    }

	////// Instance properties //////
	// [HTMLCollection.length](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection/length
    Object.defineProperty(this, "length", {
        get: function length() {
            return arry.length
        }
    })
	
	////// Instance methods //////
	// [HTMLCollection.item()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection/item
    HTMLCollection.prototype.item = function item(index) {
        return this[index];
    }
	// [HTMLCollection.namedItem()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection/namedItem
    HTMLCollection.prototype.namedItem = function namedItem(key) {
        for (var i = 0; i < this.length; i++) {
            if (this.id && this.id === key) {
                return this[i];
            }
            if (this.name && this.name === key) {
                return this[i];
            }
        }
        return null;
    }

	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object HTMLCollection]"
		}
	}
	
    return this;
}
HTMLCollection.prototype = [];
