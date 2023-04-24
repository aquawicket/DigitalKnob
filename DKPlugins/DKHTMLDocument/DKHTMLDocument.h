#pragma once
#ifndef DKHTMLDocument_H
#define DKHTMLDocument_H

#include "DKDocument/DKDocument.h"


// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#htmldocument
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLDocument
class DKHTMLDocument : public DKDocument
{
public:
	////// Constructor //////
	// [HTMLDocument()]
	DKHTMLDocument() : DKDocument() {
		DKDEBUGFUNC();
		eventTargetClass = "HTMLDocument";
		eventTargetAddress = pointerToAddress(this);		
	}
};


#endif //DKHTMLDocument_H