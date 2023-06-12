// [IDL] https://dom.spec.whatwg.org/#interface-htmlcollection
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection
#pragma once
#ifndef TEST_HTMLCollection_H
#define TEST_HTMLCollection_H

#include "DKHTMLCollection/DKHTMLCollection.h"


class TEST_HTMLCollection //: public DKObjectT<TEST_HTMLCollection>
{
public:
	TEST_HTMLCollection(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_HTMLCollection.h //////");
		
		std::vector<DKElement*> list;
		DKHTMLCollection htmlCollection(list);
		printHTMLCollectionProperties(htmlCollection);
	}

	static void printHTMLCollectionProperties(DKHTMLCollection& htmlCollection){
		DKDEBUGFUNC(htmlCollection);
		
		// readonly attribute unsigned long length;
		//console.log("htmlCollection.length() = "	+toString(htmlCollection.length()));	// FIXME
		
		// getter Element? item(unsigned long index);
		// function
		
		// getter Element? namedItem(DOMString name);
		// function
	}
};
//REGISTER_OBJECT(TEST_HTMLCollection, true);


#endif //TEST_HTMLCollection_H