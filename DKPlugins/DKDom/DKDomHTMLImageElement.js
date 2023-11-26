//https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement

var Image = function Image(width, height) {
	var image = document.createElement("img");
	image.width = width;
	image.height = height;
	return new HTMLImageElement(image);
}

var HTMLImageElement = function HTMLImageElement(pointer) {
	// Properties
	Object.defineProperty(this, "src", {
        get: function src() {
			return CPP_DKDomElement_getAttribute(pointer, "src")
        },
		set: function src(val) {
			return CPP_DKDomElement_setAttribute(pointer, "src", val)
		}
    });
 
    return HTMLElement.call(this, pointer);
}

HTMLImageElement.prototype = HTMLElement.prototype;
