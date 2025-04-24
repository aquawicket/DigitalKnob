//https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement

<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLImageElement.js
var Image = function Image(width, height) {
=======
var Image = function Image(width, height){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLImageElement.js
	var image = document.createElement("img");
	image.width = width;
	image.height = height;
	return new HTMLImageElement(image);
}

<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLImageElement.js
var HTMLImageElement = function HTMLImageElement(pointer) {
	// Properties
	Object.defineProperty(this, "src", {
        get: function src() {
			return CPP_DKDomElement_getAttribute(pointer, "src")
        },
		set: function src(val) {
=======
var HTMLImageElement = function HTMLImageElement(pointer){
	// Properties
	Object.defineProperty(this, "src", {
        get: function src(){
			return CPP_DKDomElement_getAttribute(pointer, "src")
        },
		set: function src(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLImageElement.js
			return CPP_DKDomElement_setAttribute(pointer, "src", val)
		}
    });
 
    return HTMLElement.call(this, pointer);
}

HTMLImageElement.prototype = HTMLElement.prototype;
