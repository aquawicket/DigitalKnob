// [IDL] https://drafts.csswg.org/cssom-view/#the-screen-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Screen
#pragma once
#ifndef DKScreen_H
#define DKScreen_H

#include "DKInterface/DKInterface.h"

// [Exposed=Window]
// interface Screen {
class DKScreen : public DKInterface
{
public:
	DKScreen() : DKInterface() {
		DKDEBUGFUNC();
		interfaceName = "Screen";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKScreen("+interfaceAddress+") \n");
	}
	virtual ~DKScreen() {}
	
	// readonly attribute long availWidth;
	virtual bool availWidth(int&, bool) { return false; }
	
	// readonly attribute long availHeight;
	virtual bool availHeight(int&, bool) { return false; }
	
	// readonly attribute long width;
	virtual bool width(int&, bool) { return false; }
	
	// readonly attribute long height;
	virtual bool height(int&, bool) { return false; }
	
	// readonly attribute unsigned long colorDepth;
	virtual bool colorDepth(int&, bool) { return false; }
	
	// readonly attribute unsigned long pixelDepth;
	virtual bool pixelDepth(int&, bool) { return false; }
	
//};
};


#endif //DKScreen_H