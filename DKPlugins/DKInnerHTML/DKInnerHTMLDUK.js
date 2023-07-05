// [IDL] https://www.w3.org/TR/DOM-Parsing/#widl-Element-innerHTML
console.log("DKInnerHTMLDUK.js")

// Source: DOM Parsing and Serialization (https://www.w3.org/TR/DOM-Parsing/)
// interface mixin InnerHTML {
Object.defineProperty(Element.prototype, 'innerHTML', {
    get: function innerHTML()			{ 
			console.warn("innerHTML getter");
			return CPP_DKinnerHTMLDUK_innerHTML(this.address);
		},
		set: function innerHTML(data)		{
			console.warn("innerHTML("+data+") setter");
			CPP_DKinnerHTMLDUK_innerHTML(this.address, data);		
		},
		configurable: true
});

// };