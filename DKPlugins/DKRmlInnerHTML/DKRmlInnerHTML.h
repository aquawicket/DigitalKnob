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
	DKRmlInterface* _dkRmlInterface;
	DKRmlEventListener* _dkRmlEventListener;
	
	// constructor();
	DKRmlInnerHTML(DKRmlInterface* dkRmlInterface, DKRmlEventListener* dkRmlEventListener) : DKElement() //DKInnerHTML() 
	{
		DKDEBUGFUNC();

		_dkRmlInterface = dkRmlInterface;
		if(!_dkRmlInterface)
			DKERROR("_dkRmlInterface invalid! \n");
		
		_dkRmlEventListener = dkRmlEventListener;
		if(!_dkRmlEventListener)
			DKERROR("_dkRmlEventListener invalid! \n");
	}
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerHTML;
	const DOMString& innerHTML(const DOMString& innerHTML) override {
		DKDEBUGFUNC(innerHTML);
		DKINFO("DKRmlInnerHTML::innerHTML("+innerHTML+")\n");
		Rml::Element* element = _dkRmlInterface->document->GetElementById(elementId.c_str());
		return (DKElement*)DKRmlElement::instance(_dkRmlEventListener, element);
	}

// };
};

#endif // DKRmlInnerHTML_H