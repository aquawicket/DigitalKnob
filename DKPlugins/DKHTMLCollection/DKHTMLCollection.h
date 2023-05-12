// [IDL] https://dom.spec.whatwg.org/#interface-htmlcollection
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection
#pragma once
#ifndef HTMLCollection_H
#define HTMLCollection_H

#include "DKInterface/DKInterface.h"


class HTMLCollection : public DKInterface
{
public:
	DKHTMLCollection() : DKInterface() {
		DKDEBUGFUNC();
		interfaceName = "HTMLCollection";
		interfaceAddress = pointerToAddress(this);
	}

	// TODO

};


#endif //DKHTMLCollection_H