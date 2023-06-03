// [IDL] https://dom.spec.whatwg.org/#interface-htmlcollection
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection
#pragma once
#ifndef DKHTMLCollection_H
#define DKHTMLCollection_H

#include "DKInterface/DKInterface.h"


// [Exposed=Window, LegacyUnenumerableNamedProperties]
// interface HTMLCollection {
class DKHTMLCollection : public DKInterface
{
public:
	DKHTMLCollection() : DKInterface() {
		DKDEBUGFUNC();
		interfaceName = "HTMLCollection";
		interfaceAddress = pointerToAddress(this);
	}

	// readonly attribute unsigned long length;
	unsigned int _length = 0;
	virtual const unsigned int& length()				{ return _length; }		// getter
	virtual void length(const unsigned int& length)		{ _length = length; } 	// setter
	
	// getter Element? item(unsigned long index);
	// TODO
	
	// getter Element? namedItem(DOMString name);
	// TODO
	
//};
};


#endif //DKHTMLCollection_H