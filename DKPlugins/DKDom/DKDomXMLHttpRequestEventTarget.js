// https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequestEventTarget

var XMLHttpRequestEventTarget = function(pointer) {
    // Properties
	


    return EventTarget.call(this, pointer);
}
XMLHttpRequestEventTarget.prototype = EventTarget.prototype;