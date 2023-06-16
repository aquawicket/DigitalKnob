// [IDL] https://dom.spec.whatwg.org/#interface-nonelementparentnode
// [MDN]
#pragma once
#ifndef DKRmlNonElementParentNode_H
#define DKRmlNonElementParentNode_H

//#include "DKNonElementParentNode/DKNonElementParentNode.h"
#include "DKRmlElement/DKRmlElement.h"
//#include "DKMixin/DKMixin.h"


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// interface mixin NonElementParentNode {
class DKRmlNonElementParentNode //: public DKNonElementParentNode
{
public:
	DKRmlInterface* _dkRmlInterface;
	
	// constructor();
	DKRmlNonElementParentNode(DKRmlInterface* dkRmlInterface) {//: DKNonElementParentNode() {
		DKDEBUGFUNC();
		_dkRmlInterface = dkRmlInterface;
	}
	virtual ~DKRmlNonElementParentNode() {	}
	
	// Element? getElementById(DOMString elementId);
	virtual DKElement* getElementById(const DOMString& elementId) {
		DKDEBUGFUNC(elementId);
		Rml::Element* element = _dkRmlInterface->document->GetElementById(elementId.c_str());
		return new DKRmlElement(_dkRmlInterface, element);		// FIXME: danggling pointer
	}

// };
};

#endif // DKRmlNonElementParentNode_H