// [IDL] https://www.w3.org/TR/DOM-Parsing/#widl-Element-innerHTML
console.log("DKInnerHTMLDUK.js")

// Source: DOM Parsing and Serialization (https://www.w3.org/TR/DOM-Parsing/)
// interface mixin InnerHTML {
//var innerHTML = {
var innerHTML = function innerHTML() {
	//console.log("innerHTML()")
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerHTML;
	Object.defineProperty(this, "innerHTML", {
        get: function innerHTML()			{ 
			console.log("innerHTML getter");
			//return CPP_DKinnerHTMLDUK_innerHTML(this.address) 
		},
		set: function innerHTML(data)		{
			console.log("innerHTML("+data+") setter");
			//return CPP_DKinnerHTMLDUK_innerHTML(this.address, data)			
		},
		configurable: true
    });
};


	
Object.assign(Element.prototype, innerHTML);
//Object.assign(Element.prototype, Object.create(innerHTML));
