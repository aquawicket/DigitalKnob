// [IDL] https://www.w3.org/TR/DOM-Parsing/#widl-Element-innerHTML
#pragma once
#ifndef DKInnerHTML_H
#define DKInnerHTML_H

#include "DKInterface/DKInterface.h"


// Source: DOM Parsing and Serialization (https://www.w3.org/TR/DOM-Parsing/)
// interface mixin InnerHTML {
class DKInnerHTML
{
public:
	DKInnerHTML()
	{
		DKDEBUGFUNC();
	}
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerHTML;
	DOMString _innerHTML = "";
	virtual const DOMString& innerHTML()				{ 	// getter
		DKINFO("DKInnerHTML::innerHTML()\n");
		return _innerHTML; 
	}
	virtual void innerHTML(const DOMString& innerHTML)	{ 	// setter
		DKINFO("DKInnerHTML::innerHTML("+innerHTML+")\n");
		_innerHTML = innerHTML; } 	

	// };
};

#endif // DKInnerHTML_H