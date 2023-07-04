// [IDL] https://dom.spec.whatwg.org/#interface-nonelementparentnode
#pragma once
#ifndef DKNonElementParentNode_H
#define DKNonElementParentNode_H

#include "DKInterface/DKInterface.h"
#include "DKElement/DKElement.h"
//#include "DKMixin/DKMixin.h"


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// interface mixin NonElementParentNode {
class DKNonElementParentNode : virtual public DKInterface //: public DKMixin
{
public:
	DKNonElementParentNode() : DKInterface() //: DKMixin()
	{
		DKDEBUGFUNC();
		interfaceName = "NonElementParentNode";
		address[interfaceName] = pointerToAddress(this);
		//address[interfaceName] = address["Document"];
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
	}
	
	// Element? getElementById(DOMString elementId);
	DKElement* _getElementById = NULL;
	virtual DKElement* getElementById(const DOMString& elementId) {
		DKDEBUGFUNC(elementId);
		DKINFO("DKNonElementParentNode::getElementById("+elementId+")\n");
		return _getElementById;
	}

	// };

	////// toString //////
	operator std::string() const { return "[object NonElementParentNode]"; }
};

#endif // DKNonElementParentNode_H