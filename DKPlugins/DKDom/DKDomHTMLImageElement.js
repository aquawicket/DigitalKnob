//https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement

var Image = function(width, height) {
	var image = document.createElement("img");
	image.width = width;
	image.height = height;
	return new HTMLImageElement(image);
}

var HTMLImageElement = function(pointer) {
	// Properties
	Object.defineProperty(this, "src", {
        get: function() {
			return CPP_DKDomElement_getAttribute(pointer, "src")
        },
		set: function(val) {
			return CPP_DKDomElement_setAttribute(pointer, "src", val)
		}
    });
 
    return HTMLElement.call(this, pointer);
}

HTMLImageElement.prototype = HTMLElement.prototype;
