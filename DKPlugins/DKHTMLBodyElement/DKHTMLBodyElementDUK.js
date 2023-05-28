// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLBodyElement


// [Exposed=Window]
// interface HTMLBodyElement : HTMLElement {
// [HTMLConstructor] constructor();
//	 // also has obsolete members
//};
var HTMLBodyElement = function HTMLBodyElement(address) {
	//console.log("HTMLBodyElement("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKHTMLBodyElementDUK();
	
	// partial interface HTMLBodyElement {
    	// attribute EventHandler onorientationchange;
		Object.defineProperty(this, "onorientationchange", {
			get: function onorientationchange()				{ return CPP_DKHTMLBodyElementDUK_onorientationchange(this.address) },
			set: function onorientationchange(data) 		{ return CPP_DKHTMLBodyElementDUK_onorientationchange(this.address, data) },
			//configurable: true,
		})
	// };
		
	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// HTMLBodyElement includes WindowEventHandlers;

	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// partial interface HTMLBodyElement {
		// [CEReactions] attribute [LegacyNullToEmptyString] DOMString text;
		Object.defineProperty(this, "text", {
			get: function text()			{ return CPP_DKHTMLBodyElementDUK_text(this.address) },
			set: function text(data) 		{ return CPP_DKHTMLBodyElementDUK_text(this.address, data) },
			//configurable: true,
		})

		// [CEReactions] attribute [LegacyNullToEmptyString] DOMString link;
		Object.defineProperty(this, "link", {
			get: function link()			{ return CPP_DKHTMLBodyElementDUK_link(this.address) },
			set: function link(data) 		{ return CPP_DKHTMLBodyElementDUK_link(this.address, data) },
			//configurable: true,
		})

		// [CEReactions] attribute [LegacyNullToEmptyString] DOMString vLink;
		Object.defineProperty(this, "vLink", {
			get: function vLink()			{ return CPP_DKHTMLBodyElementDUK_vLink(this.address) },
			set: function vLink(data) 		{ return CPP_DKHTMLBodyElementDUK_vLink(this.address, data) },
			//configurable: true,
		})

		// [CEReactions] attribute [LegacyNullToEmptyString] DOMString aLink;
		Object.defineProperty(this, "aLink", {
			get: function aLink()			{ return CPP_DKHTMLBodyElementDUK_aLink(this.address) },
			set: function aLink(data) 		{ return CPP_DKHTMLBodyElementDUK_aLink(this.address, data) },
			//configurable: true,
		})

		// [CEReactions] attribute [LegacyNullToEmptyString] DOMString bgColor;
		Object.defineProperty(this, "bgColor", {
			get: function bgColor()			{ return CPP_DKHTMLBodyElementDUK_bgColor(this.address) },
			set: function bgColor(data) 	{ return CPP_DKHTMLBodyElementDUK_bgColor(this.address, data) },
			//configurable: true,
		})

		// [CEReactions] attribute DOMString background;
		Object.defineProperty(this, "background", {
			get: function background()		{ return CPP_DKHTMLBodyElementDUK_background(this.address) },
			set: function background(data) 	{ return CPP_DKHTMLBodyElementDUK_background(this.address, data) },
			//configurable: true,
		})
	// };


	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object HTMLBodyElement]" }
	
	
	return HTMLElement.call(this)
}
HTMLBodyElement.prototype = HTMLElement.prototype
