// [IDL] https://www.w3.org/TR/DOM-Parsing/#widl-Element-innerHTML
#pragma once
#ifndef DKRmlInnerHTML_H
#define DKRmlInnerHTML_H

#include "DKInnerHTML/DKInnerHTML.h"
#include "DKRmlElement/DKRmlElement.h"


// Source: DOM Parsing and Serialization (https://www.w3.org/TR/DOM-Parsing/)
// interface mixin InnerHTML {
class DKRmlInnerHTML : virtual public DKElement // public DKInnerHTML
{
public:
	Rml::Element* _rmlElement;
	
	// constructor();
	DKRmlInnerHTML(Rml::Element* rmlElement) : DKElement() //DKInnerHTML() 
	{
		DKDEBUGFUNC();

		_rmlElement = rmlElement;
		if(!_rmlElement)
			DKERROR("_rmlElement invalid! \n");
	}
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerHTML;
	const DOMString& innerHTML() override {					// getter
		if(!_rmlElement){
			DKERROR("_rmlElement invalid! \n");
			return _innerHTML;
		}
		return _rmlElement->GetInnerHTML();
	}
	void innerHTML(const DOMString& innerHTML) override {	// setter
		if(!_rmlElement){
			DKERROR("_rmlElement invalid! \n");
			return _innerHTML;
		}
		return _rmlElement->SetInnerHTML(innerHTML);
	}

// };
};

#endif // DKRmlInnerHTML_H