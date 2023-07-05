// [IDL] https://www.w3.org/TR/DOM-Parsing/#widl-Element-innerHTML
#pragma once
#ifndef DKRmlInnerHTML_H
#define DKRmlInnerHTML_H

#include "DKInnerHTML/DKInnerHTML.h"
#include "DKElement/DKElement.h"

WARNING_DISABLE
#include <RmlUi/Core.h>
WARNING_ENABLE


// Source: DOM Parsing and Serialization (https://www.w3.org/TR/DOM-Parsing/)
// interface mixin InnerHTML {
class DKRmlInnerHTML : virtual public DKElement // public DKInnerHTML
{
public:
	Rml::Element* __rmlElement;
	
	// constructor();
	DKRmlInnerHTML(Rml::Element* rmlElement) : DKElement() //DKInnerHTML() 
	{
		DKDEBUGFUNC();

		__rmlElement = rmlElement;
		if(!__rmlElement)
			DKERROR("_rmlElement invalid! \n");
	}
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerHTML;
	const DOMString& innerHTML() override {					// getter
		DKINFO("DKRmlInnerHTML::innerHTML()\n");
		return __rmlElement->GetInnerRML();
	}
	void innerHTML(const DOMString& innerHTML) override {	// setter
		DKINFO("DKRmlInnerHTML::innerHTML("+innerHTML+")\n");
		return __rmlElement->SetInnerRML(innerHTML);
	}

// };
};

#endif // DKRmlInnerHTML_H