// https://developer.mozilla.org/en-US/docs/Web/API/HTMLSpanElement
// https://developer.mozilla.org/en-US/docs/Web/HTML/Element/span

var HTMLSpanElement = function HTMLSpanElement(pointer) {
 
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object HTMLSpanElement]"
		}
	}
	
    return HTMLElement.call(this, pointer);
}

HTMLSpanElement.prototype = HTMLElement.prototype;
