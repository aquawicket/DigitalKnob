// [IDL] https://dom.spec.whatwg.org/#interface-nonelementparentnode
// [MDN]
#pragma once
#ifndef DKNonElementParentNode_H
#define DKNonElementParentNode_H

#include "DKInterface/DKInterface.h"
//#include "DKMixin/DKMixin.h"


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// interface mixin NonElementParentNode {
class DKNonElementParentNode //: public DKMixin
{
public:
	// Element? getElementById(DOMString elementId);
	DKString _getElementById = "DKNonElementParentNode::getElementById()";
	virtual const DKString& getElementById(const DOMString& elementId) {
		DKDEBUGFUNC(elementId);
		return _getElementById;
	}

// };
};

#endif // NonElementParentNode_H