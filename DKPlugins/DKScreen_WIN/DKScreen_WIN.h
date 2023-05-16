// [IDL] https://drafts.csswg.org/cssom-view/#the-screen-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Screen
#pragma once
#ifndef DKScreen_WIN_H
#define DKScreen_WIN_H

#include "DKScreen/DKScreen.h"

// [Exposed=Window]
// interface Screen {
class DKScreen_WIN : public DKScreen, public DKObjectT<DKScreen_WIN>
{
public:
	DKScreen_WIN() : DKScreen() {
		DKDEBUGFUNC();
		interfaceName = "DKScreen_WIN";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKScreen_WIN("+interfaceAddress+") \n");
	}
	virtual ~DKScreen_WIN() {}
	
	/*
	// readonly attribute long availWidth;
	virtual bool availWidth(int&, bool) { 
		return DKTODO();
	}
	
	// readonly attribute long availHeight;
	virtual bool availHeight(int&, bool) { 
		return DKTODO();
	}
	*/
	
	// readonly attribute long width;
	virtual int width(int&, bool) {
		DKTODO();
		return 0; 
	}
	
	// readonly attribute long height;
	virtual bool height(int&, bool) { 
		DKTODO();
		return 0;
	}
	
	/*
	// readonly attribute unsigned long colorDepth;
	virtual bool colorDepth(int&, bool) { 
		return DKTODO();
	}
	
	// readonly attribute unsigned long pixelDepth;
	virtual bool pixelDepth(int&, bool) { 
		return DKTODO();
	}
	*/
	
//};
};


#endif //DKScreen_H