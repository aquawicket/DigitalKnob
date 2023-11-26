// [IDL] https://dom.spec.whatwg.org/#interface-nonelementparentnode
// [MDN]
#pragma once
#ifndef DKRmlNonElementParentNode_H
#define DKRmlNonElementParentNode_H

#include "DKNonElementParentNode/DKNonElementParentNode.h"
#include "DKRmlElement/DKRmlElement.h"


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// interface mixin NonElementParentNode {
class DKRmlNonElementParentNode : virtual public DKDocument
{
public:
	DKRmlInterface* _dkRmlInterface;
	DKRmlEventListener* _dkRmlEventListener;
	
	// constructor();
	DKRmlNonElementParentNode(DKRmlInterface* dkRmlInterface, DKRmlEventListener* dkRmlEventListener) : DKDocument()
	{
		DKDEBUGFUNC(dkRmlInterface, dkRmlEventListener);

		_dkRmlInterface = dkRmlInterface;
		DKASSERT(_dkRmlInterface);
		
		_dkRmlEventListener = dkRmlEventListener;
		DKASSERT(_dkRmlEventListener);

	}
	
	// Element? getElementById(DOMString elementId);
	DKElement* getElementById(const DOMString& elementId) override {
		DKDEBUGFUNC(elementId);
		DKINFO("DKRmlNonElementParentNode::getElementById("+elementId+")\n");
		Rml::Element* element = _dkRmlInterface->document->GetElementById(elementId.c_str());
		DKASSERT(element);
		return (DKElement*)DKRmlElement::instance(_dkRmlEventListener, element);
	}

// };
};

#endif // DKRmlNonElementParentNode_H