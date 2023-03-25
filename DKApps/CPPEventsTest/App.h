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
	static void printKeyboardEventProperties(/*event*/);
	static bool onKeyDown(/*event*/);
	static void onKeyUp(/*event*/);
};
REGISTER_OBJECT(App, false);


#endif //App_H