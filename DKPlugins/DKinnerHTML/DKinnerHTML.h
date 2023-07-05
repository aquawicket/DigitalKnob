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
	virtual const DOMString& innerHTML(const DOMString& innerHTML) {
		DKDEBUGFUNC(innerHTML);
		DKINFO("DKInnerHTML::innerHTML("+innerHTML+")\n");
		return _innerHTML;
	}

	// };

	////// toString //////
	operator std::string() const { return "[object InnerHTML]"; }
};

#endif // DKInnerHTML_H