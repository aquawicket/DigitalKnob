// [IDL] https://w3c.github.io/uievents/#idl-uievent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
#pragma once
#ifndef DKUIEvent_H
#define DKUIEvent_H

#include "DKEvent/DKEvent.h"
#include "DKWindow/DKWindow.h"


////// UIEventInit //////
typedef std::string UIEventInit;


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface UIEvent : Event {
class DKUIEvent : public DKEvent
{
public:
	// constructor(DOMString type, optional UIEventInit eventInitDict = {});
	DKUIEvent(const DOMString& type, const UIEventInit& eventInitDict = "{}") : DKEvent(type, eventInitDict) {
		DKDEBUGFUNC(type, eventInitDict);
		interfaceName = "UIEvent";
		address[interfaceName] = pointerToAddress(this);
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
	}
	
	// readonly attribute Window? view;
	DKWindow* _view = NULL;
	virtual DKWindow*			view()													{ return _view; }									// getter
	virtual void 				view(DKWindow* view) 									{ _view = view; } 									// setter
	
	// readonly attribute long detail;
	int _detail = 0;
	virtual const int& 			detail()												{ return _detail; }									// getter
	virtual void 				detail(const int& detail) 								{ _detail = detail; } 								// setter
	
	// Source: Input Device Capabilities (https://wicg.github.io/input-device-capabilities/)
	// partial interface UIEvent {
	// 	readonly attribute InputDeviceCapabilities? sourceCapabilities;
	DKString _sourceCapabilities = "";
	virtual const DKString& 	sourceCapabilities()									{ return _sourceCapabilities; }						// getter
	virtual void 				sourceCapabilities(const DKString& sourceCapabilities) 	{ _sourceCapabilities = sourceCapabilities; } 		// setter
	// };
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface UIEvent {
	// Deprecated in this specification
	// undefined initUIEvent(DOMString typeArg, optional boolean bubblesArg = false, optional boolean cancelableArg = false, optional Window? viewArg = null, optional long detailArg = 0);
	virtual void initUIEvent(const DOMString& typeArg, const bool& bubblesArg = false, const bool& cancelableArg = false, DKWindow* viewArg = NULL, const int& detailArg = 0){
		DKDEBUGFUNC(typeArg, bubblesArg, cancelableArg, viewArg, detailArg);
		DKTODO();
	}
	//	};
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface UIEvent {
	// The following support legacy user agents
	// readonly attribute unsigned long which;
	unsigned int _which = 0; // https://w3c.github.io/uievents/#dom-uievent-which
	virtual const unsigned int& which()													{ return _which; }									// getter
	virtual void 				which(const unsigned int& which) 						{ _which = which; } 								// setter
	// };
};


#endif //DKUIEvent_H