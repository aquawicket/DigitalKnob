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
class DKRmlInnerHTML : virtual public DKElement //, virtual public DKInnerHTML
{
public:
	Rml::Element* __rmlElement;
	
	// constructor();
	DKRmlInnerHTML(Rml::Element* rmlElement) : DKElement() //, DKInnerHTML() 
	{
		DKDEBUGFUNC(rmlElement);

		__rmlElement = rmlElement;
		DKASSERT(__rmlElement);
	}
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerHTML;
	const DOMString& innerHTML() override {					// getter
		//DKDEBUGFUNC();
		DKINFO("DKRmlInnerHTML::innerHTML()\n");
		_innerHTML = __rmlElement->GetInnerRML();
		return _innerHTML;
	}
	void innerHTML(const DOMString& innerHTML) override {	// setter
		DKDEBUGFUNC(innerHTML);
		DKINFO("DKRmlInnerHTML::innerHTML("+innerHTML+")\n");
		__rmlElement->SetInnerRML(innerHTML);
	}

// };
};

#endif // DKRmlInnerHTML_H