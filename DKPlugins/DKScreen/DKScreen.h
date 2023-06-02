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
	int _availWidth = 0;
	virtual const int& availWidth() 						{ return _availWidth; }			// getter
	virtual void availWidth(const int& availWidth) 			{ _availWidth = availWidth; } 	// setter
	
	// readonly attribute long availHeight;
	int _availHeight = 0;;
	virtual const int& availHeight()						{ return _availHeight; }		// getter
	virtual void availHeight(const int& availHeight) 		{ _availHeight = availHeight; } // setter
	
	// readonly attribute long width;
	int _width = 0;
	virtual const int& width()								{ return _width; }				// getter
	virtual void width(const int& width) 					{ _width = width; } 			// setter
	
	// readonly attribute long height;
	int _height = 0;
	virtual const int& height()								{ return _height; }				// getter
	virtual void height(const int& height)  				{ _height = height; } 			// setter
	
	// readonly attribute unsigned long colorDepth;
	unsigned int _colorDepth = 0;
	virtual const unsigned int& colorDepth()				{ return _colorDepth; }			// getter
	virtual void colorDepth(const unsigned int& colorDepth)	{ _colorDepth = colorDepth; } 	// setter
	
	// readonly attribute unsigned long pixelDepth;
	unsigned int _pixelDepth = 0;
	virtual const unsigned int& pixelDepth()				{ return _pixelDepth; }			// getter
	virtual void pixelDepth(const unsigned int& pixelDepth)	{ _pixelDepth = pixelDepth; } 	// setter
	
//};
};


#endif //DKScreen_H