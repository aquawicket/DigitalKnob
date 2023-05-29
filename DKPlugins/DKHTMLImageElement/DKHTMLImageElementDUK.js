// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement


// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Exposed=Window,
// LegacyFactoryFunction=Image(optional unsigned long width, optional unsigned long height)]
// interface HTMLImageElement : HTMLElement {
// [HTMLConstructor] constructor();
var HTMLImageElement = function HTMLImageElement(address) {
	//console.log("HTMLImageElement("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKHTMLImageElementDUK();
	
	
	// [CEReactions] attribute DOMString alt;
	Object.defineProperty(this, "onorientationchange", {
		get: function alt()				{ return CPP_DKHTMLImageElementDUK_alt(this.address) },
		set: function alt(data) 		{ return CPP_DKHTMLImageElementDUK_alt(this.address, data) },
		//configurable: true,
	})



	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object HTMLImageElement]" }
	
	
	return HTMLElement.call(this)
}
HTMLImageElement.prototype = HTMLElement.prototype
