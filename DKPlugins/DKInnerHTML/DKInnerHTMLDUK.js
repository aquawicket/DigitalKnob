// [IDL] https://www.w3.org/TR/DOM-Parsing/#widl-Element-innerHTML
console.log("DKInnerHTMLDUK.js")

// Source: DOM Parsing and Serialization (https://www.w3.org/TR/DOM-Parsing/)
// interface mixin InnerHTML {
	
// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerHTML;
Object.defineProperty(Element.prototype, 'innerHTML', {
    get: function innerHTML()			{ 
			console.log("InnerHTML.prototype.innerHTML()");
			return CPP_DKInnerHTMLDUK_innerHTML(this.address);
		},
		set: function innerHTML(data)		{
			console.log("InnerHTML.prototype.innerHTML("+data+")");
			CPP_DKInnerHTMLDUK_innerHTML(this.address, data);	
		},
		configurable: true
});

// };