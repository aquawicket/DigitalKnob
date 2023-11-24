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
		this.address = CPP_DKHTMLImageElementDUK_constructor();
	
	
	// [CEReactions] attribute DOMString alt;
	Object.defineProperty(this, "alt", {
		get: function alt()					{ return CPP_DKHTMLImageElementDUK_alt(this.address) },
		set: function alt(data) 			{ return CPP_DKHTMLImageElementDUK_alt(this.address, data) },
		//configurable: true,
	})

	// [CEReactions] attribute USVString src;
	Object.defineProperty(this, "src", {
		get: function src()					{ return CPP_DKHTMLImageElementDUK_src(this.address) },
		set: function src(data) 			{ return CPP_DKHTMLImageElementDUK_src(this.address, data) },
		//configurable: true,
	})
	
	// [CEReactions] attribute USVString srcset;
	Object.defineProperty(this, "srcset", {
		get: function srcset()				{ return CPP_DKHTMLImageElementDUK_srcset(this.address) },
		set: function srcset(data) 			{ return CPP_DKHTMLImageElementDUK_srcset(this.address, data) },
		//configurable: true,
	})

	// [CEReactions] attribute DOMString sizes;
	Object.defineProperty(this, "sizes", {
		get: function sizes()				{ return CPP_DKHTMLImageElementDUK_sizes(this.address) },
		set: function sizes(data) 			{ return CPP_DKHTMLImageElementDUK_sizes(this.address, data) },
		//configurable: true,
	})
	
	// [CEReactions] attribute DOMString? crossOrigin;
	Object.defineProperty(this, "crossOrigin", {
		get: function crossOrigin()			{ return CPP_DKHTMLImageElementDUK_crossOrigin(this.address) },
		set: function crossOrigin(data) 	{ return CPP_DKHTMLImageElementDUK_crossOrigin(this.address, data) },
		//configurable: true,
	})
	
	// [CEReactions] attribute DOMString useMap;
	Object.defineProperty(this, "useMap", {
		get: function useMap()				{ return CPP_DKHTMLImageElementDUK_useMap(this.address) },
		set: function useMap(data) 			{ return CPP_DKHTMLImageElementDUK_useMap(this.address, data) },
		//configurable: true,
	})
	
	// [CEReactions] attribute boolean isMap;
	Object.defineProperty(this, "isMap", {
		get: function isMap()				{ return CPP_DKHTMLImageElementDUK_isMap(this.address) },
		set: function isMap(data) 			{ return CPP_DKHTMLImageElementDUK_isMap(this.address, data) },
		//configurable: true,
	})
	
	// [CEReactions] attribute unsigned long width;
	Object.defineProperty(this, "width", {
		get: function width()				{ return CPP_DKHTMLImageElementDUK_width(this.address) },
		set: function width(data) 			{ return CPP_DKHTMLImageElementDUK_width(this.address, data) },
		//configurable: true,
	})
	
	// [CEReactions] attribute unsigned long height;
	Object.defineProperty(this, "height", {
		get: function height()				{ return CPP_DKHTMLImageElementDUK_height(this.address) },
		set: function height(data) 			{ return CPP_DKHTMLImageElementDUK_height(this.address, data) },
		//configurable: true,
	})
	
	// readonly attribute unsigned long naturalWidth;
	Object.defineProperty(this, "naturalWidth", {
		get: function naturalWidth()		{ return CPP_DKHTMLImageElementDUK_naturalWidth(this.address) },
		set: function naturalWidth(data) 	{ return CPP_DKHTMLImageElementDUK_naturalWidth(this.address, data) },
		//configurable: true,
	})
	
	// readonly attribute unsigned long naturalHeight;
	Object.defineProperty(this, "naturalHeight", {
		get: function naturalHeight()		{ return CPP_DKHTMLImageElementDUK_naturalHeight(this.address) },
		set: function naturalHeight(data) 	{ return CPP_DKHTMLImageElementDUK_naturalHeight(this.address, data) },
		//configurable: true,
	})
	
	// readonly attribute boolean complete;
	Object.defineProperty(this, "complete", {
		get: function complete()			{ return CPP_DKHTMLImageElementDUK_complete(this.address) },
		set: function complete(data) 		{ return CPP_DKHTMLImageElementDUK_complete(this.address, data) },
		//configurable: true,
	})
	
	// readonly attribute USVString currentSrc;
	Object.defineProperty(this, "currentSrc", {
		get: function currentSrc()			{ return CPP_DKHTMLImageElementDUK_currentSrc(this.address) },
		set: function currentSrc(data) 		{ return CPP_DKHTMLImageElementDUK_currentSrc(this.address, data) },
		//configurable: true,
	})
	
	// [CEReactions] attribute DOMString referrerPolicy;
	Object.defineProperty(this, "referrerPolicy", {
		get: function referrerPolicy()		{ return CPP_DKHTMLImageElementDUK_referrerPolicy(this.address) },
		set: function referrerPolicy(data) 	{ return CPP_DKHTMLImageElementDUK_referrerPolicy(this.address, data) },
		//configurable: true,
	})
	
	// [CEReactions] attribute DOMString decoding;
	Object.defineProperty(this, "decoding", {
		get: function decoding()			{ return CPP_DKHTMLImageElementDUK_decoding(this.address) },
		set: function decoding(data) 		{ return CPP_DKHTMLImageElementDUK_decoding(this.address, data) },
		//configurable: true,
	})
	
	// [CEReactions] attribute DOMString loading;
	Object.defineProperty(this, "loading", {
		get: function loading()				{ return CPP_DKHTMLImageElementDUK_loading(this.address) },
		set: function loading(data) 		{ return CPP_DKHTMLImageElementDUK_loading(this.address, data) },
		//configurable: true,
	})
	
	// [CEReactions] attribute DOMString fetchPriority;
	Object.defineProperty(this, "fetchPriority", {
		get: function fetchPriority()		{ return CPP_DKHTMLImageElementDUK_fetchPriority(this.address) },
		set: function fetchPriority(data) 	{ return CPP_DKHTMLImageElementDUK_fetchPriority(this.address, data) },
		//configurable: true,
	})
	
	// Promise<undefined> decode();
	HTMLElement.prototype.decode = function decode() {
		return CPP_DKHTMLImageElementDUK(this.address);
    }
	
	// also has obsolete members
	//};
	
	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// partial interface HTMLImageElement {
	// [CEReactions] attribute DOMString name;
	Object.defineProperty(this, "name", {
		get: function name()				{ return CPP_DKHTMLImageElementDUK_name(this.address) },
		set: function name(data) 			{ return CPP_DKHTMLImageElementDUK_name(this.address, data) },
		//configurable: true,
	})
	
	// [CEReactions] attribute USVString lowsrc;
	Object.defineProperty(this, "lowsrc", {
		get: function lowsrc()				{ return CPP_DKHTMLImageElementDUK_lowsrc(this.address) },
		set: function lowsrc(data) 			{ return CPP_DKHTMLImageElementDUK_lowsrc(this.address, data) },
		//configurable: true,
	})
	
	// [CEReactions] attribute DOMString align;
	Object.defineProperty(this, "align", {
		get: function align()				{ return CPP_DKHTMLImageElementDUK_align(this.address) },
		set: function align(data) 			{ return CPP_DKHTMLImageElementDUK_align(this.address, data) },
		//configurable: true,
	})
	
	// [CEReactions] attribute unsigned long hspace;
	Object.defineProperty(this, "hspace", {
		get: function hspace()				{ return CPP_DKHTMLImageElementDUK_hspace(this.address) },
		set: function hspace(data) 			{ return CPP_DKHTMLImageElementDUK_hspace(this.address, data) },
		//configurable: true,
	})
	
	// [CEReactions] attribute unsigned long vspace;
	Object.defineProperty(this, "vspace", {
		get: function vspace()				{ return CPP_DKHTMLImageElementDUK_vspace(this.address) },
		set: function vspace(data) 			{ return CPP_DKHTMLImageElementDUK_vspace(this.address, data) },
		//configurable: true,
	})
	
	// [CEReactions] attribute USVString longDesc;
	Object.defineProperty(this, "longDesc", {
		get: function longDesc()			{ return CPP_DKHTMLImageElementDUK_longDesc(this.address) },
		set: function longDesc(data) 		{ return CPP_DKHTMLImageElementDUK_longDesc(this.address, data) },
		//configurable: true,
	})
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString border;
	Object.defineProperty(this, "border", {
		get: function border()				{ return CPP_DKHTMLImageElementDUK_border(this.address) },
		set: function border(data) 			{ return CPP_DKHTMLImageElementDUK_border(this.address, data) },
		//configurable: true,
	})
	
	// };

	// Source: Attribution Reporting (https://wicg.github.io/attribution-reporting-api/)
	// HTMLImageElement includes HTMLAttributionSrcElementUtils;

	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface HTMLImageElement {
	// readonly attribute long x;
	Object.defineProperty(this, "x", {
		get: function x()					{ return CPP_DKHTMLImageElementDUK_x(this.address) },
		set: function x(data) 				{ return CPP_DKHTMLImageElementDUK_x(this.address, data) },
		//configurable: true,
	})
	
	// readonly attribute long y;
	Object.defineProperty(this, "y", {
		get: function y()					{ return CPP_DKHTMLImageElementDUK_y(this.address) },
		set: function y(data) 				{ return CPP_DKHTMLImageElementDUK_y(this.address, data) },
		//configurable: true,
	})
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object HTMLImageElement]" }
	
	
	return HTMLElement.call(this)
}
HTMLImageElement.prototype = HTMLElement.prototype
