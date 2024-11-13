
(function(doc) {
	if(typeof WScript === "object"){
		var document = function(){ return new ActiveXObject("Msxml2.DOMDocument.6.0"); 
			document.async = false;
			document.setProperty("ProhibitDTD", false);
			document.validateOnParse = false;
			globalThis.document = document;
			return document
		}
	}
})(this.document = this.document || {});
