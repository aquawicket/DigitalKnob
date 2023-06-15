// [IDL] https://html.spec.whatwg.org/multipage/system-state.html#the-navigator-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Navigator
#pragma once
#ifndef DKNavigator_H
#define DKNavigator_H

#include "DKInterface/DKInterface.h"


// [Exposed=Window]
// interface Navigator {
// objects implementing this interface also implement the interfaces given below
class DKNavigator : public DKInterface
{
public:
// };
	
	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	//	partial interface Navigator {
	//	[SameObject] readonly attribute UserActivation userActivation;
		// TODO
		
	//};
	
	// TODO . . .
	
	
	////// toString //////
	operator std::string() const { return "[object Navigator]"; }
};

class DKNullNavigator : public DKNavigator
{
public:
	operator std::string() const { return "null"; }
};


#endif //DKNavigator_H