#pragma once
#ifndef App_H
#define App_H

#include "DK/DK.h"


class App : public DKObjectT<App>
{
public:
	bool Init();
	bool End();

	// https://dom.spec.whatwg.org
	////// Event //////
	static void printEventProperties(DKEvent* event);
	static bool onevent(DKEvent* event);

	
	////// CustomEvent //////
	static void printCustomEventProperties(DKCustomEvent* customevent);
	static bool oncustom(DKEvent* event);
};
REGISTER_OBJECT(App, false);


#endif //App_H