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
	static bool onafterscriptexecute(DKEvent* event);
	static bool onbeforematch(DKEvent* event);
	static bool onbeforescriptexecute(DKEvent* event);
	static bool onerror(DKEvent* event);
	static bool onfullscreenchange(DKEvent* event);
	static bool onfullscreenerror(DKEvent* event);
	static bool onscroll(DKEvent* event);
	static bool onscrollend(DKEvent* event);
	
	
	////// UIEvent //////
	static void printUIEventProperties(DKUIEvent* uievent);
	//static bool onerror(DKEvent* event);
	
	
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