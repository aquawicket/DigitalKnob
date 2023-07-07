// [IDL] https://dom.spec.whatwg.org/#interface-nonelementparentnode
#pragma once
#ifndef DKNonElementParentNode_H
#define DKNonElementParentNode_H

#include "DKInterface/DKInterface.h"
#include "DKElement/DKElement.h"


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// interface mixin NonElementParentNode {
class DKNonElementParentNode
{
public:
	DKNonElementParentNode()
	{
		DKDEBUGFUNC();
	}
	
	// Element? getElementById(DOMString elementId);
	DKElement* _getElementById = NULL;
	virtual DKElement* getElementById(const DOMString& elementId) {
		DKDEBUGFUNC(elementId);
		DKINFO("DKNonElementParentNode::getElementById("+elementId+")\n");
		return _getElementById;
	}

	// };
};

#endif // DKNonElementParentNode_H