#include "DK/stdafx.h"

#include "App.h"

bool App::Init() {
	DKDEBUGFUNC();
	DKINFO("App::Init() \n");
	
	DKClass::DKCreate("DKEventTarget");															
	
	////// Event //////
	DKString thisAddress = DKDuktape::pointerToAddress(this);
	DKEventTarget::addEventListener<DKEvent>("generic", &App::ongeneric, thisAddress);					
	DKEvent* event = new DKEvent("generic", "");												
	DKEventTarget::dispatchEvent(event, thisAddress);													
	DKEventTarget::removeEventListener<DKEvent>("generic", &App::ongeneric, thisAddress);	
	DKEventTarget::dispatchEvent(event, thisAddress);
	
	DKINFO("/////////// ConsoleWindow ///////////////////// \n");
	DKObject* myConsoleWindow = DKClass::DKCreate("DKConsoleWindow");
	DKString consoleWindowAddress = DKDuktape::pointerToAddress(myConsoleWindow);
	
	
	////// KeyboardEvent ///////
	DKEventTarget::addEventListener<DKKeyboardEvent>("keydown", 	&App::onkeydown, 	consoleWindowAddress);
	DKEventTarget::addEventListener<DKKeyboardEvent>("keyup", 		&App::onkeyup, 		consoleWindowAddress);
	DKEventTarget::addEventListener<DKKeyboardEvent>("keypress", 	&App::onkeypress, 	consoleWindowAddress);
	
	
	////// MouseEvent ///////
	DKEventTarget::addEventListener<DKMouseEvent>("auxclick", 					&App::onauxclick,				 	consoleWindowAddress);
	DKEventTarget::addEventListener<DKMouseEvent>("click", 						&App::onclick, 						consoleWindowAddress);
	DKEventTarget::addEventListener<DKMouseEvent>("contextmenu",			 	&App::oncontextmenu,			 	consoleWindowAddress);
	DKEventTarget::addEventListener<DKMouseEvent>("dblclick", 					&App::ondblclick, 					consoleWindowAddress);
	DKEventTarget::addEventListener<DKMouseEvent>("DOMActivate", 				&App::onDOMActivate, 				consoleWindowAddress);
	DKEventTarget::addEventListener<DKMouseEvent>("mousedown", 					&App::onmousedown, 					consoleWindowAddress);
	DKEventTarget::addEventListener<DKMouseEvent>("mouseenter", 				&App::onmouseenter, 				consoleWindowAddress);
	DKEventTarget::addEventListener<DKMouseEvent>("mouseleave", 				&App::onmouseleave, 				consoleWindowAddress);
	DKEventTarget::addEventListener<DKMouseEvent>("mousemove", 					&App::onmousemove,				 	consoleWindowAddress);
	DKEventTarget::addEventListener<DKMouseEvent>("mouseout", 					&App::onmouseout, 					consoleWindowAddress);
	DKEventTarget::addEventListener<DKMouseEvent>("mouseover", 					&App::onmouseover, 					consoleWindowAddress);
	DKEventTarget::addEventListener<DKMouseEvent>("mouseup", 					&App::onmouseup, 					consoleWindowAddress);
	DKEventTarget::addEventListener<DKMouseEvent>("webkitmouseforcechanged", 	&App::onwebkitmouseforcechanged, 	consoleWindowAddress);
	DKEventTarget::addEventListener<DKMouseEvent>("webkitmouseforcedown", 		&App::onwebkitmouseforcedown, 		consoleWindowAddress);
	DKEventTarget::addEventListener<DKMouseEvent>("webkitmouseforceup",			&App::onwebkitmouseforceup, 		consoleWindowAddress);
	DKEventTarget::addEventListener<DKMouseEvent>("webkitmouseforcewillbegin",	&App::onwebkitmouseforcewillbegin,	consoleWindowAddress);
	
	
	////// WheelEvent //////
	DKEventTarget::addEventListener<DKWheelEvent>("mousewheel", &App::onmousewheel,	consoleWindowAddress);
	DKEventTarget::addEventListener<DKWheelEvent>("wheel", 		&App::onwheel,		consoleWindowAddress);
	
	return true;
}

bool App::End(){
	DKDEBUGFUNC();
	DKINFO("App::End() \n");
	return true;
}


////// Event //////
void App::printEventProperties(DKEvent* event) {
	DKDEBUGFUNC(event);
	
	////// Instance properties //////
	DKINFO("event->bubbles = "					+toString(event->bubbles)				+"\n");
	DKINFO("event->cancelable = "				+toString(event->cancelable)			+"\n");
	DKINFO("event->composed = "					+toString(event->composed)				+"\n");
	DKINFO("event->currentTarget = "			+toString(event->currentTarget)			+"\n");
	DKINFO("event->defaultPrevented = "			+toString(event->defaultPrevented)		+"\n");
	DKINFO("event->eventPhase = "				+toString(event->eventPhase)			+"\n");
	DKINFO("event->isTrusted = "				+toString(event->isTrusted)				+"\n");
	DKINFO("event->target = "					+toString(event->target)				+"\n");
	DKINFO("event->timeStamp = "				+toString(event->timeStamp)				+"\n");
	DKINFO("event->type = "						+toString(event->type)					+"\n");
	
	////// Legacy and non-standard properties //////
	DKINFO("event->cancelBubble = "				+toString(event->cancelBubble)			+"\n");
	DKINFO("event->explicitOriginalTarget = "	+toString(event->explicitOriginalTarget)+"\n");
	DKINFO("event->originalTarget = "			+toString(event->originalTarget)		+"\n");
	DKINFO("event->returnValue = "				+toString(event->returnValue)			+"\n");
	DKINFO("event->scoped = "					+toString(event->scoped)				+"\n");
}
bool App::ongeneric(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("ongeneric() \n");
	printEventProperties(event);
	return true;
}
bool App::onafterscriptexecute(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onafterscriptexecute() \n");
	printEventProperties(event);
	return true;
}
bool App::onbeforematch(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onbeforematch() \n");
	printEventProperties(event);
	return true;
}
bool App::onbeforescriptexecute(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onbeforescriptexecute() \n");
	printEventProperties(event);
	return true;
}
bool App::onerror(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onerror() \n");
	printEventProperties(event);
	return true;
}
bool App::onfullscreenchange(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onfullscreenchange() \n");
	printEventProperties(event);
	return true;
}
bool App::onfullscreenerror(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onfullscreenerror() \n");
	printEventProperties(event);
	return true;
}
bool App::onscroll(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onscroll() \n");
	printEventProperties(event);
	return true;
}
bool App::onscrollend(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onscrollend() \n");
	printEventProperties(event);
	return true;
}


////// UIEvent //////
void App::printUIEventProperties(DKUIEvent* uievent) {
	DKDEBUGFUNC(uievent);
	
	////// Instance properties //////
	DKINFO("uievent->detail = "				+toString(uievent->detail)				+"\n");
	DKINFO("uievent->sourceCapabilities = "	+toString(uievent->sourceCapabilities)	+"\n");
	DKINFO("uievent->view = "				+toString(uievent->view)				+"\n");
	DKINFO("uievent->which = "				+toString(uievent->which)				+"\n");
}


////// KeyboardEvent //////
void App::printKeyboardEventProperties(DKKeyboardEvent* keyboardevent) {
	DKDEBUGFUNC(keyboardevent);
	
	////// Instance properties //////
	DKINFO("keyboardevent->altKey = "		+toString(keyboardevent->altKey)		+"\n");
	DKINFO("keyboardevent->code = "			+toString(keyboardevent->code)			+"\n");
	DKINFO("keyboardevent->ctrlKey = "		+toString(keyboardevent->ctrlKey)		+"\n");
	DKINFO("keyboardevent->isComposing = "	+toString(keyboardevent->isComposing)	+"\n");
	DKINFO("keyboardevent->key = "			+toString(keyboardevent->key)			+"\n");
	DKINFO("keyboardevent->locale = "		+toString(keyboardevent->locale)		+"\n");
	DKINFO("keyboardevent->location = "		+toString(keyboardevent->location)		+"\n");
	DKINFO("keyboardevent->metaKey = "		+toString(keyboardevent->metaKey)		+"\n");
	DKINFO("keyboardevent->repeat = "		+toString(keyboardevent->repeat)		+"\n");
	DKINFO("keyboardevent->shiftKey = "		+toString(keyboardevent->shiftKey)		+"\n");
	
	////// Obsolete properties //////
	DKINFO("keyboardevent->char = "			+toString(keyboardevent->_char)			+"\n");
	DKINFO("keyboardevent->charCode = "		+toString(keyboardevent->charCode)		+"\n");
	DKINFO("keyboardevent->keyCode = "		+toString(keyboardevent->keyCode)		+"\n");
	DKINFO("keyboardevent->keyIdentifier = "+toString(keyboardevent->keyIdentifier)	+"\n");
	DKINFO("keyboardevent->keyLocation = "	+toString(keyboardevent->keyLocation)	+"\n");
	DKINFO("keyboardevent->which = "		+toString(keyboardevent->which)			+"\n");
}
bool App::onkeydown(DKKeyboardEvent* keyboardevent) {
	DKDEBUGFUNC(keyboardevent);
	DKINFO("onkeydown() \n");
	printEventProperties(keyboardevent);
	printUIEventProperties(keyboardevent);
	printKeyboardEventProperties(keyboardevent);
	return true;
}
bool App::onkeyup(DKKeyboardEvent* keyboardevent) {
	DKDEBUGFUNC(keyboardevent);
	DKINFO("onkeyup() \n");
	printEventProperties(keyboardevent);
	printUIEventProperties(keyboardevent);
	printKeyboardEventProperties(keyboardevent);
	return true;
}
bool App::onkeypress(DKKeyboardEvent* keyboardevent) {
	DKDEBUGFUNC(keyboardevent);
	DKINFO("onkeypress() \n");
	printEventProperties(keyboardevent);
	printUIEventProperties(keyboardevent);
	printKeyboardEventProperties(keyboardevent);
	return true;
}


////// MouseEvent //////
void App::printMouseEventProperties(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	
	////// Static properties //////
	//DKINFO("mouseevent->WEBKIT_FORCE_AT_MOUSE_DOWN = "		+toString(mouseevent->WEBKIT_FORCE_AT_MOUSE_DOWN)+"\n");
	//DKINFO("mouseevent->WEBKIT_FORCE_AT_FORCE_MOUSE_DOWN = "	+toString(mouseevent->WEBKIT_FORCE_AT_FORCE_MOUSE_DOWN)+"\n");
	
	////// Instance properties //////
	DKINFO("mouseevent->altKey = "			+toString(mouseevent->altKey)			+"\n");
	DKINFO("mouseevent->button = "			+toString(mouseevent->button)			+"\n");
	DKINFO("mouseevent->buttons = "			+toString(mouseevent->buttons)			+"\n");
	DKINFO("mouseevent->clientX = "			+toString(mouseevent->clientX)			+"\n");
	DKINFO("mouseevent->clientY = "			+toString(mouseevent->clientY)			+"\n");
	DKINFO("mouseevent->ctrlKey = "			+toString(mouseevent->ctrlKey)			+"\n");
	DKINFO("mouseevent->layerX = "			+toString(mouseevent->layerX)			+"\n");
	DKINFO("mouseevent->layerY = "			+toString(mouseevent->layerY)			+"\n");
	DKINFO("mouseevent->metaKey = "			+toString(mouseevent->metaKey)			+"\n");
	DKINFO("mouseevent->movementX = "		+toString(mouseevent->movementX)		+"\n");
	DKINFO("mouseevent->movementY = "		+toString(mouseevent->movementY)		+"\n");
	DKINFO("mouseevent->offsetX = "			+toString(mouseevent->offsetX)			+"\n");
	DKINFO("mouseevent->offsetY = "			+toString(mouseevent->offsetY)			+"\n");
	DKINFO("mouseevent->pageX = "			+toString(mouseevent->pageX)			+"\n");
	DKINFO("mouseevent->pageY = "			+toString(mouseevent->pageY)			+"\n");
	DKINFO("mouseevent->relatedTarget = "	+toString(mouseevent->relatedTarget)	+"\n");
	DKINFO("mouseevent->screenX = "			+toString(mouseevent->screenX)			+"\n");
	DKINFO("mouseevent->screenY = "			+toString(mouseevent->screenY)			+"\n");
	DKINFO("mouseevent->shiftKey = "		+toString(mouseevent->shiftKey)			+"\n");
	DKINFO("mouseevent->mozPressure = "		+toString(mouseevent->mozPressure)		+"\n");
	DKINFO("mouseevent->mozInputSource = "	+toString(mouseevent->mozInputSource)	+"\n");
	DKINFO("mouseevent->webkitForce = "		+toString(mouseevent->webkitForce)		+"\n");
	DKINFO("mouseevent->x = "				+toString(mouseevent->x)				+"\n");
	DKINFO("mouseevent->y = "				+toString(mouseevent->y)				+"\n");
}
bool App::onauxclick(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKINFO("onauxclick() \n");
	printEventProperties(mouseevent);
	printUIEventProperties(mouseevent);
	printMouseEventProperties(mouseevent);
	return true;
}
bool App::onclick(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKINFO("onclick() \n");
	printEventProperties(mouseevent);
	printUIEventProperties(mouseevent);
	printMouseEventProperties(mouseevent);
	return true;
}
bool App::oncontextmenu(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKINFO("oncontextmenu() \n");
	printEventProperties(mouseevent);
	printUIEventProperties(mouseevent);
	printMouseEventProperties(mouseevent);
	return true;
}
bool App::ondblclick(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKINFO("ondblclick() \n");
	printEventProperties(mouseevent);
	printUIEventProperties(mouseevent);
	printMouseEventProperties(mouseevent);
	return true;
}
bool App::onDOMActivate(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKINFO("onDOMActivate() \n");
	printEventProperties(mouseevent);
	printUIEventProperties(mouseevent);
	printMouseEventProperties(mouseevent);
	return true;
}
bool App::onmousedown(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKINFO("onmousedown() \n");
	printEventProperties(mouseevent);
	printUIEventProperties(mouseevent);
	printMouseEventProperties(mouseevent);
	return true;
}
bool App::onmouseenter(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKINFO("onmouseenter() \n");
	printEventProperties(mouseevent);
	printUIEventProperties(mouseevent);
	printMouseEventProperties(mouseevent);
	return true;
}
bool App::onmouseleave(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKINFO("onmouseleave() \n");
	printEventProperties(mouseevent);
	printUIEventProperties(mouseevent);
	printMouseEventProperties(mouseevent);
	return true;
}
bool App::onmousemove(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKINFO("onmousemove() \n");
	printEventProperties(mouseevent);
	printUIEventProperties(mouseevent);
	printMouseEventProperties(mouseevent);
	return true;
}
bool App::onmouseout(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKINFO("onmouseout() \n");
	printEventProperties(mouseevent);
	printUIEventProperties(mouseevent);
	printMouseEventProperties(mouseevent);
	return true;
}
bool App::onmouseover(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKINFO("onmouseover() \n");
	printEventProperties(mouseevent);
	printUIEventProperties(mouseevent);
	printMouseEventProperties(mouseevent);
	return true;
}
bool App::onmouseup(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKINFO("onmouseup() \n");
	printEventProperties(mouseevent);
	printUIEventProperties(mouseevent);
	printMouseEventProperties(mouseevent);
	return true;
}
bool App::onwebkitmouseforcechanged(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKINFO("onwebkitmouseforcechanged() \n");
	printEventProperties(mouseevent);
	printUIEventProperties(mouseevent);
	printMouseEventProperties(mouseevent);
	return true;
}
bool App::onwebkitmouseforcedown(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKINFO("onwebkitmouseforcedown() \n");
	printEventProperties(mouseevent);
	printUIEventProperties(mouseevent);
	printMouseEventProperties(mouseevent);
	return true;
}
bool App::onwebkitmouseforceup(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKINFO("onwebkitmouseforceup() \n");
	printEventProperties(mouseevent);
	printUIEventProperties(mouseevent);
	printMouseEventProperties(mouseevent);
	return true;
}
bool App::onwebkitmouseforcewillbegin(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKINFO("onwebkitmouseforcewillbegin() \n");
	printEventProperties(mouseevent);
	printUIEventProperties(mouseevent);
	printMouseEventProperties(mouseevent);
	return true;
}


///// WheelEvent //////
void App::printWheelEventProperties(DKWheelEvent* wheelevent) {
	DKDEBUGFUNC(wheelevent);
	
	////// Instance properties //////
	DKINFO("wheelevent->deltaX = "		+toString(wheelevent->deltaX)		+"\n");
	DKINFO("wheelevent->deltaY = "		+toString(wheelevent->deltaY)		+"\n");
	DKINFO("wheelevent->deltaZ = "		+toString(wheelevent->deltaZ)		+"\n");
	DKINFO("wheelevent->deltaMode = "	+toString(wheelevent->deltaMode)	+"\n");
	DKINFO("wheelevent->wheelDelta = "	+toString(wheelevent->wheelDelta)	+"\n");
	DKINFO("wheelevent->wheelDeltaX = "	+toString(wheelevent->wheelDeltaX)	+"\n");
	DKINFO("wheelevent->wheelDeltaY = "	+toString(wheelevent->wheelDeltaY)	+"\n");
}
bool App::onmousewheel(DKWheelEvent* wheelevent) {
	DKDEBUGFUNC(wheelevent);
	DKINFO("onmousewheel() \n");
	printEventProperties(wheelevent);
	printUIEventProperties(wheelevent);
	printMouseEventProperties(wheelevent);
	printWheelEventProperties(wheelevent);
	return true;
}
bool App::onwheel(DKWheelEvent* wheelevent) {
	DKDEBUGFUNC(wheelevent);
	DKINFO("onwheel() \n");
	printEventProperties(wheelevent);
	printUIEventProperties(wheelevent);
	printMouseEventProperties(wheelevent);
	printWheelEventProperties(wheelevent);
	return true;
}