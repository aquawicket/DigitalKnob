// [IDL] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement

// [Exposed=Window]
// interface HTMLElement : Element {
// [HTMLConstructor] constructor();
var HTMLElement = function HTMLElement(address) {
	//console.log("HTMLElement("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKHTMLElementDUK_constructor();
	
	
	// metadata attributes
	// [CEReactions] attribute DOMString title;
	Object.defineProperty(this, "title", {
        get: function title()				{ return CPP_DKHTMLElementDUK_title(this.address) },
		set: function title(data) 			{ return CPP_DKHTMLElementDUK_title(this.address, data) },
		//configurable: true,
    })
		
	// [CEReactions] attribute DOMString lang;
	Object.defineProperty(this, "lang", {
        get: function lang()				{ return CPP_DKHTMLElementDUK_lang(this.address) },
		set: function lang(data) 			{ return CPP_DKHTMLElementDUK_lang(this.address, data) },
		//configurable: true,
    })
	
	// [CEReactions] attribute boolean translate;
	Object.defineProperty(this, "translate", {
        get: function translate()			{ return CPP_DKHTMLElementDUK_translate(this.address) },
		set: function translate(data) 		{ return CPP_DKHTMLElementDUK_translate(this.address, data) },
		//configurable: true,
    })
	
	// [CEReactions] attribute DOMString dir;
	Object.defineProperty(this, "dir", {
        get: function dir()					{ return CPP_DKHTMLElementDUK_dir(this.address) },
		set: function dir(data) 			{ return CPP_DKHTMLElementDUK_dir(this.address, data) },
		//configurable: true,
    })
	
	// user interaction
	// [CEReactions] attribute (boolean or unrestricted double or DOMString)? hidden;
	Object.defineProperty(this, "hidden", {
        get: function hidden()				{ return CPP_DKHTMLElementDUK_hidden(this.address) },
		set: function hidden(data) 			{ return CPP_DKHTMLElementDUK_hidden(this.address, data) },
		//configurable: true,
    })
	
	// [CEReactions] attribute boolean inert;
	Object.defineProperty(this, "inert", {
        get: function inert()				{ return CPP_DKHTMLElementDUK_inert(this.address) },
		set: function inert(data) 			{ return CPP_DKHTMLElementDUK_inert(this.address, data) },
		//configurable: true,
    })
	
	// undefined click();
	HTMLElement.prototype.click = function click() {
		CPP_DKHTMLElementDUK_click(this.address);
    }
	
	// [CEReactions] attribute DOMString accessKey;
	Object.defineProperty(this, "accessKey", {
        get: function accessKey()			{ return CPP_DKHTMLElementDUK_accessKey(this.address) },
		set: function accessKey(data) 		{ return CPP_DKHTMLElementDUK_accessKey(this.address, data) },
		//configurable: true,
    })
	
	// readonly attribute DOMString accessKeyLabel;
	Object.defineProperty(this, "accessKeyLabel", {
        get: function accessKeyLabel()		{ return CPP_DKHTMLElementDUK_accessKeyLabel(this.address) },
		set: function accessKeyLabel(data) 	{ return CPP_DKHTMLElementDUK_accessKeyLabel(this.address, data) },
		//configurable: true,
    })
	
	// [CEReactions] attribute boolean draggable;
	Object.defineProperty(this, "draggable", {
        get: function draggable()			{ return CPP_DKHTMLElementDUK_draggable(this.address) },
		set: function draggable(data) 		{ return CPP_DKHTMLElementDUK_draggable(this.address, data) },
		//configurable: true,
    })
	
	// [CEReactions] attribute boolean spellcheck;
	Object.defineProperty(this, "spellcheck", {
        get: function spellcheck()			{ return CPP_DKHTMLElementDUK_spellcheck(this.address) },
		set: function spellcheck(data) 		{ return CPP_DKHTMLElementDUK_spellcheck(this.address, data) },
		//configurable: true,
    })
	
	// [CEReactions] attribute DOMString autocapitalize;
	Object.defineProperty(this, "autocapitalize", {
        get: function autocapitalize()		{ return CPP_DKHTMLElementDUK_autocapitalize(this.address) },
		set: function autocapitalize(data) 	{ return CPP_DKHTMLElementDUK_autocapitalize(this.address, data) },
		//configurable: true,
    })
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerText;
	Object.defineProperty(this, "innerText", {
        get: function innerText()		{ return CPP_DKHTMLElementDUK_innerText(this.address) },
		set: function innerText(data) 	{ return CPP_DKHTMLElementDUK_innerText(this.address, data) },
		//configurable: true,
    })
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString outerText;
	Object.defineProperty(this, "outerText", {
        get: function outerText()		{ return CPP_DKHTMLElementDUK_outerText(this.address) },
		set: function outerText(data) 	{ return CPP_DKHTMLElementDUK_outerText(this.address, data) },
		//configurable: true,
    })
	
	// ElementInternals attachInternals();
	HTMLElement.prototype.attachInternals = function attachInternals() {
		return CPP_DKHTMLElementDUK_attachInternals(this.address);
    }
	
	// The popover API
	// undefined showPopover();
	HTMLElement.prototype.showPopover = function showPopover() {
		CPP_DKHTMLElementDUK_showPopover(this.address);
    }
	
	// undefined hidePopover();
	HTMLElement.prototype.hidePopover = function hidePopover() {
		CPP_DKHTMLElementDUK_hidePopover(this.address);
    }
	
	// undefined togglePopover(optional boolean force);
	HTMLElement.prototype.togglePopover = function togglePopover(force) {
		CPP_DKHTMLElementDUK_togglePopover(this.address, force);
    }
	
	// [CEReactions] attribute DOMString? popover;
	Object.defineProperty(this, "popover", {
        get: function popover()		{ return CPP_DKHTMLElementDUK_popover(this.address) },
		set: function popover(data) { return CPP_DKHTMLElementDUK_popover(this.address, data) },
		//configurable: true,
    })
	
//};

	// HTMLElement includes GlobalEventHandlers;
	// HTMLElement includes ElementContentEditable;
	// HTMLElement includes HTMLOrSVGElement;
	
	// [Exposed=Window]
	// interface HTMLUnknownElement : HTMLElement {
		// Note: intentionally no [HTMLConstructor]
	// };
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object HTMLElement]" }
	
	return Element.call(this)
}
HTMLElement.prototype = Element.prototype
