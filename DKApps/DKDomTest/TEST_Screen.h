// [IDL] https://drafts.csswg.org/cssom-view/#the-screen-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Screen
#pragma once
#ifndef TEST_Screen_H
#define TEST_Screen_H

#include "DKScreen/DKScreen.h"


// [Exposed=Window]
// interface Screen {
class TEST_Screen //: public DKObjectT<TEST_Screen>
{
public:
	static DKScreen _screen;

	TEST_Screen(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_Screen.h //////");
		
		printScreenProperties(_screen);
	}
	
	static void printScreenProperties(DKScreen& screen){
		DKDEBUGFUNC(screen);
		
		// readonly attribute long availWidth;
		console.log("screen.availWidth() = "+toString(screen.availWidth()));
		
		// readonly attribute long availHeight;
		console.log("screen.availHeight() = "+toString(screen.availHeight()));
		
		// readonly attribute long width;
		console.log("screen.width() = "		+toString(screen.width()));
		
		// readonly attribute long height;
		console.log("screen.height() = "	+toString(screen.height()));
		
		// readonly attribute unsigned long colorDepth;
		console.log("screen.colorDepth() = "+toString(screen.colorDepth()));
		
		// readonly attribute unsigned long pixelDepth;
		console.log("screen.pixelDepth() = "+toString(screen.pixelDepth()));
	}
};
//REGISTER_OBJECT(TEST_Screen, true);

DKScreen TEST_Screen::_screen;

#endif //TEST_Screen_H