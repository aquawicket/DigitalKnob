// [IDL] https://drafts.csswg.org/cssom-view/#the-screen-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Screen
#pragma once
#ifndef TEST_Screen_H
#define TEST_Screen_H

#include "DKScreen/DKScreen.h"


class TEST_Screen : public DKObjectT<TEST_Screen>
{
public:
	bool Init(){
		DKINFO("\n////// TEST_Screen.h //////");
		
		DKScreen screen();
		printScreenProperties(screen);
		return true;
	}
	
	static void printScreenProperties(DKScreen& screen){
		DKDEBUGFUNC(screen);
		DKINFO("screen.availWidth = "	+toString(screen.availWidth)	+"\n");
		DKINFO("screen.availHeight = "	+toString(screen.availHeight)	+"\n");
		DKINFO("screen.width = "		+toString(screen.width)			+"\n");
		DKINFO("screen.height = "		+toString(screen.height)		+"\n");
		DKINFO("screen.colorDepth = "	+toString(screen.colorDepth)	+"\n");
		DKINFO("screen.pixelDepth = "	+toString(screen.pixelDepth)	+"\n");
	}
};
REGISTER_OBJECT(TEST_Screen, true);


#endif //TEST_Screen_H