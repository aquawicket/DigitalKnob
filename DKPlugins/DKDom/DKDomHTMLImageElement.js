// https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement
// https://developer.mozilla.org/en-US/docs/Web/HTML/Element/span

var HTMLImageElement = function(pointer) {
 
    return HTMLElement.call(this, pointer);
}

HTMLImageElement.prototype = HTMLElement.prototype;
