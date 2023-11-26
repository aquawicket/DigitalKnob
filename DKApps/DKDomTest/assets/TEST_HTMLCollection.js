// [IDL] https://dom.spec.whatwg.org/#interface-htmlcollection
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection
console.log("\n////// TEST_HTMLCollection.js //////")


function printHTMLCollectionProperties(htmlCollection){
		
	console.log("htmlCollection = "				+htmlCollection);
	
	// readonly attribute unsigned long length;
	console.log("htmlCollection.length = "		+htmlCollection.length);
		
	// getter Element? item(unsigned long index);
	console.log("htmlCollection.item = "		+htmlCollection.item);
		
	// getter Element? namedItem(DOMString name);
	console.log("htmlCollection.namedItem = "	+htmlCollection.namedItem);
}


var htmlCollection = new HTMLCollection();
printHTMLCollectionProperties(htmlCollection);