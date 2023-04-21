#pragma once
#ifndef DKElement_H
#define DKElement_H

#include "DKNode/DKNode.h"


// [IDL] https://dom.spec.whatwg.org/#interface-element
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Element
class DKElement : public DKNode
{
public:
	////// Constructor //////
	// [Element()]
	DKElement() : DKNode() {
		DKDEBUGFUNC();
		eventTargetClass = "Element";
		eventTargetAddress = pointerToAddress(this);
		
		
		////// Instance properties //////
		// TODO
	}
	
	
	////// Instance properties //////
	// TODO

};


#endif //DKElement_H