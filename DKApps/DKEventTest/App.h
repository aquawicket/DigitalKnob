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
	static bool ongeneric(DKEvent* event);
	static bool onafterscriptexecute(DKEvent* event);
	static bool onbeforematch(DKEvent* event);
	static bool onbeforescriptexecute(DKEvent* event);
	static bool onerror(DKEvent* event);
	static bool onfullscreenchange(DKEvent* event);
	static bool onfullscreenerror(DKEvent* event);
	static bool onscroll(DKEvent* event);
	static bool onscrollend(DKEvent* event);
	
	
	////// CustomEvent //////
	static void printCustomEventProperties(DKCustomEvent* customevent);
	
	////// EventTarget //////
	
	
	// https://w3c.github.io/uievents
	////// UIEvent //////
	static void printUIEventProperties(DKUIEvent* uievent);
	//static bool onerror(DKEvent* event);
	
	
	////// FocusEvent //////
	static void printFocusEventProperties(DKFocusEvent* focusevent);
	static bool onblur(DKFocusEvent* focusevent);
	static bool onfocus(DKFocusEvent* focusevent);
	static bool onfocusin(DKFocusEvent* focusevent);
	static bool onfocusout(DKFocusEvent* focusevent);
	
	
	////// MouseEvent //////
	static void printMouseEventProperties(DKMouseEvent* mouseevent);
	static bool onauxclick(DKMouseEvent* mouseevent);
	static bool onclick(DKMouseEvent* mouseevent);
	static bool oncontextmenu(DKMouseEvent* mouseevent);
	static bool ondblclick(DKMouseEvent* mouseevent);
	static bool onDOMActivate(DKMouseEvent* mouseevent);
	static bool onmousedown(DKMouseEvent* mouseevent);
	static bool onmouseenter(DKMouseEvent* mouseevent);
	static bool onmouseleave(DKMouseEvent* mouseevent);
	static bool onmousemove(DKMouseEvent* mouseevent);
	static bool onmouseout(DKMouseEvent* mouseevent);
	static bool onmouseover(DKMouseEvent* mouseevent);
	static bool onmouseup(DKMouseEvent* mouseevent);
	static bool onwebkitmouseforcechanged(DKMouseEvent* mouseevent);
	static bool onwebkitmouseforcedown(DKMouseEvent* mouseevent);
	static bool onwebkitmouseforceup(DKMouseEvent* mouseevent);
	static bool onwebkitmouseforcewillbegin(DKMouseEvent* mouseevent);
	
	
	///// WheelEvent //////
	static void printWheelEventProperties(DKWheelEvent* wheelevent);
	static bool onmousewheel(DKWheelEvent* wheelevent);
	static bool onwheel(DKWheelEvent* wheelevent);
	
	
	////// InputEvent //////
	static void printInputEventProperties(DKInputEvent* inputevent);
	static bool onbeforeinput(DKInputEvent* inputevent);
	static bool oninput(DKInputEvent* inputevent);
	
	////// KeyboardEvent //////
	static void printKeyboardEventProperties(DKKeyboardEvent* keyboardevent);
	static bool onkeydown(DKKeyboardEvent* keyboardevent);
	static bool onkeyup(DKKeyboardEvent* keyboardevent);
	static bool onkeypress(DKKeyboardEvent* keyboardevent);	
	
	
	///// CompositionEvent //////
	static void printCompositionEventProperties(DKCompositionEvent* compositionevent);
	static bool oncompositionstart(DKCompositionEvent* compositionevent);
	static bool oncompositionupdate(DKCompositionEvent* compositionevent);
	static bool oncompositionend(DKCompositionEvent* compositionevent);
};
REGISTER_OBJECT(App, false);


#endif //App_H