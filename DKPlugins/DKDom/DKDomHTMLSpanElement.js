// https://developer.mozilla.org/en-US/docs/Web/API/HTMLSpanElement
// https://developer.mozilla.org/en-US/docs/Web/HTML/Element/span

var HTMLSpanElement = function(pointer) {
 
    return HTMLElement.call(this, pointer);
}

HTMLSpanElement.prototype = HTMLElement.prototype;
