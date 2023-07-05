// [IDL] https://dom.spec.whatwg.org/#interface-nonelementparentnode
// [MDN]
#pragma once
#ifndef DKRmlInnerHTML_H
#define DKRmlNonElementParentNode_H

#include "DKNonElementParentNode/DKNonElementParentNode.h"
#include "DKRmlElement/DKRmlElement.h"
//#include "DKMixin/DKMixin.h"


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// interface mixin NonElementParentNode {
class DKRmlNonElementParentNode : virtual public DKDocument // public DKNonElementParentNode
{
public:
	DKRmlInterface* _dkRmlInterface;
	DKRmlEventListener* _dkRmlEventListener;
	
	// constructor();
	DKRmlNonElementParentNode(DKRmlInterface* dkRmlInterface, DKRmlEventListener* dkRmlEventListener) : DKDocument() //DKNonElementParentNode() 
	{
		DKDEBUGFUNC();

		//interfaceName = "RmlNonElementParentNode";
		//address[interfaceName] = pointerToAddress(this);
		//DKINFO("DK" + interfaceName + "(" + interfaceAddress + "," + address[interfaceName] + ") \n");

		_dkRmlInterface = dkRmlInterface;
		if(!_dkRmlInterface)
			DKERROR("_dkRmlInterface invalid! \n");
		
		_dkRmlEventListener = dkRmlEventListener;
		if(!_dkRmlEventListener)
			DKERROR("_dkRmlEventListener invalid! \n");
	}
	
	// Element? getElementById(DOMString elementId);
	DKElement* getElementById(const DOMString& elementId) override {
		DKDEBUGFUNC(elementId);
		DKINFO("DKRmlNonElementParentNode::getElementById("+elementId+")\n");
		Rml::Element* element = _dkRmlInterface->document->GetElementById(elementId.c_str());
		return (DKElement*)DKRmlElement::instance(_dkRmlEventListener, element);
	}

// };
};

#endif // DKRmlNonElementParentNode_H