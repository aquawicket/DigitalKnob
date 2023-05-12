// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement
#pragma once
#ifndef DKHTMLImageElement_H
#define DKHTMLImageElement_H

#include "DKHTMLElement/DKHTMLElement.h"


class DKHTMLImageElement : public DKHTMLElement
{
public:
	DKHTMLImageElement() : DKHTMLElement() {
		DKDEBUGFUNC();
		interfaceName = "HTMLImageElement";
		interfaceAddress = pointerToAddress(this);
	}

	// TODO

};


#endif //DKHTMLImageElement_H