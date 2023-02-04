//https://developer.mozilla.org/en-US/docs/Web/API/HTMLBodyElement
// HTMLBodyElement

var HTMLBodyElement = function HTMLBodyElement(pointer) {
	
	this.pointer = pointer
	
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object HTMLBodyElement]"
		}
	}
	
    HTMLElement.call(this, pointer)
	return this
}

HTMLBodyElement.prototype = HTMLElement.prototype;
