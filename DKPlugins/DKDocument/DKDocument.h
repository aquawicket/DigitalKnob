#pragma once
#ifndef DKDocument_H
#define DKDocument_H

#include "DKNode/DKNode.h"


// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document
class DKDocument : public DKNode
{
public:
	DKDocument() : DKNode() {
		DKDEBUGFUNC();
		eventTargetClass = "Document";
		eventTargetAddress = pointerToAddress(this);
		
		////// Instance properties //////

	}
	
	
	////// Instance properties //////

};


#endif //DKDocument_H