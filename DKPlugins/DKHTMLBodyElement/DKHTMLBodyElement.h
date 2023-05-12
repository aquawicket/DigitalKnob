// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLBodyElement
#pragma once
#ifndef DKHTMLBodyElement_H
#define DKHTMLBodyElement_H

#include "DKHTMLElement/DKHTMLElement.h"


class DKHTMLBodyElement : public DKHTMLElement
{
public:
	DKHTMLBodyElement() : DKHTMLElement() {
		DKDEBUGFUNC();
		interfaceName = "DKHTMLBodyElement";
		interfaceAddress = pointerToAddress(this);
	}

	// TODO

};


#endif //DKHTMLBodyElement_H