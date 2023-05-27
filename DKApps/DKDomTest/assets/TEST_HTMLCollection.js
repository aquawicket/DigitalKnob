// [IDL] https://dom.spec.whatwg.org/#interface-htmlcollection
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection
console.log("\n////// TEST_HTMLCollection.js //////")


function printHTMLCollectionProperties(htmlCollection){
		
	// readonly attribute unsigned long length;
	console.log("htmlCollection.length = "	+htmlCollection.length);
		
	// getter Element? item(unsigned long index);
	// function
		
	// getter Element? namedItem(DOMString name);
	// function
}


var htmlCollection = new HTMLCollection();
printHTMLCollectionProperties(htmlCollection);