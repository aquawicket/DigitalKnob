// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLBodyElement
#pragma once
#ifndef HTMLBodyElement_H
#define HTMLBodyElement_H

#include "DKInterface/DKInterface.h"


class DKHTMLBodyElement : public DKInterface
{
public:
	DKHTMLBodyElement() : DKInterface() {
		DKDEBUGFUNC();
		interfaceName = "DKHTMLBodyElement";
		interfaceAddress = pointerToAddress(this);
	}

	// TODO

};


#endif //DKHTMLBodyElement_H