#pragma once
#ifndef App_H
#define App_H

#include "DK/DK.h"


class App : public DKObjectT<App>
{
public:
	bool Init();
	bool End();

	////// Event //////
	static void printEventProperties(DKEvent* event);
	static bool ongeneric(DKEvent* event);
	
	////// UIEvent //////
	static void printUIEventProperties(DKUIEvent* uievent);
	
	////// KeyboardEvent //////
	static void printKeyboardEventProperties(DKKeyboardEvent* keyevent);
	static bool onkeydown(DKKeyboardEvent* keyevent);
	static bool onkeyup(DKKeyboardEvent* keyevent);
	static bool onkeypress(DKKeyboardEvent* keyevent);
	
	////// MouseEvent //////
	static void printMouseEventProperties(DKMouseEvent* mouseevent);
	
};
REGISTER_OBJECT(App, false);


#endif //App_H