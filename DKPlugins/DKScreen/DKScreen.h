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
	virtual int availWidth(); 								// getter
	//virtual void availWidth(const int&) { return 0; } 	// setter
	
	// readonly attribute long availHeight;
	virtual int availHeight(); 								// getter
	//virtual void availHeight(const int&) { return 0; } 	// setter
	
	// readonly attribute long width;
	virtual int width(); 									// getter
	//virtual void width(const int&) { return 0; } 			// setter
	
	// readonly attribute long height;
	virtual int height(); 									// getter
	//virtual void height(const int&) { return 0; } 		// setter
	
	// readonly attribute unsigned long colorDepth;
	virtual int colorDepth(); 								// getter
	//virtual void colorDepth(const int&) { return 0; } 	// setter
	
	// readonly attribute unsigned long pixelDepth;
	virtual int pixelDepth(); 								// getter
	//virtual void pixelDepth(const int&) { return 0; } 	// setter
	
//};
};


#endif //DKScreen_H