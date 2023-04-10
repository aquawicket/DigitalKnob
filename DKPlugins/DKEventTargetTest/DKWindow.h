#pragma once
#ifndef DKWindow_H
#define DKWindow_H

#include "DKEventTargetTest/DKEventTarget.h"


// [INTERFACE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Window
class DKWindow : public DKEventTarget
{
public:
	DKWindow() : DKEventTarget() {
		
		//eventTargetClass = "Window";
		
		////// Instance properties //////

	}

};


#endif //DKWindow_H