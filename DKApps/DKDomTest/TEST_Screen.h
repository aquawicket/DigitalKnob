// [IDL] https://drafts.csswg.org/cssom-view/#the-screen-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Screen
#pragma once
#ifndef TEST_Screen_H
#define TEST_Screen_H

#include "DKScreen/DKScreen.h"


// [Exposed=Window]
// interface Screen {
class TEST_Screen : public DKObjectT<TEST_Screen>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_Screen.h //////\n");
		
		DKScreen screen;
		printScreenProperties(screen);
		return true;
	}
	
	static void printScreenProperties(DKScreen& screen){
		DKDEBUGFUNC(screen);
		
		// readonly attribute long availWidth;
		//DKINFO("screen.availWidth = "	+toString(screen.availWidth)	+"\n");
		
		// readonly attribute long availHeight;
		//DKINFO("screen.availHeight = "	+toString(screen.availHeight)+"\n");
		
		// readonly attribute long width;
		DKINFO("screen.width() = "		+toString(screen.width())		+"\n");
		
		// readonly attribute long height;
		DKINFO("screen.height() = "		+toString(screen.height())		+"\n");
		
		// readonly attribute unsigned long colorDepth;
		//DKINFO("screen.colorDepth = "	+toString(screen.colorDepth)	+"\n");
		
		// readonly attribute unsigned long pixelDepth;
		//DKINFO("screen.pixelDepth = "	+toString(screen.pixelDepth)	+"\n");
	}
};
REGISTER_OBJECT(TEST_Screen, true);


#endif //TEST_Screen_H