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
	void printKeyboardEventProperties(/*event*/);
	void onKeyDown(/*event*/);
	void onKeyUp(/*event*/);
};
REGISTER_OBJECT(App, false);


#endif //App_H