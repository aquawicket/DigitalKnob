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
	static void printKeyboardEventProperties(DKKeyboardEvent event);
	static bool onKeyDown(DKKeyboardEvent event);
	static bool onKeyUp(DKKeyboardEvent event);
	static bool onGeneric(DKEvent event);
};
REGISTER_OBJECT(App, false);


#endif //App_H