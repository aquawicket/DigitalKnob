// [IDL] https://www.w3.org/TR/DOM-Parsing/#widl-Element-innerHTML

// Source: DOM Parsing and Serialization (https://www.w3.org/TR/DOM-Parsing/)
// interface mixin InnerHTML {
var innerHTML = {
	//console.log("innerHTML")
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerHTML;
	innerHTML(innerHTML){
		console.log("innerHTML.prototype.innerHTML("+innerHTML+")");
		return new Element(CPP_DKinnerHTMLDUK_innerHTML(this.address, innerHTML));
	}
};
Object.assign(Element.prototype, innerHTML);
