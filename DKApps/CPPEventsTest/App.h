#pragma once
#ifndef App_H
#define App_H

#include "DK/DK.h"


class App : public DKObjectT<App>
{
public:
	bool Init();
	bool End();

	////// KeyboardEvents //////
	static void printEventProperties(DKEvent event);
	static void printKeyboardEventProperties(DKEvent event);
	static bool onKeyDown(DKEvent event);
	static bool onKeyUp(DKEvent event);
};
REGISTER_OBJECT(App, false);


#endif //App_H