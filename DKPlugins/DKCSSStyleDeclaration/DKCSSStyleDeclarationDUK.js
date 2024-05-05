// [IDL] https://drafts.csswg.org/cssom/#the-cssstyledeclaration-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration

// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
// [Exposed=Window]
// interface CSSStyleDeclaration {
var CSSStyleDeclaration = function CSSStyleDeclaration(address) {
	console.log("CSSStyleDeclaration("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKCSSStyleDeclarationDUK_constructor();


	// [CEReactions] attribute CSSOMString cssText;
	Object.defineProperty(this, "cssText", {
        get: function cssText()				{ return CPP_DKCSSStyleDeclarationDUK_cssText(this.address) },
		set: function cssText(data)			{ return CPP_DKCSSStyleDeclarationDUK_cssText(this.address, data) },
		//configurable: true,
    })

	// readonly attribute unsigned long length;
	Object.defineProperty(this, "length", {
        get: function length()				{ return CPP_DKCSSStyleDeclarationDUK_length(this.address) },
		//set: function length(data)		{ return CPP_DKCSSStyleDeclarationDUK_length(this.address, data) },
		//configurable: true,
    })
	
	// getter CSSOMString item(unsigned long index);
	CSSStyleDeclaration.prototype.item = function item(index) {
        return CPP_DKCSSStyleDeclarationDUK_item(this.address, index);
    }

	// CSSOMString getPropertyValue(CSSOMString property);
	CSSStyleDeclaration.prototype.getPropertyValue = function getPropertyValue(property) {
        return CPP_DKCSSStyleDeclarationDUK_getPropertyValue(this.address, property);
    }

	// CSSOMString getPropertyPriority(CSSOMString property);
	CSSStyleDeclaration.prototype.getPropertyPriority = function getPropertyPriority(property) {
        return CPP_DKCSSStyleDeclarationDUK_getPropertyPriority(this.address, property);
    }
	
	// [CEReactions] undefined setProperty(CSSOMString property, [LegacyNullToEmptyString] CSSOMString value, optional [LegacyNullToEmptyString] CSSOMString priority = "");
	CSSStyleDeclaration.prototype.setProperty = function setProperty(property, value, priority) {
        CPP_DKCSSStyleDeclarationDUK_setProperty(this.address, property, value, priority);
    }
	
	// [CEReactions] CSSOMString removeProperty(CSSOMString property);
	CSSStyleDeclaration.prototype.removeProperty = function removeProperty(property) {
        return CPP_DKCSSStyleDeclarationDUK_removeProperty(this.address, property);
    }
	
	// readonly attribute CSSRule? parentRule;
	Object.defineProperty(this, "parentRule", {
        get: function parentRule()				{ return CPP_DKCSSStyleDeclarationDUK_parentRule(this.address) },
		//set: function parentRule(data)		{ return CPP_DKCSSStyleDeclarationDUK_parentRule(this.address, data) },
		//configurable: true,
    })
	
	// [CEReactions] attribute [LegacyNullToEmptyString] CSSOMString cssFloat;
	Object.defineProperty(this, "cssFloat", {
        get: function cssFloat()				{ return CPP_DKCSSStyleDeclarationDUK_cssFloat(this.address) },
		set: function cssFloat(data)			{ return CPP_DKCSSStyleDeclarationDUK_cssFloat(this.address, data) },
		//configurable: true,
    })
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object CSSStyleDeclaration]" }
	
	return this;
}