#pragma once
#ifndef DKHTMLElement_H
#define DKHTMLElement_H

#include "DKNode/DKNode.h"


// [IDL] 
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
class DKHTMLElement : public DKElement
{
public:
	////// Constructor //////
	// [HTMLElement()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/HTMLElement
	DKHTMLElement() : DKElement() {
		DKDEBUGFUNC();
		eventTargetClass = "HTMLElement";
		eventTargetAddress = pointerToAddress(this);
		
		
		////// Instance properties //////
		// TODO
		
	}
	
	
	////// Instance properties //////
	// TODO	
};


#endif //DKHTMLElement_H