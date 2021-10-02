//https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement

var Image = function(width, height)
	var image = document.createElement("img");
	image.width = width;
	image.height = height;
	return new HTMLImageElement(image);
}

var HTMLImageElement = function(pointer) {
 
    return HTMLElement.call(this, pointer);
}

HTMLImageElement.prototype = HTMLElement.prototype;
