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
	DKRmlEventListener* _dkRmlEventListener;
	
	// constructor();
	DKRmlNonElementParentNode(DKRmlInterface* dkRmlInterface, DKRmlEventListener* dkRmlEventListener) {//: DKNonElementParentNode() {
		DKDEBUGFUNC();
		_dkRmlInterface = dkRmlInterface;
		_dkRmlEventListener = dkRmlEventListener;
	}
	virtual ~DKRmlNonElementParentNode() {	}
	
	// Element? getElementById(DOMString elementId);
	virtual DKElement* getElementById(const DOMString& elementId) {
		DKDEBUGFUNC(elementId);
		Rml::Element* element = _dkRmlInterface->document->GetElementById(elementId.c_str());
		return DKRmlElement::instance(_dkRmlEventListener, element);
	}

// };
};

#endif // DKRmlNonElementParentNode_H