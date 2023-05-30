// [IDL] https://dom.spec.whatwg.org/#interface-htmlcollection
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection
#pragma once
#ifndef TEST_HTMLCollection_H
#define TEST_HTMLCollection_H

#include "DKHTMLCollection/DKHTMLCollection.h"


class TEST_HTMLCollection : public DKObjectT<TEST_HTMLCollection>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKConsole::log("\n////// TEST_HTMLCollection.h //////");
		
		DKHTMLCollection htmlCollection;
		printHTMLCollectionProperties(htmlCollection);
		return true;
	}

	static void printHTMLCollectionProperties(DKHTMLCollection& htmlCollection){
		DKDEBUGFUNC(htmlCollection);
		
		// readonly attribute unsigned long length;
		DKConsole::log("htmlCollection.length() = "	+toString(htmlCollection.length()));
		
		// getter Element? item(unsigned long index);
		// function
		
		// getter Element? namedItem(DOMString name);
		// function
	}
};
REGISTER_OBJECT(TEST_HTMLCollection, true);


#endif //TEST_HTMLCollection_H