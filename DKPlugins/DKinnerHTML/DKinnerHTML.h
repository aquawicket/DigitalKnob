// [IDL] https://www.w3.org/TR/DOM-Parsing/#widl-Element-innerHTML
#pragma once
#ifndef DKinnerHTML_H
#define DKinnerHTML_H

#include "DKInterface/DKInterface.h"


// Source: DOM Parsing and Serialization (https://www.w3.org/TR/DOM-Parsing/)
// interface mixin InnerHTML {
class DKinnerHTML
{
public:
	DKinnerHTML()
	{
		DKDEBUGFUNC();
	}
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerHTML;
	DOMString _innerHTML = "";
	virtual const DOMString& innerHTML(const DOMString& innerHTML) {
		DKDEBUGFUNC(innerHTML);
		DKINFO("DKinnerHTML::innerHTML("+innerHTML+")\n");
		return _innerHTML;
	}

	// };

	////// toString //////
	operator std::string() const { return "[object innerHTML]"; }
};

#endif // DKinnerHTML_H